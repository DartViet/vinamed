import { StrictMode } from 'react'
import { createRoot } from 'react-dom/client'
import CreatePatientPage from './features/patient-page/create-patient-page.tsx';
import { createBrowserRouter, RouterProvider } from 'react-router'
import NotFoundPage from './not-found.tsx';
import ReadEditPatientPage from './features/patient-page/read-edit-patient-page.tsx';
import SearchPatientPage from './features/patient-page/search-patient-page.tsx';

const router = createBrowserRouter([
  {path: '/', element: <SearchPatientPage />},
  {path: '/patients/new', element: <CreatePatientPage />},
  {path: '/patients/:id', element: <ReadEditPatientPage />},
  {path: '/search-patient', element: <SearchPatientPage />},
  {path: '*', element: <NotFoundPage />},
]);

createRoot(document.getElementById('root')!).render(
  <StrictMode>
    <RouterProvider router={router} />
  </StrictMode>,
)
