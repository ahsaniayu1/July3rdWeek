-- create the database
create database MitsubishiTraining;
use MitsubishiTraining;

-- create tables
create table Employee (
    EmployeeID int primary key identity(1,1),
    FullName varchar(50) not null,
    Department varchar(30)
);

create table TrainingCourse (
    CourseID int primary key identity(1,1),
    Title varchar(50) not null,
    Description text,
    DurationHours int not null
);

create table TrainingSession (
    SessionID int primary key identity(1,1),
    CourseID int not null,
    InstructorID int not null, -- instructor is an employee
    SessionDate date not null,
    foreign key (CourseID) references TrainingCourse(CourseID),
    foreign key (InstructorID) references Employee(EmployeeID)
);

create table ParticipationRecord (
    RecordID int primary key identity(1,1),
    SessionID int not null,
    EmployeeID int not null,
    AttendedDate date not null,
    Passed bit not null,
    foreign key (SessionID) references TrainingSession(SessionID),
    foreign key (EmployeeID) references Employee(EmployeeID)
);
