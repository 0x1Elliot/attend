import {
  BrowserRouter,
  Route,
  Routes,
} from "react-router-dom";

import { AppLayout } from "./layouts/AppLayout";

import { LandingPage } from "./pages/LandingPage";
import { DashboardPage } from "./pages/DashboardPage";
import { CreateEventPage } from "./pages/CreateEventPage";
import { EventDetailsPage } from "./pages/EventDetailsPage";
import { BookingPage } from "./pages/BookingPage";
import { BookingConfirmationPage } from "./pages/BookingConfirmationPage";
import { NotFoundPage } from "./pages/NotFoundPage";

function App() {
  return (
    <BrowserRouter>

      <Routes>

        <Route
          path="/"
          element={<LandingPage />}
        />

        <Route element={<AppLayout />}>

          <Route
            path="/dashboard"
            element={<DashboardPage />}
          />

          <Route
            path="/events/new"
            element={<CreateEventPage />}
          />

          <Route
            path="/events/:eventId"
            element={<EventDetailsPage />}
          />

        </Route>

        <Route
          path="/book/:slug"
          element={<BookingPage />}
        />

        <Route
          path="/booking/:bookingId/confirmed"
          element={<BookingConfirmationPage />}
        />

        <Route
          path="*"
          element={<NotFoundPage />}
        />

      </Routes>

    </BrowserRouter>
  );
}

export default App;
