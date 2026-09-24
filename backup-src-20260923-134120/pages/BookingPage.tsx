import {
  Link,
  useParams,
} from "react-router-dom";

const availableTimes = [
  "9:00 AM",
  "10:30 AM",
  "1:00 PM",
  "2:30 PM",
  "4:00 PM",
];

export function BookingPage() {

  const { slug } = useParams();

  return (
    <div className="booking-shell">

      <section className="booking-card">

        <div className="booking-info">

          <Link
            to="/"
            className="brand"
          >
            Attend
          </Link>

          <p className="eyebrow">
            Meeting
          </p>

          <h1>
            30 Minute Meeting
          </h1>

          <p>
            Choose a time that works for you.
            This screen currently uses temporary
            frontend availability.
          </p>

          <dl className="booking-meta">

            <div>
              <dt>Duration</dt>
              <dd>30 minutes</dd>
            </div>

            <div>
              <dt>Event</dt>
              <dd>{slug}</dd>
            </div>

          </dl>

        </div>

        <div className="availability-panel">

          <p className="eyebrow">
            Select a time
          </p>

          <h2>September 24</h2>

          <div className="time-grid">

            {availableTimes.map((time) => (

              <Link
                key={time}
                to="/booking/demo-booking/confirmed"
                className="time-button"
              >
                {time}
              </Link>

            ))}

          </div>

        </div>

      </section>

    </div>
  );
}
