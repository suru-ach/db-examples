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
    foreign key(mgr_ssn) references employee(ssn) on delete set null on update cascade;

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
