begin;

select plan(12);

select has_table(
  'public',
  'credit_analyses',
  'credit_analyses table should exist'
);
select has_column(
  'public',
  'credit_analyses',
  'user_id',
  'credit_analyses table should have a user_id column'
);
select has_column(
    'public',
    'credit_analyses',
    'monthly_income',
    'credit_analyses table should have a monthly_income column'
);

select has_column(
    'public',
    'credit_analyses',
    'credit_cards',
    'credit_analyses table should have a credit_cards column'
);

select has_column(
    'public',
    'credit_analyses',
    'personal_loans',
    'credit_analyses table should have a personal_loans column'
);
select has_column(
    'public',
    'credit_analyses',
    'vehicle_loan',
    'credit_analyses table should have a vehicle_loan column'
);

select has_column(
    'public',
    'credit_analyses',
    'mortgage',
    'credit_analyses table should have a mortgage column'
);
select has_column(
    'public',
    'credit_analyses',
    'other_debts',
    'credit_analyses table should have a other_debts column'
);
select has_column(
    'public',
    'credit_analyses',
    'total_debt',
    'credit_analyses table should have a total_debt column'
);

select has_column(
    'public',
    'credit_analyses',
    'percentage',
    'credit_analyses table should have a percentage column'
);

select has_column(
    'public',
    'credit_analyses',
    'category',
    'credit_analyses table should have a category column'
);
select has_column(
    'public',
    'credit_analyses',
    'created_at',
    'credit_analyses table should have a created_at column'
);

select * from finish();

rollback;