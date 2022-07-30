
/*******************************************************************************
   Description: Creates graduate student dimensional model database.
   DB Server: SqlServer
   
********************************************************************************/

/*******************************************************************************
   Drop database if it exists
********************************************************************************/
IF EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'graduatestudent')
BEGIN
	ALTER DATABASE [graduatestudent] SET OFFLINE WITH ROLLBACK IMMEDIATE;
	ALTER DATABASE [graduatestudent] SET ONLINE;
	DROP DATABASE [graduatestudent];
END

GO

/*******************************************************************************
   Create database
********************************************************************************/
CREATE DATABASE [graduatestudent];
GO

USE [graduatestudent];
GO

/*******************************************************************************
   Create Tables
********************************************************************************/
--dim_geography
CREATE TABLE dim_geography(
    GeoSK               int         NOT NULL,
    City                char(10)    NOT NULL,
    State               char(10)    NOT NULL,
    Country             char(10)    NOT NULL,
    SOR_ID              int         NOT NULL,
    SOR_LoadDate        date        NOT NULL,
    SOR_UpdateDate      date        NULL,
    DI_Job_ID           int         NOT NULL,
    DI_Create_Date      date        NOT NULL,
    DI_Modified_Date    date        NULL,
    CONSTRAINT PK22 PRIMARY KEY NONCLUSTERED (GeoSK)
);

--dim_date
CREATE TABLE dim_date(
    DateSK               int         NOT NULL,
    FullDateAK           date        NOT NULL,
    DayNumberOfWeek      int         NOT NULL,
    DayNameOfWeek        char(10)    NOT NULL,
    DayNumberOfMonth     int         NOT NULL,
    DayNumberOfYear      int         NOT NULL,
    WeekNumberOfYear     int         NOT NULL,
    MonthName            char(10)    NOT NULL,
    MonthNumberOfYear    int         NOT NULL,
    CalendarQuater       int         NOT NULL,
    CalendarYear         int         NOT NULL,
    SOR_ID               int         NOT NULL,
    SOR__LoadDate        date        NOT NULL,
    SOR_UpdateDate       date        NULL,
    DI_Job_ID            int         NOT NULL,
    DI_Create_Date       date        NOT NULL,
    DI_Modified_Date     date        NULL,
    CONSTRAINT PK26 PRIMARY KEY NONCLUSTERED (DateSK)
);
GO

--dim_student
CREATE TABLE dim_students(
    StudentSk              int            NOT NULL,
    StudentDK              int            NOT NULL,
    StudentID              int            NOT NULL,
    [Student Name]         varchar(20)    NOT NULL,
    [Email ID]             varchar(10)    NOT NULL,
    [Housing Type]         char(10)       NULL,
    Flag                   int      NULL,
    SOR_ID                 int            NOT NULL,
    SOR_LoadDate           date           NOT NULL,
    SOR_UpdateDate         date           NULL,
    DI_Job_ID              int            NOT NULL,
    DI_Create_Date         date           NOT NULL,
    DI_Modified_Date       date           NULL,
    StudentBirthDateSK     int            NULL,
    StudentGeographicSK    int            NOT NULL,
    SBeginDateSK           int            NOT NULL,
    SEndDateSK             int            NULL,
    CONSTRAINT PK4 PRIMARY KEY NONCLUSTERED (StudentSk), 
    CONSTRAINT Refdim_date34 FOREIGN KEY (StudentBirthDateSK)
    REFERENCES dim_date(DateSK),
    CONSTRAINT Refdim_geography39 FOREIGN KEY (StudentGeographicSK)
    REFERENCES dim_geography(GeoSK),
    CONSTRAINT Refdim_date40 FOREIGN KEY (SEndDateSK)
    REFERENCES dim_date(DateSK),
    CONSTRAINT Refdim_date43 FOREIGN KEY (SBeginDateSK)
    REFERENCES dim_date(DateSK)
);
GO

--dim_company
CREATE TABLE dim_company(
    CompanyRegNoSK             int            NOT NULL,
    [Company Registration No]  int            NOT NULL,
    [Company Name]             varchar(20)    NULL,
    [Industry Type]            varchar(10)    NULL,
    SOR_ID                     int            NOT NULL,
    SOR_LoadDate               date           NOT NULL,
    SOR_UpdateDate             date           NULL,
    DI_Job_ID                  int            NOT NULL,
    DI_Create_Date             date           NOT NULL,
    DI_Modified_Date           date           NULL,
    CONSTRAINT PK12 PRIMARY KEY NONCLUSTERED (CompanyRegNoSK)
);
GO

--dim_college
CREATE TABLE dim_college(
    CollegeIDSK         int            NOT NULL,
    CollegeName         varchar(20)    NOT NULL,
    SOR_ID              int            NOT NULL,
    SOR_LoadDate        date           NOT NULL,
    SOR_UpdateDate      date           NULL,
    DI_Job_ID           int            NOT NULL,
    DI_Create_Date      date           NOT NULL,
    DI_Modified_Date    date           NULL,
    CONSTRAINT PK6_1_1 PRIMARY KEY NONCLUSTERED (CollegeIDSK)
);
GO

--dim_department
CREATE TABLE dim_department(
    DepartmentIDSK      int            NOT NULL,
    CollegeIDSK         int            NOT NULL,
    DepartmentName      varchar(20)    NOT NULL,
    SOR_ID              int            NOT NULL,
    SOR_LoadDate        date           NOT NULL,
    SOR_UpdateDate      date           NULL,
    DI_Job_ID           int            NOT NULL,
    DI_Create_Date      date           NOT NULL,
    DI_Modified_Date    date           NULL,
    CONSTRAINT PK6_1 PRIMARY KEY NONCLUSTERED (DepartmentIDSK, CollegeIDSK), 
    CONSTRAINT Refdim_college7 FOREIGN KEY (CollegeIDSK)
    REFERENCES dim_college(CollegeIDSK)
);
GO

--dim_program
CREATE TABLE dim_program(
    ProgramIDSK         int            NOT NULL,
    DepartmentIDSK      int            NOT NULL,
    CollegeIDSK         int            NOT NULL,
    ProgramName         varchar(20)    NOT NULL,
    SOR_ID              int            NOT NULL,
    SOR_LoadDate        date           NOT NULL,
    SOR_UpdateDate      date           NULL,
    DI_Job_ID           int            NOT NULL,
    DI_Create_Date      date           NOT NULL,
    DI_Modified_Date    date           NULL,
    CONSTRAINT PK6 PRIMARY KEY NONCLUSTERED (ProgramIDSK, DepartmentIDSK, CollegeIDSK), 
    CONSTRAINT Refdim_department6 FOREIGN KEY (DepartmentIDSK, CollegeIDSK)
    REFERENCES dim_department(DepartmentIDSK, CollegeIDSK)
);
GO

--dim_course
CREATE TABLE dim_courses(
    CourseNoSK          int            NOT NULL,
    ProgramIDSK         int            NOT NULL,
    DepartmentIDSK      int            NOT NULL,
    CollegeIDSK         int            NOT NULL,
    CourseNo            int            NOT NULL,
    [Course Name]       varchar(20)    NOT NULL,
    [Pre-requisites]    varchar(10)    NULL,
    CourseType          char(10)       NOT NULL,
    Credits             int            NOT NULL,
    [Course Info]       varchar(45)    NULL,
    SOR_ID              int            NOT NULL,
    SOR_LoadDate        date           NOT NULL,
    SOR_ModifiedDate    date           NULL,
    DI_Job_ID           int            NOT NULL,
    DI_Create_Date      date           NOT NULL,
    DI_Modified_Date    date           NULL,
    CONSTRAINT PK2 PRIMARY KEY NONCLUSTERED (CourseNoSK, ProgramIDSK, DepartmentIDSK, CollegeIDSK), 
    CONSTRAINT Refdim_program26 FOREIGN KEY (ProgramIDSK, DepartmentIDSK, CollegeIDSK)
    REFERENCES dim_program(ProgramIDSK, DepartmentIDSK, CollegeIDSK)
);
GO

--dim_semester
CREATE TABLE dim_semester(
    SemesterSK          int            NOT NULL,
    [Semester Name]     varchar(20)    NOT NULL,
    SOR_ID              int            NOT NULL,
    SOR_LoadDate        date           NOT NULL,
    SOR_UpdateDate      date           NULL,
    DI_Job_ID           int            NOT NULL,
    DI_Create_Date      date           NOT NULL,
    DI_Modified_Date    date           NULL,
    EnrollmentDateSK    int            NOT NULL,
    DropDateSK          int            NOT NULL,
    CONSTRAINT PK3 PRIMARY KEY NONCLUSTERED (SemesterSK), 
    CONSTRAINT Refdim_date35 FOREIGN KEY (EnrollmentDateSK)
    REFERENCES dim_date(DateSK),
    CONSTRAINT Refdim_date37 FOREIGN KEY (DropDateSK)
    REFERENCES dim_date(DateSK)
);
GO

--dim_teachers
CREATE TABLE dim_teachers(
    TeacherSK              int            NOT NULL,
    TeacherDK              int            NOT NULL,
    TeacherID              int            NOT NULL,
    [Teacher Name]         varchar(20)    NOT NULL,
    [Email ID]             varchar(10)    NOT NULL,
    BeginDate              date           NOT NULL,
    Flag                   int      NOT NULL,
    SOR_ID                 int            NOT NULL,
    SOR_Load_Date          date           NOT NULL,
    SOR_UpdateDate         char(10)       NULL,
    DI_Job_ID              int            NOT NULL,
    DI_Create_Date         date           NOT NULL,
    DI_Modified_Date       date           NULL,
    TeacherBirthDateSK     int            NULL,
    TeacherGeographicSK    int            NOT NULL,
    TEndDateSK             int            NULL,
    TBeginDateSK           int            NOT NULL,
    CONSTRAINT PK4_1 PRIMARY KEY NONCLUSTERED (TeacherSK), 
    CONSTRAINT Refdim_date32 FOREIGN KEY (TeacherBirthDateSK)
    REFERENCES dim_date(DateSK),
    CONSTRAINT Refdim_geography38 FOREIGN KEY (TeacherGeographicSK)
    REFERENCES dim_geography(GeoSK),
    CONSTRAINT Refdim_date41 FOREIGN KEY (TEndDateSK)
    REFERENCES dim_date(DateSK),
    CONSTRAINT Refdim_date42 FOREIGN KEY (TBeginDateSK)
    REFERENCES dim_date(DateSK)
);
GO

--fact_course_registration
CREATE TABLE fact_course_registration(
    ClassRegistrationNoSK    int               NOT NULL,
    ProgramIDSK              int               NOT NULL,
    DepartmentIDSK           int               NOT NULL,
    CollegeIDSK              int               NOT NULL,
    SemesterSK               int               NOT NULL,
    CourseNoSK               int               NOT NULL,
    Section                  char(10)          NULL,
    GPA                      decimal(10, 0)    NOT NULL,
    SOR_ID                   int               NOT NULL,
    SOR_LoadDate             date              NOT NULL,
    SOR_UpdateDate           date              NULL,
    DI_Job_ID                int               NOT NULL,
    DI_Create_Date           date              NOT NULL,
    DI_Modified_Date         date              NULL,
    TeacherSK                int               NOT NULL,
    StudentSk                int               NOT NULL,
    CONSTRAINT PK1 PRIMARY KEY NONCLUSTERED (ClassRegistrationNoSK, ProgramIDSK, DepartmentIDSK, CollegeIDSK, SemesterSK, CourseNoSK), 
    CONSTRAINT Refdim_courses2 FOREIGN KEY (CourseNoSK, ProgramIDSK, DepartmentIDSK, CollegeIDSK)
    REFERENCES dim_courses(CourseNoSK, ProgramIDSK, DepartmentIDSK, CollegeIDSK),
    CONSTRAINT Refdim_semester23 FOREIGN KEY (SemesterSK)
    REFERENCES dim_semester(SemesterSK),
    CONSTRAINT Refdim_students29 FOREIGN KEY (StudentSk)
    REFERENCES dim_students(StudentSk),
    CONSTRAINT Refdim_teachers30 FOREIGN KEY (TeacherSK)
    REFERENCES dim_teachers(TeacherSK)
);
GO

--fact_coop
CREATE TABLE fact_coop(
    CompanyRegNoSK      int     NOT NULL,
    StudentSk           int     NOT NULL,
    [Start Date]        date    NOT NULL,
    [End Date]          date    NOT NULL,
    SOR_ID              int     NOT NULL,
    SOR_LoadDate        date    NOT NULL,
    SOR_UpdateDate      date    NULL,
    DI_Job_ID           int     NOT NULL,
    DI_Create_Date      date    NOT NULL,
    DI_Modified_Date    date    NULL,
    CONSTRAINT PK11 PRIMARY KEY NONCLUSTERED (CompanyRegNoSK, StudentSk), 
    CONSTRAINT Refdim_students20 FOREIGN KEY (StudentSk)
    REFERENCES dim_students(StudentSk),
    CONSTRAINT Refdim_company21 FOREIGN KEY (CompanyRegNoSK)
    REFERENCES dim_company(CompanyRegNoSK)
);
GO


-----------------------Table Alteration After adding the data through Alteryx------------------------

CREATE DATABASE [graduatestudent];
GO
USE
[graduatestudent];
GO

---Alter Table
ALTER TABLE dim_geography
ALTER COLUMN GeoSK int NOT NULL;
ALTER TABLE [dbo].[dim_date]
ALTER COLUMN DateSK int Not NULL;
ALTER TABLE dim_students   
ALTER COLUMN StudentSk int Not NULL;
ALTER TABLE dim_students   
ALTER COLUMN StudentBirthDateSK int Not NULL;
ALTER TABLE dim_students   
ALTER COLUMN StudentGeographicSK int Not NULL;
ALTER TABLE dim_students   
ALTER COLUMN SEndDateSK int NULL;
ALTER TABLE dim_students   
ALTER COLUMN SBeginDateSK int NULL;
ALTER TABLE dim_company
ALTER COLUMN CompanyRegNoSK int NOT NULL;
ALTER TABLE dim_college
ALTER COLUMN CollegeIDSK int NOT NULL;
ALTER TABLE dim_department
ALTER COLUMN DepartmentIDSK int NOT NULL;
ALTER TABLE dim_department   
ALTER COLUMN CollegeIDSK int NOT NULL;
ALTER TABLE dim_program
ALTER COLUMN ProgramIDSK int NOT NULL;
ALTER TABLE dim_program
ALTER COLUMN DepartmentIDSK int NOT NULL;
ALTER TABLE dim_program
ALTER COLUMN CollegeIDSK int NOT NULL;
ALTER TABLE dim_courses
ALTER COLUMN CourseNoSK int NOT NULL;
ALTER TABLE dim_courses
ALTER COLUMN ProgramIDSK int NOT NULL;
ALTER TABLE dim_courses
ALTER COLUMN DepartmentIDSK int NOT NULL;
ALTER TABLE dim_courses
ALTER COLUMN CollegeIDSK int NOT NULL;
ALTER TABLE dim_semester
ALTER COLUMN SemesterSK int NOT NULL;
ALTER TABLE dim_semester
ALTER COLUMN EnrollmentDateSK int NOT NULL;
ALTER TABLE dim_semester
ALTER COLUMN DropDateSK int NULL;
ALTER TABLE dim_teachers
ALTER COLUMN TeacherSK int NOT NULL;
ALTER TABLE dim_teachers
ALTER COLUMN TeacherBirthDateSK int NULL;
ALTER TABLE dim_teachers
ALTER COLUMN TeacherGeographicSK int NOT NULL;
ALTER TABLE dim_teachers
ALTER COLUMN TEndDateSK int NULL;
ALTER TABLE dim_teachers
ALTER COLUMN TBeginDateSK int NOT NULL;
ALTER TABLE fact_course_registration
ALTER COLUMN CourseRegistrationNoSK int NOT NULL;
ALTER TABLE fact_course_registration
ALTER COLUMN ProgramIDSK int NOT NULL;
ALTER TABLE fact_course_registration
ALTER COLUMN DepartmentIDSK int NOT NULL;
ALTER TABLE fact_course_registration
ALTER COLUMN CollegeIDSK int NOT NULL;
ALTER TABLE fact_course_registration
ALTER COLUMN SemesterSK int NOT NULL;
ALTER TABLE fact_course_registration
ALTER COLUMN CourseNoSK int NOT NULL;
ALTER TABLE fact_course_registration
ALTER COLUMN StudentSk int NOT NULL;
ALTER TABLE fact_course_registration
ALTER COLUMN TeacherSK int NOT NULL;
ALTER TABLE fact_coop
ALTER COLUMN CompanyRegNoSK int NOT NULL;
ALTER TABLE fact_coop
ALTER COLUMN StudentSk int NOT NULL;

-----Add constraints
ALTER TABLE dim_geography
ADD CONSTRAINT PK22 PRIMARY KEY NONCLUSTERED (GeoSK);
ALTER TABLE dim_date
ADD CONSTRAINT PK26  PRIMARY KEY NONCLUSTERED (DateSK);
ALTER TABLE dim_students
ADD CONSTRAINT PK4  PRIMARY KEY NONCLUSTERED (StudentSk);
ALTER TABLE dim_students
ADD CONSTRAINT Refdim_date34 FOREIGN KEY (StudentBirthDateSK)
REFERENCES dim_date(DateSK);
ALTER TABLE dim_students
ADD CONSTRAINT Refdim_geography39  FOREIGN KEY (StudentGeographicSK)
REFERENCES dim_geography(GeoSK);
ALTER TABLE dim_students
ADD CONSTRAINT Refdim_date40 FOREIGN KEY (SEndDateSK)
REFERENCES dim_date(DateSK);
ALTER TABLE dim_students
ADD CONSTRAINT Refdim_date43 FOREIGN KEY (SBeginDateSK)
REFERENCES dim_date(DateSK);
ALTER TABLE dim_company
ADD CONSTRAINT PK12 PRIMARY KEY NONCLUSTERED (CompanyRegNoSK);
ALTER TABLE dim_college
ADD CONSTRAINT PK6_1_1 PRIMARY KEY NONCLUSTERED (CollegeIDSK);
ALTER TABLE dim_department
ADD CONSTRAINT PK6_1  PRIMARY KEY NONCLUSTERED (DepartmentIDSK,CollegeIDSK);
ALTER TABLE dim_department
ADD CONSTRAINT Refdim_college7 FOREIGN KEY (CollegeIDSK)
REFERENCES dim_college(CollegeIDSK);
ALTER TABLE dim_program
ADD CONSTRAINT PK6 PRIMARY KEY NONCLUSTERED (ProgramIDSK, DepartmentIDSK, CollegeIDSK);
ALTER TABLE dim_program
ADD CONSTRAINT Refdim_department6 FOREIGN KEY (DepartmentIDSK, CollegeIDSK)
REFERENCES dim_department(DepartmentIDSK, CollegeIDSK);
ALTER TABLE dim_courses
ADD CONSTRAINT PK2 PRIMARY KEY NONCLUSTERED (CourseNoSK, ProgramIDSK, DepartmentIDSK, CollegeIDSK);
ALTER TABLE dim_courses
ADD CONSTRAINT Refdim_program26 FOREIGN KEY (ProgramIDSK, DepartmentIDSK, CollegeIDSK)
REFERENCES dim_program(ProgramIDSK, DepartmentIDSK, CollegeIDSK);
ALTER TABLE dim_semester
ADD CONSTRAINT PK3 PRIMARY KEY NONCLUSTERED (SemesterSK);
ALTER TABLE dim_semester
ADD CONSTRAINT Refdim_date35 FOREIGN KEY (EnrollmentDateSK)
REFERENCES dim_date(DateSK);
ALTER TABLE dim_semester
ADD CONSTRAINT Refdim_date37 FOREIGN KEY (DropDateSK)
REFERENCES dim_date(DateSK);
ALTER TABLE dim_teachers
ADD CONSTRAINT PK4_1 PRIMARY KEY NONCLUSTERED (TeacherSK);
ALTER TABLE dim_teachers
ADD CONSTRAINT Refdim_date32 FOREIGN KEY (TeacherBirthDateSK)
REFERENCES dim_date(DateSK);
ALTER TABLE dim_teachers
ADD CONSTRAINT Refdim_geography38 FOREIGN KEY (TeacherGeographicSK)
REFERENCES dim_geography(GeoSK);
ALTER TABLE dim_teachers
ADD CONSTRAINT Refdim_date41 FOREIGN KEY (TEndDateSK)
REFERENCES dim_date(DateSK);
ALTER TABLE dim_teachers
ADD CONSTRAINT Refdim_date42 FOREIGN KEY (TBeginDateSK)
REFERENCES dim_date(DateSK);
ALTER TABLE fact_course_registration
ADD CONSTRAINT PK1 PRIMARY KEY NONCLUSTERED 
(CourseRegistrationNoSK, ProgramIDSK, DepartmentIDSK, CollegeIDSK, SemesterSK, CourseNoSK);
ALTER TABLE fact_course_registration
ADD CONSTRAINT Refdim_courses2 FOREIGN KEY (CourseNoSK, ProgramIDSK, DepartmentIDSK, CollegeIDSK)
REFERENCES dim_courses(CourseNoSK, ProgramIDSK, DepartmentIDSK, CollegeIDSK);
ALTER TABLE fact_course_registration
ADD CONSTRAINT Refdim_semester23 FOREIGN KEY (SemesterSK)
REFERENCES dim_semester(SemesterSK);
ALTER TABLE fact_course_registration
ADD CONSTRAINT Refdim_students29 FOREIGN KEY (StudentSk)
REFERENCES dim_students(StudentSk);
ALTER TABLE fact_course_registration
ADD CONSTRAINT Refdim_teachers30 FOREIGN KEY (TeacherSK)
REFERENCES dim_teachers(TeacherSK);
ALTER TABLE fact_coop
ADD CONSTRAINT PK11 PRIMARY KEY NONCLUSTERED (CompanyRegNoSK, StudentSk);
ALTER TABLE fact_coop
ADD CONSTRAINT Refdim_students20 FOREIGN KEY (StudentSk)
REFERENCES dim_students(StudentSk);
ALTER TABLE fact_coop
ADD CONSTRAINT Refdim_company21 FOREIGN KEY (CompanyRegNoSK)
REFERENCES dim_company(CompanyRegNoSK);

