import React, { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router';
import { Practitioner } from 'fhir/r4';
import { practitionerService } from './practitioner-service/practitioner-service';

// Define an interface for qualification form data
interface QualificationFormData {
  id: string; // Unique identifier for each qualification in the form
  text: string;
  code: string;
  issuer: string;
  startDate: string;
  endDate: string;
}

const ReadPractitionerPage: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);
  const [editMode, setEditMode] = useState<boolean>(false);
  const [practitioner, setPractitioner] = useState<Practitioner | null>(null);
  
  // Main form data
  const [formData, setFormData] = useState({
    prefix: '',
    givenName: '',
    familyName: '',
    suffix: '',
    gender: '',
    birthDate: '',
    phone: '',
    email: '',
    active: true,
    communication: '',
  });

  // Separate state for qualifications
  const [qualifications, setQualifications] = useState<QualificationFormData[]>([]);

  useEffect(() => {
    if (!id) {
      setError('No practitioner ID provided');
      setLoading(false);
      return;
    }

    const fetchPractitioner = async () => {
      try {
        setLoading(true);
        const fetchedPractitioner = await practitionerService.getPractitioner(id);
        setPractitioner(fetchedPractitioner);
        
        // Extract practitioner data for the form
        setFormData({
          prefix: fetchedPractitioner.name?.[0]?.prefix?.[0] || '',
          givenName: fetchedPractitioner.name?.[0]?.given?.[0] || '',
          familyName: fetchedPractitioner.name?.[0]?.family || '',
          suffix: fetchedPractitioner.name?.[0]?.suffix?.[0] || '',
          gender: fetchedPractitioner.gender || '',
          birthDate: fetchedPractitioner.birthDate || '',
          phone: fetchedPractitioner.telecom?.find(t => t.system === 'phone')?.value || '',
          email: fetchedPractitioner.telecom?.find(t => t.system === 'email')?.value || '',
          active: fetchedPractitioner.active !== false,
          communication: fetchedPractitioner.communication?.[0]?.coding?.[0]?.code || '',
        });
        
        // Extract qualifications
        const extractedQualifications = fetchedPractitioner.qualification?.map(qual => ({
          id: Math.random().toString(36).substring(2, 11), // Generate a unique ID
          text: qual.code?.text || '',
          code: qual.code?.coding?.[0]?.code || '',
          issuer: qual.issuer?.display || '',
          startDate: qual.period?.start || '',
          endDate: qual.period?.end || '',
        })) || [];
        
        // Ensure at least one empty qualification if none exist
        if (extractedQualifications.length === 0) {
          extractedQualifications.push({
            id: Math.random().toString(36).substring(2, 11),
            text: '',
            code: '',
            issuer: '',
            startDate: '',
            endDate: '',
          });
        }
        
        setQualifications(extractedQualifications);
        setLoading(false);
      } catch (err) {
        console.error('Error fetching practitioner:', err);
        setError('Failed to load practitioner data. Please try again later.');
        setLoading(false);
      }
    };

    fetchPractitioner();
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

  // Handler for qualification fields
  const handleQualificationChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>, id: string) => {
    const { name, value } = e.target;
    
    setQualifications(prevQualifications => 
      prevQualifications.map(qual => 
        qual.id === id ? { ...qual, [name]: value } : qual
      )
    );
  };

  // Add a new qualification field
  const addQualification = () => {
    setQualifications([
      ...qualifications, 
      { 
        id: Math.random().toString(36).substring(2, 11),
        text: '',
        code: '',
        issuer: '',
        startDate: '',
        endDate: ''
      }
    ]);
  };

  // Remove a qualification field
  const removeQualification = (id: string) => {
    if (qualifications.length > 1) {
      setQualifications(qualifications.filter(qual => qual.id !== id));
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!practitioner || !id) return;

    try {
      setLoading(true);
      
      // Create updated practitioner object
      const updatedPractitioner: Practitioner = {
        ...practitioner,
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
        updatedPractitioner.gender = formData.gender as 'male' | 'female' | 'other' | 'unknown';
      }
      
      // Add birthDate if provided
      if (formData.birthDate) {
        updatedPractitioner.birthDate = formData.birthDate;
      }
      
      // Process qualifications - filter out empty ones
      const validQualifications = qualifications.filter(q => q.text.trim() !== '');
      
      if (validQualifications.length > 0) {
        updatedPractitioner.qualification = validQualifications.map(qual => {
          const qualification: any = {
            code: {
              text: qual.text
            },
            period: {}
          };
          
          // Add period if dates are provided
          if (qual.startDate) {
            qualification.period.start = qual.startDate;
          }
          
          if (qual.endDate) {
            qualification.period.end = qual.endDate;
          }
          
          // If no dates are provided, remove empty period
          if (!qual.startDate && !qual.endDate) {
            delete qualification.period;
          }
          
          // Add qualification code if provided
          if (qual.code) {
            qualification.code.coding = [
              {
                system: 'http://terminology.hl7.org/CodeSystem/v2-0360',
                code: qual.code
              }
            ];
          }
          
          // Add issuer if provided
          if (qual.issuer) {
            qualification.issuer = {
              display: qual.issuer
            };
          }
          
          return qualification;
        });
      }
      
      // Add communication if provided
      if (formData.communication) {
        updatedPractitioner.communication = [
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
      
      // Update the practitioner
      await practitionerService.updatePractitioner(id, updatedPractitioner);
      
      // Exit edit mode and show success message
      setEditMode(false);
      window.alert('Practitioner updated successfully');
      
      // Refresh practitioner data
      const refreshedPractitioner = await practitionerService.getPractitioner(id);
      setPractitioner(refreshedPractitioner);
      
      setLoading(false);
    } catch (err) {
      console.error('Error updating practitioner:', err);
      setError(`Failed to update practitioner: ${err instanceof Error ? err.message : 'Unknown error'}`);
      setLoading(false);
    }
  };

  const toggleEditMode = () => {
    setEditMode(!editMode);
  };

  const cancelEdit = () => {
    // Reset form data to original practitioner data
    if (practitioner) {
      setFormData({
        prefix: practitioner.name?.[0]?.prefix?.[0] || '',
        givenName: practitioner.name?.[0]?.given?.[0] || '',
        familyName: practitioner.name?.[0]?.family || '',
        suffix: practitioner.name?.[0]?.suffix?.[0] || '',
        gender: practitioner.gender || '',
        birthDate: practitioner.birthDate || '',
        phone: practitioner.telecom?.find(t => t.system === 'phone')?.value || '',
        email: practitioner.telecom?.find(t => t.system === 'email')?.value || '',
        active: practitioner.active !== false,
        communication: practitioner.communication?.[0]?.coding?.[0]?.code || '',
      });
      
      // Reset qualifications
      const resetQualifications = practitioner.qualification?.map(qual => ({
        id: Math.random().toString(36).substring(2, 11),
        text: qual.code?.text || '',
        code: qual.code?.coding?.[0]?.code || '',
        issuer: qual.issuer?.display || '',
        startDate: qual.period?.start || '',
        endDate: qual.period?.end || '',
      })) || [{
        id: Math.random().toString(36).substring(2, 11),
        text: '',
        code: '',
        issuer: '',
        startDate: '',
        endDate: '',
      }];
      
      setQualifications(resetQualifications);
    }
    
    setEditMode(false);
  };

  const handleDelete = async () => {
    if (!id) return;
    
    if (window.confirm('Are you sure you want to delete this practitioner? This action cannot be undone.')) {
      try {
        setLoading(true);
        await practitionerService.deletePractitioner(id);
        window.alert('Practitioner deleted successfully');
        navigate('/practitioners');
      } catch (err) {
        console.error('Error deleting practitioner:', err);
        setError(`Failed to delete practitioner: ${err instanceof Error ? err.message : 'Unknown error'}`);
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
        <p className="mt-2">Loading practitioner data...</p>
      </div>
    );
  }

  if (error) {
    return (
      <div className="container mt-5">
        <div className="alert alert-danger" role="alert">
          {error}
        </div>
        <button className="btn btn-primary" onClick={() => navigate('/practitioners')}>
          Back to Practitioners
        </button>
      </div>
    );
  }

  return (
    <div className="container mt-4">
      <div className="d-flex justify-content-between align-items-center mb-4">
        <h2>
          {editMode ? 'Edit Practitioner' : 'Practitioner Details'}
          {!editMode && !formData.active && (
            <span className="badge bg-warning ms-2">Inactive</span>
          )}
        </h2>
        <div className="d-flex gap-2">
          {!editMode && (
            <>
              <button 
                className="btn btn-primary"
                onClick={toggleEditMode}
              >
                Edit Practitioner
              </button>
              <button 
                className="btn btn-danger"
                onClick={handleDelete}
              >
                Delete
              </button>
            </>
          )}
        </div>
      </div>

      <form onSubmit={handleSubmit}>
        {/* Personal Information Card */}
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
                  disabled={!editMode}
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
                  disabled={!editMode}
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
                  disabled={!editMode}
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
                  disabled={!editMode}
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
                  disabled={!editMode}
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
                  disabled={!editMode}
                />
              </div>
              <div className="col-md-4">
                <label htmlFor="communication" className="form-label">Primary Language</label>
                <select
                  className="form-select"
                  id="communication"
                  value={formData.communication}
                  onChange={handleChange}
                  disabled={!editMode}
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
                disabled={!editMode}
              />
              <label className="form-check-label" htmlFor="active">
                Practitioner is currently active
              </label>
            </div>
          </div>
        </div>
        
        {/* Contact Information Card */}
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
                  disabled={!editMode}
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
                  disabled={!editMode}
                />
              </div>
            </div>
          </div>
        </div>
        
        {/* Qualifications Card */}
        <div className="card mb-4">
          <div className="card-header d-flex justify-content-between align-items-center">
            <h4 className="mb-0">Qualifications</h4>
            {editMode && (
              <button 
                type="button" 
                className="btn btn-outline-primary btn-sm"
                onClick={addQualification}
              >
                Add Qualification
              </button>
            )}
          </div>
          <div className="card-body">
            {qualifications.length === 0 ? (
              <p className="text-muted">No qualifications recorded.</p>
            ) : (
              qualifications.map((qual, index) => (
                <div key={qual.id} className="qualification-item mb-4 pb-4 border-bottom">
                  <div className="d-flex justify-content-between align-items-center mb-3">
                    <h5 className="mb-0">Qualification #{index + 1}</h5>
                    {editMode && qualifications.length > 1 && (
                      <button
                        type="button"
                        className="btn btn-outline-danger btn-sm"
                        onClick={() => removeQualification(qual.id)}
                      >
                        Remove
                      </button>
                    )}
                  </div>
                  
                  <div className="row mb-3">
                    <div className="col-md-6">
                      <label htmlFor={`qualification-text-${qual.id}`} className="form-label">Qualification</label>
                      <input
                        type="text"
                        className="form-control"
                        id={`qualification-text-${qual.id}`}
                        name="text"
                        placeholder="Medical Doctor"
                        value={qual.text}
                        onChange={(e) => handleQualificationChange(e, qual.id)}
                        disabled={!editMode}
                      />
                    </div>
                    <div className="col-md-6">
                      <label htmlFor={`qualification-code-${qual.id}`} className="form-label">Qualification Code</label>
                      <select
                        className="form-select"
                        id={`qualification-code-${qual.id}`}
                        name="code"
                        value={qual.code}
                        onChange={(e) => handleQualificationChange(e, qual.id)}
                        disabled={!editMode}
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
                  </div>
                  
                  <div className="row mb-3">
                    <div className="col-md-4">
                      <label htmlFor={`qualification-issuer-${qual.id}`} className="form-label">Issuing Institution</label>
                      <input
                        type="text"
                        className="form-control"
                        id={`qualification-issuer-${qual.id}`}
                        name="issuer"
                        placeholder="Harvard Medical School"
                        value={qual.issuer}
                        onChange={(e) => handleQualificationChange(e, qual.id)}
                        disabled={!editMode}
                      />
                    </div>
                    <div className="col-md-4">
                      <label htmlFor={`qualification-start-${qual.id}`} className="form-label">Start Date</label>
                      <input
                        type="date"
                        className="form-control"
                        id={`qualification-start-${qual.id}`}
                        name="startDate"
                        value={qual.startDate}
                        onChange={(e) => handleQualificationChange(e, qual.id)}
                        disabled={!editMode}
                      />
                    </div>
                    <div className="col-md-4">
                      <label htmlFor={`qualification-end-${qual.id}`} className="form-label">End Date</label>
                      <input
                        type="date"
                        className="form-control"
                        id={`qualification-end-${qual.id}`}
                        name="endDate"
                        value={qual.endDate}
                        onChange={(e) => handleQualificationChange(e, qual.id)}
                        disabled={!editMode}
                      />
                    </div>
                  </div>
                </div>
              ))
            )}
          </div>
        </div>
        
        <div className="d-flex gap-2 mt-4">
          {editMode && (
            <>
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
            </>
          )}
          
          {!editMode && (
            <button
              type="button"
              className="btn btn-outline-primary"
              onClick={() => navigate('/practitioners')}
            >
              Back to Practitioners
            </button>
          )}
        </div>
      </form>
      
      {/* If you want to show related data like PractitionerRole */}
      {!editMode && practitioner?.id && (
        <div className="mt-5">
          <h3>Roles & Assignments</h3>
          <div className="d-grid gap-2 d-md-flex mt-3">
            <button
              className="btn btn-outline-secondary"
              onClick={() => navigate(`/practitioners/${practitioner.id}/roles`)}
            >
              View Roles
            </button>
            <button
              className="btn btn-outline-secondary"
              onClick={() => navigate(`/practitioners/${practitioner.id}/schedule`)}
            >
              View Schedule
            </button>
          </div>
        </div>
      )}
    </div>
  );
};

export default ReadPractitionerPage;