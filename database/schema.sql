-- Empire State Financing CRM database schema
-- PostgreSQL

create extension if not exists pgcrypto;

create table if not exists prospects (
  id uuid primary key default gen_random_uuid(),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  status text not null default 'new_lead' check (status in ('new_lead','contacted','qualified','documents_pending','ready_to_submit','submitted','under_review','approved','funded','declined','inactive')),
  applicant_type text,
  first_name text,
  last_name text,
  business_name text,
  email text,
  phone text,
  preferred_language text default 'en' check (preferred_language in ('en','es')),
  city text,
  state text,
  zip text,
  lead_source text default 'website',
  assigned_to text,
  consent_at timestamptz,
  next_follow_up_at timestamptz,
  notes text
);

create index if not exists prospects_status_idx on prospects(status);
create index if not exists prospects_email_idx on prospects(lower(email));
create index if not exists prospects_phone_idx on prospects(phone);
create index if not exists prospects_next_follow_up_idx on prospects(next_follow_up_at);

create table if not exists applications (
  id uuid primary key default gen_random_uuid(),
  prospect_id uuid not null references prospects(id) on delete cascade,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  funding_preference text,
  amount_requested numeric(14,2),
  purpose text,
  timeline text,
  description text,
  program_name text,
  lender_name text,
  status text not null default 'draft' check (status in ('draft','documents_pending','ready','submitted','under_review','approved','declined','funded','withdrawn')),
  submitted_at timestamptz,
  approved_amount numeric(14,2),
  interest_rate numeric(7,4),
  term_months integer,
  approved_at timestamptz,
  funded_at timestamptz,
  outcome_notes text
);

create index if not exists applications_prospect_idx on applications(prospect_id);
create index if not exists applications_status_idx on applications(status);

create table if not exists interactions (
  id uuid primary key default gen_random_uuid(),
  prospect_id uuid not null references prospects(id) on delete cascade,
  application_id uuid references applications(id) on delete set null,
  created_at timestamptz not null default now(),
  occurred_at timestamptz not null default now(),
  channel text not null check (channel in ('phone','email','sms','whatsapp','meeting','website','internal_note','other')),
  direction text check (direction in ('inbound','outbound','internal')),
  subject text,
  notes text not null,
  staff_member text,
  next_action text,
  next_follow_up_at timestamptz
);

create index if not exists interactions_prospect_idx on interactions(prospect_id, occurred_at desc);

create table if not exists documents (
  id uuid primary key default gen_random_uuid(),
  prospect_id uuid not null references prospects(id) on delete cascade,
  application_id uuid references applications(id) on delete cascade,
  created_at timestamptz not null default now(),
  document_type text not null,
  storage_key text not null,
  original_filename text,
  status text not null default 'received' check (status in ('requested','received','reviewed','accepted','rejected')),
  reviewed_by text,
  reviewed_at timestamptz,
  notes text
);

create table if not exists tasks (
  id uuid primary key default gen_random_uuid(),
  prospect_id uuid not null references prospects(id) on delete cascade,
  application_id uuid references applications(id) on delete cascade,
  created_at timestamptz not null default now(),
  due_at timestamptz,
  title text not null,
  details text,
  assigned_to text,
  completed_at timestamptz
);

create index if not exists tasks_due_idx on tasks(due_at) where completed_at is null;

create table if not exists audit_log (
  id bigserial primary key,
  created_at timestamptz not null default now(),
  actor text,
  action text not null,
  entity_type text not null,
  entity_id text,
  details jsonb not null default '{}'::jsonb
);

-- Keep sensitive identity documents and financial files in private object storage.
-- Store only the storage key and metadata in this database.
