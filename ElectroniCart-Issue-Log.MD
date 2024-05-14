# Data Cleaning
- Inconsistent date formatting (PURCHASE_TS/SHIP_TS/DELIVERY_TS/REFUND_TS)
  - Reformatted all affected column to MM/DD/YYYY format.
- Inconsistent product names (PRODUCT_NAME)
  - Created new column ‘PRODUCT_NAME_CLEANED’ - consolidated related values.
- Nonsensical date values (DELIVERY_TS/REFUND_TS)
  - Created new column ‘DELIVERY_TS_CLEANED’ - removed dates predating the purchase date.
  - Created new column ‘REFUND_TS_CLEANED’ - removed dates predating the purchase date and dates in the future.

- Helper columns:
  - PURCHASE_MONTH: Truncate PURCHASE_TS column by month.
  - PURCHASE_YEAR: Truncate PURCHASE_TS column by year.
  - PURCHASE_EXTRACT_MONTH: Converted PURCHASE_TS to only contain month name .
  - REFUNDED: Binary field to identify if orders was refunded (based on REFUND_TS).
  - REFUND_MONTH: Month of refund (based on REFUND_TS).
  - BRAND: Brand of product (based on PRODUCT_NAME).
  -	REGION: Filled in missing regions and fixed other values to align with standardized values. Used vlookup to integrate into orders table.
