--
-- ER/Studio Data Architect SQL Code Generation
-- Project :      Dallas.DM1
--
-- Date Created : Friday, April 08, 2022 14:56:51
-- Target DBMS : MySQL 8.x
--

-- 
-- TABLE: DimInspection 
--

CREATE TABLE DimInspection(
    Inspection_id       int NOT NULL,
    sor_key           int NOT NULL,
    `Inspection Type`   CHAR(10),
    `Inspection Date`   date,
    `Inspection Month`  CHAR(10),
    `Inspection Year`   CHAR(10),
    PRIMARY KEY (Inspection_id)
)
;

-- 
-- TABLE: DimLocation 
--

CREATE TABLE DimLocation(
    Location_id          int NOT NULL,
    sor_key             int NOT NULL,
    `Street Number`      int,
    `Street Name`        CHAR(10),
    `Street Direction`   CHAR(10),
    `Street Type`        CHAR(10),
    `Street Unit`        CHAR(10),
    `Street Address`     CHAR(10),
    `Zip Code`           int,
    `Lat Long Location`  CHAR(10),
    PRIMARY KEY (Location_id)
)
;



-- 
-- TABLE: DimRestaurent 
--

CREATE TABLE DimRestaurent(
    Restaurent_id      int NOT NULL,
    sor_key            int NOT NULL,
    `Restaurant Name`  CHAR(10),
    PRIMARY KEY (Restaurent_id)
)
;



-- 
-- TABLE: DimViolation_Description 
--

CREATE TABLE DimViolation_Description(
    ViolationDescription_id       int NOT NULL,
    sor_key                      int NOT NULL,
    `Violation Description - 1`   CHAR(10),
    `Violation Description - 2`   CHAR(10),
    `Violation Description - 3`   CHAR(10),
    `Violation Description - 4`   CHAR(10),
    `Violation Description - 5`   CHAR(10),
    `Violation Description - 6`   CHAR(10),
    `Violation Description - 7`   CHAR(10),
    `Violation Description - 8`   CHAR(10),
    `Violation Description - 9`   CHAR(10),
    `Violation Description - 10`  CHAR(10),
    `Violation Description - 11`  CHAR(10),
    `Violation Description - 12`  CHAR(10),
    `Violation Description - 13`  CHAR(10),
    `Violation Description - 14`  CHAR(10),
    `Violation Description - 15`  CHAR(10),
    `Violation Description - 16`  CHAR(10),
    `Violation Description - 17`  CHAR(10),
    `Violation Description - 18`  CHAR(10),
    `Violation Description - 19`  CHAR(10),
    `Violation Description - 20`  CHAR(10),
    `Violation Description - 21`  CHAR(10),
    `Violation Description - 22`  CHAR(10),
    `Violation Description - 23`  CHAR(10),
    `Violation Description - 24`  CHAR(10),
    `Violation Description - 25`  CHAR(10),
    PRIMARY KEY (ViolationDescription_id)
)
;



-- 
-- TABLE: DimViolation_Detail 
--

CREATE TABLE DimViolation_Detail(
     ViolationDetail_id             int NOT NULL,
    sor_key                  int NOT NULL,
    `Violation Detail - 1`   CHAR(10),
    `Violation Detail - 2`   CHAR(10),
    `Violation Detail - 3`   CHAR(10),
    `Violation Detail - 4`   CHAR(10),
    `Violation Detail - 5`   CHAR(10),
    `Violation Detail - 6`   CHAR(10),
    `Violation Detail - 7`   CHAR(10),
    `Violation Detail - 8`   CHAR(10),
    `Violation Detail - 9`   CHAR(10),
    `Violation Detail - 10`  CHAR(10),
    `Violation Detail - 11`  CHAR(10),
    `Violation Detail - 12`  CHAR(10),
    `Violation Detail - 13`  CHAR(10),
    `Violation Detail - 14`  CHAR(10),
    `Violation Detail - 15`  CHAR(10),
    `Violation Detail - 16`  CHAR(10),
    `Violation Detail - 17`  CHAR(10),
    `Violation Detail - 18`  CHAR(10),
    `Violation Detail - 19`  CHAR(10),
    `Violation Detail - 20`  CHAR(10),
    `Violation Detail - 21`  CHAR(10),
    `Violation Detail - 22`  CHAR(10),
    `Violation Detail - 23`  CHAR(10),
    `Violation Detail - 24`  CHAR(10),
    `Violation Detail - 25`  CHAR(10),
    PRIMARY KEY ( ViolationDetail_id)
)
;



-- 
-- TABLE: DimViolation_Memo 
--

CREATE TABLE DimViolation_Memo(
    ViolationMemo_id       int NOT NULL,
    sor_key               int NOT NULL,
    `Violation Memo - 1`   CHAR(10),
    `Violation Memo - 2`   CHAR(10),
    `Violation Memo - 3`   CHAR(10),
    `Violation Memo - 4`   CHAR(10),
    `Violation Memo - 5`   CHAR(10),
    `Violation Memo - 6`   CHAR(10),
    `Violation Memo - 7`   CHAR(10),
    `Violation Memo - 8`   CHAR(10),
    `Violation Memo - 9`   CHAR(10),
    `Violation Memo - 10`  CHAR(10),
    `Violation Memo - 11`  CHAR(10),
    `Violation Memo - 12`  CHAR(10),
    `Violation Memo - 13`  CHAR(10),
    `Violation Memo - 14`  CHAR(10),
    `Violation Memo - 15`  CHAR(10),
    `Violation Memo - 16`  CHAR(10),
    `Violation Memo - 17`  CHAR(10),
    `Violation Memo - 18`  CHAR(10),
    `Violation Memo - 19`  CHAR(10),
    `Violation Memo - 20`  CHAR(10),
    `Violation Memo - 21`  CHAR(10),
    `Violation Memo - 22`  CHAR(10),
    `Violation Memo - 23`  CHAR(10),
    `Violation Memo - 24`  CHAR(10),
    `Violation Memo - 25`  CHAR(10),
    PRIMARY KEY (ViolationMemo_id)
)
;



-- 
-- TABLE: FactDallas_Inspection 
--

CREATE TABLE FactDallas_Inspection(
    FactInspection_id          int NOT NULL,
    Location_id                int NOT NULL,
    ViolationDescription_id    int NOT NULL,
    Inspection_id              int NOT NULL,
    Restaurent_id              int NOT NULL,
    ViolationDetail_id         int NOT NULL,
    ViolationMemo_id           int NOT NULL,
    `Inspection Score`         int,
    PRIMARY KEY (FactInspection_id, Location_id, ViolationDescription_id, Inspection_id, Restaurent_id,  ViolationDetail_id , ViolationMemo_id)
)ENGINE=MYISAM
;



-- 
-- TABLE: `FactDallas_Inspection FactDallas_Violation` 
--

CREATE TABLE `FactDallas_Inspection FactDallas_Violation`(
    FactInspection_id          int NOT NULL,
    Location_id                int NOT NULL,
    ViolationDescription_id    int NOT NULL,
    Inspection_id              int NOT NULL,
    Restaurent_id              int NOT NULL,
    ViolationDetail_id                int NOT NULL,
    ViolationMemo_id           int NOT NULL,
    FactViolation_id           int NOT NULL,
    PRIMARY KEY (FactInspection_id, Location_id, ViolationDescription_id, Inspection_id, Restaurent_id,  ViolationDetail_id , ViolationMemo_id, FactViolation_id)
)ENGINE=MYISAM
;



-- 
-- TABLE: FactDallas_Violation 
--

CREATE TABLE FactDallas_Violation(
    FactViolation_id           int NOT NULL,
    Restaurent_id              int NOT NULL,
    Location_id                int NOT NULL,
    Inspection_id              int NOT NULL,
    ViolationDescription_id    int NOT NULL,
     ViolationDetail_id               int NOT NULL,
    ViolationMemo_id           int NOT NULL,
    `Violation Points - 1`     CHAR(10),
    `Violation Points - 2`     CHAR(10),
    `Violation Points - 3`     CHAR(10),
    `Violation Points - 4`     CHAR(10),
    `Violation Points - 5`     CHAR(10),
    `Violation Points - 6`     CHAR(10),
    `Violation Points - 7`     CHAR(10),
    `Violation Points - 8`     CHAR(10),
    `Violation Points - 9`     CHAR(10),
    `Violation Points - 10`    CHAR(10),
    `Violation Points - 11`    CHAR(10),
    `Violation Points - 12`    CHAR(10),
    `Violation Points - 13`    CHAR(10),
    `Violation Points - 14`    CHAR(10),
    `Violation Points - 15`    CHAR(10),
    `Violation Points - 16`    CHAR(10),
    `Violation Points - 17`    CHAR(10),
    `Violation Points - 18`    CHAR(10),
    `Violation Points - 19`    CHAR(10),
    `Violation Points - 20`    CHAR(10),
    `Violation Points - 21`    CHAR(10),
    `Violation Points - 22`    CHAR(10),
    `Violation Points - 23`    CHAR(10),
    `Violation Points - 24`    CHAR(10),
    `Violation Points - 25`    CHAR(10),
    PRIMARY KEY (FactViolation_id, Restaurent_id, Location_id, Inspection_id, ViolationDescription_id, ViolationDetail_id , ViolationMemo_id)
)
;



-- 
-- TABLE: FactDallas_Inspection 
--

ALTER TABLE FactDallas_Inspection ADD CONSTRAINT RefDimLocation1 
    FOREIGN KEY (Location_id)
    REFERENCES DimLocation(Location_id)
;

ALTER TABLE FactDallas_Inspection ADD CONSTRAINT RefDimViolation_Description2 
    FOREIGN KEY (ViolationDescription_id)
    REFERENCES DimViolation_Description(ViolationDescription_id)
;

ALTER TABLE FactDallas_Inspection ADD CONSTRAINT RefDimInspection3 
    FOREIGN KEY (Inspection_id)
    REFERENCES DimInspection(Inspection_id)
;

ALTER TABLE FactDallas_Inspection ADD CONSTRAINT RefDimRestaurent5 
    FOREIGN KEY (Restaurent_id)
    REFERENCES DimRestaurent(Restaurent_id)
;

ALTER TABLE FactDallas_Inspection ADD CONSTRAINT RefDimViolation_Detail16 
    FOREIGN KEY (ViolationDetail_id )
    REFERENCES DimViolation_Detail(ViolationDetail_id )
;

ALTER TABLE FactDallas_Inspection ADD CONSTRAINT RefDimViolation_Memo17 
    FOREIGN KEY (ViolationMemo_id)
    REFERENCES DimViolation_Memo(ViolationMemo_id)
;


-- 
-- TABLE: `FactDallas_Inspection FactDallas_Violation` 
--

ALTER TABLE `FactDallas_Inspection FactDallas_Violation` ADD CONSTRAINT RefFactDallas_Inspection20 
    FOREIGN KEY (FactInspection_id, Location_id, ViolationDescription_id, Inspection_id, Restaurent_id, ViolationDetail_id , ViolationMemo_id)
    REFERENCES FactDallas_Inspection(FactInspection_id, Location_id, ViolationDescription_id, Inspection_id, Restaurent_id, ViolationDetail_id , ViolationMemo_id)
;

ALTER TABLE `FactDallas_Inspection FactDallas_Violation` ADD CONSTRAINT RefFactDallas_Violation21 
    FOREIGN KEY (FactViolation_id, Restaurent_id, Location_id, Inspection_id, ViolationDescription_id, ViolationDetail_id , ViolationMemo_id)
    REFERENCES FactDallas_Violation(FactViolation_id, Restaurent_id, Location_id, Inspection_id, ViolationDescription_id, ViolationDetail_id , ViolationMemo_id)
;


-- 
-- TABLE: FactDallas_Violation 
--

ALTER TABLE FactDallas_Violation ADD CONSTRAINT RefDimViolation_Detail18 
    FOREIGN KEY (ViolationDetail_id )
    REFERENCES DimViolation_Detail(ViolationDetail_id )
;

ALTER TABLE FactDallas_Violation ADD CONSTRAINT RefDimViolation_Memo19 
    FOREIGN KEY (ViolationMemo_id)
    REFERENCES DimViolation_Memo(ViolationMemo_id)
;

ALTER TABLE FactDallas_Violation ADD CONSTRAINT RefDimRestaurent6 
    FOREIGN KEY (Restaurent_id)
    REFERENCES DimRestaurent(Restaurent_id)
;

ALTER TABLE FactDallas_Violation ADD CONSTRAINT RefDimLocation7 
    FOREIGN KEY (Location_id)
    REFERENCES DimLocation(Location_id)
;

ALTER TABLE FactDallas_Violation ADD CONSTRAINT RefDimInspection8 
    FOREIGN KEY (Inspection_id)
    REFERENCES DimInspection(Inspection_id)
;

ALTER TABLE FactDallas_Violation ADD CONSTRAINT RefDimViolation_Description9 
    FOREIGN KEY (ViolationDescription_id)
    REFERENCES DimViolation_Description(ViolationDescription_id)
;


