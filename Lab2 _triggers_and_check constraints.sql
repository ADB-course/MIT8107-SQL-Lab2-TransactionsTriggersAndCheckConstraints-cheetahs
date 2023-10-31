-- Set the delimiter to '$$' to allow the creation of a trigger
DELIMITER $$
-- Creating a trigger named TRG_CREDIT_LIMIT_VIOLATION
CREATE TRIGGER TRG_CREDIT_LIMIT_VIOLATION
-- Trigger is fired before an INSERT operation on the 'customers' table
BEFORE INSERT ON customers
FOR EACH ROW
BEGIN
-- Check if the new credit limit exceeds 250,000
    IF (NEW.creditLimit > 250000) THEN
    -- If the credit limit is higher than 25,000, raise a custom SQLSTATE error 
        SIGNAL SQLSTATE '020000' SET MESSAGE_TEXT = 'Warning: Credit Limit cannot be greater than 250000!';
    END IF;
END $$
-- Restore the default delimiter
DELIMITER ;

-- Insert data into the 'customers' table
INSERT INTO customers
(`customerNumber`, `customerName`, `contactLastName`, `contactFirstName`, `phone`, `addressLine1`,`addressLine2`, `city`,`state`,`postalCode`, `country`,`salesRepEmployeeNumber`,`creditLimit`) 
VALUES 
-- new customer record to be inserted
('497', 'House of Leather', 'Wambua', 'Gabriel', '+254 720 123 456', '9 Agha Khan Walk','00100', 'Nairobi','Nairobi','00100', 'Kenya','1055','300000.00');

-- In the above code, we create a trigger named TRG_CREDIT_LIMIT_VIOLATION 
-- to check if a new customer's credit limit exceeds 250,000. 
-- If it does, the trigger raises a custom SQLSTATE error to prevent the insertion of the new record 
