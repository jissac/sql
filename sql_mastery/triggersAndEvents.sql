DELIMITER $$

CREATE TRIGGER payments_after_insert
	AFTER INSERT ON payments
    FOR EACH ROW
BEGIn
	UPDATE invoices
    SET payment_total = payment_total + NEW.amount
    WHERE invoice_id = NEW.invoice_id;
END $$

DELIMITER ;

--

INSERT INTO payments
VALUES (DEFAULT, 5, 3, '2019-01-01',10, 1)

-- 

-- create a trigger that getss fired when we delete a payment
DELIMITER $$

CREATE TRIGGER payments_after_delete
	AFTER DELETE ON payments
    FOR EACH ROW
BEGIn
	UPDATE invoices
    SET payment_total = payment_total - OLD.amount
    WHERE invoice_id = OLD.invoice_id;
END $$

DELIMITER ;

SHOW TRIGGERS;

-- EVENTS
DELIMITER $$
CREATE EVENT yearly_delete_stale_audit_rows
ON SCHEDULe
	EVERY 1 YEAR starts '2019-01-01' ENDS '2029-01-01'
DO BEGIN
	DELETE FROM payments_audit
    WHERE action_date < NOW() - INTERVAL 1 YEAR;
END $$
DELIMITER ;

SHOW EVENTS;