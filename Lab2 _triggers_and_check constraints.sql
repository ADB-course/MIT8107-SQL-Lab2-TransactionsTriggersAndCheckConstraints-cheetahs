DELIMITER $$

CREATE TRIGGER TRG_CREDIT_LIMIT_VIOLATION
BEFORE INSERT ON customers
FOR EACH ROW
BEGIN
    IF (NEW.creditLimit > 250000) THEN 
        SIGNAL SQLSTATE '020000' SET MESSAGE_TEXT = 'Warning: Credit Limit cannot be greater than 250000!';
    END IF;
END $$
DELIMITER ;


INSERT INTO customers
(`customerNumber`, `customerName`, `contactLastName`, `contactFirstName`, `phone`, `addressLine1`,`addressLine2`, `city`,`state`,`postalCode`, `country`,`salesRepEmployeeNumber`,`creditLimit`) 
VALUES 
('497', 'House of Leather', 'Wambua', 'Gabriel', '+254 720 123 456', '9 Agha Khan Walk','00100', 'Nairobi','Nairobi','00100', 'Kenya','1055','300000.00');