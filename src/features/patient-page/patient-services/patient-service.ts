import { Patient } from 'fhir/r4';

const FHIR_SERVER_BASE_URL = 'http://hapi.fhir.org/baseR4';

class PatientService {
  private static instance: PatientService;

  // Private constructor to prevent direct instantiation
  private constructor() {}

  // Static method to get the singleton instance
  public static getInstance(): PatientService {
    if (!PatientService.instance) {
      PatientService.instance = new PatientService();
    }
    return PatientService.instance;
  }

  async createPatient(patient: Patient): Promise<Patient> {
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
      
      return await response.json();
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

// Export singleton instance
export const patientService = PatientService.getInstance();