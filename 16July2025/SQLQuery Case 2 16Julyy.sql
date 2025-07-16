-- Create database
create database MitsubishiTraining1;
use MitsubishiTraining1;

-- Employee table
create table Employee (
    EmployeeID int primary key identity(1,1),
    FullName varchar(50) not null,
    Department varchar(50),
    Email varchar(50) unique
);

-- Instructor table (linked to Employee)
create table Instructor (
    InstructorID int primary key identity(1,1),
    EmployeeID int not null,
    foreign key (EmployeeID) references Employee(EmployeeID)
);

-- TrainingCourse table
create table TrainingCourse (
    CourseID int primary key identity(1,1),
    Title varchar(50) not null,
    Description text,
    DurationHours int not null
);

-- TrainingSession table
create table TrainingSession (
    SessionID int primary key identity(1,1),
    CourseID int not null,
    InstructorID int not null,
    SessionDate date not null,
    foreign key (CourseID) references TrainingCourse(CourseID),
    foreign key (InstructorID) references Instructor(InstructorID)
);

-- ParticipationRecord junction table
create table ParticipationRecord (
    ParticipationID int primary key identity(1,1),
    EmployeeID int not null,
    SessionID int not null,
    DateAttended date not null,
    Passed bit,
    foreign key (EmployeeID) references Employee(EmployeeID),
    foreign key (SessionID) references TrainingSession(SessionID)
);
