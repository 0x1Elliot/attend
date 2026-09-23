import { Link } from "react-router-dom";
import { PageHeader } from "../components/PageHeader";
import { mockEvents } from "../lib/mockEvents";

export function DashboardPage() {
  return (
    <div className="page">

      <PageHeader
        eyebrow="Workspace"
        title="Your events"
        description="Create and manage the ways people can schedule time with you."
        action={
          <Link
            className="button button-primary"
            to="/events/new"
          >
            + Create event
          </Link>
        }
      />

      <section className="event-grid">

        {mockEvents.map((event) => (

          <article
            className="event-card"
            key={event.id}
          >

            <div className="event-card-top">

              <span className="status-dot" />

              <span className="event-duration">
                {event.durationMinutes} min
              </span>

            </div>

            <h2>{event.title}</h2>

            <p>
              {event.description}
            </p>

            <div className="event-card-actions">

              <Link
                to={`/events/${event.id}`}
                className="text-link"
              >
                Edit
              </Link>

              <Link
                to={`/book/${event.slug}`}
                className="text-link"
              >
                Booking page
              </Link>

            </div>

          </article>

        ))}

      </section>

    </div>
  );
}
