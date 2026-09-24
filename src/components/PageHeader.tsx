interface PageHeaderProps {
  eyebrow?: string;
  title: string;
  description?: string;
  action?: React.ReactNode;
}

export function PageHeader({
  eyebrow,
  title,
  description,
  action,
}: PageHeaderProps) {
  return (
    <header className="page-header">
      <div>
        {eyebrow && (
          <p className="eyebrow">
            {eyebrow}
          </p>
        )}

        <h1>{title}</h1>

        {description && (
          <p className="page-description">
            {description}
          </p>
        )}
      </div>

      {action && (
        <div className="page-header-action">
          {action}
        </div>
      )}
    </header>
  );
}
