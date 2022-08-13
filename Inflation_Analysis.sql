show databases;
use project_1;
show tables;
select * from inflation_data_2021;

# Project on Inflation expectations Survey of Households(IESH) data. Using data for survey conducted in May'2021 and May'2022


# Lets see the proportion of respondents with respect to different Age groups
# In the data imported, the survey has been conducted between 9 different age groups 
select * from inflation_data_2021
where `Age Group` = "Up to 25 years";

select `City Name`, `Gender of Respondent`, `Age Group` from inflation_data_2021
where `Age group` = "30 to 35 years";

# Views on Inflation with respect to specific Area and range
select * from inflation_data_2021
where `View on Current Inflation Rate` = "4-5" and `City Name`= "Hyderabad"
order by `Gender Of Respondent`;

# Views on Inflation with respect to Expectations on prices in next 3 months-General, one year as a whole

select `City Name`, `Category of Respondent`, `Expectations on prices in next 3 months - General` 
from inflation_data_2021
where `Expectations on prices in next 3 months - General` = "Price increase more than current rate";


select `City Name`, `Category of Respondent`, `Expectations on prices in next 1 year - General` 
from inflation_data_2021
where `Expectations on prices in next 1 year - General` = "Price increase more than current rate";

# View the number of Daily workers in the data and their Inflation expectations
select count(*) from inflation_data_2021
where `Category of Respondent` = "DAILY WORKERS";

select count(*) from inflation_data_2021
where `Category of Respondent` = "DAILY WORKERS" and `Expectations on prices in next 1 year - General` = "Price increase more than current rate";

# View if any City Name starts with 'C' 
select `City Name`, `PIN Code`  from inflation_data_2021
where `City Name` like 'C%';

# View on how many respondents think that Inflation range would be more than 16%  and how much % they think

select `City Name`, `Age Group`, `View on Current Inflation Rate`, `View on Current Inflation Rate - for above 16%`
from inflation_data_2021
where `View on Current Inflation Rate` = ">=16";

# View on list of City names that think there would be increase in price than current rate under Housing sector in 2021 and 2022 in descending order

select `City Name`, count(`Expectations on prices in next 3 months - Housing`) as min_count
from inflation_data_2021 
where `Expectations on prices in next 3 months - Housing` = "Price increase more than current rate"
group by `City Name`
order by count(`Expectations on prices in next 3 months - Housing`) desc;

select `City Name`, count(`Expectations on prices in next 3 months - Housing`) as min_count
from inflation_data_2022 
where `Expectations on prices in next 3 months - Housing` = "Price increase more than current rate"
group by `City Name`
order by count(`Expectations on prices in next 3 months - Housing`) desc;

# View on list of City names that think there would be no change in prices under Housing sector in 2021 and 2022 in descending order

select `City Name`, count(`Expectations on prices in next 3 months - Housing`) as max_count
from inflation_data_2021 
where `Expectations on prices in next 3 months - Housing` = "no change in prices"
group by `City Name`
order by count(`Expectations on prices in next 3 months - Housing`) desc;

select `City Name`, count(`Expectations on prices in next 3 months - Housing`) as max_count
from inflation_data_2022 
where `Expectations on prices in next 3 months - Housing` = "no change in prices"
group by `City Name`
order by count(`Expectations on prices in next 3 months - Housing`) desc;

# View on City name that think there would be increases in prices under Housing sector in 2021 and 2022

select max(`City Name`) 
from 
(select `City Name`, count(`Expectations on prices in next 3 months - Housing`) 
from inflation_data_2022 
where `Expectations on prices in next 3 months - Housing` = "Price increase more than current rate"
group by `City Name`) as p2;

select `City Name`, count(`Expectations on prices in next 3 months - Housing`) 
from inflation_data_2022 
where `Expectations on prices in next 3 months - Housing` = "Price increase more than current rate"
group by `City Name`
order by count(`Expectations on prices in next 3 months - Housing`) desc;

#Creating stored procedure to call the values in the tables that we have queried before 
#View on list of City names that think there would be increase in price than current rate under Housing sector in 2021 and 2022 in descending order

delimiter //
create procedure data_2021()
begin
select `City Name`, count(`Expectations on prices in next 3 months - Housing`) as max_count
from inflation_data_2021 
where `Expectations on prices in next 3 months - Housing` = "no change in prices"
group by `City Name`
order by count(`Expectations on prices in next 3 months - Housing`) desc;
end; //

#stored procedure name altered from navigator pane after creating it to 'housing_ncip_data_2021'

call housing_ncip_data_2021;

delimiter //
create procedure housing_ncip_data_2022()
begin
select `City Name`, count(`Expectations on prices in next 3 months - Housing`) as max_count
from inflation_data_2022 
where `Expectations on prices in next 3 months - Housing` = "no change in prices"
group by `City Name`
order by count(`Expectations on prices in next 3 months - Housing`) desc;
end; //

call housing_ncip_data_2022;

//

# Query on views on current inflation rate-for above 16% within a range of 40-50 and that are of 'Delhi'

select `City Name`, `Gender Of Respondent`, `Category of Respondent` , `View on Current Inflation Rate - for above 16%`
from inflation_data_2022
where `View on Current Inflation Rate - for above 16%` between 40 and 50 and `City Name` = "Delhi";

 
