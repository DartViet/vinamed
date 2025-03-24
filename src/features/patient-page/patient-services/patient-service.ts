import axios from 'axios';
import { Patient } from './model';

const FHIR_SERVER_BASE_URL = 'http://hapi.fhir.org/baseR4';

class PatientService {
  async createPatient(patient: Patient): Promise<Patient> {
    try {
      const response = await axios.post(`${FHIR_SERVER_BASE_URL}/Patient`, patient, {
        headers: {
          'Content-Type': 'application/fhir+json'
        }
      });
      return response.data;
    } catch (error) {
      console.error('Error creating patient:', error);
      throw error;
    }
  }

  async getPatient(id: string): Promise<Patient> {
    try {
      const response = await axios.get(`${FHIR_SERVER_BASE_URL}/Patient/${id}`, {
        headers: {
          'Accept': 'application/fhir+json'
        }
      });
      return response.data;
    } catch (error) {
      console.error('Error getting patient:', error);
      throw error;
    }
  }

  async searchPatients(query: any): Promise<Patient[]> {
    try {
      const response = await axios.get(`${FHIR_SERVER_BASE_URL}/Patient`, {
        params: query,
        headers: {
          'Accept': 'application/fhir+json'
        }
      });
      return response.data;
    } catch (error) {
      console.error('Error searching patients:', error);
      throw error;
    }
  }

  async deletePatient(id: string): Promise<void> {
    try {
      await axios.delete(`${FHIR_SERVER_BASE_URL}/Patient/${id}`, {
        headers: {
          'Accept': 'application/fhir+json'
        }
      });
    } catch (error) {
      console.error('Error deleting patient:', error);
      throw error;
    }
  }
}

export default new PatientService();