import React, { useState } from 'react';
import { useNavigate } from 'react-router';
import { Patient } from 'fhir/r4';
import { patientService } from './patient-services/patient-service';

const SearchPatientPage: React.FC = () => {
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
        console.log(searchCriteria.birthDate);
        queryParams['birthdate'] = searchCriteria.birthDate.trim();
      }

      // Check if any search criteria were provided
      if (Object.keys(queryParams).length === 0) {
        setError('Please enter at least one search criteria');
        setLoading(false);
        return;
      }

      // Perform the search
      const results = await patientService.searchPatients(queryParams);
      setPatients(results);
      setLoading(false);
    } catch (err) {
      console.error('Error searching patients:', err);
      setError('An error occurred while searching. Please try again.');
      setLoading(false);
    }
  };

  const handleViewPatient = (id: string) => {
    navigate(`/patients/${id}`);
  };

  const handleEditPatient = (id: string) => {
    navigate(`/patients/${id}`);
  };

  const handleDeletePatient = async (id: string) => {
    if (window.confirm('Are you sure you want to delete this patient?')) {
      try {
        await patientService.deletePatient(id);
        // Refresh the search results after deleting
        const updatedPatients = patients.filter(patient => patient.id !== id);
        setPatients(updatedPatients);
        alert('Patient deleted successfully');
      } catch (err) {
        console.error('Error deleting patient:', err);
        alert('Failed to delete patient');
      }
    }
  };

  const formatDate = (dateString: string | undefined) => {
    if (!dateString) return '';
    try {
      return new Date(dateString).toLocaleDateString();
    } catch {
      return dateString;
    }
  };

  return (
    <div className="container mt-5">
      <h2 className="mb-4">Tìm Bệnh Nhân</h2>
      
      <form onSubmit={handleSearch} className="mb-5">
        <div className="row g-3">
          <div className="col-md-6">
            <label htmlFor="givenName" className="form-label">Tên</label>
            <input
              type="text"
              className="form-control"
              id="givenName"
              value={searchCriteria.givenName}
              onChange={handleChange}
              placeholder="Tên"
            />
          </div>
          
          <div className="col-md-6">
            <label htmlFor="familyName" className="form-label">Họ</label>
            <input
              type="text"
              className="form-control"
              id="familyName"
              value={searchCriteria.familyName}
              onChange={handleChange}
              placeholder="Họ"
            />
          </div>
          
          <div className="col-md-6">
            <label htmlFor="phoneNumber" className="form-label">Phone Number</label>
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
            <label htmlFor="birthDate" className="form-label">Birth Date</label>
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
                    Searching...
                  </>
                ) : 'Search Patients'}
              </button>
              <button type="button" className="btn btn-outline-secondary" onClick={handleClearSearch}>
                Clear
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
          No patients found matching your criteria.
        </div>
      )}
      
      {patients.length > 0 && (
        <>
          <h3 className="mb-3">Search Results</h3>
          <div className="table-responsive">
            <table className="table table-hover">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Birth Date</th>
                  <th>Gender</th>
                  <th>Phone</th>
                  <th>Actions</th>
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
                          View
                        </button>
                        <button 
                          className="btn btn-outline-secondary" 
                          onClick={() => handleEditPatient(patient.id!)}
                        >
                          Edit
                        </button>
                        <button 
                          className="btn btn-outline-danger" 
                          onClick={() => handleDeletePatient(patient.id!)}
                        >
                          Delete
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
          Create New Patient
        </button>
        <button 
          className="btn btn-link ms-2"
          onClick={() => navigate('/')}
        >
          Back to Home
        </button>
      </div>
    </div>
  );
};

export default SearchPatientPage;