
import React, { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router';
import { Patient } from 'fhir/r4';
import { patientService } from './patient-services/patient-service';

const ReadEditPatientPage: React.FC = () => {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const [loading, setLoading] = useState<boolean>(true);
  const [error, setError] = useState<string | null>(null);
  const [editMode, setEditMode] = useState<boolean>(false);
  const [patient, setPatient] = useState<Patient | null>(null);
  const [formData, setFormData] = useState({
    givenName: '',
    familyName: '',
    dob: '',
    gender: '',
    phone: '',
    address: '',
    language: '',
  });

  useEffect(() => {
    if (!id) {
      setError('No patient ID provided');
      setLoading(false);
      return;
    }

    const fetchPatient = async () => {
      try {
        setLoading(true);
        const fetchedPatient = await patientService.getPatient(id);
        let utcBirthDate = fetchedPatient.birthDate?.split('T')[0];
        let dob = utcBirthDate;
        setPatient(fetchedPatient);
        
        // Extract patient data for the form
        setFormData({
          givenName: fetchedPatient.name?.[0]?.given?.[0] || '',
          familyName: fetchedPatient.name?.[0]?.family || '',
          dob: dob || '',
          gender: fetchedPatient.gender || '',
          phone: fetchedPatient.telecom?.find(t => t.system === 'phone')?.value || '',
          address: fetchedPatient.address?.[0]?.text || '',
          language: fetchedPatient.communication?.[0]?.language?.coding?.[0]?.code || '',
        });
        
        setLoading(false);
      } catch (err) {
        console.error('Error fetching patient:', err);
        setError('Failed to load patient data. Please try again later.');
        setLoading(false);
      }
    };

    fetchPatient();
  }, [id]);

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
    setFormData({
      ...formData,
      [e.target.id]: e.target.value
    });
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (!patient) return;

    try {
      // Create updated patient object
      const updatedPatient: Patient = {
        ...patient,
        name: [{
          use: 'official',
          family: formData.familyName,
          given: [formData.givenName]
        }],
        birthDate: formData.dob,
        gender: formData.gender as "male" | "female" | "other" | "unknown" | undefined,
        telecom: [
          {
            system: 'phone',
            value: formData.phone
          }
        ],
        address: [
          {
            use: 'home',
            text: formData.address
          }
        ],
        communication: [
          { 
            language: { 
              coding: [{ 
                code: formData.language 
              }] 
            } 
          }
        ]
      };

      // Update the patient
      if (id) {
        await patientService.updatePatient(id, updatedPatient);
      } else {
        throw new Error('Patient ID is undefined');
      }
      
      // Exit edit mode and show success message
      setEditMode(false);
      window.alert('Patient updated successfully');
      
      // Refresh patient data
      const refreshedPatient = await patientService.getPatient(id);
      setPatient(refreshedPatient);
      
    } catch (err) {
      console.error('Error updating patient:', err);
      window.alert('Failed to update patient. Please try again.');
    }
  };

  const toggleEditMode = () => {
    setEditMode(!editMode);
  };

  const cancelEdit = () => {
    // Reset form data to original patient data
    if (patient) {
      setFormData({
        givenName: patient.name?.[0]?.given?.[0] || '',
        familyName: patient.name?.[0]?.family || '',
        dob: patient.birthDate || '',
        gender: patient.gender || '',
        phone: patient.telecom?.find(t => t.system === 'phone')?.value || '',
        address: patient.address?.[0]?.text || '',
        language: patient.communication?.[0]?.language?.coding?.[0]?.code || '',
      });
    }
    setEditMode(false);
  };

  if (loading) {
    return (
      <div className="container mt-5 text-center">
        <div className="spinner-border" role="status">
          <span className="visually-hidden">Loading...</span>
        </div>
        <p className="mt-2">Loading patient data...</p>
      </div>
    );
  }

  if (error) {
    return (
      <div className="container mt-5">
        <div className="alert alert-danger" role="alert">
          {error}
        </div>
        <button className="btn btn-primary" onClick={() => navigate('/')}>
          Back to Patients
        </button>
      </div>
    );
  }

  return (
    <div className="container mt-5">
      <div className="d-flex justify-content-between align-items-center mb-4">
        <h2>{editMode ? 'Edit Patient' : 'Patient Details'}</h2>
        <div>
          {!editMode && (
            <button 
              className="btn btn-primary"
              onClick={toggleEditMode}
            >
              Edit Patient
            </button>
          )}
          {editMode && (
            <div className="d-flex gap-2">
              <button 
                className="btn btn-secondary"
                onClick={cancelEdit}
              >
                Cancel
              </button>
            </div>
          )}
        </div>
      </div>

      <form onSubmit={handleSubmit}>
        <div className="mb-3">
          <label htmlFor="givenName" className="form-label">Given Name</label>
          <input 
            type="text" 
            className="form-control" 
            id="givenName" 
            value={formData.givenName} 
            onChange={handleChange} 
            disabled={!editMode}
            required 
          />
        </div>
        
        <div className="mb-3">
          <label htmlFor="familyName" className="form-label">Family Name</label>
          <input 
            type="text" 
            className="form-control" 
            id="familyName" 
            value={formData.familyName} 
            onChange={handleChange} 
            disabled={!editMode}
            required 
          />
        </div>
        
        <div className="mb-3">
          <label htmlFor="dob" className="form-label">Date of Birth</label>
          <input 
            type="date" 
            className="form-control" 
            id="dob" 
            value={formData.dob} 
            onChange={handleChange} 
            disabled={!editMode}
          />
        </div>
        
        <div className="mb-3">
          <label htmlFor="gender" className="form-label">Gender</label>
          <select 
            className="form-select" 
            id="gender" 
            value={formData.gender} 
            onChange={handleChange} 
            disabled={!editMode}
          >
            <option value="">Select gender...</option>
            <option value="male">Male</option>
            <option value="female">Female</option>
            <option value="other">Other</option>
            <option value="unknown">Unknown</option>
          </select>
        </div>
        
        <div className="mb-3">
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
        
        <div className="mb-3">
          <label htmlFor="address" className="form-label">Address</label>
          <textarea 
            className="form-control" 
            id="address" 
            value={formData.address} 
            onChange={handleChange as any} 
            disabled={!editMode}
            rows={3}
          />
        </div>
        
        <div className="mb-3">
          <label htmlFor="language" className="form-label">Preferred Language</label>
          <input 
            type="text" 
            className="form-control" 
            id="language" 
            value={formData.language} 
            onChange={handleChange} 
            disabled={!editMode}
          />
        </div>
        
        {editMode && (
          <div className="d-flex gap-2 mt-4">
            <button 
              type="submit" 
              className="btn btn-success"
            >
              Save Changes
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
        
        <button 
          type="button" 
          className="btn btn-link mt-3"
          onClick={() => navigate('/')}
        >
          Back to Patient List
        </button>
      </form>
    </div>
  );
};

export default ReadEditPatientPage;