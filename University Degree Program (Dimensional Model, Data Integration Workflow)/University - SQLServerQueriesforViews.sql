----What are the core requirements and elective courses for these programs
CREATE VIEW dim_programwise_course_types AS
SELECT di.ProgramName, dim."Course Name", dim.CourseType
FROM dim_program di, dim_courses dim
WHERE dim.ProgramIDSK = di.ProgramIDSK AND 
dim.DepartmentIDSK = di.DepartmentIDSK AND 
dim.CollegeIDSK = di.CollegeIDSK
;

------What classes (course & section) did students complete in a semester & what were their grades ADD COURSE No
------What were the classes taught each semester
CREATE VIEW [dim_semester_wise _courses_and_grades] AS
SELECT fa.SemesterSK, dim.StudentID, dim.[Student Name], di.CourseNo, fa.Section, di.[Course Name], di.Credits, fa.GPA
FROM fact_course_registration fa, dim_courses di, dim_students dim
WHERE fa.ProgramIDSK = di.ProgramIDSK AND fa.DepartmentIDSK = di.DepartmentIDSK AND fa.CollegeIDSK = di.CollegeIDSK AND fa.CourseNoSK = di.CourseNoSK AND fa.StudentSk = dim.StudentSk
;

----What were the enrollment and drop dates if applicable for students in each class in a semester
----Who were the teachers in each class above
CREATE VIEW dim_course_info AS
SELECT dim_."Semester Name", dim.CourseNo, dim."Course Name", fa."Teacher Name", 
dim_e.FullDateAK EnrollmentDate, dim_d.FullDateAK DropDate
FROM dim_teachers fa, dim_semester dim_, fact_course_registration fac, dim_courses dim, 
dim_date dim_e, dim_date dim_d
WHERE fac.SemesterSK = dim_.SemesterSK AND fac.TeacherSK = fa.TeacherSK AND 
fac.ProgramIDSK = dim.ProgramIDSK AND fac.DepartmentIDSK = dim.DepartmentIDSK AND 
fac.CollegeIDSK = dim.CollegeIDSK AND fac.CourseNoSK = dim.CourseNoSK AND 
dim_.EnrollmentDateSK = dim_e.DateSK AND dim_.DropDateSK = dim_d.DateSK
;

-----What teachers taught classes in a degree program in a semester
CREATE VIEW dim_teacher_info AS
SELECT dim_."Semester Name", dim.ProgramName, di.TeacherID,di."Teacher Name",di."Email ID"
FROM dim_teachers di, fact_course_registration fa, dim_program dim, dim_semester dim_
WHERE fa.TeacherSK = di.TeacherSK
 AND fa.SemesterSK = dim_.SemesterSK;
 ----Who are the students enrolled in a degree program and attributes such as ID, email, 
 ---date of birth (DOB), hometown, 
 --campus/off-campus address if applicable, etc.
CREATE VIEW dim_programwise_student_info AS
SELECT dim_c.ProgramIDSK, dim.ProgramName, di."Student Name", di."Email ID", 
di."Housing Type", dim_.FullDateAK, dim_g.City, dim_g.State, dim_g.Country
FROM dim_students di, fact_course_registration fa, dim_program dim, 
dim_date dim_, dim_geography dim_g, dim_courses dim_c
WHERE fa.StudentSK = di.StudentSK
AND di.StudentBirthDateSK = dim_.DateSK AND di.StudentGeographicSK = dim_g.GeoSK
AND dim_c.ProgramIDSK = dim.ProgramIDSK AND dim_c.DepartmentIDSK = dim.DepartmentIDSK 
AND dim_c.CollegeIDSK = dim.CollegeIDSK AND fa.ProgramIDSK = dim_c.ProgramIDSK AND
fa.DepartmentIDSK = dim_c.DepartmentIDSK AND fa.CollegeIDSK = dim_c.CollegeIDSK AND
fa.CourseNoSK = dim_c.CourseNoSK AND di.Flag=1
;




