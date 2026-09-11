# Empire State Financing CRM

This folder defines the first production-ready data model for tracking a prospective client from website lead through funding.

## Pipeline
New Lead → Contacted → Qualified → Documents Pending → Ready to Submit → Submitted → Under Review → Approved → Funded

Declined and Inactive are also supported.

## Data model
- `prospects`: one permanent client/prospect record
- `applications`: one prospect can have multiple funding applications
- `interactions`: calls, email, SMS, WhatsApp, meetings, website events, and staff notes
- `documents`: metadata for privately stored documents
- `tasks`: follow-ups and staff actions
- `audit_log`: security/accountability history

## Security architecture
The public website must never receive direct database credentials. Website submissions should go through a server-side API endpoint that validates the request and creates the prospect/application records.

The staff CRM must require authentication and role-based authorization. Financial statements, tax returns, IDs, bank statements, and similar files should be stored in private object storage. The database should hold only their private storage keys and metadata.

Use TLS in transit, encryption at rest, least-privilege database credentials, backups, audit logging, session expiration, and MFA for staff accounts. Do not place database passwords or API secrets in GitHub source files; use deployment environment variables.

## Next implementation stage
1. Provision a managed PostgreSQL database.
2. Run `schema.sql`.
3. Add authenticated server-side API routes.
4. Change the existing four-step website form so submission writes to the API/database instead of being only a browser-local record.
5. Add a protected `/admin` CRM dashboard with prospect search, pipeline status, interactions, tasks, applications, and document checklist.
6. Add automated follow-up channels only after consent and messaging-provider configuration are established.

## Environment variables expected
Exact names can be adapted to the selected database/auth provider. Typical examples:
- `DATABASE_URL`
- `AUTH_SECRET`
- private object-storage credentials
- email/SMS/WhatsApp provider credentials when those integrations are added

Never commit actual secret values.
