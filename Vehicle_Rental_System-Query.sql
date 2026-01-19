CREATE DATABASE vehicle_rental_system;


---- Users Table -----
CREATE TYPE user_role_enum AS enum('Admin', 'Customer');


CREATE TABLE Users (
  user_id serial PRIMARY KEY,
  name varchar(150) NOT NULL,
  email varchar(50) UNIQUE NOT NULL,
  password varchar(50),
  phone varchar(20) NOT NULL,
  role user_role_enum NOT NULL
);


------ Vehicles Table -------
CREATE TYPE vehicle_type_enum AS enum('car', 'bike', 'truck');


CREATE TYPE status_enum AS enum('available', 'rented', 'maintenance');


CREATE TABLE Vehicles (
  vehicle_id serial PRIMARY KEY,
  name varchar(150) NOT NULL,
  type vehicle_type_enum NOT NULL,
  model int4 NOT NULL,
  registration_number varchar(50) UNIQUE NOT NULL,
  rental_price integer NOT NULL,
  availability_status status_enum NOT NULL
);


------ Bookings Table -------
CREATE TYPE booking_status_enum AS enum('pending', 'confirmed', 'completed', 'cancelled');


CREATE TABLE bookings (
  booking_id serial PRIMARY KEY,
  user_id integer REFERENCES Users (user_id) NOT NULL,
  vehicle_id integer REFERENCES Vehicles (vehicle_id) NOT NULL,
  start_date date DEFAULT now(),
  end_date date DEFAULT now(),
  booking_status booking_status_enum NOT NULL,
  total_cost integer NOT NULL
);


------ INSERT DATA ------
INSERT INTO
  users (user_id, name, email, phone, role)
VALUES
  (
    1,
    'Alice',
    'alice@example.com',
    '1234567890',
    'Customer'
  ),
  (
    2,
    'Bob',
    'bob@example.com',
    '0987654321',
    'Admin'
  ),
  (
    3,
    'Charlie',
    'charlie@example.com',
    '1122334455',
    'Customer'
  );


INSERT INTO
  vehicles (
    vehicle_id,
    name,
    type,
    model,
    registration_number,
    rental_price,
    availability_status
  )
VALUES
  (
    1,
    'Toyota Corolla',
    'car',
    2022,
    'ABC-123',
    50,
    'available'
  ),
  (
    2,
    'Honda Civic',
    'car',
    2021,
    'DEF-456',
    60,
    'rented'
  ),
  (
    3,
    'Yamaha R15',
    'bike',
    2023,
    'GHI-789',
    30,
    'available'
  ),
  (
    4,
    'Ford F-150',
    'truck',
    2020,
    'JKL-012',
    100,
    'maintenance'
  );


INSERT INTO
  bookings (
    booking_id,
    user_id,
    vehicle_id,
    start_date,
    end_date,
    booking_status,
    total_cost
  )
VALUES
  (
    1,
    1,
    2,
    '2023-10-01',
    '2023-10-05',
    'completed',
    240
  ),
  (
    2,
    1,
    2,
    '2023-11-01',
    '2023-11-03',
    'completed',
    120
  ),
  (
    3,
    3,
    2,
    '2023-12-01',
    '2023-12-02',
    'confirmed',
    60
  ),
  (
    4,
    1,
    1,
    '2023-12-10',
    '2023-12-12',
    'pending',
    100
  );


--Query 1: JOIN
-- Requirement: Retrieve booking information along with Customer name and Vehicle name.
SELECT
  booking_id,
  u.name AS customer_name,
  v.name AS vehicle_name,
  start_date,
  end_date,
  booking_status
FROM
  bookings b
  JOIN users u ON b.user_id = u.user_id
  JOIN vehicles v ON b.vehicle_id = v.vehicle_id;


--Query 2: EXISTS
-- Requirement: Find all vehicles that have never been booked.
SELECT
  *
FROM
  vehicles v
WHERE
  NOT EXISTS (
    SELECT
      *
    FROM
      bookings b
    WHERE
      b.vehicle_id = v.vehicle_id
  );


-- Query 3: WHERE
-- Requirement: Retrieve all available vehicles of a specific type (e.g. cars).
-- create function select_vehicle_info(p_type text)
-- returns setof vehicles
-- language plpgsql
-- as
-- $$
--   begin
--   return query
--     SELECT *
--     FROM vehicles
--   where type::text = p_type
--   and availability_status = 'available';
-- end;    
-- $$
-- select * from select_vehicle_info('car');
SELECT
  *
FROM
  vehicles
WHERE
  type = 'car'
  AND availability_status = 'available';


-- Query 4: GROUP BY and HAVING
-- Requirement: Find the total number of bookings for each vehicle and display only those vehicles that have more than 2 bookings.
SELECT
  v.name AS vehicle_name,
  count(*) AS total_bookings
FROM
  bookings AS b
  JOIN vehicles AS v ON b.vehicle_id = v.vehicle_id
GROUP BY
  v.name
HAVING
  count(*) > 2;