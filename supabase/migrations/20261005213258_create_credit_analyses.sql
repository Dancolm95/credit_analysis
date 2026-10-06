create table public.credit_analyses(
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  monthly_income numeric(14,2) not null,
  credit_cards numeric(14,2) not null,
  personal_loans numeric(14,2) not null,
  vehicle_loan numeric(14,2) not null,
  mortgage numeric(14,2) not null,
  total_debt numeric(14,2) not null,
  other_debts numeric(14,2) not null,
  percentage numeric(7,2) not null,
  category text not null,
  created_at timestamptz not null default now()
);

alter table public.credit_analyses enable row level security;

create policy "Users can insert own credit analyses"
on public.credit_analyses
for insert
to authenticated
with check ((select auth.uid()) = user_id);
