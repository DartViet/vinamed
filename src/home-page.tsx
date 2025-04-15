import React from 'react';
import { useNavigate } from 'react-router';
import LanguageSwitcher from "./features/ui/language-switcher"

const HomePage: React.FC = () => {
  const navigate = useNavigate();

  return (
    <div className="container">
     
      <div className="d-flex justify-content-end mt-3 mb-2">
        <LanguageSwitcher />
      </div>

      <header className="py-5 text-center">
        <h1 className="display-4">VinaMe Health Platform</h1>
        <p className="lead text-muted">Manage patients, practitioners, and healthcare organizations in one place</p>
      </header>

      <div className="row g-4 py-5">
        <div className="col-md-4">
          <div className="card shadow-sm h-100">
            <div className="card-body">
              <h2 className="card-title mb-4 text-primary">Patient Management</h2>
              <p className="card-text">
                Create and manage patient records, search for patients, and view detailed patient information.
              </p>
              <div className="d-grid gap-3">
                <button 
                  className="btn btn-primary"
                  onClick={() => navigate('/patients/new')}
                >
                  Create New Patient
                </button>
                <button 
                  className="btn btn-outline-primary"
                  onClick={() => navigate('/patients/search')}
                >
                  Search Patients
                </button>
              </div>
            </div>
          </div>
        </div>

        <div className="col-md-4">
          <div className="card shadow-sm h-100">
            <div className="card-body">
              <h2 className="card-title mb-4 text-primary">Practitioner Management</h2>
              <p className="card-text">
                Create and manage healthcare practitioners, search for providers, and view detailed qualification information.
              </p>
              <div className="d-grid gap-3">
                <button 
                  className="btn btn-primary"
                  onClick={() => navigate('/practitioners/new')}
                >
                  Create New Practitioner
                </button>
                <button 
                  className="btn btn-outline-primary"
                  onClick={() => navigate('/practitioners/search')}
                >
                  Search Practitioners
                </button>
              </div>
            </div>
          </div>
        </div>

        <div className="col-md-4">
          <div className="card shadow-sm h-100">
            <div className="card-body">
              <h2 className="card-title mb-4 text-primary">Organization Management</h2>
              <p className="card-text">
                Create and manage healthcare organizations, search for organizations, and view detailed organization information.
              </p>
              <div className="d-grid gap-3">
                <button 
                  className="btn btn-primary"
                  onClick={() => navigate('/organizations/new')}
                >
                  Create New Organization
                </button>
                <button 
                  className="btn btn-outline-primary"
                  onClick={() => navigate('/organizations/search')}
                >
                  Search Organizations
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div className="row mt-4 mb-5">
        <div className="col-12">
          <div className="card bg-light">
            <div className="card-body">
              <h3 className="card-title h5">Quick Access</h3>
              <div className="d-flex flex-wrap gap-2 mt-3">
                <button 
                  className="btn btn-sm btn-outline-secondary"
                  onClick={() => navigate('/patients')}
                >
                  All Patients
                </button>
                <button 
                  className="btn btn-sm btn-outline-secondary"
                  onClick={() => navigate('/practitioners')}
                >
                  All Practitioners
                </button>
                <button 
                  className="btn btn-sm btn-outline-secondary"
                  onClick={() => navigate('/organizations')}
                >
                  All Organizations
                </button>
              </div>
            </div>
          </div>
        </div>
      </div>

      <footer className="text-center text-muted py-4 border-top">
        <p className="mb-1">VinaMe Health Platform &copy; {new Date().getFullYear()}</p>
        <p className="mb-0 small">Manage healthcare data with FHIR standards</p>
      </footer>
    </div>
  );
};

export default HomePage;