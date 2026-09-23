import { NavLink, Outlet } from "react-router-dom";
import { Logo } from "../components/Logo";

export function AppLayout() {
  return (
    <div className="app-shell">

      <aside className="sidebar">

        <Logo />

        <nav className="sidebar-nav">

          <NavLink
            to="/dashboard"
            className={({ isActive }) =>
              isActive
                ? "nav-link active"
                : "nav-link"
            }
          >
            Dashboard
          </NavLink>

          <NavLink
            to="/events/new"
            className={({ isActive }) =>
              isActive
                ? "nav-link active"
                : "nav-link"
            }
          >
            Create event
          </NavLink>

        </nav>

        <div className="sidebar-footer">
          <p>Attend</p>
          <span>Scheduling infrastructure</span>
        </div>

      </aside>

      <main className="app-content">
        <Outlet />
      </main>

    </div>
  );
}
