-- Creating the 'bookings' Table in the Hotel Database
CREATE TABLE bookings (
    booking_id VARCHAR(20) PRIMARY KEY NOT NULL UNIQUE,
    number_of_adults INT NOT NULL,
    number_of_children INT NOT NULL,
    number_of_weekend_nights INT NOT NULL,
    number_of_week_nights INT NOT NULL,
    type_of_meal VARCHAR(30) NOT NULL,
    car_parking_space INT NOT NULL,
    room_type VARCHAR(30) NOT NULL,
    lead_time INT NOT NULL,
    market_segment_type VARCHAR(30),
    repeated INT NOT NULL,
    p_c INT NOT NULL,
    p_not_c INT NOT NULL,
    average_price DECIMAL(10, 2) NOT NULL,
    special_requests INT NOT NULL,
    date_of_reservation TIMESTAMP NOT NULL,
    booking_status VARCHAR(30) NOT NULL
);

-- Displaying the contents of the 'bookings' table
SELECT * FROM bookings;

-- Checking the unique years present in the dataset
SELECT DISTINCT EXTRACT(YEAR FROM date_of_reservation) AS Year FROM bookings;

-- Summary statistics for the dataset
SELECT
    COUNT(*) AS "Total Bookings",
    SUM(repeated) AS "Repeat Bookings",
    SUM(number_of_week_nights) AS "Total Week Nights",
    SUM(number_of_weekend_nights) AS "Total Weekend Nights",
    SUM(special_requests) AS "Total Special Requests",
    COUNT(*) FILTER (WHERE booking_status = 'Not_Canceled') AS "Not Canceled Bookings",
    COUNT(*) FILTER (WHERE booking_status = 'Canceled') AS "Canceled Bookings"
FROM bookings;

-- Booking and cancellation activity breakdown by year
SELECT
    EXTRACT(YEAR FROM date_of_reservation) AS Year,
    COUNT(*) AS "Total Bookings",
    COUNT(*) FILTER (WHERE booking_status = 'Not_Canceled') AS "Not Canceled Bookings",
    COUNT(*) FILTER (WHERE booking_status = 'Canceled') AS "Canceled Bookings",
    ROUND((COUNT(*) FILTER (WHERE booking_status = 'Canceled') / COUNT(*)::numeric) * 100, 1) AS "Cancellation Rate (%)"
FROM bookings
GROUP BY EXTRACT(YEAR FROM date_of_reservation)
ORDER BY "Total Bookings" DESC;

-- Monthly booking activity breakdown
SELECT
    TO_CHAR(date_of_reservation, 'Month') AS "Month of Booking",
    COUNT(*) AS "Total Monthly Bookings"
FROM bookings
GROUP BY TO_CHAR(date_of_reservation, 'Month')
ORDER BY "Total Monthly Bookings" DESC;

-- Monthly cancellation activity breakdown
SELECT
    TO_CHAR(date_of_reservation, 'Month') AS "Month of Booking",
    COUNT(*) AS "Total Monthly Cancellations"
FROM bookings
WHERE booking_status = 'Canceled'
GROUP BY TO_CHAR(date_of_reservation, 'Month')
ORDER BY "Total Monthly Cancellations" DESC;

-- Comparison of Canceled and Not Canceled bookings
SELECT
    TO_CHAR(date_of_reservation, 'Month') AS "Booking Month",
    COUNT(*) AS "Total Bookings",
    COUNT(*) FILTER (WHERE booking_status = 'Not_Canceled') AS "Not Canceled Bookings",
    COUNT(*) FILTER (WHERE booking_status = 'Canceled') AS "Canceled Bookings",
    ROUND((COUNT(*) FILTER (WHERE booking_status = 'Canceled') / COUNT(*)::numeric) * 100, 1) AS "Cancellation Rate (%)"
FROM bookings
GROUP BY TO_CHAR(date_of_reservation, 'Month')
ORDER BY "Total Bookings" DESC;

-- Preferred meal types
SELECT
    type_of_meal AS "Meal Type",
    COUNT(*) AS "Total Bookings"
FROM bookings
GROUP BY type_of_meal
ORDER BY "Total Bookings" DESC;

-- Impact of the number of children on bookings and special requests
SELECT
    number_of_children AS "Number of Children",
    COUNT(*) AS "Total Bookings",
    SUM(number_of_week_nights) AS "Total Week Nights",
    SUM(number_of_weekend_nights) AS "Total Weekend Nights",
    SUM(special_requests) AS "Total Special Requests",
    COUNT(*) FILTER (WHERE booking_status = 'Not_Canceled') AS "Not Canceled Bookings",
    COUNT(*) FILTER (WHERE booking_status = 'Canceled') AS "Canceled Bookings"
FROM bookings
GROUP BY number_of_children
ORDER BY "Number of Children" DESC;

-- Most booked/preferred room types
SELECT
    room_type AS "Room Type",
    COUNT(*) AS "Total Bookings",
    COUNT(*) FILTER (WHERE booking_status = 'Not_Canceled') AS "Not Canceled Bookings",
    COUNT(*) FILTER (WHERE booking_status = 'Canceled') AS "Canceled Bookings",
    ROUND(AVG(average_price), 1) AS "Average Price",
    COUNT(*) * ROUND(AVG(average_price), 1) AS "Average Revenue Before Cancellation",
    COUNT(*) FILTER (WHERE booking_status = 'Not_Canceled') * ROUND(AVG(average_price), 1) AS "Actual Average Revenue",
    COUNT(*) FILTER (WHERE booking_status = 'Canceled') * ROUND(AVG(average_price), 1) AS "Average Revenue Loss",
    ROUND((COUNT(*) FILTER (WHERE booking_status = 'Canceled') * ROUND(AVG(average_price), 1)) /
        (COUNT(*) * ROUND(AVG(average_price), 1)) * 100, 1) AS "Average % Revenue Loss"
FROM bookings
GROUP BY "Room Type"
ORDER BY "Total Bookings" DESC;
