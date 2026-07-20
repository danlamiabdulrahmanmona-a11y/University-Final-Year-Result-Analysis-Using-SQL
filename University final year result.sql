-- create database University_Final_Year_Result

create database University_Final_Year_Result;

use University_Final_Year_Result;

create table University_Final_Year(
Student_ID	varchar(50),
Matric_Number	varchar(50),
First_Name	varchar(50),
Last_Name	varchar(50),
Gender	varchar(50),
Department	varchar(50),
Programme	varchar(50),
Level	int,
Course_Code	varchar(50),
Credit_Units	int,
Total_Score	int,
CGPA int,
carry_Overs	int,
Degree_Class varchar(50),
Graduation_Status	varchar(50),
Course_Title	varchar(50),
GPA int);

alter table university_final_year
modify column cgpa float;

SET global LOCAL_INFILE = ON;
LOAD DATA LOCAL INFILE 'C:/Users/NHS/Documents/mona/SQL/University_Final_Year.csv'
INTO TABLE University_Final_Year 
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

select * from university_final_year;


-- Total Student

select 
count(*) as Total_students
from university_final_year;

-- total number of graduated students

select count(*) as Graduated_students
from university_final_year
where Graduation_Status = "graduated";

-- total number of spilled students
select count(*) as Graduated_students
from university_final_year
where Graduation_Status = "spilled";

-- average student CGPA of all student

select avg(CGPA) as Average_CGPA
from university_final_year;

-- all students in Computer department
select *
from university_final_year
where Department = "computer science";

-- -- First class student

select * 
from university_final_year
where CGPA >  4.50;

-- students with carry overs

select * 
from university_final_year
where carry_Overs > 0;

-- students that Graduated

select * 
from university_final_year
where Graduation_Status = "graduated";

-- students who spilled

select * 
from university_final_year
where Graduation_Status = "spilled";

-- all female students
select * 
from university_final_year
where Gender = "female";

-- top 20 best student
select * 
from university_final_year
order by CGPA desc
limit 20;

-- highest Cgpa

select max(CGPA) as highest_CGPA
from university_final_year;

select min(CGPA) as highest_CGPA
from university_final_year;

-- number of student in each graduation status

select Graduation_Status,
count(*) as Total_students
from university_final_year
group by Graduation_Status;

-- number of student in each department

select Department,
count(*) as Total_students
from university_final_year
group by Department;

-- number of students with carry over for each department

select department,
count(*) as Students_with_carryovers
from university_final_year
where carry_Overs > 0
group by Department;

-- departmennt with the highest graduate
select Department,
count(*) as total_graduates
from university_final_year
where Graduation_Status = "graduated"
group by Department
order by total_graduates
limit 1;

-- graduation rate by department

select Department,
count(case when Graduation_Status = "graduated" then 1 end) as Graduatd,
count(*) as Total_Student,
round(
count(case when 
graduation_status = "graduated" then 1 end) * 100.0 / count(*), 2
) as graduation_rate
from university_final_year
group by department;

-- departments with highest spill rate

select Department,
count(case when Graduation_Status = "spilled" then 1 end) as Spilled_Student,
round(
count(case when 
graduation_status = "spilled" then 1 else 0 end) * 100.0 / count(*), 2
) as spill_rate_percentage
from university_final_year
group by department
order by spill_rate_percentage desc;

-- student with the most risk of spilling

select Student_ID,
First_Name,
Last_Name,
Department,
CGPA,
carry_Overs
from university_final_year
where CGPA < 2.50
and carry_Overs >= 2
order by carry_Overs desc, CGPA asc;


-- courses contributing to carry-overs

select Department,
count(*) as Total_Students,
sum(case when carry_Overs > 0
then 1 else 0 end) as student_with_carry_overs,
(sum(case when carry_Overs = 0
then 1 else 0 end)) as Student_without_carry_over,
round(
sum(case when carry_Overs > 0 then 1 else 0 end) * 100.0 / count(*), 2
) as carryover_rate
from university_final_year
group by Department
order by carryover_rate desc;

