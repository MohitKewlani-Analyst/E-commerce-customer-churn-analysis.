# E-commerce-customer-churn-analysis.

1. Project Description:

a) Problem Statement – 
The E-commerce company is experiencing the user churn which is threatening 
our recurring revenue and long-term market share. Therefore, the problem 
here is to understand why customers are leaving an online e-commerce 
company. 

b) Project Overview – 
This project analyses customer attrition for an e-commerce platform across 
5,630 customer records to identify why users discontinue service. Using MySQL 
for data cleaning, transformation, and aggregations alongside Power BI for 
interactive visualization, it identifies key attrition drivers such as tenure drop
offs, unresolved support complaints, and delivery distances. The resulting 
dashboards deliver actionable, data-driven retention strategies to reduce the 
platform's 16.8% churn rate and increase customer lifetime value.


2. Dataset Overview: 

Columns names – 
Identifier & Target – CustomerID, Churn. 
Customer Demographics – Gender, MaritalStatus, CityTier, NumberOfAddress. 
Customer Lifecycle & Engagement – Tenure, HourSpendOnApp, NumberOfDeviceRegistered,  
PreferredLoginDevice. 
Purchasing Behaviour – OrderCount, DaySinceLastOrder, PreferedOrderCat, PreferredPaymentMode 
Monetization & Incentives – CashbackAmount, CouponUsed, OrderAmountHikeFromlastYear. 
Logistics & Customer Experience – WarehouseToHome, Complain, SatisfactionScore. 

No. of Rows – 5,630 
No. of Columns – 20 
Data Source – Kaggle datasets.


3. Tech Stack Used:  
MySQL     -    Using MySQL for data cleaning, transformation, and data analysis. 
Power BI -   Using Power BI for Data Visualization.


4. Data Cleaning:

a.) Integrity & Deduplication: Verified data integrity using SQL window functions (ROW_NUMBER()),
confirming zero duplicate customer records across the 5,630-row dataset.
b.) Imputation: Handled missing values across 7 numerical features by imputing column-specific mean values.
c.) Standardization & Categorization: Replaced ambiguous binary flags with descriptive categorical fields to enhance reporting clarity.
d.) Data Harmonization & Outlier Correction: Consolidated redundant text entries and corrected erroneous distance outliers.


5. Data analysis:

Exploratory data analysis was conducted using MySQL to identify behavioral and operational drivers influencing the platform's 16.84% benchmark churn rate.
Customer lifecycle analysis revealed a severe early-stage attrition risk, with over 38% of total churn occurring within the first six months 
and a peak drop-off within the initial two months.
Customer support friction emerged as a primary catalyst, where customers with filed complaints experienced nearly triple the churn rate (31.7%) compared to
those without issues (10.9%). Furthermore, logistical distances and product lines played critical roles,
as customers living over 30 km from warehouses and those purchasing within the Mobile Phone category exhibited peak attrition rates of 20.9% and 27.4%, respectively.


6. Recommendations:

In order to reduce customer churn,I will recommend to create a targeted retention initiatives which should focus on early-lifecycle onboarding and
rapid customer support resolution, directly addressing the critical first two months and preventing the 3x churn risk associated with customer complaints.
Logistics and fulfillment operations must be optimized to lower shipping delays and delivery costs for outlying regions beyond 30 km, paired with city-tier-specific promotions.
Cross-device synchronization and desktop platform enhancements should be implemented to deliver a seamless shopping experience regardless of login method.
Additionally, the business should refine its incentive structures by expanding higher cashback tiers, promoting secure payment alternatives
over Cash on Delivery, and offering category-specific loyalty rewards for high-attrition segments like Mobile Phones.
