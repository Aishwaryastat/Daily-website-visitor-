# Use existing Database
use linear_regression;
# Create table to store data
create table daily_website_visitor(
row_id int,
Day varchar(15),
Day_Of_Week int,
Date varchar(15),
Page_Loads int,
Unique_Visits int,
First_Time_Visits int,
Returning_Visits int
);

# Total count of data 
select count(*) from daily_website_visitor;

-- Convert varchar dates to datetime and standardize the format for MySQL
set sql_safe_updates=0;
UPDATE daily_website_visitor
SET date = 
    CASE
        WHEN LOCATE('/', date) > 0 THEN STR_TO_DATE(date, '%m/%d/%Y')
        WHEN LOCATE('-', date) > 0 THEN STR_TO_DATE(date, '%m-%d-%Y')
    END;

-- Verify that the date column now has a consistent format
SELECT date FROM daily_website_visitor;

-- verify the distict days in the data
select distinct(day) from daily_website_visitor;

# -- verify the distict Day_Of_Week in the data
select distinct(Day_Of_Week) from daily_website_visitor;

-- Verify if there is missing data
select count(*) from daily_website_visitor where Returning_Visits is null;

-- Weekly Statistic
select day, avg(Page_Loads), avg(Unique_Visits), avg(First_Time_Visits), avg(Returning_Visits)
from daily_website_visitor
group by day;

-- Distinct years in data
select distinct(year(date)) as Years from daily_website_visitor;

-- Identify week day statistic or specific day max hight
select day, avg(Page_Loads), avg(Unique_Visits)
from daily_website_visitor
group by day
order by Unique_Visits desc, Page_Loads desc;

-- Yearly average number of page_loads
select year(date) as years,avg(Page_Loads) from daily_website_visitor
group by years;

-- Yearly and monthly average number of page_loads
select year(date)as years, month(date) as Months, avg(Page_Loads)
from daily_website_visitor
group by years, months
order by years, months ;
