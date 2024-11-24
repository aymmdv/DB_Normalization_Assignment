# Database Normalization Assignment

This project demonstrates the process of normalizing a database into 1NF, 2NF, and 3NF using PostgreSQL. It includes creating tables, loading data from a CSV file, performing normalization, and verifying the results.

## Project Overview
The project is structured as follows:
- **Unnormalized Table**: Raw data is loaded from `unnormalized.csv`.
- **Normalization**:
  - **1NF**: Split multivalued attributes into atomic values.
  - **2NF**: Removed partial dependencies by creating linking tables.
  - **3NF**: Removed transitive dependencies by introducing a separate `Publishers` table.
- **Verification**: Ensures correctness by querying normalized tables.

## Database Schema
The final schema consists of the following tables:
1. **Unnormalized**: The initial table containing raw data.
2. **Courses**: Stores course details (`CRN`, `Course_Name`).
3. **Books**: Stores book details (`ISBN`, `Title`, `Authors`, `Edition`, `Publisher_ID`, `Pages`, `Year`).
4. **Course_Books**: A linking table between courses and books (`CRN`, `ISBN`).
5. **Publishers**: Stores publisher details (`Publisher_ID`, `Publisher`, `Publisher_Address`).

## How to Run the Project

### Prerequisites
1. Install PostgreSQL on your system.
2. Ensure you have administrative access to create and manage databases.

### Steps to Run
1. Clone this repository to your local system:
   ```bash
   git clone https://github.com/aymmdv/DB_Normalization_Assignment.git
Place the unnormalized.csv file in the /tmp/ directory of your system.
Open a terminal and log into PostgreSQL:
bash
Copy code
psql -U aytanmammadova or [your_postgres_username]
Create a new database:
sql
Copy code
CREATE DATABASE NormalizationDB;
Switch to the newly created database:
bash
Copy code
\c NormalizationDB
Execute the SQL script:
bash
Copy code
\i script.sql
Expected Output
Tables will be created successfully.
Data will be loaded and normalized into 1NF, 2NF, and 3NF.
Verification queries will display the first 10 rows from each table:
Courses
Books
Course_Books
Publishers
Files Included
script.sql: Contains all SQL commands to create, normalize, and verify the database.
unnormalized.csv: Input file containing raw data.
Verification Queries
Use the following SQL queries to verify the results:

sql
Copy code
SELECT * FROM Courses LIMIT 10;
SELECT * FROM Books LIMIT 10;
SELECT * FROM Publishers LIMIT 10;
SELECT * FROM Course_Books LIMIT 10;
Author
Aytan Mammadova
