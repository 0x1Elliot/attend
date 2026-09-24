import {
  AttentionRulesSection,
} from "../components/AttentionRulesSection";

import {
  AvailabilitySection,
} from "../components/AvailabilitySection";

import {
  BookingsSection,
} from "../components/BookingsSection";

import {
  EventCard,
} from "../components/EventCard";

import type {
  AttentionRule,
  AvailabilityWindow,
  Booking,
  EventType,
} from "../types/domain";

const events: EventType[] = [
  {
    id: "event-1",
    title: "30-Minute Coffee Chat",
    durationMinutes: 30,
    status: "Active",
  },
];

const availability: AvailabilityWindow[] = [
  {
    id: "availability-1",
    day: "Mon",
    startTime: "1:00 PM",
    endTime: "5:00 PM",
  },
  {
    id: "availability-2",
    day: "Tue",
    startTime: "10:00 AM",
    endTime: "3:00 PM",
  },
];

const attentionRules: AttentionRule[] = [];

const bookings: Booking[] = [
  {
    id: "booking-1",
    guestName: "Jordan Lee",
    eventTitle: "30-Minute Coffee Chat",
    date: "Sep 25",
    time: "1:30 PM",
    status: "Confirmed",
  },
  {
    id: "booking-2",
    guestName: "Morgan Reed",
    eventTitle: "30-Minute Coffee Chat",
    date: "Sep 29",
    time: "11:00 AM",
    status: "Confirmed",
  },
];

export function DashboardPage() {
  return (
    <div className="dashboard-shell">

      <header className="top-bar">

        <div className="brand-mark">
          ATTEND
        </div>

        <div className="host-pill">
          Host workspace
        </div>

      </header>

      <main className="dashboard">

        <section className="intro-section">

          <p className="section-label">
            Host UI
          </p>

          <h1>
            Your Events
          </h1>

          <p className="intro-copy">
            A static frontend representation of the
            Attend scheduling domain.
          </p>

        </section>

        <section className="event-section">

          {events.map((event) => (
            <EventCard
              key={event.id}
              event={event}
            />
          ))}

        </section>

        <AvailabilitySection
          availability={availability}
        />

        <AttentionRulesSection
          rules={attentionRules}
        />

        <BookingsSection
          bookings={bookings}
        />

      </main>

    </div>
  );
}
