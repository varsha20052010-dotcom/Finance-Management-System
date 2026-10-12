create database finance_management;
use finance_management;

create table categories(
category_id int primary key auto_increment,
category_name varchar(100)not null
);

create table accounts(
account_id int primary key auto_increment,
account_name varchar(100) not null,
account_type varchar(50)not null,
opening_balance decimal(10,2)default 0
);

create table transactions(
transaction_id int primary key auto_increment,
account_id int not null,
category_id int not null,
transaction_type varchar(20)not null,
transaction_date date not null,
amount decimal(10,2)not null,
description varchar(200),

foreign key(account_id)
references accounts(account_id),

foreign key(category_id)
references categories(category_id)
);

create table budget(
budget_id int primary key auto_increment,
category_id int not null,
budget_month varchar(20)not null,
budget_amount decimal(10,2)not null,

foreign key(category_id)
references categories(category_id)
);

use finance_management;

insert into categories(category_name)values
('food'),
('travel'),
('rent'),
('shopping'),
('entertainment');

insert into accounts(account_name,account_type,opening_balance)values
('sbi account','bank','10000.00'),
('hdfc account','bank','15000.00'),
('cash','cash','5000.00');

insert into transactions(account_id,category_id,transaction_type,transaction_date,amount,description)values
(1,1,'Expense','2026-08-01',500.00,'grocery shopping'),
(2,2,'Expense','2026-08-03',300.00,'bus travel'),
(1,3,'Expense','2026-08-05',5000.00,'rent'),
(3,4,'Expense','2026-08-08',1200.00,'dress purchase'),
(2,5,'Expense','2026-08-10',800,'movie'),
(1,1,'income','2026-08-15',25000.00,'salary received');

-- TRIGGERS
DELIMITER //

CREATE TRIGGER after_transaction_insert
AFTER INSERT ON transactions
FOR EACH ROW
BEGIN
    SELECT 'New transaction inserted successfully' AS message;
END//

DELIMITER ;

show columns from transactions;
show create table transactions;
select*from transactions;

insert into budget(category_id,budget_month,budget_amount)values
(1,'august 2026',5000.00),
(2,'august 2026',3000.00),
(3,'august 2026',6000.00),
(4,'august2026',4000.00),
(5,'august 2026',25000);

select* from categories
select* from accounts;
select* from transactions;
select* from budget;
select*from transactions where transaction_type='expense';

select* from transactions where transaction_type='expense' and amount>1000;
select* from transactions where category_id=1 or category_id=2;
select* from transactions where amount between 500 and 5000;

select
t.transaction_id,
a.account_name,
c.category_name,
t.transaction_type,
t.transaction_date,
t.amount,
t.description from transactions t
join accounts a on t.account_id=a.account_id
join categories c on t.category_id=c.category_id;

select sum(amount)as total_income from transactions where transaction_type='income';
select sum(amount)as total_expense from transactions where transaction_type='expense';

select(select sum(amount) from transactions where transaction_type='income');
select(select sum(amount) from transactions where transaction_type='expense') as net_balance;

use finance_management;

select c.category_name,sum(t.amount) as total_expense from transactions t 
join categories c on t.category_id=c.category_id where t.transaction_type='expense'group by c.category_name;

select a.account_name,sum(t.amount)as total_expense from transactions t
join accounts a on t.account_id=a.account_id where t.transaction_type='expense'group by a.account_name;

COUNT
 Used to find the total number of transactions.

select count(*)as total_transactions from transactions;

 AVG
Used to find the average transaction amount.

select avg(amount) as average_transactions from transactions;

MAX Used to find the highest transaction amount.

select max(amount) as highest_transaction from transactions;

MIN Used to find the lowest transaction amount.

select min(amount)as lowest_transaction from transactions;

GROUP BY Used to group transactions based on transaction type.

select transaction_type,count(*)from transactions group by transaction_type;

select c.category_name,sum(t.amount) as total_expense from transactions t
join categories c on t.category_id=c.category_id where t.transaction_type='expense' 
group by c.category_name order by total_expense desc;

select c.category_name,sum(t.amount) as total_expense from transactions t 
join categories c on t.category_id='expense'
group by c.category_name having sum(t.amount)>500;

select transaction_type,sum(amount) as total_amount from transactions
group by transaction_type 
order by total_amount desc;

update transactions set amount=600 where transaction_id=1;

select*from transactions;

delete from transactions where transaction_id=1;

select*from transactions;

create view transaction_summary as select
t.transaction_id,
a.account_name,
c.category_name,
t.transaction_type,
t.amount,
t.description from transactions t join accounts a on t.account_id=a.account_id
join categories c on t.category_id=c.category_id=c.category_id;

select*from transaction_summary;

select transaction_type, sum(amount) as total_amount from transactions group by transaction_type;
























