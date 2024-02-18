create schema uber;

use uber;

select * from rides;
select * from drivers;
select * from passangers;

select count(*) from rides;
select count(*) from drivers;
select count(*) from passangers;

#Basic Level-->

#Q1: What are & how many unique pickup locations are there in the dataset?
SELECT DISTINCT pickup_location 
FROM Rides;

SELECT COUNT(DISTINCT pickup_location) 
FROM Rides;

#Q2: What is the total number of rides in the dataset?
SELECT COUNT(*) 
FROM Rides;

#Q3: Calculate the average ride duration.
SELECT AVG(ride_duration) 
FROM Rides;

#Q4: List the top 5 drivers based on their total earnings.
SELECT driver_id, SUM(earnings) AS total_earnings 
FROM Drivers 
GROUP BY driver_id 
ORDER BY total_earnings DESC LIMIT 5;

#Q5: Calculate the total number of rides for each payment method.
SELECT payment_method, COUNT(*) AS ride_count 
FROM Rides 
GROUP BY payment_method;

#Q6: Retrieve rides with a fare amount greater than 20.
SELECT * 
FROM Rides
WHERE fare_amount > 20;

#Q7: Identify the most common pickup location.
SELECT pickup_location, COUNT(*) AS ride_count 
FROM Rides 
GROUP BY pickup_location 
ORDER BY ride_count DESC LIMIT 1;

#Q8: Calculate the average fare amount.
SELECT AVG(fare_amount)
FROM Rides;

#Q9: List the top 10 drivers with the highest average ratings.
SELECT driver_id, avg(rating) as avg_rating 
FROM drivers 
GROUP BY driver_id 
order by avg_rating DESC LIMIT 10;

#Q10: Calculate the total earnings for all drivers.
SELECT SUM(earnings) 
FROM Drivers;

#Q11: How many rides were paid using the "Cash" payment method?
SELECT COUNT(*) 
FROM Rides 
WHERE payment_method = 'Cash';

#Q12: Calculate the number of rides & average ride distance for rides originating from the 'Dhanbad' pickup location.
SELECT count(*), AVG(ride_distance) 
FROM Rides 
WHERE pickup_location = 'Dhanbad';

#Q13: Retrieve rides with a ride duration less than 10 minutes.
SELECT * 
FROM Rides 
WHERE ride_duration < 10;

#Q14: List the passengers who have taken the most number of rides.
SELECT passenger_id, COUNT(*) AS ride_count 
FROM Rides GROUP BY passenger_id 
ORDER BY ride_count DESC LIMIT 1;

#Q15: Calculate the total number of rides for each driver in descending order.
SELECT driver_id, COUNT(*) AS ride_count 
FROM Rides 
GROUP BY driver_id 
ORDER BY ride_count DESC;

#Q16: Identify the payment methods used by passengers who took rides from the 'Gandhinagar' pickup location.
SELECT DISTINCT payment_method 
FROM Rides 
WHERE pickup_location = 'Gandhinagar';

#Q17: Calculate the average fare amount for rides with a ride distance greater than 10.
SELECT AVG(fare_amount) 
FROM Rides 
WHERE ride_distance > 10;

#Q18: List the drivers in descending order accordinh to their total number of rides.
SELECT driver_id, total_rides
FROM Drivers 
order by total_rides DESC;

#Q19: Calculate the percentage distribution of rides for each pickup location.
SELECT pickup_location, COUNT(*) AS ride_count, ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Rides), 2) AS percentage 
FROM Rides 
GROUP BY pickup_location
order by percentage desc;

#Q20: Retrieve rides where both pickup and dropoff locations are the same.
SELECT * 
FROM Rides 
WHERE pickup_location = dropoff_location;

#Intermediate Level-->

#Q1: List the passengers who have taken rides from at least 300 different pickup locations.
SELECT passenger_id, COUNT(DISTINCT pickup_location) AS distinct_locations
FROM Rides
GROUP BY passenger_id
HAVING distinct_locations >= 300;

#Q2: Calculate the average fare amount for rides taken on weekdays.
SELECT AVG(fare_amount)
FROM Rides
WHERE DAYOFWEEK(STR_TO_DATE(ride_timestamp, '%m/%d/%Y %H:%i'))>5;

#Q3: Identify the drivers who have taken rides with distances greater than 19.
SELECT DISTINCT driver_id
FROM Rides
WHERE ride_distance > 19;

#Q4: Calculate the total earnings for drivers who have completed more than 100 rides.
SELECT driver_id, SUM(earnings) AS total_earnings
FROM Drivers
WHERE driver_id IN (SELECT driver_id FROM Rides GROUP BY driver_id HAVING COUNT(*) > 100)
GROUP BY driver_id;

#Q5: Retrieve rides where the fare amount is less than the average fare amount.
SELECT * 
FROM Rides
WHERE fare_amount < (SELECT AVG(fare_amount) FROM Rides);

#Q6: Calculate the average rating of drivers who have driven rides with both 'Credit Card' and 'Cash' payment methods.
SELECT driver_id, AVG(rating) AS avg_rating
FROM drivers
WHERE driver_id IN (SELECT driver_id FROM Rides WHERE payment_method IN ('Credit Card', 'Cash') GROUP BY driver_id HAVING COUNT(DISTINCT payment_method) = 2)
GROUP BY driver_id;

#Q7: List the top 3 passengers with the highest total spending.
SELECT p.passenger_id, p.passenger_name, SUM(r.fare_amount) AS total_spending
FROM Passangers p
JOIN Rides r ON p.passenger_id = r.passenger_id
GROUP BY p.passenger_id, p.passenger_name
ORDER BY total_spending DESC
LIMIT 3;

#Q8: Calculate the average fare amount for rides taken during different months of the year.
SELECT MONTH(STR_TO_DATE(ride_timestamp, '%m/%d/%Y %H:%i')) AS month_of_year, AVG(fare_amount) AS avg_fare
FROM Rides
GROUP BY month_of_year;

#Q9: Identify the most common pair of pickup and dropoff locations.
SELECT pickup_location, dropoff_location, COUNT(*) AS ride_count
FROM Rides
GROUP BY pickup_location, dropoff_location
ORDER BY ride_count DESC
LIMIT 1;

#Q10: Calculate the total earnings for each driver and order them by earnings in descending order.
SELECT driver_id, SUM(earnings) AS total_earnings
FROM drivers
GROUP BY driver_id
ORDER BY total_earnings DESC;

#Q11: List the passengers who have taken rides on their signup date.
SELECT p.passenger_id, p.passenger_name
FROM Passangers p
JOIN Rides r ON p.passenger_id = r.passenger_id
WHERE DATE(p.signup_date) = DATE(r.ride_timestamp);

#Q12: Calculate the average earnings for each driver and order them by earnings in descending order.
SELECT driver_id, avg(earnings) AS average_earnings
FROM drivers
GROUP BY driver_id
ORDER BY average_earnings DESC;

#Q13: Retrieve rides with distances less than the average ride distance.
SELECT * 
FROM Rides
WHERE ride_distance < (SELECT AVG(ride_distance) FROM Rides);

#Q14: List the drivers who have completed the least number of rides.
SELECT driver_id, COUNT(*) AS ride_count
FROM Rides
GROUP BY driver_id
ORDER BY ride_count ASC;

#Q15: Calculate the average fare amount for rides taken by passengers who have taken at least 20 rides.
SELECT AVG(fare_amount)
FROM Rides
WHERE passenger_id IN (SELECT passenger_id FROM Rides GROUP BY passenger_id HAVING COUNT(*) >= 20);

#Q16: Identify the pickup location with the highest average fare amount.
SELECT pickup_location, AVG(fare_amount) AS avg_fare
FROM Rides
GROUP BY pickup_location
ORDER BY avg_fare DESC
LIMIT 1;

#Q17: Calculate the average rating of drivers who completed at least 100 rides.
SELECT AVG(rating)
FROM Drivers
WHERE driver_id IN (
    SELECT driver_id
    FROM Rides
    GROUP BY driver_id
    HAVING COUNT(*) >= 100
);

#Q18: List the passengers who have taken rides from at least 5 different pickup locations.
SELECT passenger_id, COUNT(DISTINCT pickup_location) AS distinct_locations
FROM Rides
GROUP BY passenger_id
HAVING distinct_locations >= 5;

#Q19: Calculate the average fare amount for rides taken by passengers with ratings above 4.
SELECT AVG(fare_amount)
FROM Rides
WHERE passenger_id IN (
    SELECT passenger_id
    FROM Passangers
    WHERE rating > 4
);

#Q20: Retrieve rides with the shortest ride duration in each pickup location.
SELECT r1.*
FROM Rides r1
JOIN (
    SELECT pickup_location, MIN(ride_duration) AS min_duration
    FROM Rides
    GROUP BY pickup_location
) r2 ON r1.pickup_location = r2.pickup_location AND r1.ride_duration = r2.min_duration;

#Advanced Level-->

#Q1: List the drivers who have driven rides in all pickup locations.
SELECT driver_id
FROM Drivers
WHERE driver_id NOT IN (
    SELECT DISTINCT driver_id
    FROM Rides
    WHERE pickup_location NOT IN (
        SELECT DISTINCT pickup_location
        FROM Rides
    )
);

#Q2: Calculate the average fare amount for rides taken by passengers who have spent more than 300 in total.
SELECT AVG(fare_amount)
FROM Rides
WHERE passenger_id IN (SELECT passenger_id FROM Passangers WHERE total_spent > 300);

#Q3: List the bottom 5 drivers based on their average earnings.
SELECT driver_id, avg(earnings) AS avg_earnings 
FROM Drivers 
GROUP BY driver_id 
ORDER BY avg_earnings LIMIT 5;

#Q4: Calculate the sum fare amount for rides taken by passengers who have taken rides in different payment methods.
SELECT SUM(fare_amount)
FROM Rides
WHERE passenger_id IN (
    SELECT passenger_id
    FROM Rides
    GROUP BY passenger_id
    HAVING COUNT(DISTINCT payment_method) > 1
);

#Q5: Retrieve rides where the fare amount is significantly above the average fare amount.
SELECT *
FROM Rides
WHERE fare_amount > (SELECT AVG(fare_amount) * 1.5 FROM Rides);

#Q6: List the drivers who have completed rides on the same day they joined.
SELECT d.driver_id, d.driver_name
FROM Drivers d
JOIN Rides r ON d.driver_id = r.driver_id
WHERE DATE(d.join_date) = DATE(r.ride_timestamp);

#Q7: Calculate the average fare amount for rides taken by passengers who have taken rides in different payment methods.
SELECT AVG(fare_amount)
FROM Rides
WHERE passenger_id IN (
    SELECT passenger_id
    FROM Rides
    GROUP BY passenger_id
    HAVING COUNT(DISTINCT payment_method) > 1
);

#Q8: Identify the pickup location with the highest percentage increase in average fare amount compared to the overall average fare.
SELECT pickup_location, AVG(fare_amount) AS avg_fare,
       (AVG(fare_amount) - (SELECT AVG(fare_amount) FROM Rides)) * 100.0 / (SELECT AVG(fare_amount) FROM Rides) AS percentage_increase
FROM Rides
GROUP BY pickup_location
ORDER BY percentage_increase DESC
LIMIT 1;

#Q9: Retrieve rides where the dropoff location is the same as the pickup location.
SELECT *
FROM Rides
WHERE pickup_location = dropoff_location;

#Q10: Calculate the average rating of drivers who have driven rides with varying pickup locations.
SELECT AVG(rating)
FROM Drivers
WHERE driver_id IN (
    SELECT DISTINCT driver_id
    FROM Rides
    GROUP BY driver_id
    HAVING COUNT(DISTINCT pickup_location) > 1
);















