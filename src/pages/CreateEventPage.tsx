import { useState } from "react";
import type { FormEvent } from "react";

import {
  Link,
  useNavigate,
} from "react-router-dom";

import { PageHeader } from "../components/PageHeader";

export function CreateEventPage() {

  const navigate = useNavigate();

  const [title, setTitle] =
    useState("");

  const [duration, setDuration] =
    useState("30");

  const [description, setDescription] =
    useState("");

  function handleSubmit(
    event: FormEvent<HTMLFormElement>
  ) {
    event.preventDefault();

    /**
     * TEMPORARY:
     *
     * No database call occurs yet.
     *
     * This form will be connected to the canonical
     * Attend schema once the backend contract is ready.
     */

    console.log({
      title,
      durationMinutes: Number(duration),
      description,
    });

    navigate("/dashboard");
  }

  return (
    <div className="page page-narrow">

      <PageHeader
        eyebrow="Event types"
        title="Create an event"
        description="Define the first version of the scheduling experience."
      />

      <form
        className="form-card"
        onSubmit={handleSubmit}
      >

        <label className="field">

          <span>Event name</span>

          <input
            required
            type="text"
            placeholder="30 Minute Meeting"
            value={title}
            onChange={(event) =>
              setTitle(event.target.value)
            }
          />

        </label>

        <label className="field">

          <span>Duration</span>

          <select
            value={duration}
            onChange={(event) =>
              setDuration(event.target.value)
            }
          >
            <option value="15">
              15 minutes
            </option>

            <option value="30">
              30 minutes
            </option>

            <option value="45">
              45 minutes
            </option>

            <option value="60">
              60 minutes
            </option>
          </select>

        </label>

        <label className="field">

          <span>Description</span>

          <textarea
            rows={5}
            placeholder="Tell guests what this meeting is about."
            value={description}
            onChange={(event) =>
              setDescription(event.target.value)
            }
          />

        </label>

        <div className="form-actions">

          <Link
            to="/dashboard"
            className="button button-secondary"
          >
            Cancel
          </Link>

          <button
            type="submit"
            className="button button-primary"
          >
            Continue
          </button>

        </div>

      </form>

      <p className="integration-note">
        Frontend-only for now. Database persistence
        will be connected after the Attend schema
        contract is ready.
      </p>

    </div>
  );
}

