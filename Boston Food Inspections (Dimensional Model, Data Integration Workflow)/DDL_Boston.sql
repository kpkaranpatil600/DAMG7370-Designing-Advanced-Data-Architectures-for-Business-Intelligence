--
-- ER/Studio Data Architect SQL Code Generation
-- Project :      Boston_Final.DM1
--
-- Date Created : Friday, April 08, 2022 14:55:57
-- Target DBMS : MySQL 8.x
--

-- 
-- TABLE: DimBusiness  
--

CREATE TABLE DimBusiness(
    Business_id     int   NOT NULL,
    sor_key        int   NOT NULL,
    BusinessName    CHAR(10),
    DBAName         CHAR(10),
    Descript        CHAR(10),
    legalowner      CHAR(10),
    namelast        CHAR(10),
    namefirst       CHAR(10),
    PRIMARY KEY (Business_id)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimDate_Time 
--

CREATE TABLE DimDate_Time(
    Date_Time_id    int   NOT NULL,
    sor_key         int   NOT NULL,
    issdttm         CHAR(10),
    expdttm         CHAR(10),
    resultdttm      CHAR(10),
    violdttm        CHAR(10),
    statusdate      CHAR(10),
    PRIMARY KEY (Date_Time_id)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimGeo 
--

CREATE TABLE DimGeo(
    Geo_id       int   NOT NULL,
    sor_key     int   NOT NULL,
    Address      CHAR(10),
    City         CHAR(10),
    State        CHAR(10),
    Zip          CHAR(10),
    Latitude     CHAR(10),
    Longitude    CHAR(10),
    PRIMARY KEY (Geo_id)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimLicense 
--

CREATE TABLE DimLicense(
    License_id    int   NOT NULL,
    sor_key       int   NOT NULL,
    Licensecat    CHAR(10),
    Licenseno     CHAR(10),
    PRIMARY KEY (License_id)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimProperty 
--

CREATE TABLE DimProperty(
    Property_idvvewf    int   NOT NULL,
    sor_key           int   NOT NULL,
    LicenseAddDtTm      CHAR(10),
    Property_id         CHAR(10),
    dayphn              CHAR(10),
    PRIMARY KEY (Property_idvvewf)
)ENGINE=MYISAM
;



-- 
-- TABLE: DimViolation 
--

CREATE TABLE DimViolation(
    Violation_id   int   NOT NULL,
    sor_key         int   NOT NULL,
    violdesc        CHAR(10),
    violation       CHAR(10),
    comments        CHAR(10),
    PRIMARY KEY (Violation_id)
)ENGINE=MYISAM
;



-- 
-- TABLE: FactBoston 
--

CREATE TABLE FactBoston(
    Fact_id             int   NOT NULL,
    Geo_id              int   NOT NULL,
    Violation_id        int   NOT NULL,
    Business_id         int   NOT NULL,
    Date_Time_id       int   NOT NULL,
    Property_key    int   NOT NULL,
    License_id         int   NOT NULL,
    viollevel           CHAR(10),
    violstatus          CHAR(10),
    result              CHAR(10),
    licstatus           CHAR(10),
    PRIMARY KEY (Fact_id, Geo_id, Violation_id, Business_id, Date_Time_id, Property_idvvewf, License_id)
)ENGINE=MYISAM
;



-- 
-- TABLE: FactBoston 
--

ALTER TABLE FactBoston ADD CONSTRAINT RefDimDate_Time1 
    FOREIGN KEY (Date_Time_id)
    REFERENCES DimDate_Time(Date_Time_id)
;

ALTER TABLE FactBoston ADD CONSTRAINT RefDimGeo2 
    FOREIGN KEY (Geo_id)
    REFERENCES DimGeo(Geo_id)
;

ALTER TABLE FactBoston ADD CONSTRAINT RefDimBusiness3 
    FOREIGN KEY (Business_id)
    REFERENCES DimBusiness(Business_id)
;

ALTER TABLE FactBoston ADD CONSTRAINT RefDimViolation4 
    FOREIGN KEY (Violation_id)
    REFERENCES DimViolation(Violation_id)
;

ALTER TABLE FactBoston ADD CONSTRAINT RefDimProperty5 
    FOREIGN KEY (Property_idvvewf)
    REFERENCES DimProperty(Property_idvvewf)
;

ALTER TABLE FactBoston ADD CONSTRAINT RefDimLicense6 
    FOREIGN KEY (License_id)
    REFERENCES DimLicense(License_id)
;


