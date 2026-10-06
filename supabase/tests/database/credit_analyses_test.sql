begin;

select plan(24);

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
select col_not_null(
  'public',
  'credit_analyses',
  'user_id',
  'user_id should be required'
);
select has_column(
    'public',
    'credit_analyses',
    'monthly_income',
    'credit_analyses table should have a monthly_income column'
);

select col_not_null(
    'public',
    'credit_analyses',
    'monthly_income',
    'monthly_income should be required'
);

select has_column(
    'public',
    'credit_analyses',
    'credit_cards',
    'credit_analyses table should have a credit_cards column'
);
select col_not_null(
    'public',
    'credit_analyses',
    'credit_cards',
    'credit_cards should be required'
);

select has_column(
    'public',
    'credit_analyses',
    'personal_loans',
    'credit_analyses table should have a personal_loans column'
);
select col_not_null(
    'public',
    'credit_analyses',
    'personal_loans',
    'personal_loans should be required'
);

select has_column(
    'public',
    'credit_analyses',
    'vehicle_loan',
    'credit_analyses table should have a vehicle_loan column'
);
select col_not_null(
    'public',
    'credit_analyses',
    'vehicle_loan',
    'vehicle_loan should be required'
);

select has_column(
    'public',
    'credit_analyses',
    'mortgage',
    'credit_analyses table should have a mortgage column'
);
select col_not_null(
    'public',
    'credit_analyses',
    'mortgage',
    'mortgage should be required'
);
select has_column(
    'public',
    'credit_analyses',
    'other_debts',
    'credit_analyses table should have a other_debts column'
);
select col_not_null(
    'public',
    'credit_analyses',
    'other_debts',
    'other_debts should be required'
);

select has_column(
    'public',
    'credit_analyses',
    'total_debt',
    'credit_analyses table should have a total_debt column'
);
select col_not_null(
    'public',
    'credit_analyses',
    'total_debt',
    'total_debt should be required'
);

select has_column(
    'public',
    'credit_analyses',
    'percentage',
    'credit_analyses table should have a percentage column'
);
select col_not_null(
    'public',
    'credit_analyses',
    'percentage',
    'percentage should be required'
);

select has_column(
    'public',
    'credit_analyses',
    'category',
    'credit_analyses table should have a category column'
);
select col_not_null(
    'public',
    'credit_analyses',
    'category',
    'category should be required'
);

select has_column(
    'public',
    'credit_analyses',
    'created_at',
    'credit_analyses table should have a created_at column'
);
select col_not_null(
    'public',
    'credit_analyses',
    'created_at',
    'created_at should be required'
);

select ok(
    (
        select relrowsecurity
        from pg_class
        where oid = 'public.credit_analyses'::regclass
    ),
    'RLS should be enabled for credit_analyses'
);

select * from finish();

rollback;