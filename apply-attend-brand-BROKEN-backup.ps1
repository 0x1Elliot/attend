# ============================================================
# ATTEND — QUIET EMERALD FRONTEND
# ============================================================
#
# Applies the selected Attend visual identity:
#
#   attend.
#   Make time intentional.
#
# Design direction:
#   Quiet Emerald
#   Editorial typography
#   Warm stone surfaces
#   Premium minimal UI
#
# This phase is STATIC ONLY.
#
# No:
#   - Supabase calls
#   - Authentication
#   - AI
#   - Database writes
#   - Form submission
#
# ============================================================

$ErrorActionPreference = "Stop"

$RepoPath = "C:\Users\Administrator\Attend"

Set-Location $RepoPath

Write-Host ""
Write-Host "==============================================" -ForegroundColor DarkGreen
Write-Host " ATTEND — QUIET EMERALD BRAND BUILD" -ForegroundColor DarkGreen
Write-Host "==============================================" -ForegroundColor DarkGreen
Write-Host ""

# ============================================================
# VERIFY PROJECT
# ============================================================

if (-not (Test-Path "$RepoPath\src")) {
    throw "Could not find src at $RepoPath"
}

if (-not (Test-Path "$RepoPath\package.json")) {
    throw "Could not find package.json at $RepoPath"
}

# ============================================================
# BACKUP CURRENT SRC
# ============================================================

$Timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$BackupPath = Join-Path $RepoPath "backup-before-quiet-emerald-$Timestamp"

Write-Host "Backing up current frontend..." -ForegroundColor Yellow

Copy-Item `
    "$RepoPath\src" `
    $BackupPath `
    -Recurse `
    -Force

Write-Host "Backup created:" -ForegroundColor Green
Write-Host "  $BackupPath"
Write-Host ""

# ============================================================
# HELPER
# ============================================================

function Write-ProjectFile {

    param(
        [string]$RelativePath,
        [string]$Content
    )

    $FullPath = Join-Path $RepoPath $RelativePath

    $ParentPath = Split-Path $FullPath -Parent

    if (-not (Test-Path $ParentPath)) {

        New-Item `
            -ItemType Directory `
            -Path $ParentPath `
            -Force | Out-Null
    }

    $Content |
        Set-Content `
            -Path $FullPath `
            -Encoding UTF8

    Write-Host "Created: $RelativePath" -ForegroundColor DarkGray
}

# ============================================================
# REQUIRED DIRECTORIES
# ============================================================

$Directories = @(

    "src\components",
    "src\pages",
    "src\types"
)

foreach ($Directory in $Directories) {

    New-Item `
        -ItemType Directory `
        -Path (Join-Path $RepoPath $Directory) `
        -Force | Out-Null
}

# ============================================================
# VITE TYPES
# Fixes import.meta.env + CSS module typing issues
# ============================================================

Write-ProjectFile "src\vite-env.d.ts" @'
/// <reference types="vite/client" />
'@

# ============================================================
# INDEX.HTML
# Loads the brand typography.
# ============================================================

Write-ProjectFile "index.html" @'
<!doctype html>
<html lang="en">

  <head>

    <meta charset="UTF-8" />

    <meta
      name="viewport"
      content="width=device-width, initial-scale=1.0"
    />

    <meta
      name="theme-color"
      content="#FAF9F6"
    />

    <meta
      name="description"
      content="Attend — make time intentional."
    />

    <link
      rel="preconnect"
      href="https://fonts.googleapis.com"
    />

    <link
      rel="preconnect"
      href="https://fonts.gstatic.com"
      crossorigin
    />

    <link
      href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Playfair+Display:wght@500;600;700&display=swap"
      rel="stylesheet"
    />

    <title>attend. — Make time intentional.</title>

  </head>

  <body>

    <div id="root"></div>

    <script
      type="module"
      src="/src/main.tsx"
    ></script>

  </body>

</html>
'@

# ============================================================
# DOMAIN TYPES
# ============================================================

Write-ProjectFile "src\types\domain.ts" @'
export interface EventType {
  id: string;
  title: string;
  durationMinutes: number;
  status: "Active" | "Inactive";
  description: string;
}

export interface AvailabilityWindow {
  id: string;
  day: string;
  startTime: string;
  endTime: string;
}

export interface AttentionRule {
  id: string;
  label: string;
  description: string;
  enabled: boolean;
}

export interface Booking {
  id: string;
  initials: string;
  guestName: string;
  eventTitle: string;
  date: string;
  time: string;
  status: "Confirmed" | "Cancelled";
}
'@

# ============================================================
# BRAND MARK
# ============================================================

Write-ProjectFile "src\components\BrandMark.tsx" @'
interface BrandMarkProps {
  compact?: boolean;
}

export function BrandMark({
  compact = false,
}: BrandMarkProps) {

  return (
    <div
      className={
        compact
          ? "brand-mark compact"
          : "brand-mark"
      }
    >
      attend.
    </div>
  );
}
'@

# ============================================================
# ICON COMPONENT
# ============================================================

Write-ProjectFile "src\components\Icon.tsx" @'
interface IconProps {
  name:
    | "home"
    | "calendar"
    | "booking"
    | "clock"
    | "settings"
    | "plus"
    | "arrow"
    | "spark";
}

export function Icon({
  name,
}: IconProps) {

  const common = {
    width: 18,
    height: 18,
    viewBox: "0 0 24 24",
    fill: "none",
    stroke: "currentColor",
    strokeWidth: 1.8,
    strokeLinecap: "round" as const,
    strokeLinejoin: "round" as const,
  };

  switch (name) {

    case "home":

      return (
        <svg {...common}>
          <path d="M3 10.5 12 3l9 7.5" />
          <path d="M5 9.5V21h14V9.5" />
          <path d="M9 21v-6h6v6" />
        </svg>
      );

    case "calendar":

      return (
        <svg {...common}>
          <rect
            x="3"
            y="5"
            width="18"
            height="16"
            rx="2"
          />
          <path d="M16 3v4M8 3v4M3 10h18" />
        </svg>
      );

    case "booking":

      return (
        <svg {...common}>
          <path d="M6 3h12a2 2 0 0 1 2 2v16l-8-4-8 4V5a2 2 0 0 1 2-2Z" />
        </svg>
      );

    case "clock":

      return (
        <svg {...common}>
          <circle
            cx="12"
            cy="12"
            r="9"
          />
          <path d="M12 7v5l3 2" />
        </svg>
      );

    case "settings":

      return (
        <svg {...common}>
          <circle
            cx="12"
            cy="12"
            r="3"
          />
          <path d="M19.4 15a1.7 1.7 0 0 0 .34 1.88l.06.06-2.83 2.83-.06-.06A1.7 1.7 0 0 0 15 19.4a1.7 1.7 0 0 0-1 .6 1.7 1.7 0 0 0-.4 1.1V21h-4v-.1A1.7 1.7 0 0 0 8.6 19.4a1.7 1.7 0 0 0-1.88.34l-.06.06-2.83-2.83.06-.06A1.7 1.7 0 0 0 4.6 15a1.7 1.7 0 0 0-.6-1 1.7 1.7 0 0 0-1.1-.4H3v-4h.1A1.7 1.7 0 0 0 4.6 8.6a1.7 1.7 0 0 0-.34-1.88l-.06-.06 2.83-2.83.06.06A1.7 1.7 0 0 0 9 4.6a1.7 1.7 0 0 0 1-.6 1.7 1.7 0 0 0 .4-1.1V3h4v.1A1.7 1.7 0 0 0 15.4 4.6a1.7 1.7 0 0 0 1.88-.34l.06-.06 2.83 2.83-.06.06A1.7 1.7 0 0 0 19.4 9a1.7 1.7 0 0 0 .6 1 1.7 1.7 0 0 0 1.1.4h.1v4h-.1A1.7 1.7 0 0 0 19.4 15Z" />
        </svg>
      );

    case "plus":

      return (
        <svg {...common}>
          <path d="M12 5v14M5 12h14" />
        </svg>
      );

    case "arrow":

      return (
        <svg {...common}>
          <path d="M5 12h14" />
          <path d="m14 7 5 5-5 5" />
        </svg>
      );

    case "spark":

      return (
        <svg {...common}>
          <path d="m12 3 1.5 4.5L18 9l-4.5 1.5L12 15l-1.5-4.5L6 9l4.5-1.5L12 3Z" />
          <path d="m19 16 .7 2.3L22 19l-2.3.7L19 22l-.7-2.3L16 19l2.3-.7L19 16Z" />
        </svg>
      );
  }
}
'@

# ============================================================
# SIDEBAR
# ============================================================

Write-ProjectFile "src\components\Sidebar.tsx" @'
import {
  BrandMark,
} from "./BrandMark";

import {
  Icon,
} from "./Icon";

const navigation = [
  {
    label: "Home",
    icon: "home" as const,
    active: true,
  },
  {
    label: "Events",
    icon: "calendar" as const,
  },
  {
    label: "Bookings",
    icon: "booking" as const,
  },
  {
    label: "Availability",
    icon: "clock" as const,
  },
  {
    label: "Settings",
    icon: "settings" as const,
  },
];

export function Sidebar() {

  return (
    <aside className="sidebar">

      <div className="sidebar-brand">

        <BrandMark />

      </div>

      <nav
        className="sidebar-navigation"
        aria-label="Primary navigation"
      >

        {navigation.map((item) => (

          <button
            type="button"
            key={item.label}
            className={
              item.active
                ? "navigation-item active"
                : "navigation-item"
            }
          >

            <Icon name={item.icon} />

            <span>
              {item.label}
            </span>

          </button>

        ))}

      </nav>

      <div className="sidebar-manifesto">

        <Icon name="spark" />

        <p>
          Make time
          <br />
          intentional.
        </p>

      </div>

      <div className="sidebar-profile">

        <div className="profile-avatar">
          A
        </div>

        <div>

          <strong>
            Alex Morgan
          </strong>

          <span>
            Personal workspace
          </span>

        </div>

      </div>

    </aside>
  );
}
'@

# ============================================================
# EVENT CARD
# ============================================================

Write-ProjectFile "src\components\EventCard.tsx" @'
import type {
  EventType,
} from "../types/domain";

import {
  Icon,
} from "./Icon";

interface EventCardProps {
  event: EventType;
}

export function EventCard({
  event,
}: EventCardProps) {

  return (
    <article className="event-card">

      <div className="event-visual">

        <div className="coffee-cup">

          <div className="coffee-surface" />

        </div>

        <div className="leaf leaf-one" />
        <div className="leaf leaf-two" />

      </div>

      <div className="event-content">

        <div className="event-topline">

          <span className="event-duration">

            <Icon name="clock" />

            {event.durationMinutes} minutes

          </span>

          <span className="status">

            <span className="status-dot" />

            {event.status}

          </span>

        </div>

        <h3>
          {event.title}
        </h3>

        <p>
          {event.description}
        </p>

        <div className="event-actions">

          <button
            type="button"
            className="button button-soft"
          >
            Edit
          </button>

          <button
            type="button"
            className="button button-emerald"
          >

            View booking page

            <Icon name="arrow" />

          </button>

        </div>

      </div>

    </article>
  );
}
'@

# ============================================================
# AVAILABILITY
# ============================================================

Write-ProjectFile "src\components\AvailabilityCard.tsx" @'
import type {
  AvailabilityWindow,
} from "../types/domain";

interface AvailabilityCardProps {
  availability: AvailabilityWindow[];
}

export function AvailabilityCard({
  availability,
}: AvailabilityCardProps) {

  return (
    <section className="dashboard-card">

      <div className="card-heading">

        <div>

          <p className="eyebrow">
            Availability
          </p>

          <h2>
            Hosting hours
          </h2>

        </div>

        <button
          type="button"
          className="text-action"
        >
          Edit
        </button>

      </div>

      <div className="availability-list">

        {availability.map((window) => (

          <div
            key={window.id}
            className="availability-row"
          >

            <strong>
              {window.day}
            </strong>

            <span>
              {window.startTime}
            </span>

            <span className="time-divider">
              —
            </span>

            <span>
              {window.endTime}
            </span>

          </div>

        ))}

      </div>

      <div className="card-caption">
        Your default weekly availability.
      </div>

    </section>
  );
}
'@

# ============================================================
# ATTENTION RULES
# ============================================================

Write-ProjectFile "src\components\AttentionRulesCard.tsx" @'
import type {
  AttentionRule,
} from "../types/domain";

import {
  Icon,
} from "./Icon";

interface AttentionRulesCardProps {
  rules: AttentionRule[];
}

export function AttentionRulesCard({
  rules,
}: AttentionRulesCardProps) {

  return (
    <section className="dashboard-card attention-card">

      <div className="card-heading">

        <div>

          <p className="eyebrow">
            Attention
          </p>

          <h2>
            Protect your time
          </h2>

        </div>

        <button
          type="button"
          className="text-action"
        >
          Edit
        </button>

      </div>

      {rules.length === 0 ? (

        <div className="attention-empty">

          <div className="attention-icon">

            <Icon name="clock" />

          </div>

          <strong>
            No rules configured
          </strong>

          <p>
            Set thoughtful boundaries around
            your calendar and make more room
            for what matters.
          </p>

          <button
            type="button"
            className="inline-link"
          >
            + Add attention rule
          </button>

        </div>

      ) : (

        <div>

          {rules.map((rule) => (

            <div
              key={rule.id}
              className="rule"
            >
              {rule.label}
            </div>

          ))}

        </div>

      )}

    </section>
  );
}
'@

# ============================================================
# UPCOMING BOOKINGS
# ============================================================

Write-ProjectFile "src\components\BookingsCard.tsx" @'
import type {
  Booking,
} from "../types/domain";

import {
  Icon,
} from "./Icon";

interface BookingsCardProps {
  bookings: Booking[];
}

export function BookingsCard({
  bookings,
}: BookingsCardProps) {

  return (
    <section className="dashboard-card bookings-card">

      <div className="card-heading">

        <div>

          <p className="eyebrow">
            Upcoming
          </p>

          <h2>
            Bookings
          </h2>

        </div>

        <button
          type="button"
          className="text-action"
        >
          View all
        </button>

      </div>

      <div className="booking-list">

        {bookings.map((booking) => (

          <article
            key={booking.id}
            className="booking-row"
          >

            <div className="booking-avatar">
              {booking.initials}
            </div>

            <div className="booking-person">

              <strong>
                {booking.guestName}
              </strong>

              <span>
                {booking.eventTitle}
              </span>

            </div>

            <div className="booking-time">

              <strong>
                {booking.date}
              </strong>

              <span>
                {booking.time}
              </span>

            </div>

            <button
              type="button"
              className="icon-button"
              aria-label={`View ${booking.guestName}`}
            >

              <Icon name="arrow" />

            </button>

          </article>

        ))}

      </div>

    </section>
  );
}
'@

# ============================================================
# BOOKING PREVIEW
# ============================================================

Write-ProjectFile "src\components\BookingPreview.tsx" @'
import {
  BrandMark,
} from "./BrandMark";

import {
  Icon,
} from "./Icon";

export function BookingPreview() {

  return (
    <aside className="preview-column">

      <div className="preview-intro">

        <p className="eyebrow">
          Guest experience
        </p>

        <h2>
          Calm on both
          sides of the invite.
        </h2>

        <p>
          Your public booking page stays focused,
          personal and easy to understand.
        </p>

      </div>

      <div className="phone-frame">

        <div className="phone-camera" />

        <div className="phone-content">

          <header className="phone-header">

            <BrandMark compact />

            <button
              type="button"
              className="phone-menu"
              aria-label="Menu"
            >
              <span />
              <span />
            </button>

          </header>

          <div className="booking-art">

            <div className="booking-art-circle" />

            <div className="booking-cup">

              <div className="booking-coffee" />

            </div>

            <div className="booking-leaf leaf-a" />
            <div className="booking-leaf leaf-b" />
            <div className="booking-leaf leaf-c" />

          </div>

          <div className="booking-page-copy">

            <p className="booking-eyebrow">
              Coffee & conversation
            </p>

            <h3>
              30-Minute
              <br />
              Coffee Chat
            </h3>

            <div className="booking-meta">

              <span>
                <Icon name="clock" />
                30 minutes
              </span>

              <span>
                Video call
              </span>

            </div>

            <p className="booking-description">
              A casual conversation to connect,
              share ideas and explore how we might
              work together.
            </p>

            <button
              type="button"
              className="select-time-button"
            >

              Select a time

              <Icon name="arrow" />

            </button>

            <div className="powered-by">
              Powered by <strong>attend.</strong>
            </div>

          </div>

        </div>

      </div>

      <div className="preview-quote">

        <span />

        <p>
          “A calmer way
          <br />
          to a brighter you.”
        </p>

      </div>

    </aside>
  );
}
'@

# ============================================================
# DASHBOARD PAGE
# ============================================================

Write-ProjectFile "src\pages\DashboardPage.tsx" @'
import {
  AttentionRulesCard,
} from "../components/AttentionRulesCard";

import {
  AvailabilityCard,
} from "../components/AvailabilityCard";

import {
  BookingPreview,
} from "../components/BookingPreview";

import {
  BookingsCard,
} from "../components/BookingsCard";

import {
  EventCard,
} from "../components/EventCard";

import {
  Icon,
} from "../components/Icon";

import {
  Sidebar,
} from "../components/Sidebar";

import type {
  AttentionRule,
  AvailabilityWindow,
  Booking,
  EventType,
} from "../types/domain";

const events: EventType[] = [
  {
    id: "event-001",
    title: "30-Minute Coffee Chat",
    durationMinutes: 30,
    status: "Active",
    description:
      "An easy place for thoughtful conversation, introductions and new ideas.",
  },
];

const availability: AvailabilityWindow[] = [
  {
    id: "availability-mon",
    day: "Mon",
    startTime: "1:00 PM",
    endTime: "5:00 PM",
  },
  {
    id: "availability-tue",
    day: "Tue",
    startTime: "10:00 AM",
    endTime: "3:00 PM",
  },
];

const attentionRules: AttentionRule[] = [];

const bookings: Booking[] = [
  {
    id: "booking-001",
    initials: "JC",
    guestName: "Jamie Chen",
    eventTitle: "Coffee Chat",
    date: "Mon, Sep 28",
    time: "2:00 PM",
    status: "Confirmed",
  },
  {
    id: "booking-002",
    initials: "TK",
    guestName: "Taylor Kim",
    eventTitle: "Coffee Chat",
    date: "Tue, Sep 29",
    time: "11:00 AM",
    status: "Confirmed",
  },
];

export function DashboardPage() {

  return (
    <div className="app-shell">

      <Sidebar />

      <main className="workspace">

        <div className="workspace-main">

          <header className="dashboard-header">

            <div>

              <p className="eyebrow">
                Wednesday · September 23
              </p>

              <h1>
                Good afternoon,
                <br />
                Alex.
              </h1>

              <p className="header-copy">
                A calmer, more intentional day awaits.
              </p>

            </div>

            <button
              type="button"
              className="button button-emerald new-event-button"
            >

              <Icon name="plus" />

              New Event

            </button>

          </header>

          <section className="section-block">

            <div className="section-header">

              <div>

                <p className="eyebrow">
                  Your Events
                </p>

                <h2>
                  Make space for
                  meaningful conversations.
                </h2>

              </div>

              <button
                type="button"
                className="text-action"
              >
                View all
              </button>

            </div>

            <div className="event-list">

              {events.map((event) => (

                <EventCard
                  key={event.id}
                  event={event}
                />

              ))}

            </div>

          </section>

          <div className="dashboard-grid">

            <AvailabilityCard
              availability={availability}
            />

            <AttentionRulesCard
              rules={attentionRules}
            />

            <BookingsCard
              bookings={bookings}
            />

            <section className="manifesto-card">

              <p className="eyebrow">
                Our point of view
              </p>

              <h2>
                Intentional people
                build extraordinary
                things.
              </h2>

              <p>
                Attend helps you protect your time,
                create space for meaningful conversations,
                and move closer to the work and people
                that matter.
              </p>

              <div className="manifesto-footer">

                <span />

                attend.

              </div>

            </section>

          </div>

        </div>

        <BookingPreview />

      </main>

    </div>
  );
}
'@

# ============================================================
# APP
# ============================================================

Write-ProjectFile "src\App.tsx" @'
import {
  DashboardPage,
} from "./pages/DashboardPage";

function App() {

  return (
    <DashboardPage />
  );
}

export default App;
'@

# ============================================================
# ENTRY
# ============================================================

Write-ProjectFile "src\main.tsx" @'
import {
  StrictMode,
} from "react";

import {
  createRoot,
} from "react-dom/client";

import App from "./App";

import "./index.css";

const rootElement =
  document.getElementById("root");

if (!rootElement) {

  throw new Error(
    "Root element not found."
  );
}

createRoot(rootElement).render(

  <StrictMode>

    <App />

  </StrictMode>
);
'@

# ============================================================
# QUIET EMERALD DESIGN SYSTEM
# ============================================================

Write-ProjectFile "src\index.css" @'
:root {

  /* --------------------------------------------------------
     ATTEND BRAND PALETTE
     -------------------------------------------------------- */

  --emerald-900: #0f3d32;
  --emerald-800: #16493d;
  --emerald-700: #20594b;

  --sage-500: #7f9b8a;
  --sage-300: #aabbb0;
  --mist: #d7ded6;

  --stone-100: #ede8e1;
  --stone-50: #f4f1ec;

  --off-white: #faf9f6;
  --pure-white: #ffffff;

  --ink: #16221e;
  --ink-soft: #2d3834;

  --muted: #707873;
  --muted-light: #979d99;

  --border: rgba(
    15,
    61,
    50,
    0.11
  );

  --border-strong: rgba(
    15,
    61,
    50,
    0.18
  );

  --shadow-small:
    0 8px 25px
    rgba(24, 42, 35, 0.045);

  --shadow-card:
    0 22px 60px
    rgba(30, 42, 36, 0.07);

  --shadow-phone:
    0 35px 80px
    rgba(20, 35, 29, 0.18);

  --font-display:
    "Playfair Display",
    Georgia,
    serif;

  --font-ui:
    "Inter",
    -apple-system,
    BlinkMacSystemFont,
    "Segoe UI",
    sans-serif;

  font-family: var(--font-ui);

  color: var(--ink);

  background: var(--off-white);

  font-synthesis: none;

  text-rendering:
    optimizeLegibility;

  -webkit-font-smoothing:
    antialiased;
}

/* ----------------------------------------------------------
   RESET
   ---------------------------------------------------------- */

* {
  box-sizing: border-box;
}

html {
  background:
    var(--off-white);
}

html,
body,
#root {
  margin: 0;

  min-width: 320px;

  min-height: 100%;
}

body {
  min-height: 100vh;

  background:
    radial-gradient(
      circle at 74% -10%,
      rgba(127, 155, 138, 0.13),
      transparent 32%
    ),
    var(--off-white);
}

button,
input,
textarea,
select {
  font: inherit;
}

button {
  color: inherit;
}

button:focus-visible {
  outline:
    2px solid
    var(--sage-500);

  outline-offset: 3px;
}

/* ----------------------------------------------------------
   TYPOGRAPHY
   ---------------------------------------------------------- */

.eyebrow {

  margin:
    0
    0
    10px;

  color:
    var(--muted);

  font-size:
    11px;

  font-weight:
    700;

  letter-spacing:
    0.15em;

  text-transform:
    uppercase;
}

.brand-mark {

  color:
    var(--emerald-900);

  font-family:
    var(--font-display);

  font-size:
    31px;

  font-weight:
    600;

  letter-spacing:
    -0.055em;

  line-height:
    1;
}

.brand-mark.compact {

  font-size:
    24px;
}

/* ----------------------------------------------------------
   APP LAYOUT
   ---------------------------------------------------------- */

.app-shell {

  display: grid;

  grid-template-columns:
    238px
    minmax(0, 1fr);

  min-height:
    100vh;
}

/* ----------------------------------------------------------
   SIDEBAR
   ---------------------------------------------------------- */

.sidebar {

  position: sticky;

  top: 0;

  height:
    100vh;

  padding:
    34px
    24px
    24px;

  display:
    flex;

  flex-direction:
    column;

  background:
    rgba(
      248,
      247,
      242,
      0.88
    );

  backdrop-filter:
    blur(20px);

  border-right:
    1px solid
    var(--border);
}

.sidebar-brand {

  padding:
    8px
    10px
    42px;
}

.sidebar-navigation {

  display:
    grid;

  gap:
    4px;
}

.navigation-item {

  width:
    100%;

  height:
    45px;

  padding:
    0
    13px;

  display:
    flex;

  align-items:
    center;

  gap:
    12px;

  border:
    0;

  border-radius:
    10px;

  background:
    transparent;

  color:
    var(--muted);

  cursor:
    pointer;

  font-size:
    13px;

  font-weight:
    550;

  text-align:
    left;

  transition:
    background 160ms ease,
    color 160ms ease,
    transform 160ms ease;
}

.navigation-item:hover {

  color:
    var(--emerald-900);

  background:
    rgba(
      215,
      222,
      214,
      0.42
    );

  transform:
    translateX(2px);
}

.navigation-item.active {

  color:
    var(--emerald-900);

  background:
    rgba(
      127,
      155,
      138,
      0.17
    );

  font-weight:
    650;
}

.navigation-item svg {

  flex:
    0 0 auto;
}

.sidebar-manifesto {

  margin-top:
    auto;

  padding:
    20px;

  background:
    var(--emerald-900);

  color:
    var(--pure-white);

  border-radius:
    16px;

  box-shadow:
    var(--shadow-small);
}

.sidebar-manifesto svg {

  width:
    17px;

  height:
    17px;

  color:
    var(--sage-300);
}

.sidebar-manifesto p {

  margin:
    32px
    0
    2px;

  font-family:
    var(--font-display);

  font-size:
    22px;

  line-height:
    1.12;

  letter-spacing:
    -0.025em;
}

.sidebar-profile {

  margin-top:
    16px;

  padding:
    12px
    4px;

  display:
    flex;

  align-items:
    center;

  gap:
    10px;
}

.profile-avatar {

  width:
    34px;

  height:
    34px;

  display:
    grid;

  place-items:
    center;

  flex:
    0 0 auto;

  border-radius:
    50%;

  background:
    var(--mist);

  color:
    var(--emerald-900);

  font-family:
    var(--font-display);

  font-weight:
    700;
}

.sidebar-profile strong {

  display:
    block;

  color:
    var(--ink);

  font-size:
    11px;

  font-weight:
    650;
}

.sidebar-profile span {

  display:
    block;

  margin-top:
    2px;

  color:
    var(--muted-light);

  font-size:
    9px;
}

/* ----------------------------------------------------------
   WORKSPACE
   ---------------------------------------------------------- */

.workspace {

  min-width:
    0;

  display:
    grid;

  grid-template-columns:
    minmax(0, 1fr)
    330px;

  gap:
    50px;

  padding:
    58px
    54px
    80px;
}

.workspace-main {

  min-width:
    0;
}

/* ----------------------------------------------------------
   HEADER
   ---------------------------------------------------------- */

.dashboard-header {

  min-height:
    220px;

  display:
    flex;

  align-items:
    flex-start;

  justify-content:
    space-between;

  gap:
    40px;
}

.dashboard-header h1 {

  margin:
    0;

  max-width:
    610px;

  color:
    var(--emerald-900);

  font-family:
    var(--font-display);

  font-size:
    clamp(
      45px,
      5vw,
      73px
    );

  font-weight:
    500;

  line-height:
    0.97;

  letter-spacing:
    -0.052em;
}

.header-copy {

  margin:
    18px
    0
    0;

  color:
    var(--muted);

  font-size:
    14px;

  line-height:
    1.6;
}

/* ----------------------------------------------------------
   BUTTONS
   ---------------------------------------------------------- */

.button {

  min-height:
    43px;

  padding:
    0
    16px;

  display:
    inline-flex;

  align-items:
    center;

  justify-content:
    center;

  gap:
    9px;

  border:
    0;

  border-radius:
    9px;

  cursor:
    pointer;

  font-size:
    12px;

  font-weight:
    650;

  transition:
    transform 160ms ease,
    box-shadow 160ms ease,
    background 160ms ease;
}

.button:hover {

  transform:
    translateY(-2px);
}

.button svg {

  width:
    15px;

  height:
    15px;
}

.button-emerald {

  color:
    var(--pure-white);

  background:
    var(--emerald-900);

  box-shadow:
    0 9px 20px
    rgba(15, 61, 50, 0.13);
}

.button-emerald:hover {

  background:
    var(--emerald-800);

  box-shadow:
    0 13px 25px
    rgba(15, 61, 50, 0.17);
}

.button-soft {

  color:
    var(--ink);

  background:
    var(--stone-50);

  border:
    1px solid
    var(--border);
}

.new-event-button {

  margin-top:
    14px;

  min-width:
    124px;
}

.text-action,
.inline-link {

  padding:
    0;

  border:
    0;

  background:
    transparent;

  color:
    var(--emerald-900);

  cursor:
    pointer;

  font-size:
    11px;

  font-weight:
    700;
}

.text-action:hover,
.inline-link:hover {

  text-decoration:
    underline;
}

/* ----------------------------------------------------------
   SECTIONS
   ---------------------------------------------------------- */

.section-block {

  margin-top:
    6px;
}

.section-header {

  margin-bottom:
    20px;

  display:
    flex;

  align-items:
    flex-end;

  justify-content:
    space-between;

  gap:
    30px;
}

.section-header h2 {

  max-width:
    500px;

  margin:
    0;

  color:
    var(--ink-soft);

  font-family:
    var(--font-display);

  font-size:
    26px;

  font-weight:
    500;

  line-height:
    1.16;

  letter-spacing:
    -0.028em;
}

/* ----------------------------------------------------------
   EVENT CARD
   ---------------------------------------------------------- */

.event-card {

  min-height:
    230px;

  display:
    grid;

  grid-template-columns:
    185px
    minmax(0, 1fr);

  overflow:
    hidden;

  background:
    rgba(
      255,
      255,
      255,
      0.93
    );

  border:
    1px solid
    var(--border);

  border-radius:
    18px;

  box-shadow:
    var(--shadow-card);

  transition:
    transform 200ms ease,
    box-shadow 200ms ease;
}

.event-card:hover {

  transform:
    translateY(-3px);

  box-shadow:
    0 30px 70px
    rgba(30, 42, 36, 0.1);
}

.event-visual {

  position:
    relative;

  overflow:
    hidden;

  background:
    linear-gradient(
      145deg,
      #d9d9cd,
      #eeebe3
    );
}

.event-visual::after {

  content: "";

  position:
    absolute;

  inset:
    auto -20px -40px auto;

  width:
    125px;

  height:
    125px;

  border-radius:
    50%;

  background:
    rgba(
      15,
      61,
      50,
      0.07
    );
}

.coffee-cup {

  position:
    absolute;

  top:
    66px;

  left:
    48px;

  width:
    82px;

  height:
    70px;

  border-radius:
    7px 7px 29px 29px;

  background:
    #f3eee4;

  box-shadow:
    0 18px 25px
    rgba(40, 35, 27, 0.12);

  transform:
    rotate(-2deg);
}

.coffee-cup::after {

  content: "";

  position:
    absolute;

  right:
    -22px;

  top:
    13px;

  width:
    31px;

  height:
    32px;

  border:
    7px solid
    #f3eee4;

  border-left:
    0;

  border-radius:
    0 18px 18px 0;
}

.coffee-surface {

  position:
    absolute;

  top:
    8px;

  left:
    8px;

  right:
    8px;

  height:
    18px;

  border-radius:
    50%;

  background:
    #5a3b25;
}

.leaf {

  position:
    absolute;

  width:
    54px;

  height:
    24px;

  border-radius:
    80% 0 80% 0;

  background:
    var(--emerald-800);

  transform:
    rotate(-28deg);
}

.leaf-one {

  right:
    -7px;

  top:
    33px;
}

.leaf-two {

  right:
    12px;

  top:
    59px;

  transform:
    rotate(26deg);
}

.event-content {

  padding:
    27px;
}

.event-topline {

  display:
    flex;

  align-items:
    center;

  justify-content:
    space-between;

  gap:
    16px;
}

.event-duration {

  display:
    inline-flex;

  align-items:
    center;

  gap:
    6px;

  color:
    var(--muted);

  font-size:
    11px;

  font-weight:
    550;
}

.event-duration svg {

  width:
    14px;

  height:
    14px;
}

.status {

  display:
    flex;

  align-items:
    center;

  gap:
    6px;

  color:
    var(--emerald-700);

  font-size:
    10px;

  font-weight:
    650;
}

.status-dot {

  width:
    7px;

  height:
    7px;

  border-radius:
    50%;

  background:
    #4f8c6e;

  box-shadow:
    0 0 0 4px
    rgba(
      79,
      140,
      110,
      0.11
    );
}

.event-content h3 {

  margin:
    29px
    0
    7px;

  color:
    var(--ink);

  font-family:
    var(--font-display);

  font-size:
    25px;

  font-weight:
    550;

  letter-spacing:
    -0.032em;
}

.event-content > p {

  max-width:
    470px;

  margin:
    0;

  color:
    var(--muted);

  font-size:
    11px;

  line-height:
    1.7;
}

.event-actions {

  display:
    flex;

  flex-wrap:
    wrap;

  gap:
    9px;

  margin-top:
    22px;
}

/* ----------------------------------------------------------
   GRID
   ---------------------------------------------------------- */

.dashboard-grid {

  margin-top:
    22px;

  display:
    grid;

  grid-template-columns:
    repeat(
      2,
      minmax(0, 1fr)
    );

  gap:
    18px;
}

.dashboard-card,
.manifesto-card {

  min-height:
    265px;

  padding:
    24px;

  background:
    rgba(
      255,
      255,
      255,
      0.9
    );

  border:
    1px solid
    var(--border);

  border-radius:
    16px;

  box-shadow:
    var(--shadow-small);
}

.card-heading {

  display:
    flex;

  align-items:
    flex-start;

  justify-content:
    space-between;

  gap:
    20px;
}

.card-heading h2 {

  margin:
    0;

  color:
    var(--ink);

  font-family:
    var(--font-display);

  font-size:
    21px;

  font-weight:
    550;

  letter-spacing:
    -0.03em;
}

/* ----------------------------------------------------------
   AVAILABILITY
   ---------------------------------------------------------- */

.availability-list {

  margin-top:
    29px;
}

.availability-row {

  min-height:
    48px;

  display:
    grid;

  grid-template-columns:
    45px
    1fr
    22px
    1fr;

  align-items:
    center;

  border-bottom:
    1px solid
    var(--border);
}

.availability-row:last-child {

  border-bottom:
    0;
}

.availability-row strong {

  color:
    var(--ink);

  font-size:
    11px;
}

.availability-row span {

  color:
    var(--muted);

  font-size:
    10px;
}

.time-divider {

  text-align:
    center;
}

.card-caption {

  margin-top:
    22px;

  color:
    var(--muted-light);

  font-size:
    9px;
}

/* ----------------------------------------------------------
   ATTENTION
   ---------------------------------------------------------- */

.attention-empty {

  min-height:
    174px;

  display:
    flex;

  flex-direction:
    column;

  align-items:
    center;

  justify-content:
    center;

  text-align:
    center;
}

.attention-icon {

  width:
    42px;

  height:
    42px;

  margin-bottom:
    14px;

  display:
    grid;

  place-items:
    center;

  border:
    1px solid
    var(--border-strong);

  border-radius:
    50%;

  color:
    var(--emerald-900);

  background:
    var(--stone-50);
}

.attention-empty strong {

  font-family:
    var(--font-display);

  font-size:
    16px;

  font-weight:
    550;
}

.attention-empty p {

  max-width:
    250px;

  margin:
    8px
    0
    12px;

  color:
    var(--muted);

  font-size:
    10px;

  line-height:
    1.55;
}

/* ----------------------------------------------------------
   BOOKINGS
   ---------------------------------------------------------- */

.bookings-card {

  min-height:
    292px;
}

.booking-list {

  margin-top:
    18px;
}

.booking-row {

  min-height:
    70px;

  display:
    grid;

  grid-template-columns:
    36px
    minmax(0, 1fr)
    auto
    26px;

  align-items:
    center;

  gap:
    11px;

  border-bottom:
    1px solid
    var(--border);
}

.booking-row:last-child {

  border-bottom:
    0;
}

.booking-avatar {

  width:
    34px;

  height:
    34px;

  display:
    grid;

  place-items:
    center;

  border-radius:
    50%;

  background:
    var(--stone-50);

  color:
    var(--emerald-900);

  font-size:
    9px;

  font-weight:
    700;
}

.booking-person strong,
.booking-time strong {

  display:
    block;

  font-size:
    10px;

  font-weight:
    650;
}

.booking-person span,
.booking-time span {

  display:
    block;

  margin-top:
    3px;

  color:
    var(--muted);

  font-size:
    8px;
}

.booking-time {

  text-align:
    right;
}

.icon-button {

  width:
    26px;

  height:
    26px;

  display:
    grid;

  place-items:
    center;

  border:
    0;

  background:
    transparent;

  color:
    var(--muted);

  cursor:
    pointer;
}

.icon-button svg {

  width:
    14px;

  height:
    14px;
}

/* ----------------------------------------------------------
   MANIFESTO
   ---------------------------------------------------------- */

.manifesto-card {

  position:
    relative;

  overflow:
    hidden;

  color:
    var(--pure-white);

  background:
    var(--emerald-900);

  border-color:
    transparent;
}

.manifesto-card::after {

  content: "";

  position:
    absolute;

  right:
    -80px;

  bottom:
    -100px;

  width:
    230px;

  height:
    230px;

  border-radius:
    50%;

  border:
    1px solid
    rgba(
      255,
      255,
      255,
      0.12
    );
}

.manifesto-card .eyebrow {

  color:
    var(--sage-300);
}

.manifesto-card h2 {

  max-width:
    360px;

  margin:
    25px
    0
    14px;

  font-family:
    var(--font-display);

  font-size:
    27px;

  font-weight:
    500;

  line-height:
    1.08;

  letter-spacing:
    -0.035em;
}

.manifesto-card > p {

  max-width:
    390px;

  margin:
    0;

  color:
    rgba(
      255,
      255,
      255,
      0.68
    );

  font-size:
    9px;

  line-height:
    1.7;
}

.manifesto-footer {

  position:
    absolute;

  left:
    24px;

  bottom:
    24px;

  display:
    flex;

  align-items:
    center;

  gap:
    10px;

  color:
    var(--sage-300);

  font-family:
    var(--font-display);

  font-size:
    12px;
}

.manifesto-footer span {

  width:
    30px;

  height:
    1px;

  background:
    var(--sage-300);
}

/* ----------------------------------------------------------
   BOOKING PREVIEW COLUMN
   ---------------------------------------------------------- */

.preview-column {

  min-width:
    0;
}

.preview-intro {

  padding:
    22px
    0
    30px;
}

.preview-intro h2 {

  margin:
    0;

  color:
    var(--emerald-900);

  font-family:
    var(--font-display);

  font-size:
    30px;

  font-weight:
    500;

  line-height:
    1.05;

  letter-spacing:
    -0.038em;
}

.preview-intro > p:last-child {

  margin:
    15px
    0
    0;

  color:
    var(--muted);

  font-size:
    10px;

  line-height:
    1.65;
}

/* ----------------------------------------------------------
   PHONE
   ---------------------------------------------------------- */

.phone-frame {

  position:
    relative;

  width:
    292px;

  min-height:
    592px;

  margin:
    0 auto;

  padding:
    8px;

  background:
    #121815;

  border-radius:
    37px;

  box-shadow:
    var(--shadow-phone);
}

.phone-camera {

  position:
    absolute;

  z-index:
    3;

  top:
    16px;

  left:
    50%;

  width:
    77px;

  height:
    21px;

  transform:
    translateX(-50%);

  border-radius:
    20px;

  background:
    #111714;
}

.phone-content {

  min-height:
    576px;

  overflow:
    hidden;

  border-radius:
    30px;

  background:
    var(--pure-white);
}

.phone-header {

  height:
    70px;

  padding:
    29px
    19px
    12px;

  display:
    flex;

  align-items:
    center;

  justify-content:
    space-between;
}

.phone-menu {

  width:
    25px;

  display:
    grid;

  gap:
    5px;

  border:
    0;

  background:
    transparent;

  cursor:
    pointer;
}

.phone-menu span {

  width:
    15px;

  height:
    1px;

  justify-self:
    end;

  background:
    var(--emerald-900);
}

.booking-art {

  position:
    relative;

  height:
    175px;

  overflow:
    hidden;

  background:
    linear-gradient(
      145deg,
      #dcd8cc,
      #edf0e8
    );
}

.booking-art-circle {

  position:
    absolute;

  width:
    150px;

  height:
    150px;

  left:
    -40px;

  top:
    -50px;

  border-radius:
    50%;

  background:
    rgba(
      255,
      255,
      255,
      0.38
    );
}

.booking-cup {

  position:
    absolute;

  left:
    96px;

  top:
    59px;

  width:
    72px;

  height:
    61px;

  border-radius:
    6px 6px 28px 28px;

  background:
    #f8f0e4;

  box-shadow:
    0 18px 26px
    rgba(56, 44, 29, 0.16);
}

.booking-cup::after {

  content: "";

  position:
    absolute;

  right:
    -18px;

  top:
    12px;

  width:
    25px;

  height:
    29px;

  border:
    6px solid
    #f8f0e4;

  border-left:
    0;

  border-radius:
    0 16px 16px 0;
}

.booking-coffee {

  position:
    absolute;

  top:
    6px;

  left:
    7px;

  right:
    7px;

  height:
    17px;

  border-radius:
    50%;

  background:
    #553823;
}

.booking-leaf {

  position:
    absolute;

  width:
    74px;

  height:
    31px;

  border-radius:
    80% 0 80% 0;

  background:
    var(--emerald-900);
}

.leaf-a {

  right:
    -16px;

  top:
    31px;

  transform:
    rotate(-35deg);
}

.leaf-b {

  right:
    13px;

  top:
    73px;

  transform:
    rotate(19deg);
}

.leaf-c {

  right:
    -15px;

  bottom:
    9px;

  transform:
    rotate(-17deg);
}

.booking-page-copy {

  padding:
    21px
    20px
    24px;
}

.booking-eyebrow {

  margin:
    0 0 7px;

  color:
    var(--sage-500);

  font-size:
    8px;

  font-weight:
    700;

  letter-spacing:
    0.14em;

  text-transform:
    uppercase;
}

.booking-page-copy h3 {

  margin:
    0;

  color:
    var(--ink);

  font-family:
    var(--font-display);

  font-size:
    31px;

  font-weight:
    500;

  line-height:
    0.99;

  letter-spacing:
    -0.045em;
}

.booking-meta {

  display:
    grid;

  gap:
    7px;

  margin-top:
    18px;

  color:
    var(--muted);

  font-size:
    9px;
}

.booking-meta span {

  display:
    flex;

  align-items:
    center;

  gap:
    7px;
}

.booking-meta svg {

  width:
    13px;

  height:
    13px;
}

.booking-description {

  margin:
    18px
    0;

  color:
    var(--muted);

  font-size:
    9px;

  line-height:
    1.65;
}

.select-time-button {

  width:
    100%;

  min-height:
    43px;

  display:
    flex;

  align-items:
    center;

  justify-content:
    center;

  gap:
    8px;

  border:
    0;

  border-radius:
    8px;

  color:
    var(--pure-white);

  background:
    var(--emerald-900);

  cursor:
    pointer;

  font-size:
    10px;

  font-weight:
    700;
}

.select-time-button svg {

  width:
    14px;

  height:
    14px;
}

.powered-by {

  margin-top:
    16px;

  color:
    var(--muted-light);

  text-align:
    center;

  font-size:
    7px;
}

.powered-by strong {

  color:
    var(--emerald-900);

  font-family:
    var(--font-display);

  font-size:
    9px;
}

.preview-quote {

  margin:
    40px
    0
    0
    10px;

  display:
    flex;

  align-items:
    flex-start;

  gap:
    14px;
}

.preview-quote > span {

  width:
    28px;

  height:
    1px;

  margin-top:
    11px;

  background:
    var(--sage-500);
}

.preview-quote p {

  margin:
    0;

  color:
    var(--emerald-900);

  font-family:
    var(--font-display);

  font-size:
    17px;

  font-style:
    italic;

  line-height:
    1.25;
}

/* ----------------------------------------------------------
   RESPONSIVE
   ---------------------------------------------------------- */

@media (
  max-width: 1250px
) {

  .workspace {

    grid-template-columns:
      minmax(0, 1fr);

    padding-right:
      44px;
  }

  .preview-column {

    display:
      grid;

    grid-template-columns:
      minmax(0, 1fr)
      320px;

    align-items:
      center;

    gap:
      45px;

    padding-top:
      30px;
  }

  .preview-intro {

    max-width:
      420px;
  }

  .preview-quote {

    display:
      none;
  }
}

@media (
  max-width: 930px
) {

  .app-shell {

    display:
      block;
  }

  .sidebar {

    position:
      static;

    width:
      100%;

    height:
      auto;

    padding:
      20px
      24px;

    flex-direction:
      row;

    align-items:
      center;

    gap:
      20px;

    border-right:
      0;

    border-bottom:
      1px solid
      var(--border);
  }

  .sidebar-brand {

    padding:
      0;
  }

  .sidebar-navigation {

    margin-left:
      auto;

    display:
      flex;

    gap:
      4px;
  }

  .navigation-item {

    width:
      40px;

    height:
      40px;

    padding:
      0;

    justify-content:
      center;
  }

  .navigation-item span {

    display:
      none;
  }

  .sidebar-manifesto,
  .sidebar-profile {

    display:
      none;
  }

  .workspace {

    padding:
      42px
      30px
      70px;
  }
}

@media (
  max-width: 700px
) {

  .workspace {

    padding:
      36px
      18px
      60px;
  }

  .dashboard-header {

    min-height:
      240px;

    display:
      block;
  }

  .dashboard-header h1 {

    font-size:
      49px;
  }

  .new-event-button {

    margin-top:
      27px;
  }

  .section-header {

    align-items:
      flex-start;
  }

  .event-card {

    grid-template-columns:
      1fr;
  }

  .event-visual {

    min-height:
      175px;
  }

  .coffee-cup {

    left:
      calc(50% - 40px);

    top:
      49px;
  }

  .dashboard-grid {

    grid-template-columns:
      1fr;
  }

  .preview-column {

    display:
      block;

    margin-top:
      15px;
  }

  .preview-intro {

    margin:
      0 auto;

    max-width:
      450px;
  }

  .phone-frame {

    margin-top:
      20px;
  }
}

@media (
  max-width: 520px
) {

  .sidebar {

    padding:
      16px
      18px;
  }

  .sidebar-navigation {

    gap:
      0;
  }

  .navigation-item {

    width:
      35px;

    height:
      35px;
  }

  .navigation-item:nth-child(5) {

    display:
      none;
  }

  .brand-mark {

    font-size:
      27px;
  }

  .dashboard-header h1 {

    font-size:
      43px;
  }

  .section-header h2 {

    font-size:
      23px;
  }

  .section-header .text-action {

    display:
      none;
  }

  .event-content {

    padding:
      22px;
  }

  .event-actions {

    display:
      grid;
  }

  .event-actions .button {

    width:
      100%;
  }

  .availability-row {

    grid-template-columns:
      40px
      1fr
      20px
      1fr;
  }

  .booking-row {

    grid-template-columns:
      34px
      minmax(0, 1fr)
      26px;
  }

  .booking-time {

    display:
      none;
  }

  .phone-frame {

    width:
      min(
        292px,
        100%
      );
  }
}
'@

# ============================================================
# TYPE CHECK
# ============================================================

Write-Host ""
Write-Host "Running TypeScript validation..." -ForegroundColor Yellow
Write-Host ""

npm run typecheck

if ($LASTEXITCODE -ne 0) {

    throw "TypeScript validation failed."
}

Write-Host ""
Write-Host "TypeScript validation passed." -ForegroundColor Green

# ============================================================
# PRODUCTION BUILD
# ============================================================

Write-Host ""
Write-Host "Creating production build..." -ForegroundColor Yellow
Write-Host ""

npm run build

if ($LASTEXITCODE -ne 0) {

    throw "Production build failed."
}

Write-Host ""
Write-Host "Production build passed." -ForegroundColor Green

# ============================================================
# STATUS
# ============================================================

Write-Host ""
Write-Host "==============================================" -ForegroundColor DarkGreen
Write-Host " ATTEND BRAND UI COMPLETE" -ForegroundColor DarkGreen
Write-Host "==============================================" -ForegroundColor DarkGreen
Write-Host ""

Write-Host "Brand:" -ForegroundColor Cyan
Write-Host "  attend."
Write-Host ""

Write-Host "Positioning:" -ForegroundColor Cyan
Write-Host "  Make time intentional."
Write-Host ""

Write-Host "Visual direction:" -ForegroundColor Cyan
Write-Host "  Quiet Emerald"
Write-Host "  Editorial"
Write-Host "  Calm"
Write-Host "  Premium"
Write-Host ""

Write-Host "Palette:" -ForegroundColor Cyan
Write-Host "  Emerald   #0F3D32"
Write-Host "  Sage      #7F9B8A"
Write-Host "  Mist      #D7DED6"
Write-Host "  Stone     #EDE8E1"
Write-Host "  Off White #FAF9F6"
Write-Host ""

Write-Host "Typography:" -ForegroundColor Cyan
Write-Host "  Playfair Display — brand / editorial"
Write-Host "  Inter            — application UI"
Write-Host ""

Write-Host "Static domain UI included:" -ForegroundColor Cyan
Write-Host "  Host workspace"
Write-Host "  Event types"
Write-Host "  Availability"
Write-Host "  Attention rules"
Write-Host "  Upcoming bookings"
Write-Host "  Guest booking preview"
Write-Host ""

Write-Host "No Supabase calls added." -ForegroundColor Yellow
Write-Host "No authentication added." -ForegroundColor Yellow
Write-Host "No AI added." -ForegroundColor Yellow
Write-Host "No database writes added." -ForegroundColor Yellow
Write-Host ""

Write-Host "Previous frontend backup:" -ForegroundColor Cyan
Write-Host "  $BackupPath"
Write-Host ""

Write-Host "Start the development server:" -ForegroundColor Cyan
Write-Host ""
Write-Host "  npm run dev"
Write-Host ""

Write-Host "Then open the Local URL shown by Vite."
Write-Host ""