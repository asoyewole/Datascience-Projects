-- The sql script was written (and tested) to load the postgreSQL tables in the retailDB database.

BEGIN;

-- Load the customer_dim table with data from staging table-No transformation
INSERT INTO public.customer_dim (
			customer_id,
			first_name,
			last_name,
			phone,
			email,
			address,
			country
			)
	(SELECT r.customerid, 
			r.firstname,
			r.lastname,
			r.phone, 
			r.email, 
			r.address, 
			r.country
	FROM public.retail_staging as r
	);
	


-- Load stock_dim table with stock_id and description alone
INSERT INTO public.stock_dim (
		stock_id,
		description
		)
	(SELECT r.stockcode,
			r.description
	 FROM public.retail_staging AS r
	 );


-- Generate random data for available units column
UPDATE public.stock_dim 
	SET available_units = 
	floor(random() * (10000 - 10 + 1) + 10);

	
-- Change datestyle
SET DATESTYLE = mdy; 
	
	
-- Insert into sales measure
INSERT INTO public.sales_measure(
		invoice_number,
		"quantity purchased",
		invoice_date,
		unit_price
	)
	(SELECT r.invoiceno, 
	 CAST (r.quantity AS integer), 
	 CAST (r.invoicedate AS timestamp), 
	 CAST (r.unitprice AS numeric) 
	 FROM public.retail_staging AS r
	);
	
END;