CREATE OR REPLACE FUNCTION purchase_ticket(
    p_schedule_id INT,
    p_price DECIMAL
)
RETURNS VOID AS
$$
BEGIN
    UPDATE ticket
    SET status = 'sold', buy_time = now()
    WHERE id_schedule = p_schedule_id AND status = 'free';
END;
$$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION return_ticket(
    p_ticket_id BIGINT
)
RETURNS VOID AS
$$
BEGIN
    UPDATE ticket
    SET status = 'free', refund_time = now()
    WHERE id = p_ticket_id;
END;
$$
LANGUAGE plpgsql;