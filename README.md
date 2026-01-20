# Vehicle Rental System — Database Design & SQL Queries

## Overview
This project implements a simplified Vehicle Rental System using PostgreSQL. It demonstrates relational schema design, enum-based status modeling, foreign key relationships, and SQL queries involving JOIN, EXISTS, WHERE, and GROUP BY + HAVING.

The design models three core entities:
- **Users**
- **Vehicles**
- **Bookings**

These represent real rental operations including user management, fleet availability, and booking transactions.

---

## Database Schema

The database uses PostgreSQL enums to enforce strict domain rules for:
- User roles
- Vehicle types
- Vehicle availability statuses
- Booking statuses

### Table Relationships
- **User → Bookings** (One-to-Many)
- **Bookings → Vehicle** (Many-to-One)
- Each booking links exactly one user to one vehicle.

Foreign keys enforce referential integrity.

---

## Database Features

### Users Table Includes:
- Name
- Email (unique)
- Phone
- Password
- Role (Admin/Customer)

### Vehicles Table Includes:
- Vehicle name
- Type (car/bike/truck)
- Model year
- Registration number (unique)
- Rental price
- Availability status

### Bookings Table Includes:
- User (FK)
- Vehicle (FK)
- Rental dates
- Booking status
- Total cost

---

## Sample Data
The project includes sample inserts for:
- 3 users
- 4 vehicles
- 4 bookings

These allow all query results to be tested without requiring additional data.

---

## Assignment Query Solutions

All required SQL queries are implemented:

### Query 1 — **JOIN**
Retrieve booking info with customer and vehicle names.

### Query 2 — **NOT EXISTS**
Find vehicles never booked.

### Query 3 — **WHERE**
Filter available vehicles by type (example: car).

### Query 4 — **GROUP BY + HAVING**
Count bookings per vehicle, returning those with more than two bookings.

---

## Technology Stack
- PostgreSQL (RDBMS)
- SQL DDL + DML
- Enum types
- Referential constraints

---

## Files Included
This repository contains:
queries.sql → DB creation + inserts + required queries


---

## How to Run
1. Open PostgreSQL environment (psql)
2. Run:\i queries.sql
3. Inspect query outputs as needed.

---

## Viva Component
Conceptual theory questions cover:
- Primary key and its characteristics
- Foreign key and its importance in relational databases
- WHERE vs HAVING
- INNER vs LEFT JOIN

These are practiced through spoken explanations for clarity.

---

## Status
Complete and ready for submission.
