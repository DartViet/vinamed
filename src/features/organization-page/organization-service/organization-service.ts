import { Organization } from 'fhir/r4';

const FHIR_SERVER_BASE_URL = 'http://hapi.fhir.org/baseR4';

export class OrganizationService {
  // Private static instance variable
  private static instance: OrganizationService;

  // Private constructor to prevent instantiation from outside
  private constructor() {}

  // Public static method to get the singleton instance
  public static getInstance(): OrganizationService {
    if (!OrganizationService.instance) {
      OrganizationService.instance = new OrganizationService();
    }
    return OrganizationService.instance;
  }

  /**
   * Create a new organization
   * @param organization The organization resource to create
   * @returns The created organization with server-assigned ID
   */
  async createOrganization(organization: Organization): Promise<Organization> {
    try {
      const response = await fetch(`${FHIR_SERVER_BASE_URL}/Organization`, {
        method: 'POST',
        headers: {
          'Content-Type': 'application/fhir+json'
        },
        body: JSON.stringify(organization)
      });
      
      if (!response.ok) {
        throw new Error(`Error: ${response.status} - ${response.statusText}`);
      }
      
      return await response.json();
    } catch (error) {
      console.error('Error creating organization:', error);
      throw error;
    }
  }

  /**
   * Get an organization by ID
   * @param id The organization ID
   * @returns The organization resource
   */
  async getOrganization(id: string): Promise<Organization> {
    try {
      const response = await fetch(`${FHIR_SERVER_BASE_URL}/Organization/${id}`, {
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
      console.error('Error getting organization:', error);
      throw error;
    }
  }

  /**
   * Update an existing organization
   * @param id The organization ID to update
   * @param organization The updated organization resource
   * @returns The updated organization
   */
  async updateOrganization(id: string, organization: Organization): Promise<Organization> {
    try {
      // Ensure the organization has the correct ID
      const organizationToUpdate = {
        ...organization,
        id: id
      };

      const response = await fetch(`${FHIR_SERVER_BASE_URL}/Organization/${id}`, {
        method: 'PUT',
        headers: {
          'Content-Type': 'application/fhir+json'
        },
        body: JSON.stringify(organizationToUpdate)
      });
      
      if (!response.ok) {
        throw new Error(`Error: ${response.status} - ${response.statusText}`);
      }
      
      return await response.json();
    } catch (error) {
      console.error('Error updating organization:', error);
      throw error;
    }
  }

  /**
   * Search for organizations based on query parameters
   * @param query Object containing search parameters
   * @returns Array of matching organizations
   */
  async searchOrganizations(query: Record<string, string | string[]>): Promise<Organization[]> {
    try {
      // Build URL with search parameters
      const url = new URL(`${FHIR_SERVER_BASE_URL}/Organization`);
      
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
      // Extract organization resources from FHIR bundle
      return result.entry ? result.entry.map((entry: any) => entry.resource) : [];
    } catch (error) {
      console.error('Error searching organizations:', error);
      throw error;
    }
  }

  /**
   * Delete an organization by ID
   * @param id The organization ID to delete
   */
  async deleteOrganization(id: string): Promise<void> {
    try {
      const response = await fetch(`${FHIR_SERVER_BASE_URL}/Organization/${id}`, {
        method: 'DELETE',
        headers: {
          'Accept': 'application/fhir+json'
        }
      });
      
      if (!response.ok) {
        throw new Error(`Error: ${response.status} - ${response.statusText}`);
      }
    } catch (error) {
      console.error('Error deleting organization:', error);
      throw error;
    }
  }

}


// Create and export the singleton instance
export const organizationService = OrganizationService.getInstance();

// For backward compatibility with existing code
export default OrganizationService.getInstance();