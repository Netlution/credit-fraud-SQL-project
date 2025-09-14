SELECT * FROM creditcard.`credit card`;
RENAME TABLE `credit card` TO credit_card;
USE creditcard;   -- this sets creditcard as the current database

SELECT * FROM credit_card;

# Show all transactions where the amount is greater than 1000.
SELECT * FROM credit_card 
WHERE Amount > 1000;

# Display only the Time, Amount, and Class columns for all transactions.
SELECT Time, Amount, class
FROM credit_card;

# Count the number of fraudulent transactions (where Class = 1).
SELECT count(*) FROM credit_card
where class = 1;

#List all unique transaction amounts that are less than 10
SELECT DISTINCT Amount AS unique_transaction_amounts
FROM credit_card
WHERE Amount < 10;

# Show all transactions where the amount is between 500 and 1000.
SELECT *
FROM credit_card
WHERE Amount BETWEEN 500 AND 1000;

# Retrieve all transactions where the Class value is either 0 or 1.
SELECT *
FROM credit_card
WHERE class IN (0, 1);

#Find all transactions where the Time value ends with the digit 0.
SELECT *
FROM credit_card
WHERE Time LIKE '%0';

SELECT *
FROM credit_card
WHERE CAST(Time AS CHAR) LIKE '%0';

# What are the distinct values in the Class column?
SELECT distinct Class as distinct_values
from credit_card;

# Create a new column that labels each transaction as “Fraud” (if Class = 1) or “Normal” (if Class = 0).
SELECT Amount,
       CASE WHEN Class = 1 THEN 'Fraud' ELSE 'Normal' END AS TransactionType
FROM credit_card;

SELECT 
  Amount,
  CASE 
    WHEN Amount < 100 THEN 'Low'
    WHEN Amount BETWEEN 100 AND 1000 THEN 'Medium'
    ELSE 'High'
  END AS Category
FROM credit_card;

# Replace all missing values in Amount with 0.
SELECT COALESCE(Amount, 0) AS Amount_NoNull FROM credit_card;

# Replace all NULL values in V1 with -999.
SELECT coalesce(V1, -999) AS Amount_nonull from credit_card;

#What is the average transaction amount?
SELECT AVG(Amount) FROM credit_card;

# What is the maximum transaction amount among fraudulent cases (Class = 1)?
SELECT MAX(Amount) FROM credit_card WHERE Class= 1;

# How many transactions belong to each Class category (0 and 1)?
SELECT Class, COUNT(*) FROM credit_card GROUP BY Class;

# Show all transactions where V1 has anegative  value.
SELECT * FROM credit_card WHERE V1 < 0;

# Show all transactions where the amount is NOT between 50 and 500.
SELECT* from credit_card 
where Amount NOT BETWEEN 50 AND 500;

# Display the top 10 highest transaction amounts.
SELECT * FROM credit_card 
ORDER BY Amount DESC limit 10;

#Replace missing Amount values with 0 and then label each transaction as Fraud or Normal

Select coalesce(Amount, 0) AS missing_values,
      CASE WHEN Class = 1 THEN 'Fraud' ELSE 'Normal' END AS TransactionType
from credit_card;

#Show the distinct categories of Amount (Low, Medium, High) across all transactions.

SELECT distinct
  Amount,
  CASE 
    WHEN Amount < 100 THEN 'Low'
    WHEN Amount BETWEEN 100 AND 1000 THEN 'Medium'
    ELSE 'High'
  END AS Category
FROM credit_card;

# How many total transactions are in the dataset?
SELECT count(*) AS Totaltransaction
from credit_card;

# Find the total sum of all transaction amounts
SELECT SUM(Amount) AS TotalAmount
FROM credit_card;

# Find the average transaction amount
SELECT AVG(Amount) as avg_amount
From credit_card;

# Find the minimum and maximum transaction amount
SELECT MIN(Amount) AS Minamount,
       MAX(Amount) AS Maxamount       
FROM credit_card;

# Show the number of transactions per Class (fraud vs normal)
SELECT count(*) From credit_card
group by class;

# Show the average transaction amount per Class
SELECT avg(Amount) as avg_amount
FROM credit_card
group by Class;

# Find which Class categories have an average amount greater than 200

SELECT Class, AVG(Amount) AS AvgAmount
FROM credit_card
GROUP BY Class
HAVING AvgAmount > 200;

# Use UNION to combine fraud and normal transactions (unique only)
SELECT * FROM credit_card where Class = 1
UNION
SELECT *FROM credit_card where Class = 0;

# Use UNION ALL to combine fraud and normal transactions (with duplicates)
SELECT * FROM credit_card where Class = 1
UNION ALL
SELECT *FROM credit_card where Class = 0;

#Use EXCEPT/MINUS to show transactions that are normal but not fraud
SELECT * 
FROM credit_card
WHERE Class = 0 
  AND (Time, Amount) NOT IN (SELECT Time, Amount FROM credit_card WHERE Class = 1);
