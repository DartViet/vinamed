import React, { useState } from "react";
import "bootstrap/dist/css/bootstrap.min.css";
import { Patient } from "fhir/r4";
import { patientService } from "./patient-services/patient-service";
import { useNavigate } from "react-router";

const CreatePatient: React.FC = () => {
  const navigate = useNavigate();
  const [formData, setFormData] = useState({
    givenName: "",
    familyName: "",
    dob: "",
    gender: "",
    phone: "",
    address: "",
    language: ""
  });

  const handleChange = (e: React.ChangeEvent<HTMLInputElement | HTMLSelectElement>) => {
    setFormData({ ...formData, [e.target.id]: e.target.value });
  };

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    let dateTime = new Date(formData.dob);

    let dob = dateTime.toISOString().split('T')[0];
    let patient: Patient = {
      resourceType: "Patient",
      name: [
        {
          use: "official",
          family: formData.familyName,
          given: [formData.givenName]
        }
      ],
      birthDate: dob,
      address: [
        {
          use: "home",
          text: formData.address
        }],
      gender: formData.gender as "male" | "female" | "other" | "unknown" | undefined,
      telecom: [
        {
          system: "phone",
          value: formData.phone
        }
      ],
      communication: [
        { language: { coding: [{ code: formData.language }] } }
      ]
    };


    patientService.createPatient(patient).then((patient) => {

      let objec = patient;
      if (objec.hasOwnProperty('id')) {
        alert('Patient created successfully');
        navigate('/');
      } else {
        alert('Error creating patient');
      }
    });
  };

  return (
    <div className="container mt-5">
      <h2 className="mb-4">Create Patient</h2>
      <form onSubmit={handleSubmit}>
        <div className="mb-3">
          <label htmlFor="givenName" className="form-label">Given Name</label>
          <input type="text" className="form-control" id="givenName" value={formData.givenName} onChange={handleChange} required />
        </div>
        <div className="mb-3">
          <label htmlFor="familyName" className="form-label">Family Name</label>
          <input type="text" className="form-control" id="familyName" value={formData.familyName} onChange={handleChange} required />
        </div>
        <div className="mb-3">
          <label htmlFor="dob" className="form-label">Date of Birth</label>
          <input type="date" className="form-control" id="dob" value={formData.dob} onChange={handleChange} required />
        </div>
        <div className="mb-3">
          <label htmlFor="gender" className="form-label">Gender</label>
          <select className="form-select" id="gender" value={formData.gender} onChange={handleChange} required>
            <option value="">Select Gender</option>
            <option value="male">Male</option>
            <option value="female">Female</option>
            <option value="other">Other</option>
            <option value="unknown">Unknown</option>
          </select>
        </div>
        <div className="mb-3">
          <label htmlFor="phone" className="form-label">Phone Number</label>
          <input type="tel" className="form-control" id="phone" value={formData.phone} onChange={handleChange} />
        </div>
        <div className="mb-3">
          <label htmlFor="address" className="form-label">Address</label>
          <input type="text" className="form-control" id="address" value={formData.address} onChange={handleChange} />
        </div>
        <div className="mb-3">
          <label htmlFor="language" className="form-label">Preferred Language</label>
          <select className="form-select" id="language" value={formData.language} onChange={handleChange}>
            <option value="">Select Language</option>
            <option value="en">English</option>
            <option value="zh">Chinese</option>
            <option value="ja">Japanese</option>
            <option value="ko">Korean</option>
            <option value="ru">Russian</option>
            <option value="ms">Malay</option>
            <option value="id">Indonesian</option>
            <option value="tl">Tagalog</option>
            <option value="vi">Vietnamese</option>
            <option value="th">Thai</option>
            <option value="my">Burmese</option>
            <option value="km">Khmer</option>
            <option value="lo">Lao</option>
          </select>
        </div>
        <button type="submit" className="btn btn-primary">Create Patient</button>
      </form>
    </div>
  );
};

export default CreatePatient;