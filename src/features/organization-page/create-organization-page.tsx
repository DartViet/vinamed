import React, { useState } from 'react';
import { useNavigate } from 'react-router';
import { Organization } from 'fhir/r4';
import { organizationService } from './organization-service/organization-service';

const CreateOrganizationPage: React.FC = () => {
  const navigate = useNavigate();
  const [loading, setLoading] = useState<boolean>(false);
  const [error, setError] = useState<string | null>(null);
  
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
    
    try {
      setLoading(true);
      setError(null);
      
      // Create the FHIR Organization resource
      const organization: Organization = {
        resourceType: 'Organization',
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
            ],
            city: formData.city,
            state: formData.state,
            postalCode: formData.postalCode,
            country: formData.country
          }
        ]
      };
      
      // Add type if provided
      if (formData.type) {
        organization.type = [{
          coding: [{
            system: 'http://terminology.hl7.org/CodeSystem/organization-type',
            code: formData.type
          }]
        }];
      }
      
      // Send the organization to the FHIR server
    await organizationService.createOrganization(organization);
      
      // Show success message
      alert('Organization created successfully!');
      
      // Navigate back to the organization list
      navigate('/organizations');
      
    } catch (err) {
      console.error('Error creating organization:', err);
      setError(`Failed to create organization: ${err instanceof Error ? err.message : 'Unknown error'}`);
      setLoading(false);
    }
  };

  return (
    <div className="container mt-4">
      <div className="row">
        <div className="col">
          <h2>Create New Organization</h2>
          
          {error && (
            <div className="alert alert-danger" role="alert">
              {error}
            </div>
          )}
          
          <form onSubmit={handleSubmit} className="mt-4">
            <div className="row mb-3">
              <div className="col-md-12">
                <label htmlFor="name" className="form-label">Organization Name*</label>
                <input
                  type="text"
                  className="form-control"
                  id="name"
                  value={formData.name}
                  onChange={handleChange}
                  required
                />
              </div>
            </div>
            
            <div className="row mb-3">
              <div className="col-md-6">
                <label htmlFor="type" className="form-label">Organization Type</label>
                <select
                  className="form-select"
                  id="type"
                  value={formData.type}
                  onChange={handleChange}
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
              <div className="col-md-6">
                <div className="form-check mt-4">
                  <input
                    className="form-check-input"
                    type="checkbox"
                    id="active"
                    checked={formData.active}
                    onChange={handleChange}
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
                />
              </div>
            </div>
            
            <div className="d-flex gap-2 mt-4">
              <button 
                type="submit" 
                className="btn btn-primary"
                disabled={loading}
              >
                {loading ? (
                  <>
                    <span className="spinner-border spinner-border-sm me-2" role="status" aria-hidden="true"></span>
                    Creating...
                  </>
                ) : 'Create Organization'}
              </button>
              <button
                type="button"
                className="btn btn-secondary"
                onClick={() => navigate('/organizations')}
              >
                Cancel
              </button>
            </div>
          </form>
        </div>
      </div>
    </div>
  );
};

export default CreateOrganizationPage;