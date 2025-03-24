import axios from 'axios';
import PatientService from './patient-service';
import { Patient } from './model';

jest.mock('axios');
const mockedAxios = axios as jest.Mocked<typeof axios>;

describe('PatientService', () => {
  const patient: Patient = {
    resourceType: 'Patient',
    name: [{ given: ['John'], family: 'Doe' }],
    gender: 'male',
    birthDate: '1980-01-01'
  };

  it('should create a patient', async () => {
    mockedAxios.post.mockResolvedValue({ data: patient });

    const result = await PatientService.createPatient(patient);

    expect(result).toEqual(patient);
    expect(mockedAxios.post).toHaveBeenCalledWith(
      'http://hapi.fhir.org/baseR4/Patient',
      patient,
      { headers: { 'Content-Type': 'application/fhir+json' } }
    );
  });

  it('should get a patient by id', async () => {
    mockedAxios.get.mockResolvedValue({ data: patient });

    const result = await PatientService.getPatient('123');

    expect(result).toEqual(patient);
    expect(mockedAxios.get).toHaveBeenCalledWith(
      'http://hapi.fhir.org/baseR4/Patient/123',
      { headers: { 'Accept': 'application/fhir+json' } }
    );
  });

  it('should search patients', async () => {
    const patients = [patient];
    mockedAxios.get.mockResolvedValue({ data: patients });

    const result = await PatientService.searchPatients({ name: 'John' });

    expect(result).toEqual(patients);
    expect(mockedAxios.get).toHaveBeenCalledWith(
      'http://hapi.fhir.org/baseR4/Patient',
      {
        params: { name: 'John' },
        headers: { 'Accept': 'application/fhir+json' }
      }
    );
  });

  it('should delete a patient by id', async () => {
    mockedAxios.delete.mockResolvedValue({});

    await PatientService.deletePatient('123');

    expect(mockedAxios.delete).toHaveBeenCalledWith(
      'http://hapi.fhir.org/baseR4/Patient/123',
      { headers: { 'Accept': 'application/fhir+json' } }
    );
  });
});