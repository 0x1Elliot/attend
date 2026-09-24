import { Link } from "react-router-dom";
import { Logo } from "../components/Logo";

export function LandingPage() {
  return (
    <div className="landing">

      <header className="landing-nav">

        <Logo />

        <Link
          to="/dashboard"
          className="button button-secondary"
        >
          Open dashboard
        </Link>

      </header>

      <main className="hero">

        <p className="eyebrow">
          Scheduling, without the friction.
        </p>

        <h1>
          Make time for what
          <span> actually matters.</span>
        </h1>

        <p className="hero-copy">
          Attend is being built to make scheduling,
          availability, events, and bookings feel
          simple for everyone involved.
        </p>

        <div className="hero-actions">

          <Link
            to="/dashboard"
            className="button button-primary"
          >
            Enter Attend
          </Link>

          <Link
            to="/book/30-minute-meeting"
            className="button button-secondary"
          >
            Preview booking flow
          </Link>

        </div>

      </main>

    </div>
  );
}
