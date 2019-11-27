select * from Demographics
select * from xrui.demographics

#1a
alter table xrui.Demographics
ADD Age int NULL

UPDATE xrui.Demographics SET Age=Tri_Age

select tri_age, Age from xrui.demographics

#1b
alter table xrui.Demographics
ADD Gender NVARCHAR(255) NULL

UPDATE xrui.Demographics SET Gender=gendercode

select gendercode, Gender from xrui.demographics

#1c
alter table xrui.Demographics
ADD ID NVARCHAR(255) NULL

UPDATE xrui.Demographics SET ID=contactid

select contactid, ID from xrui.demographics

#1d
alter table xrui.Demographics
ADD State NVARCHAR(255) NULL

UPDATE xrui.Demographics SET State=address1_stateorprovince

select address1_stateorprovince, State from xrui.demographics

#1e
alter table xrui.Demographics
ADD EmailSentdate NVARCHAR(255) NULL

UPDATE xrui.Demographics SET EmailSentdate=tri_imaginecareenrollmentemailsentdate

select tri_imaginecareenrollmentemailsentdate, EmailSentdate from xrui.demographics

#1f
alter table xrui.Demographics
ADD Completedate NVARCHAR(255) NULL

UPDATE xrui.Demographics SET Completedate=tri_enrollmentcompletedate

select tri_enrollmentcompletedate, Completedate from xrui.demographics

#1g
alter table xrui.Demographics
ADD Duration int NULL 

UPDATE xrui.Demographics
SET Duration=DATEDIFF(DAY,  try_convert(date, EmailSentdate, 101), try_convert(date, Completedate, 101))

select EmailSentdate, Completedate, Duration from xrui.demographics

#2a /*this syntax will alter an existing column's data type*/
alter table xrui.Demographics
alter COLUMN Enrollment_Status NVARCHAR(255) NULL

UPDATE xrui.demographics
SET Enrollment_Status='Complete' WHERE tri_imaginecareenrollmentstatus='167410011'

#checking
select * from xrui.demographics where Enrollment_Status='Complete'
select tri_imaginecareenrollmentstatus, Enrollment_Status from xrui.demographics

#2b
UPDATE xrui.demographics
SET Enrollment_Status='Email sent' WHERE tri_imaginecareenrollmentstatus='167410001'

#checking
select * from xrui.demographics where Enrollment_Status='Email sent'
select tri_imaginecareenrollmentstatus, Enrollment_Status from xrui.demographics

#2c
UPDATE xrui.demographics
SET Enrollment_Status='Non responder' WHERE tri_imaginecareenrollmentstatus='167410004'

#checking
select * from xrui.demographics where Enrollment_Status='Non responder'
select tri_imaginecareenrollmentstatus, Enrollment_Status from xrui.demographics

#2d
UPDATE xrui.demographics
SET Enrollment_Status='Facilitated Enrollment' WHERE tri_imaginecareenrollmentstatus='167410005'

#checking
select * from xrui.demographics where Enrollment_Status='Facilitated Enrollment'
select tri_imaginecareenrollmentstatus, Enrollment_Status from xrui.demographics

#2e
UPDATE xrui.demographics
SET Enrollment_Status='Incomplete Enrollments' WHERE tri_imaginecareenrollmentstatus='167410002'

#checking
select * from xrui.demographics where Enrollment_Status='Incomplete Enrollments'
select tri_imaginecareenrollmentstatus, Enrollment_Status from xrui.demographics

#2f
UPDATE xrui.demographics
SET Enrollment_Status='Opted Out' WHERE tri_imaginecareenrollmentstatus='167410003'

#checking
select * from xrui.demographics where Enrollment_Status='Opted Out'
select tri_imaginecareenrollmentstatus, Enrollment_Status from xrui.demographics

#2g
UPDATE xrui.demographics
SET Enrollment_Status='Unprocessed' WHERE tri_imaginecareenrollmentstatus='167410000'

#checking
select * from xrui.demographics where Enrollment_Status='Unprocessed'
select tri_imaginecareenrollmentstatus, Enrollment_Status from xrui.demographics

#2h
UPDATE xrui.demographics
SET Enrollment_Status='Second email sent' WHERE tri_imaginecareenrollmentstatus='167410006'

#checking
select * from xrui.demographics where Enrollment_Status='Second email sent'
select tri_imaginecareenrollmentstatus, Enrollment_Status from xrui.demographics

#3a
alter table xrui.Demographics
ADD Sex NVARCHAR(255) NULL

UPDATE xrui.demographics
SET sex='female' where gendercode='2'

#checking
select * from xrui.demographics where sex='female'
select gendercode='2', sex='female' from xrui.demographics

#3b
UPDATE xrui.demographics
SET sex='male' where gendercode='1'

#checking
select * from xrui.demographics where sex='male'
select gendercode='1', sex='male' from xrui.demographics

#3c
UPDATE xrui.demographics
SET sex='other' where gendercode='167410000'

#checking
select * from xrui.demographics where sex='other'
select gendercode='167410000', sex='other' from xrui.demographics

#3d
UPDATE xrui.demographics
SET sex='Unknown' where gendercode='NULL'

#checking
select * from xrui.demographics where sex='Unknown'
select gendercode='NULL', sex='Unknown' from xrui.demographics

#checking for Q3 overall
select gendercode, sex from xrui.demographics
order by NEWID()


#4
alter table xrui.demographics
ADD Age_Group NVARCHAR(255) NULL

UPDATE xrui.demographics
SET Age_Group='0-25' where Age BETWEEN 0 and 25

UPDATE xrui.demographics
SET Age_Group='26-50' where Age BETWEEN 26 and 50

UPDATE xrui.demographics
SET Age_Group='51-75' where Age BETWEEN 51 and 75

UPDATE xrui.demographics
SET Age_Group='76-100' where Age BETWEEN 76 and 100

#checking
select Age, Age_Group from xrui.demographics


