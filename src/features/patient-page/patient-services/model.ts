export interface HumanName {
    use?: string;
    text?: string;
    family?: string;
    given?: string[];
    prefix?: string[];
    suffix?: string[];
  }
  
  export interface Address {
    use?: string;
    type?: string;
    text?: string;
    line?: string[];
    city?: string;
    district?: string;
    state?: string;
    postalCode?: string;
    country?: string;
  }
  
  export interface ContactPoint {
    system?: string;
    value?: string;
    use?: string;
    rank?: number;
  }
  
  export interface Patient {
    status: number;
    resourceType: 'Patient';
    id?: string;
    identifier?: {
      use?: string;
      type?: {
        coding?: {
          system?: string;
          code?: string;
          display?: string;
        }[];
        text?: string;
      };
      system?: string;
      value?: string;
    }[];
    active?: boolean;
    name?: HumanName[];
    telecom?: ContactPoint[];
    gender?: 'male' | 'female' | 'other' | 'unknown';
    birthDate?: string;
    address?: Address[];
    maritalStatus?: {
      coding?: {
        system?: string;
        code?: string;
        display?: string;
      }[];
      text?: string;
    };
    contact?: {
      relationship?: {
        coding?: {
          system?: string;
          code?: string;
          display?: string;
        }[];
        text?: string;
      }[];
      name?: HumanName;
      telecom?: ContactPoint[];
      address?: Address;
      gender?: 'male' | 'female' | 'other' | 'unknown';
      organization?: {
        reference?: string;
        display?: string;
      };
      period?: {
        start?: string;
        end?: string;
      };
    }[];
    communication?: {
      language?: {
        coding?: {
          system?: string;
          code?: string;
          display?: string;
        }[];
        text?: string;
      };
      preferred?: boolean;
    }[];
  }
  