--Chuyển đổi kiểu dữ liệu phù hợp cho các trường ( sử dụng câu lệnh ALTER) 
alter table sales_dataset_rfm_prj
alter column ordernumber type integer using ordernumber::integer,
alter column quantityordered type integer using quantityordered::integer,
alter column priceeach type numeric using priceeach::numeric,
alter column orderlinenumber type integer using orderlinenumber::integer,
alter column sales type numeric using sales::numeric,
alter column status type text,
alter column productline type text,
alter column msrp type integer using msrp::integer,
alter column productcode type text,
alter column customername type text,
alter column addressline1 type text,
alter column addressline2 type text,
alter column orderdate type timestamp using orderdate::timestamp,
alter column city type text,
alter column state type text,
alter column postalcode type text,
alter column country type text,
alter column territory type text,
alter column contactfullname type text,
alter column dealsize type text
;

--Check NULL/BLANK (‘’)  ở các trường: ORDERNUMBER, QUANTITYORDERED, PRICEEACH, ORDERLINENUMBER, SALES, ORDERDATE.
select * from sales_dataset_rfm_prj
where orderdate is null;

--Thêm cột CONTACTLASTNAME, CONTACTFIRSTNAME được tách ra từ CONTACTFULLNAME .

alter table sales_dataset_rfm_prj
add contactlastname varchar(100);

alter table sales_dataset_rfm_prj
add contactfirstname varchar(100);

-- Chuẩn hóa CONTACTLASTNAME, CONTACTFIRSTNAME theo định dạng chữ cái đầu tiên viết hoa, chữ cái tiếp theo viết thường. 

update sales_dataset_rfm_prj
set contactfirstname = initcap(left(contactfullname,position ('-' in contactfullname)-1));

update sales_dataset_rfm_prj
set contactlastname = initcap(right(contactfullname,length(contactfullname)- position ('-' in contactfullname)));

--Thêm cột QTR_ID, MONTH_ID, YEAR_ID lần lượt là Qúy, tháng, năm được lấy ra từ ORDERDATE 

--Add month_id
alter table sales_dataset_rfm_prj
add month_id varchar(100);

update sales_dataset_rfm_prj
set month_id=extract(month from orderdate);

-- Add year_id
alter table sales_dataset_rfm_prj
add year_id varchar(100);

update sales_dataset_rfm_prj
set year_id=extract(year from orderdate);

--Add qtr_id
alter table sales_dataset_rfm_prj
add qtr_id varchar(100);

update sales_dataset_rfm_prj
set qtr_id=extract(quarter from orderdate);

--Hãy tìm outlier (nếu có) cho cột QUANTITYORDERED và hãy chọn cách xử lý cho bản ghi đó (2 cách)
with min_max as(
select
Q1-1.5*IQR as min_val,
Q3+1.5*IQR as max_val
from(
	select
	percentile_cont(0.25) within group (order by quantityordered) as Q1,
	percentile_cont(0.75) within group (order by quantityordered) as Q3,
	percentile_cont(0.75) within group (order by quantityordered)-percentile_cont(0.25) within group (order by quantityordered) as IQR
	from sales_dataset_rfm_prj as percentile) as min_max)
,outlier as(
select * from sales_dataset_rfm_prj
where quantityordered < (select min_val from min_max)
or quantityordered > (select max_val from min_max))

update sales_dataset_rfm_prj
set quantityordered = avg(quantityordered)
where quantityordered in (select quantityordered in outlier);

--Sau khi làm sạch dữ liệu, hãy lưu vào bảng mới  tên là SALES_DATASET_RFM_PRJ_CLEAN

create table SALES_DATASET_RFM_PRJ_CLEAN
(
  ordernumber VARCHAR,
  quantityordered VARCHAR,
  priceeach        VARCHAR,
  orderlinenumber  VARCHAR,
  sales            VARCHAR,
  orderdate        VARCHAR,
  status           VARCHAR,
  productline      VARCHAR,
  msrp             VARCHAR,
  productcode      VARCHAR,
  customername     VARCHAR,
  phone            VARCHAR,
  addressline1     VARCHAR,
  addressline2     VARCHAR,
  city             VARCHAR,
  state            VARCHAR,
  postalcode       VARCHAR,
  country          VARCHAR,
  territory        VARCHAR,
  contactfullname  VARCHAR,
  dealsize         VARCHAR,
	contactlastname	varchar,
	contactfirstname	varchar,
	month_id varchar,
	year_id varchar,
	qtr_id varchar
); 
insert into SALES_DATASET_RFM_PRJ_CLEAN (
ordernumber ,
  quantityordered ,
  priceeach       ,
  orderlinenumber ,
  sales           ,
  orderdate       ,
  status          ,
  productline     ,
  msrp            ,
  productcode   ,
  customername    ,
  phone           ,
  addressline1    ,
  addressline2    ,
  city            ,
  state           ,
  postalcode      ,
  country         ,
  territory       ,
  contactfullname ,
  dealsize        ,
	contactlastname,
	contactfirstname	,
	month_id ,
	year_id ,
	qtr_id)
select
ordernumber ,
  quantityordered ,
  priceeach       ,
  orderlinenumber ,
  sales           ,
  orderdate       ,
  status          ,
  productline     ,
  msrp            ,
  productcode   ,
  customername    ,
  phone           ,
  addressline1    ,
  addressline2    ,
  city            ,
  state           ,
  postalcode      ,
  country         ,
  territory       ,
  contactfullname ,
  dealsize        ,
	contactlastname,
	contactfirstname	,
	month_id ,
	year_id ,
	qtr_id
from sales_dataset_rfm_prj




