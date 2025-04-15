import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import { createBrowserRouter, RouterProvider } from 'react-router'

// Localization
import { I18nextProvider } from 'react-i18next' 
import i18n from './i18n'     

// Patient pages
import CreatePatientPage from './features/patient-page/create-patient-page.tsx';
import ReadEditPatientPage from './features/patient-page/read-patient-page.tsx';
import SearchPatientPage from './features/patient-page/search-patient-page.tsx';

// Organization pages
import CreateOrganizationPage from './features/organization-page/create-organization-page.tsx';
import ReadOrganizationPage from './features/organization-page/read-organization-page.tsx';
import SearchOrganizationPage from './features/organization-page/search-organization-page.tsx';

// Practitioner pages
import CreatePractitionerPage from './features/practitioner-page/create-practitioner-page.tsx';
import ReadPractitionerPage from './features/practitioner-page/read-practitioner-page.tsx';
import SearchPractitionerPage from './features/practitioner-page/search-practitioner-page.tsx';

// Other pages
import NotFoundPage from './not-found.tsx';
import HomePage from './home-page.tsx';

const router = createBrowserRouter([
  // Home route
  {path: '/', element: <HomePage />},
  
  // Patient routes
  {path: '/patients', element: <SearchPatientPage />},
  {path: '/patients/new', element: <CreatePatientPage />},
  {path: '/patients/:id', element: <ReadEditPatientPage />},
  {path: '/patients/search', element: <SearchPatientPage />},
  
  // Organization routes
  {path: '/organizations', element: <SearchOrganizationPage />},
  {path: '/organizations/new', element: <CreateOrganizationPage />},
  {path: '/organizations/:id', element: <ReadOrganizationPage />},
  {path: '/organizations/search', element: <SearchOrganizationPage />},
  
  // Practitioner routes
  {path: '/practitioners', element: <SearchPractitionerPage />},
  {path: '/practitioners/new', element: <CreatePractitionerPage />},
  {path: '/practitioners/:id', element: <ReadPractitionerPage />},
  {path: '/practitioners/search', element: <SearchPractitionerPage />},
  
  // 404 route
  {path: '*', element: <NotFoundPage />},
]);

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <I18nextProvider i18n={i18n}> {/* [wrap your RouterProvider here] */}
      <RouterProvider router={router} />
    </I18nextProvider>
  </StrictMode>,
)