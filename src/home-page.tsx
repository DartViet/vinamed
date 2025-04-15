import React from 'react';
import { useNavigate } from 'react-router';
import LanguageSwitcher from "./features/ui/language-switcher"
import { useTranslation } from 'react-i18next';

const HomePage: React.FC = () => {
  const navigate = useNavigate();
  const { t } = useTranslation();

  return (
    <div className="container">
     
      <div className="d-flex justify-content-end mt-3 mb-2">
        <LanguageSwitcher />
      </div>

      <header className="py-5 text-center">
        <h1 className="display-4">{t('homePage.title')}</h1>
        <p className="lead text-muted">{t('homePage.description')}</p>
      </header>

      <div className="row g-4 py-5">
        <div className="col-md-4">
          <div className="card shadow-sm h-100">
            <div className="card-body">
              <h2 className="card-title mb-4 text-primary">{t('homePage.patient.patient')}</h2>
              <p className="card-text">
                {t('homePage.patient.description')}
              </p>
              <div className="d-grid gap-3">
                <button 
                  className="btn btn-primary"
                  onClick={() => navigate('/patients/new')}
                >
                  {t('homePage.patient.create')}
                </button>
                <button 
                  className="btn btn-outline-primary"
                  onClick={() => navigate('/patients/search')}
                >
                  {t('homePage.patient.search')}
                </button>
              </div>
            </div>
          </div>
        </div>

        <div className="col-md-4">
          <div className="card shadow-sm h-100">
            <div className="card-body">
              <h2 className="card-title mb-4 text-primary">{t('homePage.practitioner.practitioner')}</h2>
              <p className="card-text">
                {t('homePage.practitioner.description')}
              </p>
              <div className="d-grid gap-3">
                <button 
                  className="btn btn-primary"
                  onClick={() => navigate('/practitioners/new')}
                >
                  {t('homePage.practitioner.create')}
                </button>
                <button 
                  className="btn btn-outline-primary"
                  onClick={() => navigate('/practitioners/search')}
                >
                  {t('homePage.practitioner.search')}
                </button>
              </div>
            </div>
          </div>
        </div>

        <div className="col-md-4">
          <div className="card shadow-sm h-100">
            <div className="card-body">
              <h2 className="card-title mb-4 text-primary">{t('homePage.organization.organization')}</h2>
              <p className="card-text">
                {t('homePage.organization.description')}
              </p>
              <div className="d-grid gap-3">
                <button 
                  className="btn btn-primary"
                  onClick={() => navigate('/organizations/new')}
                >
                  {t('homePage.organization.create')}
                </button>
                <button 
                  className="btn btn-outline-primary"
                  onClick={() => navigate('/organizations/search')}
                >
                  {t('homePage.organization.search')}
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
              <h3 className="card-title h5">{t('homePage.quickAccess.quickAccess')}</h3>
              <div className="d-flex flex-wrap gap-2 mt-3">
                <button 
                  className="btn btn-sm btn-outline-secondary"
                  onClick={() => navigate('/patients')}
                >
                  {t('homePage.quickAccess.allPatients')}
                </button>
                <button 
                  className="btn btn-sm btn-outline-secondary"
                  onClick={() => navigate('/practitioners')}
                >
                  {t('homePage.quickAccess.allPractitioners')}
                </button>
                <button 
                  className="btn btn-sm btn-outline-secondary"
                  onClick={() => navigate('/organizations')}
                >
                  {t('homePage.quickAccess.allOrganizations')}
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