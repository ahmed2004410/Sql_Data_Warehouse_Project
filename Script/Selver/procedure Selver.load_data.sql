create or alter procedure Selver.load_data as 
Begin
Begin try
------------------------------------------------------------------------------------------------------------first table
print '>>truncate table : [Selver].[crm_cust_info] '
truncate table [Selver].[crm_cust_info] 

print '>>Insert Data into : [Selver].[crm_cust_info] '
insert into [Selver].[crm_cust_info] (cst_id,cst_key,cst_firstname,cst_lastname,cst_marital_status,cst_gndr,cst_create_date)
( 
SELECT
    cst_id,
	cst_key,
	TRIM(cst_firstname) AS cst_firstname,
	TRIM(cst_lastname) AS cst_lastname,
	CASE 
		WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single'
		WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married'
		ELSE 'n/a'
		END AS cst_marital_status, -- Normalize marital status values to readable format
	CASE 
		WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female'
		WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male'
	    ELSE 'n/a'
		END AS cst_gndr, -- Normalize gender values to readable format
	cst_create_date
FROM (
	SELECT
	*,
	ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
	FROM Bronze.crm_cust_info
	WHERE cst_id IS NOT NULL)t
	WHERE flag_last = 1
    )


------------------------------------------------------------------------------------------------------------------secound table
 
print '>>truncate table : [Selver].[crm_prd_info]'
truncate table [Selver].[crm_prd_info]

print '>>Insert Data into :  [Selver].[crm_prd_info] '
 insert into [Selver].[crm_prd_info]
 (
    prd_id,
    prd_key,
    cat_id,
    prd_nm,
    prd_cost,
    prd_line,
    prd_start_dt,
    prd_end_dt
)
(
select [prd_id],
       substring ([prd_key],7,len([prd_key])) as [prd_key],
       Replace(SUBSTRING([prd_key],1,5),'-','_')as cat_id,
       [prd_nm],
       isnull([prd_cost],0) as [prd_cost],
       case UPPER(trim(prd_line))
            when  'M' then 'Mountain'
            when  'R' then 'Road'
            when  'S' then 'Other Sales'
            when 'T' then 'Touring'
            else 'n/a' 
       end as prd_line,
       cast ([prd_start_dt] as date)as [prd_start_dt],
       cast( lead ([prd_start_dt]) over(partition by prd_key order by[prd_start_dt] )-1 as date )as [prd_end_dt]

from [Bronze].[crm_prd_info]
)


-------------------------------------------------------------------------------------------------------------------third table

print '>>truncate table :[Selver].[crm_sales_details]'
truncate table [Selver].[crm_sales_details]

print '>>Insert Data into :[Selver].[crm_sales_details] '
insert into [Selver].[crm_sales_details] 
(
    sls_ord_num,
    sls_prd_key,
    sls_cust_id,
    sls_order_dt,
    sls_due_dt,
    sls_ship_dt,
    sls_sales,
    sls_quantity,
    sls_price)

select 
      sls_ord_num,
      sls_prd_key,
      sls_cust_id,
      case when sls_order_dt <= 0 then null
           when len(sls_order_dt) < 8 then null 
           else cast(cast(sls_order_dt as NVARCHAR) as date)
           end as sls_order_dt,
      case when sls_due_dt <= 0 then null
           when len(sls_due_dt) < 8 then null 
           else cast(cast(sls_due_dt as NVARCHAR) as date)
           end as sls_ship_dt,
      case when sls_ship_dt <= 0 then null
           when len(sls_ship_dt) < 8 then null 
           else cast(cast(sls_ship_dt as NVARCHAR) as date)
           end as sls_due_dt,
      case when sls_sales <= 0 
            or sls_sales is null 
            or sls_sales !=sls_quantity * ABS(sls_price) then sls_quantity * ABS(sls_price)
      else sls_sales end as sls_sales  ,    
      sls_quantity,
      case when sls_price is null or sls_price <=0 then ABS(sls_sales)/sls_quantity
           else sls_price end as  sls_price
from [Bronze].[crm_sales_details]


--------------------------------------------------------------------------------------------------------------------fourth table


print '>>truncate table :[Selver].[erp_cust_az12]'
truncate table [Selver].[erp_cust_az12]

print '>>Insert Data into :[Selver].[erp_cust_az12] '
insert into [Selver].[erp_cust_az12] (cid,bdate,gen)
 select case when cid like 'NAS%'then substring(cid,4,len(cid))
             else cid end as cid,
        case when bdate > getdate () then null
             else bdate end as bdate ,
        case when Upper(trim(gen)) in( 'M','MALE') then 'Male'
             when Upper(trim(gen)) in( 'F','FEMALE') then 'Female' 
             else 'n/a' end as gen 
from [Bronze].[erp_cust_az12]


---------------------------------------------------------------------------------------------------------------------fiveth table 
print '>>truncate table :[Selver].[erp_loc_a101]'
truncate table [Selver].[erp_loc_a101]
print '>>Insert Data into :[Selver].[erp_loc_a101]'
insert into [Selver].[erp_loc_a101] 
(
    cid,
    cntry
)

select replace (cid,'-','') as cid,
       case when trim([cntry]) = 'DE' then 'Germany'
            when trim([cntry]) in ('USA','US')  then 'United States'
            when trim(cntry) is null or trim(cntry)  = ' ' then 'n/a' 
            Else trim(cntry) End as cntry
from [Bronze].[erp_loc_a101]


---------------------------------------------------------------------------------------------------------------------sixth table 

print '>>truncate table :[Selver].[erp_px_cat_g1v2]'
truncate table [Selver].[erp_px_cat_g1v2]

print '>>Insert Data into :[Selver].[erp_px_cat_g1v2]'
insert into [Selver].[erp_px_cat_g1v2]
(
    id,
    cat,
    subcat,
    maintenance
)
(select 
    id,
    cat,
    subcat,
    maintenance
from Bronze.[erp_px_cat_g1v2])

--------------------------------------------------------------------------------------------------------------------
END try
Begin Catch
    print '==================================================='
    print 'Error Occured During Loading selver layer'
    print 'Error Message'+Error_Message();
    print '==================================================='
END Catch
END