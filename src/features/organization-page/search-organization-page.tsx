import React, { useState } from 'react';
import { useNavigate } from 'react-router';
import { Organization } from 'fhir/r4';
import { organizationService } from './organization-service/organization-service';

const SearchOrganizationPage: React.FC = () => {
  const navigate = useNavigate();
  const [searchCriteria, setSearchCriteria] = useState({
    name: '',
    type: '',
    city: '',
    state: '',
    active: '',
  });
  const [organizations, setOrganizations] = useState<Organization[]>([]);
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
      type: '',
      city: '',
      state: '',
      active: '',
    });
    setOrganizations([]);
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
      
      if (searchCriteria.type) {
        queryParams['type'] = searchCriteria.type;
      }
      
      if (searchCriteria.city.trim()) {
        queryParams['address-city'] = searchCriteria.city.trim();
      }
      
      if (searchCriteria.state.trim()) {
        queryParams['address-state'] = searchCriteria.state.trim();
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
      const results = await organizationService.searchOrganizations(queryParams);
      setOrganizations(results);
      setLoading(false);
    } catch (err) {
      console.error('Error searching organizations:', err);
      setError('An error occurred while searching. Please try again.');
      setLoading(false);
    }
  };

  const handleViewOrganization = (id: string) => {
    navigate(`/organizations/${id}`);
  };

  const handleDeleteOrganization = async (id: string) => {
    if (window.confirm('Are you sure you want to delete this organization?')) {
      try {
        await organizationService.deleteOrganization(id);
        // Refresh the search results after deleting
        const updatedOrganizations = organizations.filter(org => org.id !== id);
        setOrganizations(updatedOrganizations);
        alert('Organization deleted successfully');
      } catch (err) {
        console.error('Error deleting organization:', err);
        alert('Failed to delete organization');
      }
    }
  };

  return (
    <div className="container mt-5">
      <h2 className="mb-4">Search Organizations</h2>
      
      <form onSubmit={handleSearch} className="mb-5">
        <div className="row g-3">
          <div className="col-md-6">
            <label htmlFor="name" className="form-label">Organization Name</label>
            <input
              type="text"
              className="form-control"
              id="name"
              value={searchCriteria.name}
              onChange={handleChange}
              placeholder="General Hospital"
            />
          </div>
          
          <div className="col-md-6">
            <label htmlFor="type" className="form-label">Organization Type</label>
            <select
              className="form-select"
              id="type"
              value={searchCriteria.type}
              onChange={handleChange}
            >
              <option value="">Any Type</option>
              <option value="prov">Healthcare Provider</option>
              <option value="dept">Hospital Department</option>
              <option value="team">Organizational Team</option>
              <option value="govt">Government</option>
              <option value="ins">Insurance Company</option>
              <option value="edu">Educational Institute</option>
              <option value="reli">Religious Institution</option>
              <option value="crs">Clinical Research Sponsor</option>
              <option value="cg">Community Group</option>
              <option value="bus">Non-Healthcare Business</option>
              <option value="other">Other</option>
            </select>
          </div>
          
          <div className="col-md-3">
            <label htmlFor="city" className="form-label">City</label>
            <input
              type="text"
              className="form-control"
              id="city"
              value={searchCriteria.city}
              onChange={handleChange}
              placeholder="Boston"
            />
          </div>
          
          <div className="col-md-3">
            <label htmlFor="state" className="form-label">State/Province</label>
            <input
              type="text"
              className="form-control"
              id="state"
              value={searchCriteria.state}
              onChange={handleChange}
              placeholder="MA"
            />
          </div>
          
          <div className="col-md-6">
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
                ) : 'Search Organizations'}
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
      
      {searched && !loading && organizations.length === 0 && !error && (
        <div className="alert alert-info" role="alert">
          No organizations found matching your criteria.
        </div>
      )}
      
      {organizations.length > 0 && (
        <>
          <h3 className="mb-3">Search Results</h3>
          <div className="table-responsive">
            <table className="table table-hover">
              <thead>
                <tr>
                  <th>Name</th>
                  <th>Type</th>
                  <th>Contact Info</th>
                  <th>Address</th>
                  <th>Status</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                {organizations.map((org) => (
                  <tr key={org.id}>
                    <td className="fw-bold">{org.name}</td>
                    <td>
                      {org.type?.[0]?.coding?.[0]?.code && getOrganizationTypeDisplay(org.type[0].coding[0].code)}
                    </td>
                    <td>
                      {org.telecom?.find(t => t.system === 'phone')?.value && (
                        <div><small>📞 {org.telecom?.find(t => t.system === 'phone')?.value}</small></div>
                      )}
                      {org.telecom?.find(t => t.system === 'email')?.value && (
                        <div><small>✉️ {org.telecom?.find(t => t.system === 'email')?.value}</small></div>
                      )}
                    </td>
                    <td>
                      { org.address?.length && org.address.length > 0 && (
                        <small>
                          {org.address[0].city}
                          {org.address[0].state && `, ${org.address[0].state}`}
                          {org.address[0].country && ` (${org.address[0].country})`}
                        </small>
                      )}
                    </td>
                    <td>
                      {org.active !== false ? (
                        <span className="badge bg-success">Active</span>
                      ) : (
                        <span className="badge bg-secondary">Inactive</span>
                      )}
                    </td>
                    <td>
                      <div className="btn-group btn-group-sm">
                        <button 
                          className="btn btn-outline-primary" 
                          onClick={() => handleViewOrganization(org.id!)}
                        >
                          View
                        </button>
                        <button 
                          className="btn btn-outline-danger" 
                          onClick={() => handleDeleteOrganization(org.id!)}
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
          onClick={() => navigate('/organizations/new')}
        >
          Create New Organization
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

// Helper function to display organization type in a human-readable format
const getOrganizationTypeDisplay = (code: string): string => {
  const typeMap: Record<string, string> = {
    'prov': 'Healthcare Provider',
    'dept': 'Hospital Department',
    'team': 'Organizational Team',
    'govt': 'Government',
    'ins': 'Insurance Company',
    'edu': 'Educational Institute',
    'reli': 'Religious Institution',
    'crs': 'Clinical Research Sponsor',
    'cg': 'Community Group',
    'bus': 'Non-Healthcare Business',
    'other': 'Other'
  };
  
  return typeMap[code] || code;
};

export default SearchOrganizationPage;