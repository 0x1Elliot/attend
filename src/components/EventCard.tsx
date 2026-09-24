import type { EventType } from "../types/domain";

interface EventCardProps {
  event: EventType;
}

export function EventCard({
  event,
}: EventCardProps) {
  return (
    <article className="domain-card">

      <div className="domain-card-header">

        <div>

          <p className="section-label">
            Event Type
          </p>

          <h3>
            {event.title}
          </h3>

        </div>

        <span className="status-badge">
          {event.status}
        </span>

      </div>

      <p className="muted">
        {event.durationMinutes} minutes
      </p>

      <div className="button-row">

        <button
          type="button"
          className="button secondary-button"
        >
          Edit
        </button>

        <button
          type="button"
          className="button primary-button"
        >
          View booking page
        </button>

      </div>

    </article>
  );
}
