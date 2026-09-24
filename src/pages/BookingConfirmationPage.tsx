import { Link } from "react-router-dom";

export function BookingConfirmationPage() {
  return (
    <div className="confirmation-shell">

      <div className="confirmation-card">

        <div className="confirmation-icon">
          ✓
        </div>

        <p className="eyebrow">
          Scheduled
        </p>

        <h1>
          You're on the calendar.
        </h1>

        <p>
          The booking flow is connected from
          beginning to end at the UI level.
        </p>

        <div className="confirmation-details">

          <strong>
            30 Minute Meeting
          </strong>

          <span>
            September 24 · 10:30 AM
          </span>

        </div>

        <Link
          to="/"
          className="button button-primary"
        >
          Return to Attend
        </Link>

      </div>

    </div>
  );
}
