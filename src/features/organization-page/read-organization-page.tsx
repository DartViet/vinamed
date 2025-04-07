import React, { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router';
import { Organization } from 'fhir/r4';
import { organizationService } from './organization-service/organization-service';

const ReadOrganizationPage: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);
  const [editMode, setEditMode] = useState<boolean>(false);
  const [organization, setOrganization] = useState<Organization | null>(null);
  const [formData, setFormData] = useState({
    name: '',
    type: '',
    active: true,
    phone: '',
    email: '',
    website: '',
    addressLine1: '',
    addressLine2: '',
    city: '',
    state: '',
    postalCode: '',
    country: '',
  });

  useEffect(() => {
    if (!id) {
      setError('No organization ID provided');
      setLoading(false);
      return;
    }

    const fetchOrganization = async () => {
      try {
        setLoading(true);
        const fetchedOrganization = await organizationService.getOrganization(id);
        setOrganization(fetchedOrganization);
        
        // Extract organization data for the form
        setFormData({
          name: fetchedOrganization.name || '',
          type: fetchedOrganization.type?.[0]?.coding?.[0]?.code || '',
          active: fetchedOrganization.active !== false, // Default to true if not specified
          phone: fetchedOrganization.telecom?.find(t => t.system === 'phone')?.value || '',
          email: fetchedOrganization.telecom?.find(t => t.system === 'email')?.value || '',
          website: fetchedOrganization.telecom?.find(t => t.system === 'url')?.value || '',
          addressLine1: fetchedOrganization.address?.[0]?.line?.[0] || '',
          addressLine2: fetchedOrganization.address?.[0]?.line?.[1] || '',
          city: fetchedOrganization.address?.[0]?.city || '',
          state: fetchedOrganization.address?.[0]?.state || '',
          postalCode: fetchedOrganization.address?.[0]?.postalCode || '',
          country: fetchedOrganization.address?.[0]?.country || '',
        });
        
        setLoading(false);
      } catch (err) {
        console.error('Error fetching organization:', err);
        setError('Failed to load organization data. Please try again later.');
        setLoading(false);
      }
    };

    fetchOrganization();
  }, [id]);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement | HTMLTextAreaElement>) => {
    const value = e.target.type === 'checkbox' 
      ? (e.target as HTMLInputElement).checked 
      : e.target.value;
      
    setFormData({
      ...formData,
      [e.target.id]: value
    });
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!organization || !id) return;

    try {
      setLoading(true);
      
      // Create updated organization object
      const updatedOrganization: Organization = {
        ...organization,
        name: formData.name,
        active: formData.active,
        telecom: [
          ...(formData.phone ? [{
            system: 'phone' as 'phone',
            value: formData.phone,
            use: 'work' as 'work'
          }] : []),
          ...(formData.email ? [{
            system: 'email' as 'email',
            value: formData.email,
            use: 'work' as 'work'
          }] : []),
          ...(formData.website ? [{
            system: 'url' as 'url',
            value: formData.website,
            use: 'work' as 'work'
          }] : [])
        ],
        address: [
          {
            use: 'work',
            type: 'both',
            line: [
              formData.addressLine1,
              ...(formData.addressLine2 ? [formData.addressLine2] : [])
            ].filter(Boolean),
            city: formData.city,
            state: formData.state,
            postalCode: formData.postalCode,
            country: formData.country
          }
        ]
      };
      
      // Add type if provided
      if (formData.type) {
        updatedOrganization.type = [{
          coding: [{
            system: 'http://terminology.hl7.org/CodeSystem/organization-type',
            code: formData.type
          }]
        }];
      }
      
      // Update the organization
      await organizationService.updateOrganization(id, updatedOrganization);
      
      // Exit edit mode and show success message
      setEditMode(false);
      window.alert('Organization updated successfully');
      
      // Refresh organization data
      const refreshedOrganization = await organizationService.getOrganization(id);
      setOrganization(refreshedOrganization);
      
      setLoading(false);
    } catch (err) {
      console.error('Error updating organization:', err);
      setError(`Failed to update organization: ${err instanceof Error ? err.message : 'Unknown error'}`);
      setLoading(false);
    }
  };

  const toggleEditMode = () => {
    setEditMode(!editMode);
  };

  const cancelEdit = () => {
    // Reset form data to original organization data
    if (organization) {
      setFormData({
        name: organization.name || '',
        type: organization.type?.[0]?.coding?.[0]?.code || '',
        active: organization.active !== false,
        phone: organization.telecom?.find(t => t.system === 'phone')?.value || '',
        email: organization.telecom?.find(t => t.system === 'email')?.value || '',
        website: organization.telecom?.find(t => t.system === 'url')?.value || '',
        addressLine1: organization.address?.[0]?.line?.[0] || '',
        addressLine2: organization.address?.[0]?.line?.[1] || '',
        city: organization.address?.[0]?.city || '',
        state: organization.address?.[0]?.state || '',
        postalCode: organization.address?.[0]?.postalCode || '',
        country: organization.address?.[0]?.country || '',
      });
    }
    setEditMode(false);
  };

  const handleDelete = async () => {
    if (!id) return;
    
    if (window.confirm('Are you sure you want to delete this organization? This action cannot be undone.')) {
      try {
        setLoading(true);
        await organizationService.deleteOrganization(id);
        window.alert('Organization deleted successfully');
        navigate('/organizations');
      } catch (err) {
        console.error('Error deleting organization:', err);
        setError(`Failed to delete organization: ${err instanceof Error ? err.message : 'Unknown error'}`);
        setLoading(false);
      }
    }
  };

  if (loading) {
    return (
      <div className="container mt-5 text-center">
        <div className="spinner-border" role="status">
          <span className="visually-hidden">Loading...</span>
        </div>
        <p className="mt-2">Loading organization data...</p>
      </div>
    );
  }

  if (error) {
    return (
      <div className="container mt-5">
        <div className="alert alert-danger" role="alert">
          {error}
        </div>
        <button className="btn btn-primary" onClick={() => navigate('/organizations')}>
          Back to Organizations
        </button>
      </div>
    );
  }

  return (
    <div className="container mt-4">
      <div className="d-flex justify-content-between align-items-center mb-4">
        <h2>{editMode ? 'Edit Organization' : 'Organization Details'}</h2>
        <div className="d-flex gap-2">
          {!editMode && (
            <>
              <button 
                className="btn btn-primary"
                onClick={toggleEditMode}
              >
                Edit Organization
              </button>
              <button 
                className="btn btn-danger"
                onClick={handleDelete}
              >
                Delete
              </button>
            </>
          )}
          {editMode && (
            <button 
              className="btn btn-secondary"
              onClick={cancelEdit}
            >
              Cancel
            </button>
          )}
        </div>
      </div>

      <form onSubmit={handleSubmit}>
        <div className="row mb-3">
          <div className="col-md-8">
            <label htmlFor="name" className="form-label">Organization Name*</label>
            <input
              type="text"
              className="form-control"
              id="name"
              value={formData.name}
              onChange={handleChange}
              disabled={!editMode}
              required
            />
          </div>
          <div className="col-md-4">
            <label htmlFor="type" className="form-label">Organization Type</label>
            <select
              className="form-select"
              id="type"
              value={formData.type}
              onChange={handleChange}
              disabled={!editMode}
            >
              <option value="">Select Type...</option>
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
        </div>
        
        <div className="row mb-3">
          <div className="col-md-12">
            <div className="form-check">
              <input
                className="form-check-input"
                type="checkbox"
                id="active"
                checked={formData.active}
                onChange={handleChange}
                disabled={!editMode}
              />
              <label className="form-check-label" htmlFor="active">
                Organization is currently active
              </label>
            </div>
          </div>
        </div>
        
        <h4 className="mt-4">Contact Information</h4>
        
        <div className="row mb-3">
          <div className="col-md-4">
            <label htmlFor="phone" className="form-label">Phone Number</label>
            <input
              type="tel"
              className="form-control"
              id="phone"
              value={formData.phone}
              onChange={handleChange}
              disabled={!editMode}
            />
          </div>
          <div className="col-md-4">
            <label htmlFor="email" className="form-label">Email Address</label>
            <input
              type="email"
              className="form-control"
              id="email"
              value={formData.email}
              onChange={handleChange}
              disabled={!editMode}
            />
          </div>
          <div className="col-md-4">
            <label htmlFor="website" className="form-label">Website</label>
            <input
              type="url"
              className="form-control"
              id="website"
              placeholder="https://"
              value={formData.website}
              onChange={handleChange}
              disabled={!editMode}
            />
          </div>
        </div>
        
        <h4 className="mt-4">Address</h4>
        
        <div className="row mb-3">
          <div className="col-md-6">
            <label htmlFor="addressLine1" className="form-label">Address Line 1</label>
            <input
              type="text"
              className="form-control"
              id="addressLine1"
              value={formData.addressLine1}
              onChange={handleChange}
              disabled={!editMode}
            />
          </div>
          <div className="col-md-6">
            <label htmlFor="addressLine2" className="form-label">Address Line 2</label>
            <input
              type="text"
              className="form-control"
              id="addressLine2"
              value={formData.addressLine2}
              onChange={handleChange}
              disabled={!editMode}
            />
          </div>
        </div>
        
        <div className="row mb-3">
          <div className="col-md-3">
            <label htmlFor="city" className="form-label">City</label>
            <input
              type="text"
              className="form-control"
              id="city"
              value={formData.city}
              onChange={handleChange}
              disabled={!editMode}
            />
          </div>
          <div className="col-md-3">
            <label htmlFor="state" className="form-label">State/Province</label>
            <input
              type="text"
              className="form-control"
              id="state"
              value={formData.state}
              onChange={handleChange}
              disabled={!editMode}
            />
          </div>
          <div className="col-md-3">
            <label htmlFor="postalCode" className="form-label">Postal Code</label>
            <input
              type="text"
              className="form-control"
              id="postalCode"
              value={formData.postalCode}
              onChange={handleChange}
              disabled={!editMode}
            />
          </div>
          <div className="col-md-3">
            <label htmlFor="country" className="form-label">Country</label>
            <input
              type="text"
              className="form-control"
              id="country"
              value={formData.country}
              onChange={handleChange}
              disabled={!editMode}
            />
          </div>
        </div>
        
        {editMode && (
          <div className="d-flex gap-2 mt-4">
            <button 
              type="submit" 
              className="btn btn-success"
              disabled={loading}
            >
              {loading ? (
                <>
                  <span className="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>
                  Saving...
                </>
              ) : 'Save Changes'}
            </button>
            <button 
              type="button" 
              className="btn btn-secondary"
              onClick={cancelEdit}
            >
              Cancel
            </button>
          </div>
        )}
        
        <div className="mt-4">
          {!editMode && (
            <div className="d-flex gap-2">
              <button
                type="button"
                className="btn btn-outline-primary"
                onClick={() => navigate('/organizations')}
              >
                Back to Organizations
              </button>
              
              {organization?.id && (
                <button
                  type="button"
                  className="btn btn-outline-secondary"
                  onClick={() => navigate(`/organizations/${organization.id}/locations`)}
                >
                  View Locations
                </button>
              )}
            </div>
          )}
        </div>
      </form>
    </div>
  );
};

export default ReadOrganizationPage;