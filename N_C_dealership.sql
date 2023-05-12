CREATE TABLE mechanics(
    mechanics_id SERIAL PRIMARY KEY NOT NULL,
    serial_number INTEGER NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
);

CREATE TABLE service_shop (
	service_shop_id SERIAL PRIMARY KEY NOT NULL,
    customer_id INTEGER NOT NULL,
    mechanics_id INTEGER NOT NULL,
    serial_number INTEGER NOT NULL,
	FOREIGN KEY (mechanics_id) REFERENCES mechanics(mechanics_id)	
);
ALTER TABLE service_ticket ADD COLUMN dealership_id INTEGER NOT NULL;
CREATE TABLE service_ticket(
    service_ticket_id SERIAL PRIMARY KEY NOT NULL,
    serial_number INTEGER NOT NULL,
   	service_shop_id INTEGER NOT NULL,
    service_description VARCHAR(250) NOT NULL,
    price DECIMAL(8, 2) NOT NULL,
    FOREIGN KEY (service_shop_id) REFERENCES service_shop(service_shop_id)
    ALTER TABLE service_ticket ADD CONSTRAINT service_ticket_dealership_id_foreign FOREIGN KEY (dealership_id) REFERENCES dealership(dealership_id);
);

CREATE TABLE invoice(
    invoice_id SERIAL PRIMARY KEY NOT NULL,
    customer_id INTEGER NOT NULL,
    salesperson_id INTEGER NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    address VARCHAR(200) NOT NULL,
    city VARCHAR(255) NOT NULL,
    price DECIMAL(8, 2) NOT NULL
);

CREATE TABLE new_cars(
    new_cars_id SERIAL PRIMARY KEY NOT NULL,
    make VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    car_year INTEGER NOT NULL,
    price DECIMAL(8, 2) NOT NULL,
    salesperson_id INTEGER NOT NULL,
    serial_number INTEGER NOT NULL
);

CREATE TABLE used_cars(
    used_cars_id SERIAL PRIMARY KEY NOT NULL,
    salesperson_id INTEGER NOT NULL,
    make VARCHAR(50) NOT NULL,
    model VARCHAR(255) NOT NULL,
    car_year INTEGER NOT NULL,
    price DECIMAL(8, 2) NOT NULL,
    serial_number INTEGER NOT NULL
);
ALTER TABLE salesperson ADD COLUMN dealership_id INTEGER NOT NULL;
CREATE TABLE salesperson(
	salesperson_id SERIAL PRIMARY KEY NOT NULL,
	invoice_id INTEGER NOT NULL,
	used_cars_id INTEGER NOT NULL,
	new_cars_id INTEGER NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL
    ALTER TABLE salesperson ADD CONSTRAINT salesperson_invoice_id_foreign FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id);
    ALTER TABLE salesperson ADD CONSTRAINT salesperson_used_cars_id_foreign FOREIGN KEY (used_cars_id) REFERENCES used_cars(used_cars_id);
    ALTER TABLE salesperson ADD CONSTRAINT salesperson_new_cars_id_foreign FOREIGN KEY (new_cars_id) REFERENCES new_cars(new_cars_id);
);

CREATE TABLE inventory(
    inventory_id INTEGER PRIMARY KEY NOT NULL,
    dealership_id INTEGER NOT NULL,
    serial_number INTEGER NOT NULL
);

CREATE TABLE service_records(
    service_records_id SERIAL PRIMARY KEY NOT NULL,
    used_cars_id INTEGER NOT NULL,
    service_completed VARCHAR(250) NOT NULL,
    customer_id INTEGER NOT NULL,
    mechanics_id INTEGER NOT NULL,
    serial_number INTEGER NOT NULL
);
ALTER TABLE dealership ADD COLUMN customer_id INTEGER NOT NULL;
CREATE TABLE dealership(
    dealership_id INTEGER PRIMARY KEY NOT NULL,
    salesperson_id INTEGER NOT NULL,
    service_records_id INTEGER NOT NULL,
    inventory_id INTEGER NOT NULL,
    salesperson_name VARCHAR(50),
    salesperson_lastname VARCHAR(50),
    service_data INTEGER NOT NULL,
    service_ticket INTEGER NOT NULL,
    ALTER TABLE dealership ADD CONSTRAINT dealership_salesperson_id_foreign FOREIGN KEY (salesperson_id) REFERENCES salesperson(salesperson_id);
    ALTER TABLE dealership ADD CONSTRAINT dealership_service_records_foreign FOREIGN KEY (service_records_id) REFERENCES service_records(service_records_id);
    ALTER TABLE dealership ADD CONSTRAINT dealership_inventory_id_foreign FOREIGN KEY (inventory_id) REFERENCES inventory(inventory_id);
);

CREATE TABLE customer(
    customer_id SERIAL PRIMARY KEY NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    address VARCHAR(200) NOT NULL,
    city VARCHAR(50) NOT NULL,
    payment_info VARCHAR(100) NOT NULL,
    dealership_id INTEGER NOT NULL,
    FOREIGN KEY (dealership_id) REFERENCES dealership(dealership_id)
);
