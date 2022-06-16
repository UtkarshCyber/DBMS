create database banking;
show databases;
use banking;

create table branch(
branch_name varchar(20) primary key,
branch_city char(10),
assets real
);

create table accounts(
account_no int(10)primary key,
branch_name varchar(20),
balance real,
foreign key (branch_name) references branch (branch_name)
);

create table depositor(
custm_name varchar(15)primary key,
custm_street varchar(20),
custm_city char(10)
);

create table loan(
loan_no int(5)primary key,
branch_name varchar(20),
amount real,
foreign key (branch_name) references branch(branch_name)
);

create table borrower(
custm_name varchar(15),
loan_no int(5),
primary key(custm_name,loan_no),
foreign key (custm_name) references depositor(custm_name),
foreign key (loan_no) references loan(loan_no)
);


insert into branch values('SBI_Chamrajpet','Bangalore',50000);
insert into branch values('SBI_ResidencyRoad','Bangalore',10000);
insert into branch values('SBI_ShivajiRoad','Bombay',20000);
insert into branch values('SBI_ParliamentRoad','Delhi',10000);
insert into branch values('SBI_Jantarmantar','Delhi',20000);

insert into accounts values(101,'SBI_Chamrajpet',1000);
insert into accounts values(102,'SBI_ResidencyRoad',2000);
insert into accounts values(103,'SBI_ShivajiRoad',3000);
insert into accounts values(104,'SBI_ParliamentRoad',4000);
insert into accounts values(105,'SBI_Jantarmantar',5000);

insert into depositor values('Avinash','Chamrajpet','Bangalore');
insert into depositor values('Dinesh','JP_Nagar','Bangalore');
insert into depositor values('Nikhil','Bandra','Bombay');
insert into depositor values('Ravi','Noida','Delhi');
insert into depositor values('Rishab','Jantar','Delhi');

 
 

