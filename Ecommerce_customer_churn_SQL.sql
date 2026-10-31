create database ecommerce_churn;
use ecommerce_churn;
drop database ecommerce_churn;

-- Data extraction

CREATE TABLE ecommercechurn (
    CustomerID INT PRIMARY KEY,
    Churn INT NOT NULL,
    Tenure INT DEFAULT NULL,
    PreferredLoginDevice VARCHAR(50) DEFAULT NULL,
    CityTier INT DEFAULT NULL,
    WarehouseToHome INT DEFAULT NULL,
    PreferredPaymentMode VARCHAR(50) DEFAULT NULL,
    Gender VARCHAR(20) DEFAULT NULL,
    HourSpendOnApp INT DEFAULT NULL,
    NumberOfDeviceRegistered INT DEFAULT NULL,
    PreferedOrderCat VARCHAR(50) DEFAULT NULL,
    SatisfactionScore INT DEFAULT NULL,
    MaritalStatus VARCHAR(30) DEFAULT NULL,
    NumberOfAddress INT DEFAULT NULL,
    Complain INT DEFAULT NULL,
    OrderAmountHikeFromlastYear INT DEFAULT NULL,
    CouponUsed INT DEFAULT NULL,
    OrderCount INT DEFAULT NULL,
    DaySinceLastOrder INT DEFAULT NULL,
    CashbackAmount DECIMAL(10, 2) DEFAULT NULL
);


LOAD DATA  INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ecommerce_churn.csv"
INTO TABLE ecommercechurn
FIELDS TERMINATED BY ',' 
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'  
IGNORE 1 ROWS
(
   CustomerID,
    Churn,
    @Tenure,
    PreferredLoginDevice,
    CityTier,
    @WarehouseToHome,
    PreferredPaymentMode,
    Gender,
    @HourSpendOnApp,
    NumberOfDeviceRegistered,
    PreferedOrderCat,
    SatisfactionScore,
    MaritalStatus,
    NumberOfAddress,
    Complain,
    @OrderAmountHikeFromlastYear,
    @CouponUsed,
    @OrderCount,
    @DaySinceLastOrder,
    @CashbackAmount
)
SET
    Tenure                      = NULLIF(TRIM(@Tenure), ''),
    WarehouseToHome             = NULLIF(TRIM(@WarehouseToHome), ''),
    HourSpendOnApp              = NULLIF(TRIM(@HourSpendOnApp), ''),
    OrderAmountHikeFromlastYear = NULLIF(TRIM(@OrderAmountHikeFromlastYear), ''),
    CouponUsed                  = NULLIF(TRIM(@CouponUsed), ''),
    OrderCount                  = NULLIF(TRIM(@OrderCount), ''),
    DaySinceLastOrder           = NULLIF(TRIM(@DaySinceLastOrder), ''),
    CashbackAmount              = NULLIF(TRIM(@CashbackAmount), '');
    
    -- @ creates temporary new empty column,so that we can import blank cell without any error
    
    select * from ecommercechurn;



--        Data cleaning


	-- Finding Duplicates

	with duplicates as (select customerid ,row_number() over(partition by customerid ) as rn from ecommercechurn)
	select * from duplicates where rn > 1;




-- Finding Null values

SELECT 'Tenure' as ColumnName, COUNT(*) AS NullCount 
FROM ecommercechurn
WHERE Tenure IS NULL 
UNION
SELECT 'WarehouseToHome' as ColumnName, COUNT(*) AS NullCount 
FROM ecommercechurn
WHERE warehousetohome IS NULL 
UNION
SELECT 'HourSpendonApp' as ColumnName, COUNT(*) AS NullCount 
FROM ecommercechurn
WHERE hourspendonapp IS NULL
UNION
SELECT 'OrderAmountHikeFromLastYear' as ColumnName, COUNT(*) AS NullCount 
FROM ecommercechurn
WHERE orderamounthikefromlastyear IS NULL 
UNION
SELECT 'CouponUsed' as ColumnName, COUNT(*) AS NullCount 
FROM ecommercechurn
WHERE couponused IS NULL 
UNION
SELECT 'OrderCount' as ColumnName, COUNT(*) AS NullCount 
FROM ecommercechurn
WHERE ordercount IS NULL 
UNION
SELECT 'DaySinceLastOrder' as ColumnName, COUNT(*) AS NullCount 
FROM ecommercechurn
WHERE daysincelastorder IS NULL ;


-- Filling null values with there Mean

SELECT AVG(Hourspendonapp) FROM ecommercechurn;
UPDATE ecommercechurn
SET Hourspendonapp = 2.9315
WHERE Hourspendonapp IS NULL ;

SELECT AVG(tenure) FROM ecommercechurn;
UPDATE ecommercechurn
SET tenure = 10.1899
WHERE tenure IS NULL ;

SELECT AVG(orderamounthikefromlastyear) FROM ecommercechurn;
UPDATE ecommercechurn
SET orderamounthikefromlastyear = 15.7079
WHERE orderamounthikefromlastyear IS NULL ;

SELECT  AVG(WarehouseToHome) FROM ecommercechurn;
UPDATE ecommercechurn
SET WarehouseToHome = 15.6399
WHERE WarehouseToHome IS NULL ;

SELECT AVG(couponused) FROM ecommercechurn;
UPDATE ecommercechurn
SET couponused = 1.7510
WHERE couponused IS NULL ;

SELECT AVG(ordercount) FROM ecommercechurn;
UPDATE ecommercechurn
SET ordercount = 3.0080
WHERE ordercount IS NULL ;

SELECT AVG(daysincelastorder) FROM ecommercechurn;
UPDATE ecommercechurn
SET daysincelastorder = 4.5435
WHERE daysincelastorder IS NULL ;

-- created new column 

alter table ecommercechurn
add column customerstatus varchar(50) after `churn`;

update ecommercechurn
set customerstatus = case when churn = 0 then 'Stayed' when churn = 1 then 'Churned' end ;
select distinct customerstatus from ecommercechurn;
alter table ecommercechurn drop column churn;


ALTER TABLE ecommercechurn
ADD column ComplainRecieved VARCHAR(10) after `customerstatus`;

UPDATE ecommercechurn
SET ComplainRecieved =  
CASE  WHEN complain = 1 THEN 'Yes' WHEN complain = 0 THEN 'No' END;
select distinct complainrecieved from ecommercechurn;
alter table ecommercechurn drop column complain;


-- Checking values in each column for correctness and accuracy

select distinct customerstatus from ecommercechurn;
select distinct ComplainRecieved from ecommercechurn;
select distinct Tenure from ecommercechurn;
select distinct PreferredLoginDevice from ecommercechurn;
select distinct CityTier from ecommercechurn;
select distinct WarehouseToHome from ecommercechurn;
select distinct PreferredPaymentMode from ecommercechurn;
select distinct Gender from ecommercechurn;
select distinct HourSpendOnApp from ecommercechurn;
select distinct NumberOfDeviceRegistered from ecommercechurn;
select distinct PreferedOrderCat from ecommercechurn;
select distinct SatisfactionScore from ecommercechurn;
select distinct MaritalStatus from ecommercechurn;
select distinct NumberOfAddress from ecommercechurn;
select distinct OrderAmountHikeFromlastYear from ecommercechurn;
select distinct CouponUsed from ecommercechurn;
select distinct OrderCount from ecommercechurn;
select distinct DaySinceLastOrder from ecommercechurn;
select distinct CashbackAmount from ecommercechurn;


-- Replace mobile phone with phone
UPDATE ecommercechurn
SET preferredlogindevice = 'phone'
WHERE preferredlogindevice = 'mobile phone';

-- Replace mobile with mobile phone
UPDATE ecommercechurn
SET preferedordercat = 'Mobile Phone'
WHERE Preferedordercat = 'Mobile';

--  Replace cod with Cash on Delivery
UPDATE ecommercechurn
SET PreferredPaymentMode  = 'Cash on Delivery'
WHERE PreferredPaymentMode  = 'COD';

-- Replace value 126 with 26
UPDATE ecommercechurn
SET warehousetohome = '26'
WHERE warehousetohome = '126';

-- Replace value 127 with 27
UPDATE ecommercechurn
SET warehousetohome = '27'
WHERE warehousetohome = '127';



-- Data Exploration

-- Q1 What is the overall customer churn rate? 

select customerstatus,count(customerid),
100 * count(customerid)/(select count(CustomerID) from ecommercechurn)  as rate
from ecommercechurn
where customerstatus = 'churned'
group by customerstatus;
select PreferredLoginDevice,customerstatus,count(customerid),
100 * count(customerid)/(select count(CustomerID) from ecommercechurn)  as rate
from ecommercechurn
where customerstatus = 'churned'
group by 1,2;

-- Q2 How does the churn rate vary based on the preferred login device?  

select PreferredLoginDevice,
sum( case when customerstatus = 'churned' then 1 else 0 end) as totalchurnedcustomers,
count(customerid),
round(100 * sum( case when customerstatus = 'churned' then 1 else 0 end)/count(CustomerID),2)  as rate
from ecommercechurn
group by 1;

-- Q3 What is the distribution of customers across different city tiers? 

SELECT citytier,count(customerid),
sum( case when customerstatus = 'churned' then 1 else 0 end) as totalchurnedcustomers,
Round(100 * sum( case when customerstatus = 'churned' then 1 else 0 end)/count(CustomerID) ,2) as rate
from ecommercechurn
group by 1;

-- Q4 Is there any correlation between the warehouse-to-home distance and customer churn?  

alter table ecommercechurn
add column warehousetohomerange varchar(50) after warehousetohome;

update  ecommercechurn
set warehousetohomerange = case when warehousetohome <= 10 then 'very close distance'
when warehousetohome >10 and warehousetohome <=20 then 'close distance'
when warehousetohome >20 and warehousetohome <=30 then 'moderate distance'
when warehousetohome > 30 then 'far distance'
end;

select warehousetohomerange,count(customerid),
sum( case when customerstatus = 'churned' then 1 else 0 end) as totalchurnedcustomers,
Round(100 * sum( case when customerstatus = 'churned' then 1 else 0 end)/count(CustomerID) ,2) as rate
from ecommercechurn
group by 1
order by rate desc;

-- Q5 Which is the most preferred payment mode among churned customers?  

SELECT PreferredPaymentMode,count(customerid),
sum( case when customerstatus = 'churned' then 1 else 0 end) as totalchurnedcustomers,
Round(100 * sum( case when customerstatus = 'churned' then 1 else 0 end)/count(CustomerID) ,2) as rate
from ecommercechurn
group by 1
order by rate desc;

-- Q6 What is the typical tenure for churned customers? 

ALTER TABLE ecommercechurn
ADD TenureRange VARCHAR(50) after tenure;

UPDATE ecommercechurn
SET TenureRange =
CASE 
    WHEN tenure <= 6 THEN '6 Months'
    WHEN tenure > 6 AND tenure <= 12 THEN '1 Year'
    WHEN tenure > 12 AND tenure <= 24 THEN '2 Years'
    WHEN tenure > 24 THEN 'more than 2 years'
END;

select tenurerange,count(customerid),
sum( case when customerstatus = 'churned' then 1 else 0 end) as totalchurnedcustomers,
Round(100 * sum( case when customerstatus = 'churned' then 1 else 0 end)/count(CustomerID) ,2) as rate
from ecommercechurn
group by 1
order by rate desc;



-- Q7 Is there any difference in churn rate between male and female customers? 

select gender,count(customerid),
sum( case when customerstatus = 'churned' then 1 else 0 end) as totalchurnedcustomers,
Round(100 * sum( case when customerstatus = 'churned' then 1 else 0 end)/count(CustomerID) ,2) as rate
from ecommercechurn
group by 1
order by rate desc;

-- Q8 How does the average time spent on the app differ for churned and non churned customers? 

SELECT customerstatus, avg(hourspendonapp) AS AverageHourSpentonApp
FROM ecommercechurn
GROUP BY customerstatus;

-- Q9 Does the number of registered devices impact the likelihood of churn? 

select numberofdeviceregistered,count(customerid),
sum( case when customerstatus = 'churned' then 1 else 0 end) as totalchurnedcustomers,
Round(100 * sum( case when customerstatus = 'churned' then 1 else 0 end)/count(CustomerID) ,2) as rate
from ecommercechurn
group by 1
order by rate desc;

-- Q10 Which order category is most preferred among churned customers? 

select PreferedOrderCat,count(customerid),
sum( case when customerstatus = 'churned' then 1 else 0 end) as totalchurnedcustomers,
Round(100 * sum( case when customerstatus = 'churned' then 1 else 0 end)/count(CustomerID) ,2) as rate
from ecommercechurn
group by 1
order by rate desc;

-- Q11 Is there any relationship between customer satisfaction scores and churn? 

select SatisfactionScore,count(customerid),
sum( case when customerstatus = 'churned' then 1 else 0 end) as totalchurnedcustomers,
Round(100 * sum( case when customerstatus = 'churned' then 1 else 0 end)/count(CustomerID) ,2) as rate
from ecommercechurn
group by 1
order by rate desc;

-- Q12 Does the marital status of customers influence churn behaviour? 

select MaritalStatus,count(customerid),
sum( case when customerstatus = 'churned' then 1 else 0 end) as totalchurnedcustomers,
Round(100 * sum( case when customerstatus = 'churned' then 1 else 0 end)/count(CustomerID) ,2) as rate
from ecommercechurn
group by 1
order by rate desc;

-- Q13 How many addresses do churned customers have on average? 

SELECT round(AVG(numberofaddress),0) AS Averagenumofchurnedcustomeraddress
FROM ecommercechurn
WHERE customerstatus = 'churned';

-- Q14  Do customer complaints influence churned behavior?

select ComplainRecieved,count(customerid),
sum( case when customerstatus = 'churned' then 1 else 0 end) as totalchurnedcustomers,
Round(100 * sum( case when customerstatus = 'churned' then 1 else 0 end)/count(CustomerID) ,2) as rate
from ecommercechurn
group by 1
order by rate desc;

-- Q15 How does the use of coupons differ between churned and non-churned customers?

with cte as (
SELECT customerstatus, SUM(couponused) AS SumofCouponUsed
FROM ecommercechurn
GROUP BY customerstatus)
select customerstatus,sumofcouponused,sum(sumofcouponused) over() as total,
100 * sumofcouponused/sum(sumofcouponused) over() as rate
from cte ;

-- Q16 What is the average number of days since the last order for churned customers?

SELECT Round(AVG(daysincelastorder),0) AS AverageNumofDaysSinceLastOrder
FROM ecommercechurn
WHERE customerstatus = 'churned';

-- Q17 Is there any correlation between cashback amount and churn rate? 

ALTER TABLE ecommercechurn
ADD column cashbackamountrange VARCHAR(50);

UPDATE ecommercechurn
SET cashbackamountrange =
CASE 
    WHEN cashbackamount <= 100 THEN 'Low Cashback Amount'
    WHEN cashbackamount > 100 AND cashbackamount <= 200 THEN 'Moderate Cashback Amount'
    WHEN cashbackamount > 200 AND cashbackamount <= 300 THEN 'High Cashback Amount'
    WHEN cashbackamount > 300 THEN 'Very High Cashback Amount'
END;

select cashbackamountrange,count(customerid),
sum( case when customerstatus = 'churned' then 1 else 0 end) as totalchurnedcustomers,
Round(100 * sum( case when customerstatus = 'churned' then 1 else 0 end)/count(CustomerID) ,2) as rate
from ecommercechurn
group by 1
order by rate desc;



