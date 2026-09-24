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
