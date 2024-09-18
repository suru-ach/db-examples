create table employee (
    fname varchar(15) not null,
    minit char,
    lname varchar(15) not null,
    ssn char(9) not null,
    bdate date,
    address varchar(30),
    sex char,
    salary decimal(10,2),
    super_ssn char(9),
    dno int not null,
    primary key(ssn)
);

create table department (
    dname varchar(15) not null,
    dnumber int not null,
    mgr_ssn char(9) not null,
    mgr_start_date date,
    primary key (dnumber),
    unique(dname)
    --foreign key(mgr_ssn) references employee(ssn)
);

create table dept_locations (
    dnumber int not null,
    dlocation varchar(15) not null,
    primary key(dnumber, dlocation)
    --foreign key (dnumber) references department(dnumber)
);

create table project (
    pname varchar(15) not null,
    pnumber int not null,
    plocation varchar(15),
    dnum int not null,
    primary key(pnumber),
    unique(pname)
    --foreign key(dnum) references department(dnumber)
);

create table works_on (
    essn char(9) not null,
    pno int not null,
    hours varchar(15) not null,
    primary key(essn, pno)
    --foreign key(essn) references employee(ssn),
    --foreign key(pno) references project(pnumber)
);

create table dependent (
    essn char(9) not null,
    dependent_name varchar(15) not null,
    sex char,
    bdate date,
    relationship varchar(8),
    primary key (essn, dependent_name)
    --foreign key (essn) references employee(ssn)
);

--alter table department add constraint dep_fk_ssn
--    foreign key(mgr_ssn) references employee(ssn) on delete cascade on update cascade;

alter table employee add constraint emp_fk_superssn
    foreign key(super_ssn) references employee(ssn) on delete set null on update cascade;

alter table department add constraint dep_fk_ssn
    foreign key(mgr_ssn) references employee(ssn) on delete cascade on update cascade;

alter table dept_locations add constraint deptloc_fk_dnum
    foreign key (dnumber) references department(dnumber) on delete cascade on update cascade;

alter table project add constraint proj_fk_dnum
    foreign key(dnum) references department(dnumber) on delete cascade on update cascade;

alter table dependent add constraint depd_fk_essn
    foreign key(essn) references employee(ssn) on delete cascade on update cascade;


alter table works_on add constraint  works_on_fk_ssn
    foreign key(essn) references employee(ssn) on delete cascade on update cascade;
    
alter table works_on add constraint  works_on_fk_pnum
    foreign key(pno) references project(pnumber) on delete cascade on update cascade;


-- Insertion 

INSERT INTO employee
VALUES      ('John','B','Smith',123456789,'1965-01-09','731 Fondren, Houston TX','M',30000,333445555,5),
            ('Franklin','T','Wong',333445555,'1965-12-08','638 Voss, Houston TX','M',40000,888665555,5),
            ('Alicia','J','Zelaya',999887777,'1968-01-19','3321 Castle, Spring TX','F',25000,987654321,4),
            ('Jennifer','S','Wallace',987654321,'1941-06-20','291 Berry, Bellaire TX','F',43000,888665555,4),
            ('Ramesh','K','Narayan',666884444,'1962-09-15','975 Fire Oak, Humble TX','M',38000,333445555,5),
            ('Joyce','A','English',453453453,'1972-07-31','5631 Rice, Houston TX','F',25000,333445555,5),
            ('Ahmad','V','Jabbar',987987987,'1969-03-29','980 Dallas, Houston TX','M',25000,987654321,4),
            ('James','E','Borg',888665555,'1937-11-10','450 Stone, Houston TX','M',55000,null,1);

INSERT INTO department
VALUES      ('Research',5,333445555,'1988-05-22'),
            ('Administration',4,987654321,'1995-01-01'),
            ('Headquarters',1,888665555,'1981-06-19');

INSERT INTO project
VALUES      ('ProductX',1,'Bellaire',5),
            ('ProductY',2,'Sugarland',5),
            ('ProductZ',3,'Houston',5),
            ('Computerization',10,'Stafford',4),
            ('Reorganization',20,'Houston',1),
            ('Newbenefits',30,'Stafford',4);

INSERT INTO works_on
VALUES     (123456789,1,32.5),
           (123456789,2,7.5),
           (666884444,3,40.0),
           (453453453,1,20.0),
           (453453453,2,20.0),
           (333445555,2,10.0),
           (333445555,3,10.0),
           (333445555,10,10.0),
           (333445555,20,10.0),
           (999887777,30,30.0),
           (999887777,10,10.0),
           (987987987,10,35.0),
           (987987987,30,5.0),
           (987654321,30,20.0),
           (987654321,20,15.0),
           (888665555,20,16.0);

INSERT INTO dependent
VALUES      (333445555,'Alice','F','1986-04-04','Daughter'),
            (333445555,'Theodore','M','1983-10-25','Son'),
            (333445555,'Joy','F','1958-05-03','Spouse'),
            (987654321,'Abner','M','1942-02-28','Spouse'),
            (123456789,'Michael','M','1988-01-04','Son'),
            (123456789,'Alice','F','1988-12-30','Daughter'),
            (123456789,'Elizabeth','F','1967-05-05','Spouse');

INSERT INTO dept_locations
VALUES      (1,'Houston'),
            (4,'Stafford'),
            (5,'Bellaire'),
            (5,'Sugarland'),
            (5,'Houston');
            
-- selection 

-- Retrieve the names of all employees who do not have supervisors
select fname,lname from employee where super_ssn is null;

-- the first nested query selects the project numbers of projects that have an
-- employee with last name ‘Smith’ involved as manager, whereas the second nested query
-- selects the project numbers of projects that have an employee with last name ‘Smith’
-- involved as worker. In the outer query, we use the OR logical connective to retrieve a
-- PROJECT tuple if the PNUMBER value of that tuple is in the result of either nested query

select pname
    from project
    where pnumber in 
        (select pnumber 
            from project, employee, department 
            where ssn = mgr_ssn and dnum = dnumber and lname = 'Smith'
        )
        or
        pnumber in
        (select pno
            from works_on, employee
            where essn = ssn and lname = 'Smith'
        );


select pnumber from project, employee, department where ssn = mgr_ssn and dnum = dnumber;
select fname, pnumber from project, employee, department where dno = dnumber and dnum = dnumber and lname = 'Smith';

select fname, lname 
from employee
where salary > all (
    select salary
    from employee, department
    where dno = dnumber and department = 'Research'
);

-- Retrieve the name of each employee who has a dependent with the
-- same first name and is the same sex as the employee

INSERT INTO dependent
VALUES      (123456789,'John','M','1986-04-04','Person');

select e.fname, e.lname
from employee as e
where e.ssn in (
    select d.ssn
    from dependent as d
    where d.dependent_name = e.fname and e.sex = d.sex
);

select e.fname, e.lname
from employee as e
where exists (
    select*
    from dependent as d
    where d.essn = e.ssn and d.dependent_name = e.fname and d.sex = e.sex
);

-- no dependents
select e.fname
from employee
where not exists (
    select *
    from dependent
    where ssn = essn
);

-- List the names of managers who have at least one dependent

select e.fname
from employee as e
where exists (
        select *
        from dependent
        where ssn = essn
    )
    and
    exists (
        select *
        from department
        where ssn = mgr_ssn
    )
;

-- Retrieve the name of each employee who works on 
-- all the projects controlled by department number 5

-- does not work 
select fname, lname from employee where ssn in all (
    select distinct(essn)
    from works_on
    where exists
    (
        select *
        from project
        where dnum = 5 and pno = pnumber
    )
);

-- set differnece
-- except
-- (S2 - S1)
-- (project5_dnum - employees_dnum) = ()

insert into works_on values (123456789, 3, 10.25);

select fname, lname 
from employee 
where not exists (
    (
        select pnumber
        from project
        where dnum = 5
    ) except (
        select pno
        from works_on
        where ssn = essn
    )
);

-- alternate approach
-- :( hard

select fname, lname
from employee
where not exists (
    select *
    from works_on as a
)

-- joins

select fname
from employee 
join department on dno = dnumber
where dname = 'Research';

select fname
from (employeee natural join (department as dept(dname, dno, mssn, mdate)))
where dname = 'research';

select e.fname as employee_name, s.fname as supervisor_name
from (employee as e left outer join employee as s on e.super_ssn = s.ssn);

select sum(salary) as sum, max(salary) as maxsal, min(salary) as minsal, avg(salary) as avgsal from employee;

-- Find the sum of the salaries of all employees of the ‘Research’ depart-
-- ment, as well as the maximum salary, the minimum salary, and the average
-- salary in this department.

select sum(salary)
from employee join department on dno = dnumber
where dname = 'Research';

select count(*)
from employee join department on dno = dnumber
where dname = 'Management';

-- group by and having

-- For each department, retrieve the department number, the number
-- of employees in the department, and their average salary

select dname, count(*) as numbe_of_employees, avg(salary)
from employee join department on dno = dnumber
group by dname;

-- For each project, retrieve the project number, the project name, and
-- the number of employees who work on that project

select pnumber, pname, count(*)
from project join works_on on pno = pnumber
group by pnumber;

-- For each project on which more than two employees work, retrieve the
-- project number, the project name, and the number of employees who work on
-- the project

select pnumber, pname, count(*)
from project join works_on on pno = pnumber
group by pnumber, pname
having count(*) > 2;

-- For each project, retrieve the project number, the project name, and
-- the number of employees from department 5 who work on the project.

select pname, pnumber, count(*)
from project
join
works_on on pno = pnumber
join
employee on essn = ssn
group by pname, pnumber;

-- VIEWS --

create or replace view employee_details
as (
    select employee.*, dname, pname
    from employee
    join
    works_on on essn = ssn
    join
    project on pno = pnumber
    join
    department on dno = dnumber
);


create materialized view if not exists employee_details_mat
as
 (SELECT employee.fname,
    employee.lname,
    employee.ssn,
    employee.bdate,
    employee.address,
    employee.sex,
    employee.salary,
    employee.super_ssn,
    department.dname,
    project.pname
   FROM employee
     JOIN works_on ON works_on.essn = employee.ssn
     JOIN project ON works_on.pno = project.pnumber
     JOIN department ON employee.dno = department.dnumber;
) with no data;

refresh materialized view employee_details_mat;

