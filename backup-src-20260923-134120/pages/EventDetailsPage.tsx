import {
  Link,
  useParams,
} from "react-router-dom";

import { PageHeader } from "../components/PageHeader";
import { mockEvents } from "../lib/mockEvents";

export function EventDetailsPage() {

  const { eventId } = useParams();

  const event =
    mockEvents.find(
      (item) => item.id === eventId
    ) ?? mockEvents[0];

  return (
    <div className="page page-narrow">

      <PageHeader
        eyebrow="Event type"
        title={event.title}
        description="This is the initial event configuration surface."
      />

      <section className="detail-card">

        <div className="detail-row">

          <span>Duration</span>

          <strong>
            {event.durationMinutes} minutes
          </strong>

        </div>

        <div className="detail-row">

          <span>Status</span>

          <strong>
            {event.active
              ? "Active"
              : "Inactive"}
          </strong>

        </div>

        <div className="detail-row">

          <span>Booking URL</span>

          <strong>
            /book/{event.slug}
          </strong>

        </div>

      </section>

      <div className="page-actions">

        <Link
          to={`/book/${event.slug}`}
          className="button button-primary"
        >
          Preview booking page
        </Link>

        <Link
          to="/dashboard"
          className="button button-secondary"
        >
          Back to dashboard
        </Link>

      </div>

    </div>
  );
}
