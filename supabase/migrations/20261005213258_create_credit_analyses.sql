create table public.credit_analyses(
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  monthly_income numeric(14,2),
  credit_cards numeric(14,2),
  personal_loans numeric(14,2),
  vehicle_loan numeric(14,2),
  mortgage numeric(14,2),
  total_debt numeric(14,2),
  other_debts numeric(14,2),
  percentage numeric(7,2),
  category text,
  created_at timestamptz default now()
);