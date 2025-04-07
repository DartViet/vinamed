import React, { useState } from 'react';
import { useNavigate } from 'react-router';
import { Practitioner, PractitionerQualification } from 'fhir/r4';
import { practitionerService } from './practitioner-service/practitioner-service';

const CreatePractitionerPage: React.FC = () => {
  const navigate = useNavigate();
  const [loading, setLoading] = useState<boolean>(false);
  const [error, setError] = useState<string | null>(null);
  
  const [formData, setFormData] = useState({
    prefix: '',
    givenName: '',
    familyName: '',
    suffix: '',
    gender: '',
    birthDate: '',
    phone: '',
    email: '',
    qualification: '',
    qualificationIssuer: '',
    qualificationCode: '',
    active: true,
    communication: '',
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
      
      // Create the FHIR Practitioner resource
      const practitioner: Practitioner = {
        resourceType: 'Practitioner',
        active: formData.active,
        name: [
          {
            use: 'official',
            family: formData.familyName,
            given: formData.givenName ? [formData.givenName] : undefined,
            prefix: formData.prefix ? [formData.prefix] : undefined,
            suffix: formData.suffix ? [formData.suffix] : undefined
          }
        ],
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
          }] : [])
        ]
      };
      
      // Add gender if provided
      if (formData.gender) {
        practitioner.gender = formData.gender as 'male' | 'female' | 'other' | 'unknown';
      }
      
      // Add birthDate if provided
      if (formData.birthDate) {
        // Format date to YYYY-MM-DD
        const birthDate = new Date(formData.birthDate);
        practitioner.birthDate = birthDate.toISOString().split('T')[0];
      }
      
      // Add qualification if provided
      if (formData.qualification) {
        const qualification: PractitionerQualification = {
            code: {
                text: formData.qualification,
                coding: []
            },
            period: {
                start: new Date().toISOString()
            }
        }
        
        // Add qualification code if provided
        if (formData.qualificationCode) {
          qualification.code.coding = [
            {
              system: 'http://terminology.hl7.org/CodeSystem/v2-0360',
              code: formData.qualificationCode
            }
          ];
        }
        
        // Add issuer if provided
        if (formData.qualificationIssuer) {
          qualification.issuer = {
            display: formData.qualificationIssuer
          };
        }
        
        practitioner.qualification = [qualification];
      }
      
      // Add communication if provided
      if (formData.communication) {
        practitioner.communication = [
          {
            coding: [
              {
                system: 'urn:ietf:bcp:47',
                code: formData.communication
              }
            ]
          }
        ];
      }
      
      // Send the practitioner to the FHIR server
      await practitionerService.createPractitioner(practitioner);
      
      // Show success message
      alert('Practitioner created successfully!');
      
      // Navigate back to the practitioner list
      navigate('/practitioners');
      
    } catch (err) {
      console.error('Error creating practitioner:', err);
      setError(`Failed to create practitioner: ${err instanceof Error ? err.message : 'Unknown error'}`);
      setLoading(false);
    }
  };

  return (
    <div className="container mt-4">
      <div className="row">
        <div className="col">
          <h2>Create New Practitioner</h2>
          
          {error && (
            <div className="alert alert-danger" role="alert">
              {error}
            </div>
          )}
          
          <form onSubmit={handleSubmit} className="mt-4">
            <div className="card mb-4">
              <div className="card-header">
                <h4 className="mb-0">Personal Information</h4>
              </div>
              <div className="card-body">
                <div className="row mb-3">
                  <div className="col-md-2">
                    <label htmlFor="prefix" className="form-label">Title</label>
                    <input
                      type="text"
                      className="form-control"
                      id="prefix"
                      placeholder="Dr"
                      value={formData.prefix}
                      onChange={handleChange}
                    />
                  </div>
                  <div className="col-md-4">
                    <label htmlFor="givenName" className="form-label">Given Name*</label>
                    <input
                      type="text"
                      className="form-control"
                      id="givenName"
                      placeholder="John"
                      value={formData.givenName}
                      onChange={handleChange}
                      required
                    />
                  </div>
                  <div className="col-md-4">
                    <label htmlFor="familyName" className="form-label">Family Name*</label>
                    <input
                      type="text"
                      className="form-control"
                      id="familyName"
                      placeholder="Smith"
                      value={formData.familyName}
                      onChange={handleChange}
                      required
                    />
                  </div>
                  <div className="col-md-2">
                    <label htmlFor="suffix" className="form-label">Suffix</label>
                    <input
                      type="text"
                      className="form-control"
                      id="suffix"
                      placeholder="PhD"
                      value={formData.suffix}
                      onChange={handleChange}
                    />
                  </div>
                </div>
                
                <div className="row mb-3">
                  <div className="col-md-4">
                    <label htmlFor="gender" className="form-label">Gender</label>
                    <select
                      className="form-select"
                      id="gender"
                      value={formData.gender}
                      onChange={handleChange}
                    >
                      <option value="">Select Gender</option>
                      <option value="male">Male</option>
                      <option value="female">Female</option>
                      <option value="other">Other</option>
                      <option value="unknown">Unknown</option>
                    </select>
                  </div>
                  <div className="col-md-4">
                    <label htmlFor="birthDate" className="form-label">Birth Date</label>
                    <input
                      type="date"
                      className="form-control"
                      id="birthDate"
                      value={formData.birthDate}
                      onChange={handleChange}
                    />
                  </div>
                  <div className="col-md-4">
                    <label htmlFor="communication" className="form-label">Primary Language</label>
                    <select
                      className="form-select"
                      id="communication"
                      value={formData.communication}
                      onChange={handleChange}
                    >
                      <option value="">Select Language</option>
                      <option value="en">English</option>
                      <option value="es">Spanish</option>
                      <option value="fr">French</option>
                      <option value="de">German</option>
                      <option value="it">Italian</option>
                      <option value="pt">Portuguese</option>
                      <option value="vi">Vietnamese</option>
                      <option value="zh">Chinese</option>
                    </select>
                  </div>
                </div>
                
                <div className="form-check mb-3">
                  <input
                    className="form-check-input"
                    type="checkbox"
                    id="active"
                    checked={formData.active}
                    onChange={handleChange}
                  />
                  <label className="form-check-label" htmlFor="active">
                    Practitioner is currently active
                  </label>
                </div>
              </div>
            </div>
            
            <div className="card mb-4">
              <div className="card-header">
                <h4 className="mb-0">Contact Information</h4>
              </div>
              <div className="card-body">
                <div className="row">
                  <div className="col-md-6 mb-3">
                    <label htmlFor="phone" className="form-label">Phone Number</label>
                    <input
                      type="tel"
                      className="form-control"
                      id="phone"
                      placeholder="555-123-4567"
                      value={formData.phone}
                      onChange={handleChange}
                    />
                  </div>
                  <div className="col-md-6 mb-3">
                    <label htmlFor="email" className="form-label">Email Address</label>
                    <input
                      type="email"
                      className="form-control"
                      id="email"
                      placeholder="john.smith@example.com"
                      value={formData.email}
                      onChange={handleChange}
                    />
                  </div>
                </div>
              </div>
            </div>
            
            <div className="card mb-4">
              <div className="card-header">
                <h4 className="mb-0">Qualifications</h4>
              </div>
              <div className="card-body">
                <div className="row mb-3">
                  <div className="col-md-4">
                    <label htmlFor="qualification" className="form-label">Qualification</label>
                    <input
                      type="text"
                      className="form-control"
                      id="qualification"
                      placeholder="Medical Doctor"
                      value={formData.qualification}
                      onChange={handleChange}
                    />
                  </div>
                  <div className="col-md-4">
                    <label htmlFor="qualificationCode" className="form-label">Qualification Code</label>
                    <select
                      className="form-select"
                      id="qualificationCode"
                      value={formData.qualificationCode}
                      onChange={handleChange}
                    >
                      <option value="">Select Code</option>
                      <option value="MD">MD - Doctor of Medicine</option>
                      <option value="DO">DO - Doctor of Osteopathy</option>
                      <option value="NP">NP - Nurse Practitioner</option>
                      <option value="PA">PA - Physician Assistant</option>
                      <option value="RN">RN - Registered Nurse</option>
                      <option value="PT">PT - Physical Therapist</option>
                      <option value="OT">OT - Occupational Therapist</option>
                      <option value="PHD">PHD - Doctor of Philosophy</option>
                      <option value="MSW">MSW - Master of Social Work</option>
                      <option value="DDS">DDS - Doctor of Dental Surgery</option>
                    </select>
                  </div>
                  <div className="col-md-4">
                    <label htmlFor="qualificationIssuer" className="form-label">Issuing Institution</label>
                    <input
                      type="text"
                      className="form-control"
                      id="qualificationIssuer"
                      placeholder="Harvard Medical School"
                      value={formData.qualificationIssuer}
                      onChange={handleChange}
                    />
                  </div>
                </div>
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
                ) : 'Create Practitioner'}
              </button>
              <button
                type="button"
                className="btn btn-secondary"
                onClick={() => navigate('/practitioners')}
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

export default CreatePractitionerPage;