import { Practitioner } from 'fhir/r4';

const FHIR_SERVER_BASE_URL = 'https://ltd.zapto.org/fhir';

export class PractitionerService {
  // Private static instance variable
  private static instance: PractitionerService;

  // Private constructor to prevent instantiation from outside
  private constructor() {}

  // Public static method to get the singleton instance
  public static getInstance(): PractitionerService {
    if (!PractitionerService.instance) {
      PractitionerService.instance = new PractitionerService();
    }
    return PractitionerService.instance;
  }

  /**
   * Create a new practitioner
   * @param practitioner The practitioner resource to create
   * @returns The created practitioner with server-assigned ID
   */
  async createPractitioner(practitioner: Practitioner): Promise<Practitioner> {
    try {
      const response = await fetch(`${FHIR_SERVER_BASE_URL}/Practitioner`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/fhir+json'
        },
        body: JSON.stringify(practitioner)
      });
      
      if (!response.ok) {
        throw new Error(`Error: ${response.status} - ${response.statusText}`);
      }
      
      return await response.json();
    } catch (error) {
      console.error('Error creating practitioner:', error);
      throw error;
    }
  }

  /**
   * Get a practitioner by ID
   * @param id The practitioner ID
   * @returns The practitioner resource
   */
  async getPractitioner(id: string): Promise<Practitioner> {
    try {
      const response = await fetch(`${FHIR_SERVER_BASE_URL}/Practitioner/${id}`, {
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
      console.error('Error getting practitioner:', error);
      throw error;
    }
  }

  /**
   * Update an existing practitioner
   * @param id The practitioner ID to update
   * @param practitioner The updated practitioner resource
   * @returns The updated practitioner
   */
  async updatePractitioner(id: string, practitioner: Practitioner): Promise<Practitioner> {
    try {
      // Ensure the practitioner has the correct ID
      const practitionerToUpdate = {
        ...practitioner,
        id: id
      };

      const response = await fetch(`${FHIR_SERVER_BASE_URL}/Practitioner/${id}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/fhir+json'
        },
        body: JSON.stringify(practitionerToUpdate)
      });
      
      if (!response.ok) {
        throw new Error(`Error: ${response.status} - ${response.statusText}`);
      }
      
      return await response.json();
    } catch (error) {
      console.error('Error updating practitioner:', error);
      throw error;
    }
  }

  /**
   * Search for practitioners based on query parameters
   * @param query Object containing search parameters
   * @returns Array of matching practitioners
   */
  async searchPractitioners(query: Record<string, string | string[]>): Promise<Practitioner[]> {
    try {
      // Build URL with search parameters
      const url = new URL(`${FHIR_SERVER_BASE_URL}/Practitioner`);
      
      // Add query parameters to URL
      if (query) {
        Object.entries(query).forEach(([key, value]) => {
          if (Array.isArray(value)) {
            // Handle arrays of values for the same parameter
            value.forEach(v => url.searchParams.append(key, v));
          } else {
            url.searchParams.append(key, value);
          }
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
      // Extract practitioner resources from FHIR bundle
      return result.entry ? result.entry.map((entry: any) => entry.resource) : [];
    } catch (error) {
      console.error('Error searching practitioners:', error);
      throw error;
    }
  }

  /**
   * Delete a practitioner by ID
   * @param id The practitioner ID to delete
   */
  async deletePractitioner(id: string): Promise<void> {
    try {
      const response = await fetch(`${FHIR_SERVER_BASE_URL}/Practitioner/${id}`, {
        method: 'DELETE',
        headers: {
          'Accept': 'application/fhir+json'
        }
      });
      
      if (!response.ok) {
        throw new Error(`Error: ${response.status} - ${response.statusText}`);
      }
    } catch (error) {
      console.error('Error deleting practitioner:', error);
      throw error;
    }
  }

  /**
   * Get practitioner roles for a specific practitioner
   * @param practitionerId The practitioner ID
   * @returns Array of PractitionerRole resources
   */
  async getPractitionerRoles(practitionerId: string): Promise<any[]> {
    try {
      const url = new URL(`${FHIR_SERVER_BASE_URL}/PractitionerRole`);
      url.searchParams.append('practitioner', practitionerId);
      
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
      console.error('Error getting practitioner roles:', error);
      throw error;
    }
  }
}

// Create and export the singleton instance
export const practitionerService = PractitionerService.getInstance();

// For backward compatibility with existing code
export default PractitionerService.getInstance();