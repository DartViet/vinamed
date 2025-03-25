import { Patient } from 'fhir/r4';

const FHIR_SERVER_BASE_URL = 'https://ltd.zapto.org/fhir';

class PatientService {
  // Private static instance variable
  private static instance: PatientService;

  // Private constructor to prevent instantiation from outside
  private constructor() {}

  // Public static method to get the singleton instance
  public static getInstance(): PatientService {
    if (!PatientService.instance) {
      PatientService.instance = new PatientService();
    }
    return PatientService.instance;
  }

  async createPatient(patient: Patient): Promise<any> {
    try {
      const response = await fetch(`${FHIR_SERVER_BASE_URL}/Patient`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/fhir+json'
        },
        body: JSON.stringify(patient)
      });
      
      if (!response.ok) {
        throw new Error(`Error: ${response.status} - ${response.statusText}`);
      }
      let patientResult = await response.json();
      return patientResult;
    } catch (error) {
      console.error('Error creating patient:', error);
      throw error;
    }
  }

  async getPatient(id: string): Promise<Patient> {
    try {
      const response = await fetch(`${FHIR_SERVER_BASE_URL}/Patient/${id}`, {
        method: 'GET',
        headers: {
          'Accept': 'application/fhir+json'
        }
      });
      
      if (!response.ok) {
        throw new Error(`Error: ${response.status} - ${response.statusText}`);
      }
      
      return await response.json();
    } catch (error) {
      console.error('Error getting patient:', error);
      throw error;
    }
  }

  async updatePatient(id: string, patient: Patient): Promise<Patient> {
    try {
      // Ensure the patient has the correct ID
      const patientToUpdate = {
        ...patient,
        id: id
      };

      const response = await fetch(`${FHIR_SERVER_BASE_URL}/Patient/${id}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/fhir+json'
        },
        body: JSON.stringify(patientToUpdate)
      });
      
      if (!response.ok) {
        throw new Error(`Error: ${response.status} - ${response.statusText}`);
      }
      
      return await response.json();
    } catch (error) {
      console.error('Error updating patient:', error);
      throw error;
    }
  }

  async searchPatients(query: any): Promise<Patient[]> {
    try {
      // Build URL with search parameters
      const url = new URL(`${FHIR_SERVER_BASE_URL}/Patient`);
      
      // Add query parameters to URL
      if (query) {
        Object.keys(query).forEach(key => {
          url.searchParams.append(key, query[key]);
        });
      }
      
      const response = await fetch(url.toString(), {
        method: 'GET',
        headers: {
          'Accept': 'application/fhir+json'
        }
      });
      
      if (!response.ok) {
        throw new Error(`Error: ${response.status} - ${response.statusText}`);
      }
      
      const result = await response.json();
      // Extract patient resources from FHIR bundle
      return result.entry ? result.entry.map((entry: any) => entry.resource) : [];
    } catch (error) {
      console.error('Error searching patients:', error);
      throw error;
    }
  }

  async deletePatient(id: string): Promise<void> {
    try {
      const response = await fetch(`${FHIR_SERVER_BASE_URL}/Patient/${id}`, {
        method: 'DELETE',
        headers: {
          'Accept': 'application/fhir+json'
        }
      });
      
      if (!response.ok) {
        throw new Error(`Error: ${response.status} - ${response.statusText}`);
      }
    } catch (error) {
      console.error('Error deleting patient:', error);
      throw error;
    }
  }
}

// Create and export the singleton instance
export const patientService = PatientService.getInstance();