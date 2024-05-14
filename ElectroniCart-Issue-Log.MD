#Data Cleaning
- Inconsistent date formatting (PURCHASE_TS/SHIP_TS/DELIVERY_TS/REFUND_TS)
  - Reformatted all affected column to MM/DD/YYYY format
- Inconsistent product names (PRODUCT_NAME)
  - Created new column ‘PRODUCT_NAME_CLEANED’ and consolidated related values
- Nonsensical date values (DELIVERY_TS/REFUND_TS)
  - Created new column ‘DELIVERY_TS_CLEANED’ and ‘REFUND_TS_CLEANED’ and removed dates predating purchase date.
  - Created new column ‘REFUND_TS_CLEANED’ and dates in future
•	Help columns:
o	PURCHASE_MONTH: Truncate PURCHASE_TS column by month
o	PURCHASE_YEAR: Truncate PURCHASE_TS column by year
o	PURCHASE_EXTRACT_MONTH: Converted PURCHASE_TS to only contain month name 
o	REFUNDED: Binary field to identify if orders was refunded (based on REFUND_TS)
o	REFUND_MONTH: Month of refund (based on REFUND_TS)
o	BRAND: Brand of product (based on PRODUCT_NAME)
o	REGION: Filled in missing regions and fixed other values to align with standardized values. Used vlookup to integrate into orders table.
