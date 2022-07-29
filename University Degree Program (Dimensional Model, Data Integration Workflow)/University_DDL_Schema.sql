--
-- ER/Studio Data Architect SQL Code Generation
-- Project :      University.DM1
--
-- Date Created : Friday, April 08, 2022 14:52:38
-- Target DBMS : MySQL 8.x
--

-- 
-- TABLE: dim_College 
--

CREATE TABLE dim_College(
    College_id     INT            NOT NULL,
    sor_key        INT            NOT NULL,
    CollegeName    VARCHAR(50)    NOT NULL,
    PRIMARY KEY (College_id)
)ENGINE=MYISAM
;



-- 
-- TABLE: dim_Company 
--

CREATE TABLE dim_Company(
    CompanyRegNo_id    INT            NOT NULL,
    sor_key           INT            NOT NULL,
    CompanyRegNo      INT            NOT NULL,
    CompanyName       VARCHAR(50),
    IndustryType      VARCHAR(50),
    PRIMARY KEY (CompanyRegNoSK)
)ENGINE=MYISAM
;



-- 
-- TABLE: dim_Course 
--

CREATE TABLE dim_Course(
    Course_id      INT            NOT NULL,
    Program_id       INT            NOT NULL,
    Department_id    INT            NOT NULL,
    College_id       INT            NOT NULL,
    sor_key          INT            NOT NULL,
    CourseNo         INT            NOT NULL,
    CourseName       VARCHAR(50)    NOT NULL,
    `Pre-req`        VARCHAR(50),
    CourseType       VARCHAR(50)    NOT NULL,
    Credits          INT            NOT NULL,
    CourseInfo       VARCHAR(45),
    PRIMARY KEY (CourseNoSK, Program_id, Department_id, College_id)
)ENGINE=MYISAM
;



-- 
-- TABLE: dim_Date 
--

CREATE TABLE dim_Date(
    Date_id             INT         NOT NULL,
    sor_key             CHAR(10),
    DayOfWeek           INT         NOT NULL,
    WeekNumberOfYear    INT         NOT NULL,
    DayOfMonth          INT         NOT NULL,
    MonthOfYear         INT         NOT NULL,
    Year                INT         NOT NULL,
    PRIMARY KEY (Date_id)
)ENGINE=MYISAM
;



-- 
-- TABLE: dim_Department 
--

CREATE TABLE dim_Department(
    Department_id     INT            NOT NULL,
    College_id        INT            NOT NULL,
    sor_key           INT            NOT NULL,
    DepartmentName    VARCHAR(50)    NOT NULL,
    PRIMARY KEY (Department_id, College_id)
)ENGINE=MYISAM
;



-- 
-- TABLE: dim_Geography 
--

CREATE TABLE dim_Geography(
    Geo_id     INT            NOT NULL,
    sor_key    CHAR(10),
    City       VARCHAR(50)    NOT NULL,
    State      VARCHAR(50)    NOT NULL,
    Country    VARCHAR(50)    NOT NULL,
    PRIMARY KEY (Geo_id)
)ENGINE=MYISAM
;



-- 
-- TABLE: dim_Professor 
--

CREATE TABLE dim_Professor(
    Professor_id    INT            NOT NULL,
    sor_key         INT            NOT NULL,
    ProfName        CHAR(10),
    ProfEmail_ID    VARCHAR(50)    NOT NULL,
    Geo_id          INT            NOT NULL,
    Date_id         INT            NOT NULL,
    PRIMARY KEY (Professor_id)
)ENGINE=MYISAM
;



-- 
-- TABLE: dim_Program 
--

CREATE TABLE dim_Program(
    Program_id       INT            NOT NULL,
    Department_id    INT            NOT NULL,
    College_id       INT            NOT NULL,
    sor_key          INT            NOT NULL,
    ProgramName      VARCHAR(50)    NOT NULL,
    PRIMARY KEY (Program_id, Department_id, College_id)
)ENGINE=MYISAM
;



-- 
-- TABLE: dim_Semester 
--

CREATE TABLE dim_Semester(
    Semester_id     INT            NOT NULL,
    sor_key         INT            NOT NULL,
    SemesterName    VARCHAR(50)    NOT NULL,
    Date_id         INT            NOT NULL,
    PRIMARY KEY (Semester_id)
)ENGINE=MYISAM
;



-- 
-- TABLE: dim_Students 
--

CREATE TABLE dim_Students(
    Student_id         INT            NOT NULL,
    sor_key            INT            NOT NULL,
    StudentName        VARCHAR(50)    NOT NULL,
    StudentEmail_ID    VARCHAR(30)    NOT NULL,
    HousingType        VARCHAR(40),
    Geo_id             INT            NOT NULL,
    Date_id            INT            NOT NULL,
    PRIMARY KEY (Student_id)
)ENGINE=MYISAM
;



-- 
-- TABLE: fact_Coop 
--

CREATE TABLE fact_Coop(
    CompanyRegNo_id    INT     NOT NULL,
    StartDate         DATE    NOT NULL,
    EndDate           DATE    NOT NULL,
    Student_id        INT     NOT NULL,
    Date_id           INT     NOT NULL,
    PRIMARY KEY (CompanyRegNo_id)
)ENGINE=MYISAM
;



-- 
-- TABLE: `fact_Coop fact_CourseRegistration` 
--

CREATE TABLE `fact_Coop fact_CourseRegistration`(
    CompanyRegNo_id          INT    NOT NULL,
    CourseRegistration_id    INT    NOT NULL,
    Program_id               INT    NOT NULL,
    Department_id            INT    NOT NULL,
    College_id               INT    NOT NULL,
    Semester_id              INT    NOT NULL,
    Course_id               INT    NOT NULL,
    PRIMARY KEY (CompanyRegNo_id, CourseRegistration_id, Program_id, Department_id, College_id, Semester_id, Course_id)
)ENGINE=MYISAM
;



-- 
-- TABLE: fact_CourseRegistration 
--

CREATE TABLE fact_CourseRegistration(
    CourseRegistration_id    INT            NOT NULL,
    Program_id               INT            NOT NULL,
    Department_id            INT            NOT NULL,
    College_id               INT            NOT NULL,
    Semester_id              INT            NOT NULL,
    Course_id               INT            NOT NULL,
    Section                  VARCHAR(50),
    GPA                      INT            NOT NULL,
    Professor_id             INT            NOT NULL,
    PRIMARY KEY (CourseRegistration_id, Program_id, Department_id, College_id, Semester_id, Course_id)
)ENGINE=MYISAM
;



-- 
-- TABLE: dim_Course 
--

ALTER TABLE dim_Course ADD CONSTRAINT Refdim_Program26 
    FOREIGN KEY (Program_id, Department_id, College_id)
    REFERENCES dim_Program(Program_id, Department_id, College_id)
;


-- 
-- TABLE: dim_Department 
--

ALTER TABLE dim_Department ADD CONSTRAINT Refdim_College7 
    FOREIGN KEY (College_id)
    REFERENCES dim_College(College_id)
;


-- 
-- TABLE: dim_Professor 
--

ALTER TABLE dim_Professor ADD CONSTRAINT Refdim_Geography58 
    FOREIGN KEY (Geo_id)
    REFERENCES dim_Geography(Geo_id)
;

ALTER TABLE dim_Professor ADD CONSTRAINT Refdim_Date60 
    FOREIGN KEY (Date_id)
    REFERENCES dim_Date(Date_id)
;


-- 
-- TABLE: dim_Program 
--

ALTER TABLE dim_Program ADD CONSTRAINT Refdim_Department6 
    FOREIGN KEY (Department_id, College_id)
    REFERENCES dim_Department(Department_id, College_id)
;


-- 
-- TABLE: dim_Semester 
--

ALTER TABLE dim_Semester ADD CONSTRAINT Refdim_Date59 
    FOREIGN KEY (Date_id)
    REFERENCES dim_Date(Date_id)
;


-- 
-- TABLE: dim_Students 
--

ALTER TABLE dim_Students ADD CONSTRAINT Refdim_Geography52 
    FOREIGN KEY (Geo_id)
    REFERENCES dim_Geography(Geo_id)
;

ALTER TABLE dim_Students ADD CONSTRAINT Refdim_Date53 
    FOREIGN KEY (Date_id)
    REFERENCES dim_Date(Date_id)
;


-- 
-- TABLE: fact_Coop 
--

ALTER TABLE fact_Coop ADD CONSTRAINT Refdim_Company21 
    FOREIGN KEY (CompanyRegNo_id)
    REFERENCES dim_Company(CompanyRegNo_id)
;

ALTER TABLE fact_Coop ADD CONSTRAINT Refdim_Students54 
    FOREIGN KEY (Student_id)
    REFERENCES dim_Students(Student_id)
;

ALTER TABLE fact_Coop ADD CONSTRAINT Refdim_Date61 
    FOREIGN KEY (Date_id)
    REFERENCES dim_Date(Date_id)
;


-- 
-- TABLE: `fact_Coop fact_CourseRegistration` 
--

ALTER TABLE `fact_Coop fact_CourseRegistration` ADD CONSTRAINT Reffact_Coop62 
    FOREIGN KEY (CompanyRegNo_id)
    REFERENCES fact_Coop(CompanyRegNo_id)
;

ALTER TABLE `fact_Coop fact_CourseRegistration` ADD CONSTRAINT Reffact_CourseRegistration63 
    FOREIGN KEY (CourseRegistration_id, Program_id, Department_id, College_id, Semester_id, Course_id)
    REFERENCES fact_CourseRegistration(CourseRegistration_id, Program_id, Department_id, College_id, Semester_id, Course_id)
;


-- 
-- TABLE: fact_CourseRegistration 
--

ALTER TABLE fact_CourseRegistration ADD CONSTRAINT Refdim_Course2 
    FOREIGN KEY (Course_id, Program_id, Department_id, College_id)
    REFERENCES dim_Course(Course_id, Program_id, Department_id, College_id)
;

ALTER TABLE fact_CourseRegistration ADD CONSTRAINT Refdim_Semester23 
    FOREIGN KEY (Semester_id)
    REFERENCES dim_Semester(Semester_id)
;

ALTER TABLE fact_CourseRegistration ADD CONSTRAINT Refdim_Professor30 
    FOREIGN KEY (Professor_id)
    REFERENCES dim_Professor(Professor_id)
;


