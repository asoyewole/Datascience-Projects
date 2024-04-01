-- This script was generated by the ERD tool in pgAdmin 4.
-- Please log an issue at https://github.com/pgadmin-org/pgadmin4/issues/new/choose if you find any bugs, including reproduction steps.
BEGIN;


CREATE TABLE IF NOT EXISTS public.customer_dim
(
    customer_key serial NOT NULL,
    customer_id character varying,
    first_name character varying,
    last_name character varying,
    phone character varying,
    email character varying,
    address character varying,
    country character varying,
    PRIMARY KEY (customer_key)
);

CREATE TABLE IF NOT EXISTS public.stock_dim
(
    stock_key serial NOT NULL,
    stock_id character varying,
    description character varying,
    available_units integer,
    PRIMARY KEY (stock_key)
);

CREATE TABLE IF NOT EXISTS public.sales_measure
(
    sales_id serial NOT NULL,
    invoice_number character varying,
    "quantity purchased" integer,
    invoice_date timestamp without time zone[],
    unit_price numeric
);

COMMENT ON COLUMN public.sales_measure.invoice_number
    IS 'invoice number is included under the sales measure rather than creating a seperate invoice dimension. This is because there are limited information about the invoice on our source document. A seperate invoice dimension will not lend positive credence to this analysis.';

CREATE TABLE IF NOT EXISTS public.retail_staging
(
    "invoiceNo" character varying,
    stockcode character varying,
    description character varying,
    quantity character varying,
    invoicedate character varying,
    unitprice character varying,
    customerid character varying,
    country character varying,
    firstname character varying,
    lastname character varying,
    address character varying,
    phone character varying,
    email character varying
);

ALTER TABLE IF EXISTS public.sales_measure
    ADD CONSTRAINT sales_cust_rel FOREIGN KEY (sales_id)
    REFERENCES public.customer_dim (customer_key) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.sales_measure
    ADD CONSTRAINT sales_stock_rel FOREIGN KEY (sales_id)
    REFERENCES public.stock_dim (stock_key) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;