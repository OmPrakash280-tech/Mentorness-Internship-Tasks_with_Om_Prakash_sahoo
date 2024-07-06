-- Database: hotel_reservations

-- DROP DATABASE IF EXISTS hotel_reservations;

CREATE DATABASE hotel_reservations
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'English_India.1252'
    LC_CTYPE = 'English_India.1252'
    LOCALE_PROVIDER = 'libc'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;

\connect hotel_reservations

-- Create the reservations table
CREATE TABLE reservations (
    Booking_ID VARCHAR PRIMARY KEY,
    no_of_adults INT,
    no_of_children INT,
    no_of_weekend_nights INT,
    no_of_week_nights INT,
    type_of_meal_plan VARCHAR,
    room_type_reserved VARCHAR,
    lead_time INT,
    arrival_date DATE,
    market_segment_type VARCHAR,
    avg_price_per_room DECIMAL,
    booking_status VARCHAR
);

-- Load the data from the CSV file
COPY reservations FROM 'C:\Users\Public\Hotel Reservation Dataset.csv' DELIMITER ',' CSV HEADER;

-- Question 1: Total number of reservations
SELECT COUNT(*) AS total_reservations FROM reservations;

-- Question 2: Most popular meal plan
SELECT type_of_meal_plan, COUNT(*) AS count
FROM reservations
GROUP BY type_of_meal_plan
ORDER BY count DESC
LIMIT 1;

-- Question 3: Average price per room for reservations involving children
SELECT AVG(avg_price_per_room) AS avg_price
FROM reservations
WHERE no_of_children > 0;

-- Question 4: Reservations made for the year 20XX (replace XX with the desired year, e.g., 2022)
SELECT COUNT(*) AS reservations_2022
FROM reservations
WHERE EXTRACT(YEAR FROM arrival_date) = 2022;

-- Question 5: Most commonly booked room type
SELECT room_type_reserved, COUNT(*) AS count
FROM reservations
GROUP BY room_type_reserved
ORDER BY count DESC
LIMIT 1;

-- Question 6: Reservations on a weekend
SELECT COUNT(*) AS weekend_reservations
FROM reservations
WHERE no_of_weekend_nights > 0;

-- Question 7: Highest and lowest lead time
SELECT MAX(lead_time) AS highest_lead_time, MIN(lead_time) AS lowest_lead_time
FROM reservations;

-- Question 8: Most common market segment type
SELECT market_segment_type, COUNT(*) AS count
FROM reservations
GROUP BY market_segment_type
ORDER BY count DESC
LIMIT 1;

-- Question 9: Confirmed reservations
SELECT COUNT(*) AS confirmed_reservations
FROM reservations
WHERE booking_status = 'Confirmed';

-- Question 10: Total number of adults and children
SELECT SUM(no_of_adults) AS total_adults, SUM(no_of_children) AS total_children
FROM reservations;

-- Question 11: Average number of weekend nights for reservations involving children
SELECT AVG(no_of_weekend_nights) AS avg_weekend_nights
FROM reservations
WHERE no_of_children > 0;

-- Question 12: Reservations per month
SELECT EXTRACT(MONTH FROM arrival_date) AS month, COUNT(*) AS reservations
FROM reservations
GROUP BY month
ORDER BY month;

-- Question 13: Average number of nights by room type
SELECT room_type_reserved,
       AVG(no_of_weekend_nights + no_of_week_nights) AS avg_nights
FROM reservations
GROUP BY room_type_reserved;

-- Question 14: Most common room type for reservations involving children and average price
SELECT room_type_reserved, COUNT(*) AS count, AVG(avg_price_per_room) AS avg_price
FROM reservations
WHERE no_of_children > 0
GROUP BY room_type_reserved
ORDER BY count DESC
LIMIT 1;

-- Question 15: Market segment type with the highest average price per room
SELECT market_segment_type, AVG(avg_price_per_room) AS avg_price
FROM reservations
GROUP BY market_segment_type
ORDER BY avg_price DESC
LIMIT 1;