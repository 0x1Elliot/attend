/**
 * TEMPORARY FRONTEND CONTRACT
 *
 * The canonical database/schema model is being built separately.
 *
 * Do not treat this interface as the permanent database schema.
 * Replace or generate these types when the backend contract
 * becomes available.
 */

export interface EventType {
  id: string;
  title: string;
  description?: string;
  durationMinutes: number;
  slug: string;
  active: boolean;
}
