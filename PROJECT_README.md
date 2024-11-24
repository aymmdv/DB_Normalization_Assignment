# Database Normalization Assignment

This project demonstrates the normalization of a database into 1NF, 2NF, and 3NF using PostgreSQL. The database contains data about books used in different courses, including information about authors, publishers, and more. The process includes creating tables, normalizing data step-by-step, and verifying the results.

## Steps Included

### 1. Unnormalized Table
- Created an initial table (`Unnormalized`) based on provided data in `unnormalized.csv`.
- Loaded data into the table using the `COPY` command.

### 2. Normalization
- **1NF**:
  - Split multivalued attributes (e.g., `Authors`) into atomic values.
  - Created separate tables: `Courses` and `Books`.

- **2NF**:
  - Removed partial dependencies.
  - Created a linking table: `Course_Books`.

- **3NF**:
  - Removed transitive dependencies.
  - Created a `Publishers` table to store publisher details and linked it to the `Books` table.

### 3. Verification
- Verified the correctness of the data by selecting records from all tables using `SELECT` queries.

## Database Schema
The final schema includes the following tables:
1. **Unnormalized**: Initial unnormalized data.
2. **Courses**: Contains course details (`CRN`, `Course_Name`).
3. **Books**: Contains book details (`ISBN`, `Title`, `Authors`, `Edition`, `Publisher_ID`, `Pages`, `Year`).
4. **Course_Books**: Links courses and books (`CRN`, `ISBN`).
5. **Publishers**: Contains publisher details (`Publisher_ID`, `Publisher`, `Publisher_Address`).

## How to Run the Script

### Prerequisites
1. Install PostgreSQL on your system.
2. Ensure that you have administrative access to create databases and users.

### Steps
1. Place the CSV file (`unnormalized.csv`) in the `/tmp/` directory.
2. Open a terminal and log in to PostgreSQL:
   ```bash
   psql -U aytanmammadova or [your_postgres_username]
