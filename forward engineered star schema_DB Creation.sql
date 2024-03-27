-- This script was generated by the ERD tool in pgAdmin 4.
-- Please log an issue at https://github.com/pgadmin-org/pgadmin4/issues/new/choose if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public.customer_dim
(
    customer_id character varying NOT NULL,
    first_name character varying,
    last_name character varying,
    phone character varying,
    email character varying,
    address character varying,
    country character varying,
    username character varying,
    password character varying,
    PRIMARY KEY (customer_id)
);

CREATE TABLE IF NOT EXISTS public.stock_dim
(
    stock_id character varying NOT NULL,
    description character varying,
    available_units integer,
    PRIMARY KEY (stock_id)
);

CREATE TABLE IF NOT EXISTS public.sales_measure
(
    invoice_number character varying NOT NULL,
    "quantity purchased" smallint,
    invoice_date date,
    unit_price numeric
);

COMMENT ON COLUMN public.sales_measure.invoice_number
    IS 'invoice number is included under the sales measure rather than creating a seperate invoice dimension. This is because there are limited information about the invoice on our source document. A seperate invoice dimension will not lend positive credence to this analysis.';

ALTER TABLE IF EXISTS public.sales_measure
    ADD CONSTRAINT customer_key FOREIGN KEY (invoice_number)
    REFERENCES public.customer_dim (customer_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.sales_measure
    ADD CONSTRAINT stock_key FOREIGN KEY (invoice_number)
    REFERENCES public.stock_dim (stock_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;