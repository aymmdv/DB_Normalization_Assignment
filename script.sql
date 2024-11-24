-- Drop all existing tables to avoid conflicts during re-execution
DROP TABLE IF EXISTS Course_Books CASCADE;
DROP TABLE IF EXISTS Books CASCADE;
DROP TABLE IF EXISTS Courses CASCADE;
DROP TABLE IF EXISTS Publishers CASCADE;
DROP TABLE IF EXISTS Unnormalized CASCADE;

-- Step 1: Create the unnormalized table
CREATE TABLE Unnormalized (
    CRN INT,
    ISBN BIGINT,
    Title VARCHAR(255),
    Authors TEXT,
    Edition INT,
    Publisher VARCHAR(255),
    Publisher_Address TEXT,
    Pages INT,
    Year INT,
    Course_Name VARCHAR(255),
    PRIMARY KEY (CRN, ISBN)
);

-- Step 2: Load data from the CSV file
COPY Unnormalized
FROM '/tmp/unnormalized.csv'
DELIMITER ','
CSV HEADER;

-- Step 3: Normalize to 1NF - Create Courses and Books tables
CREATE TABLE Courses (
    CRN INT PRIMARY KEY,
    Course_Name VARCHAR(255)
);

CREATE TABLE Books (
    ISBN BIGINT PRIMARY KEY,
    Title VARCHAR(255),
    Authors TEXT,
    Edition INT,
    Publisher VARCHAR(255),
    Publisher_Address TEXT,
    Pages INT,
    Year INT
);

-- Populate the Courses table
INSERT INTO Courses (CRN, Course_Name)
SELECT DISTINCT CRN, Course_Name FROM Unnormalized;

-- Populate the Books table
INSERT INTO Books (ISBN, Title, Authors, Edition, Publisher, Publisher_Address, Pages, Year)
SELECT DISTINCT ISBN, Title, Authors, Edition, Publisher, Publisher_Address, Pages, Year
FROM Unnormalized;

-- Step 4: Normalize to 2NF - Create the Course_Books linking table
CREATE TABLE Course_Books (
    CRN INT,
    ISBN BIGINT,
    PRIMARY KEY (CRN, ISBN),
    FOREIGN KEY (CRN) REFERENCES Courses(CRN),
    FOREIGN KEY (ISBN) REFERENCES Books(ISBN)
);

-- Populate the Course_Books linking table
INSERT INTO Course_Books (CRN, ISBN)
SELECT DISTINCT CRN, ISBN FROM Unnormalized;

-- Step 5: Normalize to 3NF - Create the Publishers table
CREATE TABLE Publishers (
    Publisher_ID SERIAL PRIMARY KEY,
    Publisher VARCHAR(255),
    Publisher_Address TEXT
);

-- Populate the Publishers table
INSERT INTO Publishers (Publisher, Publisher_Address)
SELECT DISTINCT Publisher, Publisher_Address FROM Books;

-- Update the Books table to link it to the Publishers table
ALTER TABLE Books ADD COLUMN Publisher_ID INT;

UPDATE Books
SET Publisher_ID = (
    SELECT Publisher_ID
    FROM Publishers
    WHERE Publishers.Publisher = Books.Publisher
);

-- Remove redundant columns Publisher and Publisher_Address from the Books table
ALTER TABLE Books DROP COLUMN Publisher;
ALTER TABLE Books DROP COLUMN Publisher_Address;

-- Add a foreign key to connect Books and Publishers
ALTER TABLE Books ADD FOREIGN KEY (Publisher_ID) REFERENCES Publishers(Publisher_ID);

-- Verification: Select data from all tables
SELECT * FROM Unnormalized LIMIT 10;
SELECT * FROM Courses LIMIT 10;
SELECT * FROM Books LIMIT 10;
SELECT * FROM Course_Books LIMIT 10;
SELECT * FROM Publishers LIMIT 10;
