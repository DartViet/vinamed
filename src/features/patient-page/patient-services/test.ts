import { Patient } from 'fhir/r4';
import { patientService } from './patient-service';

// Mock fetch globally
global.fetch = jest.fn();

describe('PatientService', () => {
  // Setup and teardown
  beforeEach(() => {
    jest.resetAllMocks();
  });

  const patient: Patient = {
    resourceType: 'Patient',
    name: [{ given: ['John'], family: 'Doe' }],
    gender: 'male',
    birthDate: '1980-01-01'
  };

  it('should create a patient', async () => {
    // Mock fetch response
    (fetch as jest.Mock).mockResolvedValueOnce({
      ok: true,
      json: async () => patient,
    });

    const result = await patientService.createPatient(patient);

    expect(result).toEqual(patient);
    expect(fetch).toHaveBeenCalledWith(
      'http://hapi.fhir.org/baseR4/Patient',
      {
        method: 'POST',
        headers: { 'Content-Type': 'application/fhir+json' },
        body: JSON.stringify(patient)
      }
    );
  });

  it('should get a patient by id', async () => {
    (fetch as jest.Mock).mockResolvedValueOnce({
      ok: true,
      json: async () => patient,
    });

    const result = await patientService.getPatient('123');

    expect(result).toEqual(patient);
    expect(fetch).toHaveBeenCalledWith(
      'http://hapi.fhir.org/baseR4/Patient/123',
      {
        method: 'GET',
        headers: { 'Accept': 'application/fhir+json' }
      }
    );
  });

  it('should search patients', async () => {
    const bundleResponse = {
      entry: [
        { resource: patient }
      ]
    };
    
    (fetch as jest.Mock).mockResolvedValueOnce({
      ok: true,
      json: async () => bundleResponse,
    });

    const result = await patientService.searchPatients({ name: 'John' });

    expect(result).toEqual([patient]);
    expect(fetch).toHaveBeenCalledWith(
      'http://hapi.fhir.org/baseR4/Patient?name=John',
      {
        method: 'GET',
        headers: { 'Accept': 'application/fhir+json' }
      }
    );
  });

  it('should delete a patient by id', async () => {
    (fetch as jest.Mock).mockResolvedValueOnce({
      ok: true
    });

    await patientService.deletePatient('123');

    expect(fetch).toHaveBeenCalledWith(
      'http://hapi.fhir.org/baseR4/Patient/123',
      {
        method: 'DELETE',
        headers: { 'Accept': 'application/fhir+json' }
      }
    );
  });

  it('should handle fetch errors properly', async () => {
    (fetch as jest.Mock).mockResolvedValueOnce({
      ok: false,
      status: 404,
      statusText: 'Not Found'
    });

    await expect(patientService.getPatient('nonexistent')).rejects.toThrow('Error: 404 - Not Found');
  });
});