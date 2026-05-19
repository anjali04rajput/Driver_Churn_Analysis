Create database Churn_rider;
Use Churn_rider;
Select * from driver_churn_dataset;
Select * from driver_data;
Select * from churn_data;

# how many drivers are in the company
Select Count(distinct(driver_id))
from driver_churn_dataset;

# churn rate
Select round(avg(churned)*100,2)
from churn_data;

# Average earning of those who stays
Select avg(earnings)
from driver_churn_dataset
where churned=0;
# Average earning of those who churns
Select avg(earnings)
from driver_churn_dataset
where churned=1;

# Average Login hr. of who stays
Select avg(login_hours)
from driver_churn_dataset
where churned=0;
# Average login hr of who churns
Select avg(login_hours)
from driver_churn_dataset
where churned=1;

# City level churn
Select d.city, count(c.churned) as Count_Churned
from driver_data as d
inner join churn_data as c
on d.driver_id = c.driver_id
where churned = 1
group by d.city
order by count_churned DESC;
# Best Driver
Select d.city, count(c.churned) as Count_Churned
from driver_data as d
inner join churn_data as c
on d.driver_id = c.driver_id
where churned = 0
group by d.city
order by count_churned DESC;

# Cohort Analysis

Select dd.driver_id, date_format(dd.join_date, '%Y-%m') as cohort_month, dcd.month as activity_month,
period_diff(
Replace(dcd.month, '-',''), DATE_FORMAT(dd.join_date, '%Y%m')
) As cohort_index
From driver_churn_dataset as dcd
JOIN driver_data as dd
on dcd.driver_id= dd.driver_id;
