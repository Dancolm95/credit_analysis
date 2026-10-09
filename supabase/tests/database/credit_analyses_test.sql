begin;

select plan(27);

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
select ok(
    exists(
        select 1
        from pg_policies
        where schemaname = 'public'
        and tablename = 'credit_analyses'
        and policyname = 'Users can insert own credit analyses'
        and cmd = 'INSERT'
    ),
    'credit_analyses should have an insert policy'
);

insert into auth.users (id, email)
values(
    '00000000-0000-0000-0000-000000000001',
    'owner@example.com'
);

set local role authenticated;
set local request.jwt.claim.sub = '00000000-0000-0000-0000-000000000001';

select lives_ok(
    $$
    insert into public.credit_analyses (
        user_id,
        monthly_income,
        credit_cards,
        personal_loans,
        vehicle_loan,
        mortgage,
        total_debt,
        other_debts,
        percentage,
        category
    )
    values (
        '00000000-0000-0000-0000-000000000001',
        50000,
        500,
        0,
        0,
        0,
        500,
        0,
        10,
        'low'
    )
    $$,
    'an authenticated user can insert their own analysis'
);
reset role;

insert into auth.users (id, email)
values(
    '00000000-0000-0000-0000-000000000002',
    'other@example.com'
);

set local role authenticated;
set local request.jwt.claim.sub = '00000000-0000-0000-0000-000000000001';

select throws_ok(
    $$
    insert into public.credit_analyses (
        user_id,
        monthly_income,
        credit_cards,
        personal_loans,
        vehicle_loan,
        mortgage,
        total_debt,
        other_debts,
        percentage,
        category
    )
    values (
        '00000000-0000-0000-0000-000000000002',
        50000,
        500,
        0,
        0,
        0,
        500,
        0,
        10,
        'low'
    )
    $$,
    '42501',
    'new row violates row-level security policy for table "credit_analyses"',
    'a user cannot insert an analysis for another user'
);

reset role;

select * from finish();

rollback;