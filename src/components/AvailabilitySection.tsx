import type {
  AvailabilityWindow,
} from "../types/domain";

interface AvailabilitySectionProps {
  availability: AvailabilityWindow[];
}

export function AvailabilitySection({
  availability,
}: AvailabilitySectionProps) {
  return (
    <section className="domain-section">

      <div className="section-heading">

        <div>
          <p className="section-label">
            Availability
          </p>

          <h2>
            Weekly availability
          </h2>
        </div>

        <button
          type="button"
          className="button secondary-button"
        >
          Edit availability
        </button>

      </div>

      <div className="availability-list">

        {availability.map((window) => (

          <div
            className="availability-row"
            key={window.id}
          >

            <strong className="availability-day">
              {window.day}
            </strong>

            <span>
              {window.startTime}
              {" â€“ "}
              {window.endTime}
            </span>

          </div>

        ))}

      </div>

    </section>
  );
}
