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
