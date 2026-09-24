import { Link } from "react-router-dom";

export function NotFoundPage() {
  return (
    <div className="confirmation-shell">

      <div className="confirmation-card">

        <p className="eyebrow">
          404
        </p>

        <h1>
          We couldn't find that page.
        </h1>

        <Link
          to="/"
          className="button button-primary"
        >
          Return home
        </Link>

      </div>

    </div>
  );
}
