import React, { useState } from 'react';
import { useNavigate } from 'react-router';
import { Patient } from 'fhir/r4';
import { patientService } from './patient-services/patient-service';
import { useTranslation } from 'react-i18next';

const SearchPatientPage: React.FC = () => {
  const { t } = useTranslation();
  const navigate = useNavigate();
  const [searchCriteria, setSearchCriteria] = useState({
    givenName: '',
    familyName: '',
    phoneNumber: '',
    birthDate: '',
  });
  const [patients, setPatients] = useState<Patient[]>([]);
  const [loading, setLoading] = useState<boolean>(false);
  const [error, setError] = useState<string | null>(null);
  const [searched, setSearched] = useState<boolean>(false);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    setSearchCriteria({
      ...searchCriteria,
      [e.target.id]: e.target.value
    });
  };

  const handleClearSearch = () => {
    setSearchCriteria({
      givenName: '',
      familyName: '',
      phoneNumber: '',
      birthDate: '',
    });
    setPatients([]);
    setSearched(false);
  };

  const handleSearch = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    setError(null);
    setSearched(true);

    try {
      // Build the search query parameters
      const queryParams: Record<string, string> = {};
      
      if (searchCriteria.givenName.trim()) {
        queryParams['given'] = searchCriteria.givenName.trim();
      }
      
      if (searchCriteria.familyName.trim()) {
        queryParams['family'] = searchCriteria.familyName.trim();
      }
      
      if (searchCriteria.phoneNumber.trim()) {
        queryParams['telecom'] = `phone|${searchCriteria.phoneNumber.trim()}`;
      }
      
      if (searchCriteria.birthDate.trim()) {
        queryParams['birthdate'] = searchCriteria.birthDate.trim();
      }

      // Check if any search criteria were provided
      if (Object.keys(queryParams).length === 0) {
        setError(t('searchPatient.error.emptySearch'));
        setLoading(false);
        return;
      }

      // Perform the search
      const results = await patientService.searchPatients(queryParams);
      setPatients(results);
      setLoading(false);
    } catch (err) {
      console.error('Error searching patients:', err);
      setError(t('searchPatient.error.searchFailed'));
      setLoading(false);
    }
  };

  const handleViewPatient = (id: string) => {
    navigate(`/patients/${id}`);
  };

  const handleDeletePatient = async (id: string) => {
    if (window.confirm(t('searchPatient.error.deleteConfirm'))) {
      try {
        await patientService.deletePatient(id);
        // Refresh the search results after deleting
        const updatedPatients = patients.filter(patient => patient.id !== id);
        setPatients(updatedPatients);
        alert(t('searchPatient.error.deleteSuccess'));
      } catch (err) {
        console.error('Error deleting patient:', err);
        alert(t('searchPatient.error.deleteFailed'));
      }
    }
  };

  const formatDate = (dateString: string | undefined) => {
    if (!dateString) return '';
    try {
      let year = dateString.split('T')[0].split('-')[0];
      let month = dateString.split('T')[0].split('-')[1];
      let day = dateString.split('T')[0].split('-')[2];
      let date = new Date(parseInt(year), parseInt(month) - 1, parseInt(day));
      return date.toDateString();
    } catch {
      return dateString;
    }
  };

  return (
    <div className="container mt-5">
      <h2 className="mb-4">{t('searchPatient.title')}</h2>
      
      <form onSubmit={handleSearch} className="mb-5">
        <div className="row g-3">
          <div className="col-md-6">
            <label htmlFor="givenName" className="form-label">{t('searchPatient.givenName')}</label>
            <input
              type="text"
              className="form-control"
              id="givenName"
              value={searchCriteria.givenName}
              onChange={handleChange}
              placeholder={t('searchPatient.givenName')}
            />
          </div>
          
          <div className="col-md-6">
            <label htmlFor="familyName" className="form-label">{t('searchPatient.familyName')}</label>
            <input
              type="text"
              className="form-control"
              id="familyName"
              value={searchCriteria.familyName}
              onChange={handleChange}
              placeholder={t('searchPatient.familyName')}
            />
          </div>
          
          <div className="col-md-6">
            <label htmlFor="phoneNumber" className="form-label">{t('searchPatient.phoneNumber')}</label>
            <input
              type="tel"
              className="form-control"
              id="phoneNumber"
              value={searchCriteria.phoneNumber}
              onChange={handleChange}
              placeholder="555-123-4567"
            />
          </div>
          
          <div className="col-md-6">
            <label htmlFor="birthDate" className="form-label">{t('searchPatient.dayOfBirth')}</label>
            <input
              type="date"
              className="form-control"
              id="birthDate"
              value={searchCriteria.birthDate}
              onChange={handleChange}
            />
          </div>
          
          <div className="col-12 mt-4">
            <div className="d-flex gap-2">
              <button type="submit" className="btn btn-primary" disabled={loading}>
                {loading ? (
                  <>
                    <span className="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>
                    {t('searchPatient.searching')}
                  </>
                ) : t('searchPatient.title')}
              </button>
              <button type="button" className="btn btn-outline-secondary" onClick={handleClearSearch}>
                {t('searchPatient.clear')}
              </button>
            </div>
          </div>
        </div>
      </form>
      
      {error && (
        <div className="alert alert-danger" role="alert">
          {error}
        </div>
      )}
      
      {searched && !loading && patients.length === 0 && !error && (
        <div className="alert alert-info" role="alert">
          {t('searchPatient.noResults')}
        </div>
      )}
      
      {patients.length > 0 && (
        <>
          <h3 className="mb-3">{t('searchPatient.searchResults')}</h3>
          <div className="table-responsive">
            <table className="table table-hover">
              <thead>
                <tr>
                  <th>{t('searchPatient.searchPatientTable.name')}</th>
                  <th>{t('searchPatient.searchPatientTable.birthDate')}</th>
                  <th>{t('searchPatient.searchPatientTable.gender')}</th>
                  <th>{t('searchPatient.searchPatientTable.phone')}</th>
                  <th>{t('searchPatient.searchPatientTable.actions')}</th>
                </tr>
              </thead>
              <tbody>
                {patients.map((patient) => (
                  <tr key={patient.id}>
                    <td>
                      {patient.name?.[0]?.given?.join(' ')} {patient.name?.[0]?.family}
                    </td>
                    <td>{formatDate(patient.birthDate)}</td>
                    <td>{patient.gender ? patient.gender.charAt(0).toUpperCase() + patient.gender.slice(1) : ''}</td>
                    <td>{patient.telecom?.find(t => t.system === 'phone')?.value || ''}</td>
                    <td>
                      <div className="btn-group btn-group-sm">
                        <button 
                          className="btn btn-outline-primary" 
                          onClick={() => handleViewPatient(patient.id!)}
                        >
                          {t('searchPatient.viewEdit')}
                        </button>
                        <button 
                          className="btn btn-outline-danger" 
                          onClick={() => handleDeletePatient(patient.id!)}
                        >
                          {t('Delete')}
                        </button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </>
      )}
      
      <div className="mt-4">
        <button 
          className="btn btn-success"
          onClick={() => navigate('/patients/new')}
        >
          {t('searchPatient.createNewPatient')}
        </button>
        <button 
          className="btn btn-link ms-2"
          onClick={() => navigate('/')}
        >
          {t('searchPatient.back')}
        </button>
      </div>
    </div>
  );
};

export default SearchPatientPage;