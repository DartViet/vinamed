import React, { useState } from 'react';
import { useNavigate } from 'react-router';
import { Practitioner } from 'fhir/r4';
import { practitionerService } from './practitioner-service/practitioner-service';

const SearchPractitionerPage: React.FC = () => {
  const navigate = useNavigate();
  const [searchCriteria, setSearchCriteria] = useState({
    name: '',
    identifier: '',
    specialty: '',
    qualification: '',
    gender: '',
    active: '',
  });
  const [practitioners, setPractitioners] = useState<Practitioner[]>([]);
  const [loading, setLoading] = useState<boolean>(false);
  const [error, setError] = useState<string | null>(null);
  const [searched, setSearched] = useState<boolean>(false);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
    setSearchCriteria({
      ...searchCriteria,
      [e.target.id]: e.target.value
    });
  };

  const handleClearSearch = () => {
    setSearchCriteria({
      name: '',
      identifier: '',
      specialty: '',
      qualification: '',
      gender: '',
      active: '',
    });
    setPractitioners([]);
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
      
      if (searchCriteria.name.trim()) {
        queryParams['name'] = searchCriteria.name.trim();
      }
      
      if (searchCriteria.identifier.trim()) {
        queryParams['identifier'] = searchCriteria.identifier.trim();
      }
      
      if (searchCriteria.qualification.trim()) {
        queryParams['qualification'] = searchCriteria.qualification.trim();
      }
      
      if (searchCriteria.specialty.trim()) {
        queryParams['specialty'] = searchCriteria.specialty.trim();
      }
      
      if (searchCriteria.gender) {
        queryParams['gender'] = searchCriteria.gender;
      }
      
      if (searchCriteria.active) {
        queryParams['active'] = searchCriteria.active;
      }

      // Check if any search criteria were provided
      if (Object.keys(queryParams).length === 0) {
        setError('Please enter at least one search criteria');
        setLoading(false);
        return;
      }

      // Perform the search
      const results = await practitionerService.searchPractitioners(queryParams);
      setPractitioners(results);
      setLoading(false);
    } catch (err) {
      console.error('Error searching practitioners:', err);
      setError('An error occurred while searching. Please try again.');
      setLoading(false);
    }
  };

  const handleViewPractitioner = (id: string) => {
    navigate(`/practitioners/${id}`);
  };

  const handleDeletePractitioner = async (id: string) => {
    if (window.confirm('Are you sure you want to delete this practitioner?')) {
      try {
        await practitionerService.deletePractitioner(id);
        // Refresh the search results after deleting
        const updatedPractitioners = practitioners.filter(practitioner => practitioner.id !== id);
        setPractitioners(updatedPractitioners);
        alert('Practitioner deleted successfully');
      } catch (err) {
        console.error('Error deleting practitioner:', err);
        alert('Failed to delete practitioner');
      }
    }
  };

  // Helper function to get a practitioner's full name
  const getPractitionerName = (practitioner: Practitioner): string => {
    const name = practitioner.name?.[0];
    if (!name) return 'Unnamed Practitioner';
    
    const prefix = name.prefix?.[0] ? `${name.prefix[0]} ` : '';
    const given = name.given?.[0] || '';
    const family = name.family || '';
    const suffix = name.suffix?.[0] ? `, ${name.suffix[0]}` : '';
    
    return `${prefix}${given} ${family}${suffix}`;
  };

  // Helper function to get qualification text
  const getQualificationText = (practitioner: Practitioner): string => {
    if (!practitioner.qualification || practitioner.qualification.length === 0) return '';
    
    return practitioner.qualification
      .map(q => q.code?.text || q.code?.coding?.[0]?.display || q.code?.coding?.[0]?.code || '')
      .filter(Boolean)
      .join(', ');
  };

  return (
    <div className="container mt-5">
      <h2 className="mb-4">Search Practitioners</h2>
      
      <form onSubmit={handleSearch} className="mb-5">
        <div className="row g-3">
          <div className="col-md-6">
            <label htmlFor="name" className="form-label">Practitioner Name</label>
            <input
              type="text"
              className="form-control"
              id="name"
              value={searchCriteria.name}
              onChange={handleChange}
              placeholder="John Smith"
            />
          </div>
          
          <div className="col-md-6">
            <label htmlFor="identifier" className="form-label">Identifier</label>
            <input
              type="text"
              className="form-control"
              id="identifier"
              value={searchCriteria.identifier}
              onChange={handleChange}
              placeholder="License number, NPI, etc."
            />
          </div>
          
          <div className="col-md-4">
            <label htmlFor="qualification" className="form-label">Qualification</label>
            <input
              type="text"
              className="form-control"
              id="qualification"
              value={searchCriteria.qualification}
              onChange={handleChange}
              placeholder="MD, RN, PhD"
            />
          </div>
          
          <div className="col-md-4">
            <label htmlFor="specialty" className="form-label">Specialty</label>
            <input
              type="text"
              className="form-control"
              id="specialty"
              value={searchCriteria.specialty}
              onChange={handleChange}
              placeholder="Cardiology, Pediatrics"
            />
          </div>
          
          <div className="col-md-2">
            <label htmlFor="gender" className="form-label">Gender</label>
            <select
              className="form-select"
              id="gender"
              value={searchCriteria.gender}
              onChange={handleChange}
            >
              <option value="">Any Gender</option>
              <option value="male">Male</option>
              <option value="female">Female</option>
              <option value="other">Other</option>
              <option value="unknown">Unknown</option>
            </select>
          </div>
          
          <div className="col-md-2">
            <label htmlFor="active" className="form-label">Status</label>
            <select
              className="form-select"
              id="active"
              value={searchCriteria.active}
              onChange={handleChange}
            >
              <option value="">Any Status</option>
              <option value="true">Active</option>
              <option value="false">Inactive</option>
            </select>
          </div>
          
          <div className="col-12 mt-4">
            <div className="d-flex gap-2">
              <button type="submit" className="btn btn-primary" disabled={loading}>
                {loading ? (
                  <>
                    <span className="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>
                    Searching...
                  </>
                ) : 'Search Practitioners'}
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
      
      {searched && !loading && practitioners.length === 0 && !error && (
        <div className="alert alert-info" role="alert">
          No practitioners found matching your criteria.
        </div>
      )}
      
      {practitioners.length > 0 && (
        <>
          <h3 className="mb-3">Search Results</h3>
          <div className="table-responsive">
            <table className="table table-hover">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Qualifications</th>
                  <th>Gender</th>
                  <th>Contact</th>
                  <th>Status</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                {practitioners.map((practitioner) => (
                  <tr key={practitioner.id}>
                    <td className="fw-bold">{getPractitionerName(practitioner)}</td>
                    <td>{getQualificationText(practitioner)}</td>
                    <td>
                      {practitioner.gender && 
                        practitioner.gender.charAt(0).toUpperCase() + practitioner.gender.slice(1)}
                    </td>
                    <td>
                      {practitioner.telecom?.find(t => t.system === 'phone')?.value && (
                        <div><small>📞 {practitioner.telecom?.find(t => t.system === 'phone')?.value}</small></div>
                      )}
                      {practitioner.telecom?.find(t => t.system === 'email')?.value && (
                        <div><small>✉️ {practitioner.telecom?.find(t => t.system === 'email')?.value}</small></div>
                      )}
                    </td>
                    <td>
                      {practitioner.active !== false ? (
                        <span className="badge bg-success">Active</span>
                      ) : (
                        <span className="badge bg-secondary">Inactive</span>
                      )}
                    </td>
                    <td>
                      <div className="btn-group btn-group-sm">
                        <button 
                          className="btn btn-outline-primary" 
                          onClick={() => handleViewPractitioner(practitioner.id!)}
                        >
                          View
                        </button>
                        <button 
                          className="btn btn-outline-danger" 
                          onClick={() => handleDeletePractitioner(practitioner.id!)}
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
          onClick={() => navigate('/practitioners/new')}
        >
          Create New Practitioner
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

export default SearchPractitionerPage;