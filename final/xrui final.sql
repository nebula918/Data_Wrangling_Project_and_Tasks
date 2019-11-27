###1a. Add BPstatus and Drop BPAlerts
select * from xrui.IC_BP_v2_original
select * into xrui.IC_BP_v2_copy from xrui.IC_BP_v2_original
alter table xrui.IC_BP_v2_copy
Add BPstatus nvarchar(255) NULL
UPDATE xrui.IC_BP_v2_copy SET BPstatus=BPAlerts
alter table xrui.IC_BP_v2_copy
Drop COLUMN BPAlerts
select BPstatus from xrui.IC_BP_v2_copy
select * from xrui.IC_BP_v2_copy

#1b
alter table xrui.IC_BP_v2_copy
ADD ControllingBP_status nvarchar(255) NULL
UPDATE xrui.IC_BP_v2_copy
SET ControllingBP_status='Controlled Blood Pressure' WHERE BPstatus='Hypo1'
UPDATE xrui.IC_BP_v2_copy
SET ControllingBP_status='Controlled Blood Pressure' WHERE BPstatus='Normal'
UPDATE xrui.IC_BP_v2_copy
SET ControllingBP_status='Uncontrolled Blood Pressure' WHERE BPstatus='Hypo2'
UPDATE xrui.IC_BP_v2_copy
SET ControllingBP_status='Uncontrolled Blood Pressure' WHERE BPstatus='HTN1'
UPDATE xrui.IC_BP_v2_copy
SET ControllingBP_status='Uncontrolled Blood Pressure' WHERE BPstatus='HTN2'
UPDATE xrui.IC_BP_v2_copy
SET ControllingBP_status='Uncontrolled Blood Pressure' WHERE BPstatus='HTN3'
UPDATE xrui.IC_BP_v2_copy
SET ControllingBP_status='1' WHERE ControllingBP_status='Controlled Blood Pressure'
UPDATE xrui.IC_BP_v2_copy
SET ControllingBP_status='0' WHERE ControllingBP_status='Uncontrolled Blood Pressure'
select ControllingBP_status, BPstatus from xrui.IC_BP_v2_copy
order by NEWID()

#1c
select xrui.demographics.contactid,
xrui.IC_BP_v2_copy.ID,
xrui.demographics.EmailSentdate,
xrui.demographics.Completedate, 
xrui.demographics.Duration, 
xrui.IC_BP_v2_copy.ObservedTime,
xrui.IC_BP_v2_copy.BPstatus,
xrui.IC_BP_v2_copy.ControllingBP_status
into xrui.final from xrui.demographics 
inner join xrui.IC_BP_v2_copy on xrui.demographics.contactid=xrui.IC_BP_v2_copy.ID
select * from xrui.final
order by NEWID()

#1d
alter table xrui.final
add Week nvarchar(255) NULL
Update xrui.final SET Week=DATEDIFF(WEEK, try_convert(date,Completedate), ObservedTime)
select ID, Week, Avg(try_convert(float,ControllingBP_status)) as Avg_score 
from (select xrui.final.*, xrui.final.Completedate as base_date from xrui.final inner join
(select ID, Min(ObservedTime) as base_date from xrui.final group by ID)A
on xrui.final.contactid = A.ID)B where Week <=12 and Week >0
group by ID, Week order by NEWID()

#1e
select * into xrui.draft 
from (select xrui.final.*, xrui.final.Completedate as base_date from xrui.final inner join
(select ID, Min(ObservedTime) as base_date from xrui.final group by ID)A
on xrui.final.contactid = A.ID)B
select C.contactid, C.score_w1, D.ID, D.score_w12 into xrui.draft2
from (select contactid, AVG(try_convert(float,ControllingBP_status)) as score_w1 from xrui.draft
where ObservedTime <= DATEADD(week,1,try_convert(datetime,Completedate)) and ObservedTime>0 group by contactid)C inner join
(select ID, AVG(try_convert(float,ControllingBP_status)) as score_w12 from xrui.draft
where ObservedTime <= DATEADD(week,12,try_convert(datetime,Completedate)) and ObservedTime > DATEADD(week,11,try_convert(datetime,Completedate))
group by ID)D
on C.contactid=D.ID
select ID,score_w1, score_w12, score_w12-score_w1 as score_diff from xrui.draft2 order by NEWID()

#1f
select count(*) from xrui.draft2
where score_w1=0 and score_w12=1


#2 merge
select A.*,B.*,C.* into xrui.final2 from Demographics A inner join Conditions B ON A.contactid=B.tri_patientid 
inner join TextMessages C ON C.tri_contactid=B.tri_patientid
select xrui.final2.*, D.* into xrui.final2_1 from xrui.final2 
inner join (select tri_patientid as ID, max(TextSentDate) as Latest_Date from xrui.final2 group by tri_patientid)D
on xrui.final2.tri_patientid=D.ID and xrui.final2.TextSentDate=D.Latest_Date
alter table xrui.final2_1
drop column ID, TextSentDate,tri_contactid
select * from xrui.final2_1 order by NEWID()









































