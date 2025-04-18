import React, { useState } from "react";
import "bootstrap/dist/css/bootstrap.min.css";
import { Patient } from "fhir/r4";
import { patientService } from "./patient-services/patient-service";
import { useNavigate } from "react-router";
import { useTranslation } from 'react-i18next';

const CreatePatient: React.FC = () => {
  const navigate = useNavigate();
  const { t } = useTranslation();
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
      <h2 className="mb-4">{t('createPatient.title')}</h2>
      <form onSubmit={handleSubmit}>
        <div className="mb-3">
          <label htmlFor="givenName" className="form-label">{t('createPatient.givenName')}</label>
          <input type="text" className="form-control" id="givenName" value={formData.givenName} onChange={handleChange} required />
        </div>
        <div className="mb-3">
          <label htmlFor="familyName" className="form-label">{t('createPatient.familyName')}</label>
          <input type="text" className="form-control" id="familyName" value={formData.familyName} onChange={handleChange} required />
        </div>
        <div className="mb-3">
          <label htmlFor="dob" className="form-label">{t('createPatient.dayOfBirth')}</label>
          <input type="date" className="form-control" id="dob" value={formData.dob} onChange={handleChange} required />
        </div>
        <div className="mb-3">
          <label htmlFor="gender" className="form-label">{t('createPatient.gender')}</label>
          <select className="form-select" id="gender" value={formData.gender} onChange={handleChange} required>
            <option value="">{t('createPatient.gender')}</option>
            <option value="male">{t('createPatient.male')}</option>
            <option value="female">{t('createPatient.female')}</option>
            <option value="other">{t('createPatient.other')}</option>
            <option value="unknown">{t('createPatient.unknown')}</option>
          </select>
        </div>
        <div className="mb-3">
          <label htmlFor="phone" className="form-label">{t('createPatient.phoneNumber')}</label>
          <input type="tel" className="form-control" id="phone" value={formData.phone} onChange={handleChange} />
        </div>
        <div className="mb-3">
          <label htmlFor="address" className="form-label">{t('createPatient.address')}</label>
          <input type="text" className="form-control" id="address" value={formData.address} onChange={handleChange} />
        </div>
        <div className="mb-3">
          <label htmlFor="language" className="form-label">{t('createPatient.preferredLanguage')}</label>
          <select className="form-select" id="language" value={formData.language} onChange={handleChange}>
            <option value="">{t('createPatient.selectLanguage')}</option>
            <option value="en">{t('createPatient.languages.en')}</option>
            <option value="zh">{t('createPatient.languages.zh')}</option>
            <option value="ja">{t('createPatient.languages.ja')}</option>
            <option value="ko">{t('createPatient.languages.ko')}</option>
            <option value="ru">{t('createPatient.languages.ru')}</option>
            <option value="ms">{t('createPatient.languages.ms')}</option>
            <option value="id">{t('createPatient.languages.id')}</option>
            <option value="tl">{t('createPatient.languages.tl')}</option>
            <option value="vi">{t('createPatient.languages.vi')}</option>
            <option value="th">{t('createPatient.languages.th')}</option>
            <option value="my">{t('createPatient.languages.my')}</option>
            <option value="km">{t('createPatient.languages.km')}</option>
            <option value="lo">{t('createPatient.languages.lo')}</option>
          </select>
        </div>
        <button type="submit" className="btn btn-primary">{t('createPatient.createPatient')}</button>
      </form>
    </div>
  );
};

export default CreatePatient;