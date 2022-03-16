DROP PROCEDURE IF EXISTS `get_clients`;
DELIMITER $$
CREATE PROCEDURE `get_clients`()
BEGIN
	SELECT * FROM clients;
END $$

DELIMITER ;

CALL get_clients();

-- 

DROP PROCEDURE IF EXISTS `get_invoices_with_balance`;
DELIMITER $$
CREATE PROCEDURE `get_invoices_with_balance`()
BEGIN
	SELECT *
	FROM invoices_with_balance
	WHERE balance > 0;
END $$

DELIMITER ;

-- 

DROP PROCEDURE IF EXISTS `get_clients_by_state`;
DELIMITER $$
CREATE PROCEDURE `get_clients_by_state`
(
	state CHAR(2)
)
BEGIN
	IF state IS NULL THEN
		SELECT * FROM clients;
	ELSE
		SELECT * FROM clients c
		WHERE c.state = state;
	END IF;
END $$

DELIMITER ;

CALL get_clients_by_state('CA');

-- 

DROP PROCEDURE IF EXISTS `get_clients_by_state`;
DELIMITER $$
CREATE PROCEDURE `get_clients_by_state`
(
	state CHAR(2)
)
BEGIN
		SELECT * FROM clients c
		WHERE c.state = IFNULL(state, c.state);
END $$

DELIMITER ;

CALL get_clients_by_state('CA');

--
-- get payements stored procedure with two params, client_id => INT, payment_method => TINYINT

DROP PROCEDURE IF EXISTS `get_payments`;
DELIMITER $$
CREATE PROCEDURE `get_payments`
(
	client_id INT,
    payment_method_id TINYINT
)
BEGIN
	SELECT * FROM payments p
    WHERE p.client_id = IFNULL(client_id,p.client_id)
		AND p.payment_method = IFNULL(payment_method_id,p.payment_method);
END $$

DELIMITER ;

-- Validating procedures
DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `make_payment`(
	invoice_id INT,
    payment_amount DECIMAL(9,2),
    payment_date DATE
)
BEGIN
	IF payment_amount <= 0 THEN
		SIGNAL SQLSTATE '22003' 
        SET MESSAGE_TEXT = 'Invalid payment amount';
	END IF;
    
	UPDATE invoices i 
    SET 
		i.payment_total = payment_amount,
        i.payment_date = payment_date
	WHERE i.invoice_id = invoice_id;
END $$
DELIMITER ;


-- FUNCTIONS
CREATE FUNCTION get_risk_factor_for_client
(
	client_id INT
)
RETURNS INTEGER
-- DETERMINISTIC
READ SQL DATA
-- MODIFIES SQL DATA
BEGIN
	DECLARE risk_factor DECIMAL(9,2) DEFAULT 0;
    

