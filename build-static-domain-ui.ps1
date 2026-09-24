$ErrorActionPreference = "Stop"

$RepoPath = "C:\Users\Administrator\Attend"

Set-Location $RepoPath

Write-Host ""
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host " ATTEND STATIC DOMAIN UI BUILD" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""

# ------------------------------------------------------------
# Safety checks
# ------------------------------------------------------------

if (-not (Test-Path "$RepoPath\src")) {
    throw "src folder not found at $RepoPath"
}

if (-not (Test-Path "$RepoPath\package.json")) {
    throw "package.json not found at $RepoPath"
}

# ------------------------------------------------------------
# Create backup of current frontend
# ------------------------------------------------------------

$Timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$BackupPath = Join-Path $RepoPath "backup-src-$Timestamp"

Write-Host "Backing up current src folder..." -ForegroundColor Yellow

Copy-Item `
    "$RepoPath\src" `
    $BackupPath `
    -Recurse `
    -Force

Write-Host "Backup created at:" -ForegroundColor Green
Write-Host $BackupPath
Write-Host ""

# ------------------------------------------------------------
# Helper
# ------------------------------------------------------------

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

    $Content | Set-Content `
        -Path $FullPath `
        -Encoding UTF8

    Write-Host "Created: $RelativePath" -ForegroundColor DarkGray
}

# ------------------------------------------------------------
# Ensure folders exist
# ------------------------------------------------------------

$Folders = @(
    "src\components",
    "src\pages",
    "src\types"
)

foreach ($Folder in $Folders) {
    New-Item `
        -ItemType Directory `
        -Path (Join-Path $RepoPath $Folder) `
        -Force | Out-Null
}

# ------------------------------------------------------------
# Domain types
# ------------------------------------------------------------

Write-ProjectFile "src\types\domain.ts" @'
export interface EventType {
  id: string;
  title: string;
  durationMinutes: number;
  status: "Active" | "Inactive";
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
  enabled: boolean;
}

export interface Booking {
  id: string;
  guestName: string;
  eventTitle: string;
  date: string;
  time: string;
  status: "Confirmed" | "Cancelled";
}
'@

# ------------------------------------------------------------
# Event card
# ------------------------------------------------------------

Write-ProjectFile "src\components\EventCard.tsx" @'
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
'@

# ------------------------------------------------------------
# Availability UI
# ------------------------------------------------------------

Write-ProjectFile "src\components\AvailabilitySection.tsx" @'
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
              {" – "}
              {window.endTime}
            </span>

          </div>

        ))}

      </div>

    </section>
  );
}
'@

# ------------------------------------------------------------
# Attention Rules
# ------------------------------------------------------------

Write-ProjectFile "src\components\AttentionRulesSection.tsx" @'
import type {
  AttentionRule,
} from "../types/domain";

interface AttentionRulesSectionProps {
  rules: AttentionRule[];
}

export function AttentionRulesSection({
  rules,
}: AttentionRulesSectionProps) {
  return (
    <section className="domain-section">

      <div className="section-heading">

        <div>

          <p className="section-label">
            Attention Rules
          </p>

          <h2>
            Scheduling rules
          </h2>

        </div>

        <button
          type="button"
          className="button secondary-button"
        >
          + Add attention rule
        </button>

      </div>

      {rules.length === 0 ? (

        <div className="empty-state">

          <p>
            No rules configured
          </p>

          <span>
            Attention rules will eventually control
            how Attend handles scheduling constraints.
          </span>

        </div>

      ) : (

        <div className="rule-list">

          {rules.map((rule) => (

            <div
              key={rule.id}
              className="rule-row"
            >

              <span>
                {rule.label}
              </span>

              <span className="status-badge">
                {rule.enabled
                  ? "Enabled"
                  : "Disabled"}
              </span>

            </div>

          ))}

        </div>

      )}

    </section>
  );
}
'@

# ------------------------------------------------------------
# Booking UI
# ------------------------------------------------------------

Write-ProjectFile "src\components\BookingsSection.tsx" @'
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
'@

# ------------------------------------------------------------
# Dashboard
# ------------------------------------------------------------

Write-ProjectFile "src\pages\DashboardPage.tsx" @'
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
'@

# ------------------------------------------------------------
# App
# ------------------------------------------------------------

Write-ProjectFile "src\App.tsx" @'
import { DashboardPage } from "./pages/DashboardPage";

function App() {
  return <DashboardPage />;
}

export default App;
'@

# ------------------------------------------------------------
# Main
# ------------------------------------------------------------

Write-ProjectFile "src\main.tsx" @'
import { StrictMode } from "react";
import { createRoot } from "react-dom/client";

import App from "./App";
import "./index.css";

const root =
  document.getElementById("root");

if (!root) {
  throw new Error(
    "Root element not found."
  );
}

createRoot(root).render(
  <StrictMode>
    <App />
  </StrictMode>
);
'@

# ------------------------------------------------------------
# CSS
# ------------------------------------------------------------

Write-ProjectFile "src\index.css" @'
:root {
  font-family:
    Inter,
    ui-sans-serif,
    system-ui,
    -apple-system,
    BlinkMacSystemFont,
    "Segoe UI",
    sans-serif;

  color: #171717;
  background: #f5f5f2;

  font-synthesis: none;
  text-rendering: optimizeLegibility;
}

* {
  box-sizing: border-box;
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
}

button {
  font: inherit;
}

.dashboard-shell {
  min-height: 100vh;
}

.top-bar {
  height: 72px;

  display: flex;
  align-items: center;
  justify-content: space-between;

  padding: 0 3rem;

  background: #ffffff;

  border-bottom:
    1px solid #e2e2dc;
}

.brand-mark {
  font-size: 0.85rem;

  font-weight: 800;

  letter-spacing: 0.18em;
}

.host-pill {
  padding:
    0.45rem
    0.7rem;

  border-radius: 999px;

  background: #f0f0eb;

  color: #666660;

  font-size: 0.75rem;

  font-weight: 650;
}

.dashboard {
  width: min(
    100% - 3rem,
    900px
  );

  margin: 0 auto;

  padding:
    5rem
    0
    8rem;
}

.intro-section {
  margin-bottom: 2rem;
}

.section-label {
  margin:
    0
    0
    0.65rem;

  color: #83837c;

  font-size: 0.72rem;

  font-weight: 750;

  letter-spacing: 0.12em;

  text-transform: uppercase;
}

.intro-section h1 {
  margin: 0;

  font-size:
    clamp(
      2.6rem,
      6vw,
      4.75rem
    );

  line-height: 0.98;

  letter-spacing:
    -0.055em;
}

.intro-copy {
  max-width: 600px;

  margin:
    1rem
    0
    0;

  color: #73736d;

  line-height: 1.6;
}

.event-section {
  margin-bottom: 1.5rem;
}

.domain-card,
.domain-section {
  background: #ffffff;

  border:
    1px solid
    #e2e2dc;

  border-radius: 14px;
}

.domain-card {
  padding: 1.7rem;
}

.domain-section {
  margin-top: 1.5rem;

  padding: 1.7rem;
}

.domain-card-header,
.section-heading {
  display: flex;

  align-items: flex-start;

  justify-content:
    space-between;

  gap: 2rem;
}

.domain-card h3,
.section-heading h2 {
  margin: 0;

  letter-spacing:
    -0.03em;
}

.domain-card h3 {
  font-size: 1.5rem;
}

.section-heading h2 {
  font-size: 1.35rem;
}

.muted {
  margin:
    0.7rem
    0
    0;

  color: #7b7b75;
}

.status-badge {
  display: inline-flex;

  align-items: center;

  justify-content: center;

  min-height: 28px;

  padding:
    0
    0.65rem;

  border-radius: 999px;

  background: #efefe9;

  color: #4d4d48;

  font-size: 0.72rem;

  font-weight: 750;
}

.button-row {
  display: flex;

  flex-wrap: wrap;

  gap: 0.7rem;

  margin-top: 2rem;
}

.button {
  min-height: 40px;

  padding:
    0
    0.9rem;

  border-radius: 8px;

  border: 0;

  cursor: pointer;

  font-size: 0.82rem;

  font-weight: 700;
}

.primary-button {
  color: #ffffff;

  background: #1d1d1b;
}

.secondary-button {
  color: #242421;

  background: #f3f3ee;

  border:
    1px solid
    #ddddD6;
}

.availability-list,
.rule-list,
.booking-list {
  margin-top: 1.5rem;
}

.availability-row {
  min-height: 56px;

  display: grid;

  grid-template-columns:
    90px
    1fr;

  align-items: center;

  border-bottom:
    1px solid
    #efefe9;
}

.availability-row:last-child {
  border-bottom: 0;
}

.availability-day {
  font-size: 0.9rem;
}

.availability-row span {
  color: #666660;

  font-size: 0.9rem;
}

.empty-state {
  margin-top: 1.5rem;

  padding: 1.25rem;

  background: #f7f7f3;

  border-radius: 10px;
}

.empty-state p {
  margin: 0;

  font-weight: 700;
}

.empty-state span {
  display: block;

  margin-top: 0.45rem;

  color: #797972;

  font-size: 0.85rem;

  line-height: 1.5;
}

.rule-row {
  min-height: 54px;

  display: flex;

  align-items: center;

  justify-content:
    space-between;

  border-bottom:
    1px solid
    #efefe9;
}

.booking-row {
  display: grid;

  grid-template-columns:
    minmax(0, 1.5fr)
    minmax(0, 1fr)
    auto;

  align-items: center;

  gap: 1.5rem;

  min-height: 74px;

  border-bottom:
    1px solid
    #efefe9;
}

.booking-row:last-child {
  border-bottom: 0;
}

.booking-row strong {
  display: block;
}

.booking-row p {
  margin:
    0.25rem
    0
    0;

  color: #7c7c76;

  font-size: 0.82rem;
}

.booking-meta {
  display: grid;

  gap: 0.2rem;

  color: #686863;

  font-size: 0.82rem;
}

@media (
  max-width: 700px
) {

  .top-bar {
    padding:
      0
      1.2rem;
  }

  .dashboard {
    width:
      min(
        100% - 2rem,
        900px
      );

    padding:
      3rem
      0
      5rem;
  }

  .domain-card-header,
  .section-heading {
    display: block;
  }

  .section-heading
  .button {
    margin-top: 1rem;
  }

  .booking-row {
    grid-template-columns:
      1fr;

    gap: 0.75rem;

    padding:
      1rem
      0;
  }

}
'@

# ------------------------------------------------------------
# Verify types
# ------------------------------------------------------------

Write-Host ""
Write-Host "Running TypeScript check..." -ForegroundColor Yellow

npm run typecheck

if ($LASTEXITCODE -ne 0) {
    throw "TypeScript check failed."
}

# ------------------------------------------------------------
# Production build
# ------------------------------------------------------------

Write-Host ""
Write-Host "Running production build..." -ForegroundColor Yellow

npm run build

if ($LASTEXITCODE -ne 0) {
    throw "Production build failed."
}

# ------------------------------------------------------------
# Completion
# ------------------------------------------------------------

Write-Host ""
Write-Host "==========================================" -ForegroundColor Green
Write-Host " STATIC DOMAIN UI COMPLETE" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Green
Write-Host ""

Write-Host "Frontend now represents:" -ForegroundColor Cyan
Write-Host "  Profile / Host UI"
Write-Host "  Event Type"
Write-Host "  Availability"
Write-Host "  Attention Rule"
Write-Host "  Booking"
Write-Host ""

Write-Host "No Supabase calls were added."
Write-Host "No authentication was added."
Write-Host "No AI was added."
Write-Host "No forms submit data."
Write-Host ""

Write-Host "Start the app with:" -ForegroundColor Cyan
Write-Host ""
Write-Host "  npm run dev"
Write-Host ""

Write-Host "Backup of the previous src folder:" -ForegroundColor Cyan
Write-Host "  $BackupPath"
Write-Host ""