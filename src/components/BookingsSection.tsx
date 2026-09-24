import type {
  Booking,
} from "../types/domain";

interface BookingsSectionProps {
  bookings: Booking[];
}

export function BookingsSection({
  bookings,
}: BookingsSectionProps) {
  return (
    <section className="domain-section">

      <div className="section-heading">

        <div>

          <p className="section-label">
            Bookings
          </p>

          <h2>
            Upcoming bookings
          </h2>

        </div>

      </div>

      <div className="booking-list">

        {bookings.map((booking) => (

          <article
            key={booking.id}
            className="booking-row"
          >

            <div>

              <strong>
                {booking.guestName}
              </strong>

              <p>
                {booking.eventTitle}
              </p>

            </div>

            <div className="booking-meta">

              <span>
                {booking.date}
              </span>

              <span>
                {booking.time}
              </span>

            </div>

            <span className="status-badge">
              {booking.status}
            </span>

          </article>

        ))}

      </div>

    </section>
  );
}
