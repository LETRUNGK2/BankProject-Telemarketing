--Phase 1: Explore dataset

select *from dbo.bankmkt 

select day, count(day) from dbo.bankmkt
group by day
order by 1,2
select contact, count(contact) from (select job from dbo.bankmkt where job = 'admin.')
group by contact

select poutcome,count(poutcome) from dbo.bankmkt
group by poutcome

select deposit,count(deposit) from dbo.bankmkt
group by deposit

SELECT previous,count(previous)from bankmkt group by previous order by previous desc

select UPPER(job) from dbo.bankmkt

--Phase 2: Clean Data
--1. Remove unneeded "." in job column 
	
update bankmkt
set job = replace(job,'.','') from bankmkt;

--2. Join day and month into 1 column called ContactedDate and converted to date format

ALTER TABLE bankmkt
ADD ContactedDate Varchar(50)

UPDATE bankmkt 
SET ContactedDate = concat('2020','-',month,'-',day) from bankmkt

UPDATE bankmkt
SET ContactedDate = try_convert(date,ContactedDate) from bankmkt

--Remove unneeded column: 
ALTER TABLE bankmkt
DROP COLUMN day,month,pdays
 
--4. Add random order id into dataset
ALTER TABLE bankmkt
ADD ID INT

UPDATE bankmkt
SET ID = abs(checksum(NewId()) % 10000)
WHERE ID IS NULL
SELECT count(ID) FROM bankmkt

--Rename column titles 
Begin transaction 
ALTER TABLE bankmkt 
RENAME COLUMN default to Credit_Open
rollback

-- Rename and change column by using  Object Explorer
-- Phase 3:Analytic questions.

select * from bankmkt

-- check correlation between previous campaign and this campaign 
