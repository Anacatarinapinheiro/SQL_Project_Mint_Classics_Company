# Coursera SQL Project: Analyze Data in a Model Car Database
## Mint Classics Company 

This project is part of my journey to enhance my data analytics skills through Coursera. It is a hands-on SQL-based project where I analyze inventory data for the fictional Mint Classics Company, a retailer of classic cars and vehicles. The goal is to support inventory-related business decisions, focusing on stock optimization and the closure of a storage facility.

# Work Process

## Step 1: Database Setup

The first step was to download the [`mintclassicsDB.sql`](./mintclassicsDB.sql) file, which contains the script for creating and populating the Mint Classics relational database. Using the **"Import from Self-Contained File"** option in MySQL Workbench, I imported the script, which created a nine-table relational database.

![Database Import Screenshot](./SupportFiles/MintTClassic_DB_Import.png)


The following EER diagram illustrates the structure of the Mint Classics database, which served as a reference for my analysis:

<img src="./SupportFiles/EER_MintClassicsDataModel.png" alt="EER Diagram" width="50%">

## Step 2: Explore the Tables

In this step, I explored the various tables within the Mint Classics database to gather insights. Click the arrow below to expand and view the details of each table.

<details>
<summary>Expand to see Customers Table</summary>

### Customers Table Description

The `customers` table contains essential information about customers of the Mint Classics Company. Below is a description of each column in the table:

| Column Name               | Data Type       | Description                                                                                      |
|--------------------------|-----------------|--------------------------------------------------------------------------------------------------|
| `customerNumber`         | int             | Unique identifier for each customer (Primary Key).                                             |
| `customerName`           | varchar(50)     | Name of the customer or business.                                                               |
| `contactLastName`        | varchar(50)     | Last name of the primary contact person for the customer.                                       |
| `contactFirstName`       | varchar(50)     | First name of the primary contact person for the customer.                                      |
| `phone`                  | varchar(50)     | Phone number of the customer or their primary contact.                                         |
| `addressLine1`           | varchar(50)     | Primary address of the customer (e.g., street address).                                        |
| `addressLine2`           | varchar(50)     | Additional address details (optional).                                                          |
| `city`                   | varchar(50)     | City where the customer resides.                                                                 |
| `state`                  | varchar(50)     | State or province where the customer is located (optional).                                    |
| `postalCode`             | varchar(15)     | Postal code of the customer's address.                                                           |
| `country`                | varchar(50)     | Country of the customer.                                                                          |
| `salesRepEmployeeNumber` | int             | Employee number of the sales representative assigned to the customer (Foreign Key).             |
| `creditLimit`            | decimal(10,2)   | Credit limit assigned to the customer.                                                            |

</details>

<details>
<summary>Expand to see Employees Table</summary>

### Employees Table Description

The `employees` table contains information about the employees who manage customer relationships and sales within the Mint Classics Company. Below is a description of each column in the table:

| Column Name             | Data Type       | Description                                                                                      |
|-------------------------|-----------------|--------------------------------------------------------------------------------------------------|
| `employeeNumber`        | int             | Unique identifier for each employee (Primary Key).                                             |
| `lastName`              | varchar(50)     | Last name of the employee.                                                                       |
| `firstName`             | varchar(50)     | First name of the employee.                                                                      |
| `extension`             | varchar(10)     | Phone extension for the employee.                                                                |
| `email`                 | varchar(100)    | Email address of the employee.                                                                   |
| `officeCode`            | varchar(10)     | Identifier for the office where the employee works (Foreign Key).                               |
| `reportsTo`             | int             | Identifier of the employee's manager (Foreign Key).                                             |
| `jobTitle`              | varchar(50)     | Job title of the employee.                                                                        |

</details>

<details>
<summary>Expand to see Offices Table</summary>

### Offices Table Description

The `offices` table contains information about the various office locations of the Mint Classics Company. Below is a description of each column in the table:

| Column Name        | Data Type       | Description                                                                                      |
|--------------------|-----------------|--------------------------------------------------------------------------------------------------|
| `officeCode`       | varchar(10)     | Unique identifier for each office (Primary Key).                                              |
| `city`             | varchar(50)     | City where the office is located.                                                               |
| `phone`            | varchar(50)     | Phone number for the office.                                                                     |
| `addressLine1`     | varchar(50)     | Primary address of the office (e.g., street address).                                           |
| `addressLine2`     | varchar(50)     | Additional address details (optional).                                                           |
| `state`            | varchar(50)     | State or province where the office is located (optional).                                      |
| `country`          | varchar(50)     | Country where the office is located.                                                             |
| `postalCode`       | varchar(15)     | Postal code of the office's address.                                                             |
| `territory`        | varchar(10)     | Identifier for the sales territory associated with the office.                                   |

</details>

<details>
<summary>Expand to see Order Details Table</summary>

### Order Details Table Description

The `orderdetails` table contains information about the individual products included in each order placed by customers. Below is a description of each column in the table:

| Column Name          | Data Type       | Description                                                                                      |
|----------------------|-----------------|--------------------------------------------------------------------------------------------------|
| `orderNumber`        | int             | Unique identifier for each order (Foreign Key).                                               |
| `productCode`        | varchar(15)     | Unique identifier for each product (Foreign Key).                                              |
| `quantityOrdered`    | int             | Number of units of the product ordered.                                                         |
| `priceEach`          | decimal(10,2)   | Price per unit of the product at the time of the order.                                        |
| `orderLineNumber`    | smallint        | Line item number for the product in the order, used to differentiate between multiple products in a single order. |

</details>

<details>
<summary>Expand to see Orders Table</summary>

### Orders Table Description

The `orders` table contains information about customer orders placed with the Mint Classics Company. Below is a description of each column in the table:

| Column Name       | Data Type       | Description                                                                                      |
|-------------------|-----------------|--------------------------------------------------------------------------------------------------|
| `orderNumber`     | int             | Unique identifier for each order (Primary Key).                                               |
| `orderDate`       | date            | Date when the order was placed.                                                                |
| `requiredDate`    | date            | Date by which the customer requires the order to be delivered.                                  |
| `shippedDate`     | date            | Date when the order was shipped (optional).                                                    |
| `status`          | varchar(15)     | Current status of the order (e.g., Shipped, Cancelled, etc.).                                 |
| `comments`        | text            | Additional comments or notes related to the order.                                             |
| `customerNumber`   | int             | Unique identifier for the customer placing the order (Foreign Key).                            |

</details>

<details>
<summary>Expand to see Payments Table</summary>

### Payments Table Description

The `payments` table contains information about the payments made by customers for their orders at the Mint Classics Company. Below is a description of each column in the table:

| Column Name          | Data Type       | Description                                                                                      |
|----------------------|-----------------|--------------------------------------------------------------------------------------------------|
| `customerNumber`     | int             | Unique identifier for each customer (Foreign Key).                                             |
| `checkNumber`        | varchar(50)     | Unique identifier for the payment (e.g., check number).                                        |
| `paymentDate`        | date            | Date when the payment was made.                                                                  |
| `amount`             | decimal(10,2)   | Amount of money paid by the customer.                                                            |

</details>

<details>
<summary>Expand to see Product Lines Table</summary>

### Product Lines Table Description

The `productlines` table contains information about the different categories of products offered by the Mint Classics Company. Below is a description of each column in the table:

| Column Name        | Data Type       | Description                                                                                      |
|--------------------|-----------------|--------------------------------------------------------------------------------------------------|
| `productLine`      | varchar(50)     | Unique identifier for each product line (Primary Key).                                         |
| `textDescription`  | varchar(4000)   | Textual description of the product line (optional).                                            |
| `htmlDescription`  | mediumtext      | HTML formatted description of the product line.                                                |
| `image`            | mediumblob      | Binary data for an image representing the product line.                                        |

</details>

<details>
<summary>Expand to see Products Table</summary>

### Products Table Description

The `products` table contains information about the various products offered by the Mint Classics Company. Below is a description of each column in the table:

| Column Name          | Data Type       | Description                                                                                      |
|----------------------|-----------------|--------------------------------------------------------------------------------------------------|
| `productCode`        | varchar(15)     | Unique identifier for each product (Primary Key).                                              |
| `productName`        | varchar(70)     | Name of the product.                                                                             |
| `productLine`        | varchar(50)     | Identifier for the product line to which the product belongs (Foreign Key).                     |
| `productScale`       | varchar(10)     | Scale of the product (e.g., 1:10, 1:12, etc.).                                                |
| `productVendor`      | varchar(50)     | Name of the vendor supplying the product.                                                       |
| `productDescription`  | text            | Detailed description of the product.                                                             |
| `quantityInStock`    | smallint        | Number of units available in stock.                                                             |
| `warehouseCode`      | char(1)         | Identifier for the warehouse where the product is stored (Foreign Key).                         |
| `buyPrice`           | decimal(10,2)   | Purchase price of the product.                                                                   |
| `MSRP`               | decimal(10,2)   | Manufacturer's suggested retail price for the product.                                          |

</details>

<details>
<summary>Expand to see Warehouses Table</summary>

### Warehouses Table Description

The `warehouses` table contains information about the storage facilities used by the Mint Classics Company. Below is a description of each column in the table:

| Column Name           | Data Type       | Description                                                                                      |
|-----------------------|-----------------|--------------------------------------------------------------------------------------------------|
| `warehouseCode`       | char(1)         | Unique identifier for each warehouse (Primary Key).                                            |
| `warehouseName`       | varchar(45)     | Name of the warehouse.                                                                           |
| `warehousePctCap`     | varchar(50)     | Percentage capacity of the warehouse, indicating how full the warehouse is.                     |

</details>

## Step 3: Data Understanding
  - [Warehouse and Inventory Distribution](#warehouse-and-inventory-distribution)
  - [Analysis of Inventory Numbers and Sales Figures](#analysis-of-inventory-numbers-and-sales-figures)
  - [Order Volume Evolution](#order-volume-evolution)
  - [Employees and Customers](#employees-and-customers)

- ### Warehouse and Inventory Distribution

In this project, it was essential to analyze how the inventory of Mint Company was organized and distributed. One of the key questions I aimed to explore was: 

1. **Where are the items stored, and if they were reorganized, could a warehouse be eliminated?**

To address this, we first needed to understand:

- How many warehouses were in operation.
- Which product lines were stored in each warehouse.

One of the analyses I performed was to understand the relationship between warehouses and product lines.

```sql
SELECT 
    w.warehouseName as "Warehouse",
    p.productLine as "Product Line"
FROM 
    products p
JOIN 
    warehouses w ON p.warehouseCode = w.warehouseCode
GROUP BY 
    w.warehouseName, p.productLine
ORDER BY 
    w.warehouseName, p.productLine;
```

| Warehouse | Product Line        |
|-----------|---------------------|
| East      | Classic Cars        |
| North     | Motorcycles         |
| North     | Planes              |
| South     | Ships               |
| South     | Trains              |
| South     | Trucks and Buses    |
| West      | Vintage Cars        |


We observed that there are **four warehouses** and **seven product lines** distributed across them. The **South Warehouse** holds the most product lines.

Now, we want to understand the **inventory quantity** across all warehouses, as well as analyze the **average product size**.

The following SQL query retrieves the total quantity of inventory:

```sql
SELECT 
    'Total' AS "Warehouse",
    SUM(quantityInStock) AS "Total Quantity"
FROM 
    products;
```

| Warehouse | Total Quantity |
|-----------|----------------|
| Total     | 555,131        |

```sql
SELECT w.warehouseName as Warehouse, 
       SUM(p.quantityInStock) AS "Current Stock", 
       w.warehousePctCap as "Warehouse Capacity (%)", 
       ROUND((SUM(p.quantityInStock) * 100.0) / w.warehousePctCap) AS "Max Capacity",
       ROUND((SUM(p.quantityInStock) * 100.0) / w.warehousePctCap) - SUM(p.quantityInStock) AS "Available Space",
       CONCAT('1:', MIN(CAST(SUBSTRING_INDEX(p.productScale, ':', -1) AS UNSIGNED))) AS minScale,
       CONCAT('1:', MAX(CAST(SUBSTRING_INDEX(p.productScale, ':', -1) AS UNSIGNED))) AS maxScale
FROM products p
JOIN warehouses w ON p.warehouseCode = w.warehouseCode
GROUP BY w.warehouseName, w.warehousePctCap;
```

| Warehouse | Current Stock | Warehouse Capacity (%) | Max Capacity | Available Space | Min Scale | Max Scale |
|-----------|---------------|------------------------|--------------|------------------|-----------|-----------|
| East      | 219,183       | 67                     | 327,139      | 107,956          | 1:10      | 1:24      |
| North     | 131,688       | 72                     | 182,900      | 51,212           | 1:10      | 1:700     |
| West      | 124,880       | 50                     | 249,760      | 124,880          | 1:18      | 1:50      |
| South     | 79,380        | 75                     | 105,840      | 26,460           | 1:12      | 1:700     |

From this analysis, we found that the total number of products in stock is **555,131**. The **East Warehouse** holds the highest number of products; however, the warehouses in the **North** and **South** accommodate larger-scale products.

In response to the initial question, it possible to determine that we could indeed reduce one of the warehouses, considering the available capacity in the other locations. Therefore, it is also important to take into account the scale of the products. Additionally, understanding the distribution by product line will help us reorganize the inventory more effectively.

```sql

SELECT 
    w.warehouseName,
    p.productLine,
    SUM(p.quantityInStock) AS totalQuantity,
    CONCAT('1:', MIN(CAST(SUBSTRING_INDEX(p.productScale, ':', -1) AS UNSIGNED))) AS minScale,
	CONCAT('1:', MAX(CAST(SUBSTRING_INDEX(p.productScale, ':', -1) AS UNSIGNED))) AS maxScale
FROM 
    products p
JOIN 
    warehouses w ON p.warehouseCode = w.warehouseCode
GROUP BY 
    w.warehouseName, p.productLine
ORDER BY 
    w.warehouseName, p.productLine;
```
| Warehouse  | Product Line       | Total Quantity | Min Scale | Max Scale |
|------------|--------------------|----------------|-----------|-----------|
| East       | Classic Cars       | 219,183        | 1:10      | 1:24      |
| North      | Motorcycles        | 69,401         | 1:10      | 1:50      |
| North      | Planes             | 62,287         | 1:18      | 1:700     |
| South      | Ships              | 26,833         | 1:18      | 1:700     |
| South      | Trains             | 16,696         | 1:18      | 1:50      |
| South      | Trucks and Buses   | 35,851         | 1:12      | 1:50      |
| West       | Vintage Cars       | 124,880        | 1:18      | 1:50      |

#### *Proposal for Warehouse Optimization*

Considering the points discussed, I would propose the dissolution of the **South Warehouse**, with the following product line reallocations:
- The **Ships** product line will be moved to the **North Warehouse**, as it already accommodates products of equal scale.
- The **Trains** and **Trucks and Buses** product lines will be moved to the **West Warehouse**.

The new distribution would be as follows:

| Warehouse  | Warehouse % Capacity | Current Stock | Max Capacity | Available Space | Min Scale | Max Scale |
|------------|----------------------|---------------|--------------|------------------|-----------|-----------|
| East       | 67                   | 219,183       | 327,139      | 107,956          | 01:10     | 01:24     |
| North      | 87                   | 158,521       | 182,900      | 24,379           | 01:10     | 1:700     |
| West       | 71                   | 177,427       | 249,760      | 72,333           | 01:18     | 01:50     |


- ### Analysis of Inventory Numbers and Sales Figures

In this analysis, I aim to understand how inventory counts relate to sales figures. Specifically, we will investigate whether current inventory levels are adequate for demand and identify any discrepancies where order quantities exceed stock levels. This leads to the second and third question proposed:

2. *How are inventory numbers related to sales figures? Do the inventory counts seem appropriate for each item?*
3. *Are we storing items that are not moving? Are any items candidates for being dropped from the product line?*

In the following section, I aimed to answer several key questions regarding the products in the database:

- How many different product types exist?
- Which products are the most expensive in stock?
- What are the most sought-after products in terms of stock?
- How do orders align with the available stock?

To begin, I investigated the number of distinct product models in the database using the following query:

```sql
SELECT COUNT(DISTINCT productCode) AS "Number of Models"
FROM products;
```
| Number of Models |
|--------------|
| 110            | 


From this query, I discovered that there are **110 different product models** in the system.

Next, I examined the stock levels to determine which products had the highest and lowest quantity in stock:

```sql
SELECT 
    productCode, 
    productName, 
    quantityInStock
FROM 
    products
ORDER BY 
    quantityInStock DESC
LIMIT 1;
```

| Product Code | Product Name       | Quantity In Stock |
|--------------|--------------------|-------------------|
| S12_2823     | 2002 Suzuki XREO    | 9997              |
| ...     | ...    | ...               |
| S24_2000     | 1960 BSA Gold Star DBD34    | 15                |

From this query, we observe that the product with the largest stock is the **2002 Suzuki XREO**, with *9,997 units available*. This high inventory level may indicate strong demand or successful marketing efforts, positioning it as a staple product. Oppositely, the product with the **smallest stock is the 1960 BSA Gold Star DBD34**, with only **15 units** remaining. Such low inventory might suggest either limited demand or potential supply chain issues.

To further analyze our inventory, I turned my attention to the products' value based on their unit prices. Understanding the pricing of these products is crucial, as it can provide insights into profitability and market positioning. 

```sql
SELECT 
    productName, 
    buyPrice 
FROM 
    products
ORDER BY 
    buyPrice DESC 
LIMIT 1;

```
| Product Name                        | Buy Price |
|-------------------------------------|-----------|
| 1962 LanciaA Delta 16V              | 103.42    |
| ... | ...     |
| 1958 Chevy Corvette Limited Edition | 15.91     |

The results showed that the most expensive product by unit price is the **1962 Lancia Delta 16V**, with a unit purchase price of **103.42**. On the other hand, the cheapest product is the **1958 Chevy Corvette Limited Edition**, with a unit price of **15.91**.

To gain further insights, I calculated the total value of the products in stock by multiplying their unit prices by the number of units available.

```sql
SELECT 
    productName, 
    buyPrice, 
    quantityInStock, 
    (buyPrice * quantityInStock) AS totalValue
FROM 
    products
ORDER BY 
    totalValue DESC
LIMIT 5;
```

| Product Name                       | Buy Price | Quantity In Stock | Total Value   |
|------------------------------------|-----------|-------------------|---------------|
| 1995 Honda Civic                   | 93.89     | 9772              | 917493.08     |
| 1952 Alpine Renault 1300           | 98.58     | 7305              | 720126.90     |
| 1962 LanciaA Delta 16V             | 103.42    | 6791              | 702325.22     |
| 1968 Dodge Charger                  | 75.16     | 9123              | 685684.68     |
| 1976 Ford Gran Torino               | 73.49     | 9127              | 670743.23     |


This revealed that, although the **1995 Honda Civic** is not the most expensive product by unit price, it **has the highest accumulated stock value** due to the large quantity available. This insight is crucial for inventory management, as it indicates which product holds the most financial weight in stock.

After reviewing the stock, I turned my attention to the orders, aiming to understand which product was the most requested both in terms of units and in terms of popularity across different customers.

```sql
SELECT p.productCode, p.productName, 
    COUNT(od.productCode) AS totalOrders,
    COUNT(DISTINCT o.customerNumber) AS totalCustomers 
FROM
    orderdetails od
JOIN products p ON od.productCode = p.productCode
JOIN orders o ON od.orderNumber = o.orderNumber
GROUP BY p.productCode, p.productName
ORDER BY totalOrders DESC
LIMIT 3;
```

| productCode | productName                         | totalOrders | totalCustomers |
|-------------|-------------------------------------|-------------|----------------|
| S18_3232    | 1992 Ferrari 360 Spider red         | 53          | 40             |
| S10_1678    | 1969 Harley Davidson Ultimate Chopper | 28        | 26             |
| S10_1949    | 1952 Alpine Renault 1300            | 28          | 27             |
| ...         | ...                                 | ...         | ...            |
| S18_4933    | 1957 Ford Thunderbird               | 24          | 20             |

```sql
SELECT p.productCode, p.productName, SUM(od.quantityOrdered) AS totalQuantityOrdered
FROM orderdetails od
JOIN products p ON od.productCode = p.productCode
GROUP BY p.productCode, p.productName
ORDER BY totalQuantityOrdered desc
LIMIT 3;
```

| productCode | productName                         | totalQuantityOrdered |
|-------------|-------------------------------------|----------------------|
| S18_3232    | 1992 Ferrari 360 Spider red         | 1808                 |
| S18_1342    | 1937 Lincoln Berline                | 1111                 |
| S700_4002   | American Airlines: MD-11S           | 1085                 |
| ...         | ...                                 | ...                  |
| S18_4933    | 1957 Ford Thunderbird               | 767                  |

From the data, we can observe that the **1992 Ferrari 360 Spider** was the most ordered product, with *53 total orders* placed by **40 different customers**, demonstrating its popularity across a wide customer base. This model **also had the highest number of units ordered**, with a total of 1,808 units. On the other hand, the **1957 Ford Thunderbird** had the fewest units ordered, with only **767 units**.

It is also important to identify any product that did not receive any orders and has remained in stock.

```sql
SELECT p.productCode, p.productName
FROM products p
LEFT JOIN orderdetails od ON p.productCode = od.productCode
WHERE od.productCode IS NULL;
```

| productCode | productName           |
|-------------|-----------------------|
| S18_3233    | 1985 Toyota Supra     |

As seen in the data, the **1985 Toyota Supra** *did not register any orders*, indicating it remains unsold in our stock.

At this stage, it's important to gain a better understanding of our orders. One key point is determining whether the current stock can meet the quantities ordered.

```sql
SELECT p.productName AS "Product Name", 
       SUM(od.quantityOrdered) AS "Quantity Ordered",
       p.quantityInStock AS "Available Stock",
       CASE 
           WHEN p.quantityInStock - SUM(od.quantityOrdered) < 0 THEN 'Not enough Stock'
           ELSE 'OK'
       END AS "Status"
FROM
       orderdetails od
JOIN products p ON od.productCode = p.productCode
GROUP BY p.productCode, p.productName, p.quantityInStock;
```
| Product Name                               | Quantity Ordered | Available Stock | Situation         |
|--------------------------------------------|------------------|-----------------|-------------------|
| 1968 Ford Mustang                          | 933              | 68              | Not enough Stock  |
| 1911 Ford Town Car                         | 832              | 540             | Not enough Stock  |
| 1928 Mercedes-Benz SSK                     | 880              | 548             | Not enough Stock  |
| 1960 BSA Gold Star DBD34                   | 1015             | 15              | Not enough Stock  |
| 1997 BMW F650 ST                           | 1014             | 178             | Not enough Stock  |
| 1996 Peterbilt 379 Stake Bed with Outrigger | 988              | 814             | Not enough Stock  |
| 1928 Ford Phaeton Deluxe                   | 972              | 136             | Not enough Stock  |
| 2002 Yamaha YZR M1                         | 992              | 600             | Not enough Stock  |
| The Mayflower                              | 898              | 737             | Not enough Stock  |
| F/A 18 Hornet 1/72                         | 1047             | 551             | Not enough Stock  |
| Pont Yacht                                 | 958              | 414             | Not enough Stock  |


From this, we can conclude that there are **11 products** with **insufficient stock** to fulfill the registered orders.

Before examining our customers and collaborators, let’s look at the profit generated from these orders. 

```sql
SELECT 
    p.productName AS "Product Name",                              
    SUM(od.quantityOrdered * od.priceEach) AS revenue, 
    (SUM(od.quantityOrdered * od.priceEach) - SUM(od.quantityOrdered * p.buyPrice)) AS profit,
    ROUND(( (SUM(od.quantityOrdered * od.priceEach) - SUM(od.quantityOrdered * p.buyPrice)) / SUM(od.quantityOrdered * od.priceEach) ) * 100) AS profit_margin
FROM
    orderdetails od                             
JOIN products p ON od.productCode = p.productCode            
GROUP BY p.productCode, p.productName, p.buyPrice                
ORDER BY profit DESC
LIMIT 10;
```
| Product Name                               | Revenue      | Profit        | Profit Margin (%) |
|--------------------------------------------|--------------|---------------|--------------------|
| 1992 Ferrari 360 Spider red                | 276839.98    | 135996.78     | 49                 |
| 1952 Alpine Renault 1300                  | 190017.96    | 95282.58      | 50                 |
| 2001 Ferrari Enzo                          | 190755.86    | 93349.65      | 49                 |
| 2003 Harley-Davidson Eagle Drag Bike       | 170686.00    | 81031.30      | 47                 |
| 1968 Ford Mustang                          | 161531.48    | 72579.26      | 45                 |
| 1969 Ford Falcon                           | 152543.02    | 72399.77      | 47                 |
| 1928 Mercedes-Benz SSK                     | 132275.98    | 68423.18      | 52                 |
| 2002 Suzuki XREO                           | 135767.03    | 67641.47      | 50                 |
| 1980s Black Hawk Helicopter                | 144959.91    | 64599.11      | 45                 |
| 1948 Porsche Type 356 Roadster             | 121653.46    | 62725.78      | 52                 |
|...					     | ... 	    | ... 	    | ... 		 |
| 1939 Chevrolet Deluxe Coupe 		     | 28052.94     | 6904.85       | 25		 |


The **1992 Ferrari 360 Spider red** is the most profitable product, generating a *profit of 135,996.78* with a **profit margin of 49%**. Its high revenue potential makes it a key focus for sales strategies.

Interestingly, Both the **1968 Ford Mustang** and **1928 Mercedes-Benz SSK** stand out due to high demand but face stock shortages. The **Ford Mustang** has **933 units ordered** but only **68 available** in stock, while the **Mercedes-Benz SSK** has **880 units ordered** with only **548 available**. This deficit compromises potential profits and could impact customer satisfaction if not resolved. 
At the lower end of profitability, the **1939 Chevrolet Deluxe Coupe** generated the **least profit**, with *6,904.85* in profit and a **profit margin of 25%**. This may indicate an opportunity to either improve marketing, reduce costs, or focus efforts on more profitable models.
The high demand coupled with low available stock for various products indicates a need for improved inventory management strategies to capitalize on high-margin products.

- ### Order Volume Evolution
  
Another interesting aspect to analyze is how orders have varied over time. Our dataset spans from **January 2003 to May 2005**, and we aim to understand the evolution of order volume during this period.

```sql
SELECT 
    DATE_FORMAT(orderDate, '%Y-%m') AS "Month", 
    COUNT(orderNumber) AS "Total Orders"
FROM 
    orders
GROUP BY 
    DATE_FORMAT(orderDate, '%Y-%m')
ORDER BY 
    DATE_FORMAT(orderDate, '%Y-%m');
```


| Month     | 2003-01 | 2003-02 | 2003-03 | 2003-04 | 2003-05 | 2003-06 | 2003-07 | 2003-08 | 2003-09 | 2003-10 | 2003-11 | 2003-12 | 2004-01 | 2004-02 | 2004-03 | 2004-04 | 2004-05 | 2004-06 | 2004-07 | 2004-08 | 2004-09 | 2004-10 | 2004-11 | 2004-12 | 2005-01 | 2005-02 | 2005-03 | 2005-04 | 2005-05 |
|-----------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|
| Total Orders | 5       | 3       | 6       | 7       | 6       | 7       | 7       | 5       | 8       | 18      | 30      | 9       | 8       | 11      | 8       | 10      | 8       | 12      | 11      | 12      | 12      | 13      | 33      | 13      | 12      | 12      | 13      | 12      | 15      |

We observed that significant order volumes began to emerge towards the end of 2003. Notably, the months of November recorded the highest order volumes, with **30 orders in 2003** and **33 orders in 2004**.

It is also interesting to understand how long it takes for a product to be processed, that is, to be shipped.

``` sql
SELECT 
    DATE_FORMAT(orderDate, '%Y-%m') AS "Month", 
    round(AVG(DATEDIFF(shippedDate, orderDate))) AS "Avg Processing Time (Days)"
FROM
    orders
GROUP BY 
    DATE_FORMAT(orderDate, '%Y-%m')
ORDER BY 
    DATE_FORMAT(orderDate, '%Y-%m');
```


| Month     | 2003-01 | 2003-02 | 2003-03 | 2003-04 | 2003-05 | 2003-06 | 2003-07 | 2003-08 | 2003-09 | 2003-10 | 2003-11 | 2003-12 | 2004-01 | 2004-02 | 2004-03 | 2004-04 | 2004-05 | 2004-06 | 2004-07 | 2004-08 | 2004-09 | 2004-10 | 2004-11 | 2004-12 | 2005-01 | 2005-02 | 2005-03 | 2005-04 | 2005-05 |
|-----------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|---------|
| Avg Processing Time (Days) | 3       | 2       | 3       | 3       | 4       | 4       | 4       | 3       | 4       | 7       | 4       | 3       | 4       | 3       | 4       | 5       | 4       | 3       | 3       | 4       | 4       | 3       | 4       | 3       | 4       | 2       | 4       | 4       | 4       |

The average **processing time fluctuates throughout the dataset**, with some months experiencing lower averages and others showing higher averages.
The data reveals a general consistency in processing times, predominantly remaining **between 2 to 4 days** for most months.

- ### Employees and Customers

Moving forward with this analysis, let's take a deeper look at our clients and employees. We'll examine which employees have the most clients associated with them and who generated the highest revenue. Additionally, we'll explore our top-performing clients and determine where they are located.

```sql
SELECT 
    e.employeeNumber, e.firstName, e.lastName,
    COUNT(DISTINCT c.customerNumber) AS "Number of Clients",
    SUM(od.quantityOrdered * od.priceEach) AS revenue
FROM
    employees e
JOIN customers c on e.employeeNumber = c.salesRepEmployeeNumber
JOIN orders o on c.customerNumber = o.customerNumber
JOIN orderdetails od ON od.orderNumber = o.orderNumber
GROUP BY e.employeeNumber
ORDER BY revenue DESC;
```
| employeeNumber | firstName  | lastName  | Number of Clients | Revenue       |
|----------------|------------|-----------|-------------------|---------------|
| 1370           | Gerard     | Hernandez | 7                 | 1,258,577.81  |
| 1165           | Leslie     | Jennings  | 6                 | 1,081,530.54  |
| 1401           | Pamela     | Castillo  | 10                | 868,220.55    |
| 1501           | Larry      | Bott      | 8                 | 732,096.79    |
| 1504           | Barry      | Jones     | 9                 | 704,853.91    |
| 1323           | George     | Vanauf    | 8                 | 669,377.05    |
| 1612           | Peter      | Marsh     | 5                 | 584,593.76    |
| 1337           | Loui       | Bondur    | 6                 | 569,485.75    |
| 1611           | Andy       | Fixter    | 5                 | 562,582.59    |
| 1216           | Steve      | Patterson | 6                 | 505,875.42    |
| 1286           | Foon Yue   | Tseng     | 6                 | 488,212.67    |
| 1621           | Mami       | Nishi     | 5                 | 457,110.07    |
| 1702           | Martin     | Gerard    | 5                 | 387,477.47    |
| 1188           | Julie      | Firrelli  | 6                 | 386,663.20    |
| 1166           | Leslie     | Thompson  | 6                 | 347,533.03    |

From this, we can take away that **Gerard Hernandez** was the employee who generated the highest revenue of **1,258,577.81** *while managing 7 clients*. **Leslie Jennings** followed *closely behind, generating 1,081,530.54 from 6 clients*. **Pamela Castillo**, despite managing the **most clients (10)**, *generated a total revenue of 868,220.55*.  On the other side, the bottom employee in terms of revenue is **Leslie Thompson**, who managed **6 clients and generated 347,533.03**.

```sql
select count(distinct country) as "Number of Clients" from customers;
```
| Number of Clients | 
|-------------------|
|       27	    |

Delving into our clients we know that we have clients from **27** different countries, but it would be interesting to know which country holds the most clients, as well as the revenue by countrie.

```sql
SELECT 
    c.country, 
	count(distinct c.customerNumber) as clients,
    SUM(od.quantityOrdered * od.priceEach) AS revenue
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
join orderdetails od on o.orderNumber = od.orderNumber
GROUP BY c.country
ORDER BY revenue DESC
LIMIT 5;
```

| Country      | Clients | Revenue       |
|--------------|---------|---------------|
| USA          | 35      | 3,273,280.05  |
| Spain        | 5       | 1,099,389.09  |
| France       | 12      | 1,007,374.02  |
| Australia    | 5       | 562,582.59    |
| New Zealand  | 4       | 476,847.01    |
| ... 	       | ...     | ...           |
| Hong Kong    | 1 	 | 45,480.79      |

The **USA leads** significantly with **35 clients and a revenue of 3,273,280.05**, indicating a robust market presence. **Spain and France** generate substantial revenues of *1,099,389.09 and 1,007,374.02* respectively, despite having only 5 and 12 clients. Overall, **the USA is the dominant market**, while Spain and France showcase strong revenue performance with fewer clients. There are clear opportunities for growth in Australia and New Zealand. 

On the other **Hong Kong** has only **1 client**, contributing to its status as the *least profitable country in terms of revenue*, with a total revenue of **45,480.79**, the financial impact from this single client is minimal compared to more profitable countries.

```sql
SELECT 
    c.customerName, 
    c.country, 
    SUM(od.quantityOrdered * od.priceEach) AS revenue
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od on o.orderNumber = od.orderNumber
GROUP BY c.customerName, c.country
ORDER BY revenue DESC
LIMIT 5;
```
| Customer Name                     | Country | Revenue      |
|-----------------------------------|---------|--------------|
| Euro+ Shopping Channel            | Spain   | 820,689.54   |
| Mini Gifts Distributors Ltd.      | USA     | 591,827.34   |
| Australian Collectors, Co.        | Australia| 180,585.07   |
| Muscle Machine Inc                | USA     | 177,913.95   |
| La Rochelle Gifts                 | France  | 158,573.12   |
| ... 				    | ...     | ...	     |
| Boards & Toys Co.		    | USA     | 7,918.60     |

The **Euro+ Shopping Channel** in Spain stands out as the highest revenue generator at **820,689.54**. The USA contributes significantly through **Mini Gifts Distributors Ltd.** and **Muscle Machine Inc.**, generating a combined **769,741.29**. Notably, Australia and France also have clients among the top five, indicating a diverse market. The revenue disparity suggests a need to nurture high-value client relationships. At the end of the list, we encounter **Boards & Toys Co.** from the USA, as the customer with less revenue, generating **7,918.60**.

# Summary of Findings

## Warehouse and Inventory Analysis
We currently have **four operational warehouses** with a total inventory of **555,131 items** spread across seven product lines. The South Warehouse manages the most product lines, but inventory utilization differs by location:
- **East Warehouse**: 67% utilized (**219,183 items**)
- **North Warehouse**: 72% utilized (**131,688 items**)
- **West Warehouse**: 50% utilized (**124,880 items**)
- **South Warehouse**: 75% utilized (**79,380 items**)

## Potential Warehouse Optimization
I’m considering a proposal to eliminate the **South Warehouse** and redistribute its product lines (Ships, Trains, Trucks, and Buses) to the **North** and **West Warehouses**. After optimization, the utilization rates would look like this:
- **North**: 87% (after adding Ships)
- **West**: 71% (after adding Trains, Trucks, and Buses)
- **East**: 67%   (would remain the same) 

## Inventory and Sales Analysis
In our analysis, we found **110 distinct product models**, with stock levels varying quite a bit:
- The **2002 Suzuki XREO** has the highest stock with **9,997 units**, while the **1960 BSA Gold Star DBD34** only has **15 units**.
- The most expensive item in our inventory, based on purchase cost, is the **1962 Lancia Delta 16V**, bought at **103.42**.
- The highest profit came from the **1992 Ferrari 360 Spider red**, bringing in **135,996.78** from **1,808 units** sold.

## Order Volume Evolution
We saw a significant increase in order volumes starting in late **2003**, with peaks in:
- **November 2003**: 30 orders
- **November 2004**: 33 orders
- Our **shipping times** have been fairly consistent, averaging between **2 to 4 days**.

## Customer and Employee Analysis
When looking at employee performance by revenue and client count:
- We have clients in **27** countries, with the **USA** leading in customer count at **35** clients.
- **Gerard Hernandez** came out on top, generating **$1,258,577.81** from **7 clients**.




