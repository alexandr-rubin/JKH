create database JKH_NEW
 
use JKH_NEW
 
create table houses_and_apartments 
( 
id_houses int identity(1,1) primary key, 
adres varchar(40) not null, 
numbers_of_tenants int not null, 
gas_this_month float not null, 
hot_water_this_month float not null, 
cold_water_this_month float not null, 
electricity_this_month float not null, 
gas_last_month float default 0, 
hot_water_last_month float default 0, 
cold_water_last_month float default 0,
electricity_last_month float default 0,
maintenance float default 0,
overhaul float default 0,
area float not null,
garbage_chute bit default 0,
electric_stoves bit default 0,
priveleges bit default 0,
lift bit default 0,
sub bit default 0,
FIO varchar(40) not null,
date_add date,
CONSTRAINT check_numbers_of_tenants CHECK (numbers_of_tenants>0),
CONSTRAINT check_gas_this_month CHECK (gas_this_month>0),
CONSTRAINT check_hot_water_this_month CHECK (hot_water_this_month>0),
CONSTRAINT check_cold_water_this_month CHECK (cold_water_this_month>0),
CONSTRAINT check_electricity_this_month CHECK (electricity_this_month>0),
CONSTRAINT check_gas_last_month CHECK (gas_last_month>=0),
CONSTRAINT check_hot_water_last_month CHECK (hot_water_last_month>=0),
CONSTRAINT check_cold_water_last_month CHECK (cold_water_last_month>=0),
CONSTRAINT check_electricity_last_month CHECK (electricity_last_month>=0),
CONSTRAINT check_area CHECK (area>0)
) 
go 



create table report_houses_and_apartments 
( 
id_houses_rep int identity(1,1) primary key, 
adres_rep varchar(40), 
numbers_of_tenants_rep int default 0, 
gas_this_month_rep float default 0, 
hot_water_this_month_rep float default 0, 
cold_water_this_month_rep float default 0, 
electricity_this_month_rep float default 0, 
gas_last_month_rep float default 0, 
hot_water_last_month_rep float default 0, 
cold_water_last_month_rep float default 0,
electricity_last_month_rep float default 0,
maintenance_rep_houses float default 0,
overhaul_rep_houses float default 0,
area_rep float default 0,
garbage_chute_rep bit default 0,
electric_stoves_rep bit default 0,
priveleges_rep bit default 0,
lift_rep_houses bit default 0,
sub_rep bit default 0,
FIO_rep varchar(40),
date_add_rep date,
fk_houses_rep int foreign key references houses_and_apartments(id_houses) on delete set null on update cascade,
CONSTRAINT check_fk_huoses_rep CHECK (fk_houses_rep>0)
) 
go 



create table periodds_tariffs
(
id_pe int identity(1,1) primary key,
periodd varchar(40) not null,
gas_tariff_pe float not null,
CONSTRAINT check_gas_tariff_pe CHECK (gas_tariff_pe>0)
)
go



create table sub_periodds_tariffs
(
id_sub_pe int identity(1,1) primary key,
sub_periodd varchar(40) not null,
sub_gas_tariff_pe float not null,
CONSTRAINT sub_check_gas_tariff_pe CHECK (sub_gas_tariff_pe>0)
)
go

 
create table tariffs 
( 
id_tar int identity(1,1) primary key, 
gas_tariff float default 0, 
hot_water_tariff float not null, 
cold_water_tariff float not null, 
electricity_tariff float not null,
garbage_tariff float not null,
lift_tariff float not null,
maintenance_tariff float not null,
overhaul_tariff float not null,
sewage_tariff float not null,
ses varchar(40) not null,
fk_pe int foreign key references periodds_tariffs(id_pe) on delete set null on update cascade,
CONSTRAINT check_hot_water_tariff CHECK (hot_water_tariff>0),
CONSTRAINT check_cold_water_tariff CHECK (cold_water_tariff>0),
CONSTRAINT check_electricity_tariff CHECK (electricity_tariff>0),
CONSTRAINT check_garbage_tariff CHECK (garbage_tariff>0)
) 
go



create table sub_tariffs 
( 
id_sub_tar int identity(1,1) primary key, 
sub_gas_tariff float default 0, 
sub_hot_water_tariff float not null, 
sub_cold_water_tariff float not null, 
sub_electricity_tariff float not null,
sub_garbage_tariff float not null,
sub_lift_tariff float not null,
sub_maintenance_tariff float not null,
sub_overhaul_tariff float not null,
sub_sewage_tariff float not null,
sub_ses varchar(40) not null,
fk_sub_pe int foreign key references sub_periodds_tariffs(id_sub_pe) on delete set null on update cascade,
CONSTRAINT sub_check_hot_water_tariff CHECK (sub_hot_water_tariff>0),
CONSTRAINT sub_check_cold_water_tariff CHECK (sub_cold_water_tariff>0),
CONSTRAINT sub_check_electricity_tariff CHECK (sub_electricity_tariff>0),
CONSTRAINT sub_check_garbage_tariff CHECK (sub_garbage_tariff>0)
) 
go 

 
 
create table cost_of_services 
( 
id_cost int identity(1,1) primary key, 
gas_price float default 0, 
hot_water_price float default 0, 
cold_water_price float default 0, 
electricity_price float default 0,
garbage_price float default 0,
lift_price float default 0,
maintenance_price float default 0,
overhaul_price float default 0,
sewage_price float default 0,
full_price float default 0,
price_with_p float default 0,
pay float,
payday_date date,
deadline_payday_date date,
fk_houses int foreign key references houses_and_apartments(id_houses) on delete set null on update cascade,
fk_tar int foreign key references tariffs(id_tar) on delete set null on update cascade,
fk_sub_tar int foreign key references sub_tariffs(id_sub_tar) on delete set null on update cascade,
CONSTRAINT check_pay CHECK (pay>=0),
CONSTRAINT check_deadline_payday_date CHECK (deadline_payday_date>=getdate())
) 
go



create table report 
( 
id_rep int identity(1,1) primary key,
gas_rep float default 0, 
hot_water_rep float default 0, 
cold_water_rep float default 0, 
electricity_rep float default 0,
garbage_rep float default 0,
full_rep float default 0,
lift_rep float default 0,
maintenance_rep float default 0,
overhaul_rep float default 0,
sewage_rep float default 0,
price_with_p_rep float default 0,
pay_rep float default 0,
payday_date_rep date,
deadline_payday_date_rep date,
fk_cost int foreign key references cost_of_services(id_cost) on delete set null on update cascade,
CONSTRAINT rep_check_fk_cost CHECK (fk_cost>0)
) 
go



create proc viv_report 
as 
select gas_rep as 'Цена за газ', hot_water_rep as 'Цена за горячую воду', cold_water_rep as 'Цена за холодную воду', electricity_rep as 'Цена за электричество', 
garbage_rep as 'Цена за вывоз мусора', lift_rep as 'Цена за обслуживание лифта', maintenance_rep as 'Цена за техническое обслуживание', overhaul_rep as 'Цена за капитальный ремонт', 
sewage_rep as 'Цена за водоотведение', full_rep as 'Общая стоимость', pay_rep as 'Оплата', payday_date_rep as 'Дата оплаты', deadline_payday_date_rep as 'Крайний срок оплаты', 
price_with_p_rep as 'Цена с пеней'
from report
go
 
 
 
create proc vivod_houses_and_apartments 
as 
select id_houses as '№', adres as 'Адрес', date_add as 'Дата', numbers_of_tenants as 'Количество жильцов', gas_this_month as 'Газ в этом месяце', hot_water_this_month as 'Горячая вода в этом месяце', 
cold_water_this_month as 'Холодная вода в этом месяце', electricity_this_month as 'Электричество в этом месяце',
gas_last_month as 'Газ в прошлом месяце', hot_water_last_month as 'Горячая вода в прошлом месяце', cold_water_last_month as 'Холодная вода в прошлом месяце', 
electricity_last_month as 'Электричество в прошлом месяце', maintenance as 'Площадь технического обслуживания', overhaul as 'Площадь капитального ремонта', 
electric_stoves as 'Наличие электрических плит', priveleges as 'Льготы', area as 'Площадь', garbage_chute as 'Наличие мусоропровода', lift as 'Наличие лифта', sub as 'Наличие субсидий',
FIO as 'Ф.И.О. владельца'
from houses_and_apartments 
go 



create proc vivod_report_houses_and_apartments 
as 
select adres_rep as 'Адрес', numbers_of_tenants_rep as 'Количество жильцов', gas_this_month_rep as 'Газ в этом месяце', 
hot_water_this_month_rep as 'Горячая вода в этом месяце', cold_water_this_month_rep as 'Холодная вода в этом месяце', 
electricity_this_month_rep as 'Электричество в этом месяце',gas_last_month_rep as 'Газ в прошлом месяце', 
hot_water_last_month_rep as 'Горячая вода в прошлом месяце', cold_water_last_month_rep as 'Холодная вода в прошлом месяце', 
electricity_last_month_rep as 'Электричество в прошлом месяце', maintenance_rep_houses as 'Площадь технического обслуживания', 
overhaul_rep_houses as 'Площадь капитального ремонта', electric_stoves_rep as 'Наличие электрических плит', priveleges_rep as 'Льготы', area_rep as 'Площадь', 
garbage_chute_rep as 'Наличие мусоропровода', lift_rep_houses as 'Наличие лифта', sub_rep as 'Наличие субсидий', FIO_rep as 'Ф.И.О. владельца', date_add_rep as 'Дата'
from report_houses_and_apartments 
go 



create proc viv_periods
as
select periodd as 'Период', gas_tariff_pe as 'Тариф на газ'
from periodds_tariffs
go


create proc viv_sub_periods
as
select sub_periodd as 'Период', sub_gas_tariff_pe as 'Тариф на газ'
from sub_periodds_tariffs
go

 
create proc viv_tariffs 
as 
select gas_tariff as 'Тариф на газ', hot_water_tariff as 'Тариф на горячую воду', cold_water_tariff as 'Тариф на холодную воду', electricity_tariff as 'Тариф на электричество', 
periodd as 'Период', garbage_tariff as 'Тариф на вывоз мусора', lift_tariff as 'Тариф на обслуживание лифта', maintenance_tariff as 'Тариф на техническое обслуживание',
overhaul_tariff as 'Тариф на капитальный ремонт', sewage_tariff as 'Тариф на водоотведение'
from tariffs, periodds_tariffs
where id_pe = fk_pe
go 



create proc viv_sub_tariffs 
as 
select sub_gas_tariff as 'Тариф на газ', sub_hot_water_tariff as 'Тариф на горячую воду', sub_cold_water_tariff as 'Тариф на холодную воду', 
sub_electricity_tariff as 'Тариф на электричество', sub_periodd as 'Период', sub_garbage_tariff as 'Тариф на вывоз мусора', 
sub_lift_tariff as 'Тариф на обслуживание лифта', sub_maintenance_tariff as 'Тариф на техническое обслуживание', 
sub_overhaul_tariff as 'Тариф на капитальный ремонт', sub_sewage_tariff as 'Тариф на водоотведение'
from sub_tariffs, sub_periodds_tariffs
where id_sub_pe = fk_sub_pe
go 


 
create proc viv_cost_of_services 
as 
select id_cost as '№', gas_price as 'Цена за газ', hot_water_price as 'Цена за горячую воду', cold_water_price as 'Цена за холодную воду', electricity_price as 'Цена за электричество', 
garbage_price as 'Цена за вывоз мусора', maintenance_price as 'Цена за техническое обслуживание', overhaul_price as 'Цена за капитальный ремонт',
lift_price as 'Цена за обслуживание лифта', sewage_price as 'Цена за водоотведение', adres as 'Адрес', full_price as 'Общая стоимость', payday_date as 'Дата оплаты', 
deadline_payday_date as 'Крайний срок оплаты', price_with_p as 'Цена с пеней'
from cost_of_services, houses_and_apartments
where id_houses = fk_houses
go


create proc search_houses_and_apartments 
@id varchar(100)
as
select id_houses as '№', date_add as 'Дата', adres as 'Адрес', numbers_of_tenants as 'Количество жильцов', gas_this_month as 'Газ в этом месяце', hot_water_this_month as 'Горячая вода в этом месяце', 
cold_water_this_month as 'Холодная вода в этом месяце', electricity_this_month as 'Электричество в этом месяце',
gas_last_month as 'Газ в прошлом месяце', hot_water_last_month as 'Горячая вода в прошлом месяце', cold_water_last_month as 'Холодная вода в прошлом месяце', 
electricity_last_month as 'Электричество в прошлом месяце', maintenance as 'Площадь технического обслуживания', overhaul as 'Площадь капитального ремонта', 
electric_stoves as 'Наличие электрических плит', priveleges as 'Льготы', area as 'Площадь', garbage_chute as 'Наличие мусоропровода', lift as 'Наличие лифта', sub as 'Наличие субсидий'
from houses_and_apartments
where adres like '%'+ @id + '%'
go


create proc search_tariffs 
@id varchar(100)
as
select gas_tariff as 'Тариф на газ', hot_water_tariff as 'Тариф на горячую воду', cold_water_tariff as 'Тариф на холодную воду', electricity_tariff as 'Тариф на электричество', 
periodd 'Период', garbage_tariff as 'Тариф на вывоз мусора', lift_tariff as 'Тариф на обслуживание лифта', maintenance_tariff as 'Тариф на техническое обслуживание',
overhaul_tariff as 'Тариф на капитальный ремонт', sewage_tariff as 'Тариф на водоотведение'
from tariffs, periodds_tariffs
where periodd like '%'+ @id + '%'  
go



create proc search_sub_tariffs 
@id varchar(100)
as
select sub_gas_tariff as 'Тариф на газ', sub_hot_water_tariff as 'Тариф на горячую воду', sub_cold_water_tariff as 'Тариф на холодную воду', 
sub_electricity_tariff as 'Тариф на электричество', sub_periodd as 'Период', sub_garbage_tariff as 'Тариф на вывоз мусора', 
sub_lift_tariff as 'Тариф на обслуживание лифта', sub_maintenance_tariff as 'Тариф на техническое обслуживание', 
sub_overhaul_tariff as 'Тариф на капитальный ремонт', sub_sewage_tariff as 'Тариф на водоотведение'
from sub_tariffs, sub_periodds_tariffs
where sub_periodd like '%'+ @id + '%'  
go



create proc search_cost_of_services 
@id varchar(100)
as
select id_houses as '№', gas_price as 'Цена за газ', hot_water_price as 'Цена за горячую воду', cold_water_price as 'Цена за холодную воду', electricity_price as 'Цена за электричество', 
garbage_price as 'Стоимость вывоза мысора', adres as 'Адрес', payday_date as 'Дата оплаты', deadline_payday_date as 'Крайний срок оплаты', maintenance_price as 'Цена за техническое обслуживание', 
overhaul_price as 'Цена за капитальный ремонт обслуживание', lift_price as 'Цена за обслуживание лифта', sewage_price as 'Цена за водоотведение', full_price as 'Общая стоимость',
price_with_p as 'Цена с пеней'
from cost_of_services, houses_and_apartments
where id_houses = fk_houses and (gas_price like '%'+ @id + '%' or hot_water_price like '%'+ @id + '%' or cold_water_price like '%'+ @id + '%' or electricity_price like '%'+ @id + '%'
or adres like '%'+ @id + '%' or payday_date like '%'+ @id + '%' or deadline_payday_date like '%'+ @id + '%' )
go
 
 

create proc search_cost_date_period
@date_start date,
@date_fin date
as
select gas_price as 'Цена за газ', hot_water_price as 'Цена за горячую воду', cold_water_price as 'Цена за холодную воду', electricity_price as 'Цена за электричество', 
garbage_price as 'Стоимость вывоза мысора', adres as 'Адрес', payday_date as 'Дата оплаты', deadline_payday_date as 'Крайний срок оплаты', maintenance_price as 'Цена за техническое обслуживание', 
overhaul_price as 'Цена за капитальный ремонт обслуживание', lift_price as 'Цена за обслуживание лифта', sewage_price as 'Цена за водоотведение', full_price as 'Общая стоимость',
price_with_p as 'Цена с пеней'
from cost_of_services, houses_and_apartments
where id_houses = fk_houses and (payday_date between @date_start and @date_fin)
go



create proc search_period_tariffs 
@id varchar(100)
as
select periodd as 'Период', gas_tariff_pe 'Тариф на газ' 
from periodds_tariffs
where periodd like '%'+ @id + '%'  
go



create proc search_sub_period_tariffs 
@id varchar(100)
as
select sub_periodd as 'Период', sub_gas_tariff_pe 'Тариф на газ' 
from sub_periodds_tariffs
where sub_periodd like '%'+ @id + '%'  
go



create trigger calc_cost_of_services 
on cost_of_services 
after insert, update
as 
begin 
SET NOCOUNT ON;
if((convert(decimal(6,2), (select priveleges from houses_and_apartments where id_houses = (select fk_houses from inserted))) = '0'))
begin
-- Расчет стоимости электричества
if((convert(decimal(6,2), (select sub from houses_and_apartments where id_houses = (select fk_houses from inserted))) = '1'))
begin
if((convert(decimal(6,2), (select electric_stoves from houses_and_apartments where id_houses = (select fk_houses from inserted))) = '1'))
begin
update cost_of_services
set electricity_price = (((convert(decimal(6,2),(select electricity_this_month from houses_and_apartments where id_houses = (select fk_houses from inserted))))-
(convert(decimal(6,2),(select electricity_last_month from houses_and_apartments where id_houses = (select fk_houses from inserted)))))*
((convert(decimal(6,2),(select electricity_tariff from tariffs where id_tar = (select fk_tar from inserted))))) - 0.02)
where id_cost =(select id_cost from inserted)
end
else
begin
update cost_of_services
set electricity_price = (((convert(decimal(6,2),(select electricity_this_month from houses_and_apartments where id_houses = (select fk_houses from inserted))))-
(convert(decimal(6,2),(select electricity_last_month from houses_and_apartments where id_houses = (select fk_houses from inserted)))))*
(convert(decimal(6,2),(select electricity_tariff from tariffs where id_tar = (select fk_tar from inserted)))))
where id_cost =(select id_cost from inserted)
end
end
else
begin
if((convert(decimal(6,2), (select electric_stoves from houses_and_apartments where id_houses = (select fk_houses from inserted))) = '1'))
begin
update cost_of_services
set electricity_price = (((convert(decimal(6,2),(select electricity_this_month from houses_and_apartments where id_houses = (select fk_houses from inserted))))-
(convert(decimal(6,2),(select electricity_last_month from houses_and_apartments where id_houses = (select fk_houses from inserted)))))*
((convert(decimal(6,2),(select sub_electricity_tariff from sub_tariffs where id_sub_tar = (select fk_sub_tar from inserted))))) - 0.02)
where id_cost =(select id_cost from inserted)
end
else
begin
update cost_of_services
set electricity_price = (((convert(decimal(6,2),(select electricity_this_month from houses_and_apartments where id_houses = (select fk_houses from inserted))))-
(convert(decimal(6,2),(select electricity_last_month from houses_and_apartments where id_houses = (select fk_houses from inserted)))))*
(convert(decimal(6,2),(select sub_electricity_tariff from sub_tariffs where id_sub_tar = (select fk_sub_tar from inserted)))))
where id_cost =(select id_cost from inserted)
end
end
-- Расчет стоимости вывоза мусора
if((convert(decimal(6,2), (select garbage_chute from houses_and_apartments where id_houses = (select fk_houses from inserted))) = '1'))
begin
update cost_of_services
set garbage_price = convert(decimal(6,2),(2.68 * (convert(decimal(6,2),(select numbers_of_tenants from houses_and_apartments where id_houses = (select fk_houses from inserted)))) / 12) *
((convert(decimal(6,2),(select garbage_tariff from tariffs where id_tar = (select fk_tar from inserted)))) + 1.71))
where id_cost =(select id_cost from inserted)
end
else
begin
update cost_of_services
set garbage_price = convert(decimal(6,2),(2.68 * (convert(decimal(6,2),(select numbers_of_tenants from houses_and_apartments where id_houses = (select fk_houses from inserted)))) / 12) *
((convert(decimal(6,2),(select garbage_tariff from tariffs where id_tar = (select fk_tar from inserted))))))
where id_cost =(select id_cost from inserted)
end
-- Расчет стоимости обслуживания лифтов
if((convert(decimal(6,2), (select lift from houses_and_apartments where id_houses = (select fk_houses from inserted))) = '1'))
begin
update cost_of_services
set lift_price = (convert(decimal(6,2),(select lift_tariff from tariffs where id_tar = (select fk_tar from inserted)))) * 
(convert(decimal(6,2),(select numbers_of_tenants from houses_and_apartments where id_houses = (select fk_houses from inserted))))
where id_cost =(select id_cost from inserted)
end
-- Расчет стоимости газа
if((convert(decimal(6,2), (select sub from houses_and_apartments where id_houses = (select fk_houses from inserted))) = '1'))
begin
update cost_of_services
set gas_price = ((convert(decimal(6,2),(select gas_this_month from houses_and_apartments where id_houses = (select fk_houses from inserted))))-
(convert(decimal(6,2),(select gas_last_month from houses_and_apartments where id_houses = (select fk_houses from inserted)))))*
(convert(decimal(6,2),(select sub_gas_tariff from sub_tariffs where id_sub_tar = (select fk_sub_tar from inserted))))
where id_cost =(select id_cost from inserted)
end
else
begin
update cost_of_services
set gas_price = ((convert(decimal(6,2),(select gas_this_month from houses_and_apartments where id_houses = (select fk_houses from inserted))))-
(convert(decimal(6,2),(select gas_last_month from houses_and_apartments where id_houses = (select fk_houses from inserted)))))*
(convert(decimal(6,2),(select gas_tariff from tariffs where id_tar = (select fk_tar from inserted))))
where id_cost =(select id_cost from inserted)
end
-- Расчет стоимости горячей воды
if((convert(decimal(6,2), (select sub from houses_and_apartments where id_houses = (select fk_houses from inserted))) = '1'))
begin
update cost_of_services
set hot_water_price = convert(decimal(6,2),((convert(decimal(6,2),(select hot_water_this_month from houses_and_apartments where id_houses = (select fk_houses from inserted))))-
(convert(decimal(6,2),(select hot_water_last_month from houses_and_apartments where id_houses = (select fk_houses from inserted))))) *
(convert(decimal(6,2),(select sub_hot_water_tariff from sub_tariffs where id_sub_tar = (select fk_sub_tar from inserted)))))
where id_cost =(select id_cost from inserted)
end
else
begin
update cost_of_services
set hot_water_price = convert(decimal(6,2),((convert(decimal(6,2),(select hot_water_this_month from houses_and_apartments where id_houses = (select fk_houses from inserted))))-
(convert(decimal(6,2),(select hot_water_last_month from houses_and_apartments where id_houses = (select fk_houses from inserted))))) *
(convert(decimal(6,2),(select hot_water_tariff from tariffs where id_tar = (select fk_tar from inserted)))))
where id_cost =(select id_cost from inserted)
end
-- Расчет стоимости холодной воды
if((convert(decimal(6,2), (select sub from houses_and_apartments where id_houses = (select fk_houses from inserted))) = '1'))
begin
update cost_of_services
set cold_water_price = convert(decimal(6,2),((convert(decimal(6,2),(select cold_water_this_month from houses_and_apartments where id_houses = (select fk_houses from inserted))))-
(convert(decimal(6,2),(select cold_water_last_month from houses_and_apartments where id_houses = (select fk_houses from inserted))))) *
(convert(decimal(6,2),(select sub_cold_water_tariff from sub_tariffs where id_sub_tar = (select fk_sub_tar from inserted)))))
where id_cost =(select id_cost from inserted)
end
else
begin
update cost_of_services
set cold_water_price = convert(decimal(6,2),((convert(decimal(6,2),(select cold_water_this_month from houses_and_apartments where id_houses = (select fk_houses from inserted))))-
(convert(decimal(6,2),(select cold_water_last_month from houses_and_apartments where id_houses = (select fk_houses from inserted))))) *
(convert(decimal(6,2),(select cold_water_tariff from tariffs where id_tar = (select fk_tar from inserted)))))
where id_cost =(select id_cost from inserted)
end
-- Расчет остального
update cost_of_services
set maintenance_price = (convert(decimal(6,2),(select maintenance from houses_and_apartments where id_houses = (select fk_houses from inserted)))) *
(convert(decimal(6,2),(select maintenance_tariff from tariffs where id_tar = (select fk_tar from inserted)))),
overhaul_price = (convert(decimal(6,2),(select overhaul from houses_and_apartments where id_houses = (select fk_houses from inserted)))) *
(convert(decimal(6,2),(select overhaul_tariff from tariffs where id_tar = (select fk_tar from inserted))))
where id_cost =(select id_cost from inserted)
end
------------------------------------------------------------ Льготный расчет------------------------------------------------------------------------------------
else
begin
-- Расчет стоимости электричества
if((convert(decimal(6,2), (select sub from houses_and_apartments where id_houses = (select fk_houses from inserted))) = '1'))
begin
if((convert(decimal(6,2), (select electric_stoves from houses_and_apartments where id_houses = (select fk_houses from inserted))) = '1'))
begin
update cost_of_services
set electricity_price = ((((convert(decimal(6,2),(select electricity_this_month from houses_and_apartments where id_houses = (select fk_houses from inserted))))-
(convert(decimal(6,2),(select electricity_last_month from houses_and_apartments where id_houses = (select fk_houses from inserted)))))*
((convert(decimal(6,2),(select electricity_tariff from tariffs where id_tar = (select fk_tar from inserted))))) - 0.02)) / 2
where id_cost =(select id_cost from inserted)
end
else
begin
update cost_of_services
set electricity_price = (((convert(decimal(6,2),(select electricity_this_month from houses_and_apartments where id_houses = (select fk_houses from inserted))))-
(convert(decimal(6,2),(select electricity_last_month from houses_and_apartments where id_houses = (select fk_houses from inserted)))))*
(convert(decimal(6,2),(select electricity_tariff from tariffs where id_tar = (select fk_tar from inserted))))) / 2
where id_cost =(select id_cost from inserted)
end
end
else
begin
if((convert(decimal(6,2), (select electric_stoves from houses_and_apartments where id_houses = (select fk_houses from inserted))) = '1'))
begin
update cost_of_services
set electricity_price = (((convert(decimal(6,2),(select electricity_this_month from houses_and_apartments where id_houses = (select fk_houses from inserted))))-
(convert(decimal(6,2),(select electricity_last_month from houses_and_apartments where id_houses = (select fk_houses from inserted)))))*
((convert(decimal(6,2),(select sub_electricity_tariff from sub_tariffs where id_sub_tar = (select fk_sub_tar from inserted))))) - 0.02) / 2
where id_cost =(select id_cost from inserted)
end
else
begin
update cost_of_services
set electricity_price = (((convert(decimal(6,2),(select electricity_this_month from houses_and_apartments where id_houses = (select fk_houses from inserted))))-
(convert(decimal(6,2),(select electricity_last_month from houses_and_apartments where id_houses = (select fk_houses from inserted)))))*
(convert(decimal(6,2),(select sub_electricity_tariff from sub_tariffs where id_sub_tar = (select fk_sub_tar from inserted))))) / 2
where id_cost =(select id_cost from inserted)
end
end
-- Расчет стоимости вывоза мусора
if((convert(decimal(6,2), (select garbage_chute from houses_and_apartments where id_houses = (select fk_houses from inserted))) = '1'))
begin
update cost_of_services
set garbage_price = convert(decimal(6,2),((2.68 * (convert(decimal(6,2),(select numbers_of_tenants from houses_and_apartments where id_houses = (select fk_houses from inserted)))) / 12) *
((convert(decimal(6,2),(select garbage_tariff from tariffs where id_tar = (select fk_tar from inserted)))) + 1.71)) / 2)
where id_cost =(select id_cost from inserted)
end
else
begin
update cost_of_services
set garbage_price = convert(decimal(6,2),((2.68 * (convert(decimal(6,2),(select numbers_of_tenants from houses_and_apartments where id_houses = (select fk_houses from inserted)))) / 12) *
(convert(decimal(6,2),(select garbage_tariff from tariffs where id_tar = (select fk_tar from inserted))))) / 2)
where id_cost =(select id_cost from inserted)
end
-- Расчет стоимости обслуживания лифтов
if((convert(decimal(6,2), (select lift from houses_and_apartments where id_houses = (select fk_houses from inserted))) = '1'))
begin
update cost_of_services
set lift_price = (((convert(decimal(6,2),(select lift_tariff from tariffs where id_tar = (select fk_tar from inserted)))) * 
(convert(decimal(6,2),(select numbers_of_tenants from houses_and_apartments where id_houses = (select fk_houses from inserted)))))) / 2
where id_cost =(select id_cost from inserted)
end
-- Расчет стоимости газа
if((convert(decimal(6,2), (select sub from houses_and_apartments where id_houses = (select fk_houses from inserted))) = '1'))
begin
update cost_of_services
set gas_price = (((convert(decimal(6,2),(select gas_this_month from houses_and_apartments where id_houses = (select fk_houses from inserted))))-
(convert(decimal(6,2),(select gas_last_month from houses_and_apartments where id_houses = (select fk_houses from inserted)))))*
(convert(decimal(6,2),(select sub_gas_tariff from sub_tariffs where id_sub_tar = (select fk_sub_tar from inserted))))) / 2
where id_cost =(select id_cost from inserted)
end
else
begin
update cost_of_services
set gas_price = (((convert(decimal(6,2),(select gas_this_month from houses_and_apartments where id_houses = (select fk_houses from inserted))))-
(convert(decimal(6,2),(select gas_last_month from houses_and_apartments where id_houses = (select fk_houses from inserted)))))*
(convert(decimal(6,2),(select gas_tariff from tariffs where id_tar = (select fk_tar from inserted))))) / 2
where id_cost =(select id_cost from inserted)
end
-- Расчет стоимости горячей воды
if((convert(decimal(6,2), (select sub from houses_and_apartments where id_houses = (select fk_houses from inserted))) = '1'))
begin
update cost_of_services
set hot_water_price = convert(decimal(6,2),(((convert(decimal(6,2),(select hot_water_this_month from houses_and_apartments where id_houses = (select fk_houses from inserted))))-
(convert(decimal(6,2),(select hot_water_last_month from houses_and_apartments where id_houses = (select fk_houses from inserted))))) *
(convert(decimal(6,2),(select sub_hot_water_tariff from sub_tariffs where id_sub_tar = (select fk_sub_tar from inserted))))) / 2)
where id_cost =(select id_cost from inserted)
end
else
begin
update cost_of_services
set hot_water_price = convert(decimal(6,2),(((convert(decimal(6,2),(select hot_water_this_month from houses_and_apartments where id_houses = (select fk_houses from inserted))))-
(convert(decimal(6,2),(select hot_water_last_month from houses_and_apartments where id_houses = (select fk_houses from inserted))))) *
((convert(decimal(6,2),(select hot_water_tariff from tariffs where id_tar = (select fk_tar from inserted)))))) / 2)
where id_cost =(select id_cost from inserted)
end
-- Расчет стоимости холодной воды
if((convert(decimal(6,2), (select sub from houses_and_apartments where id_houses = (select fk_houses from inserted))) = '1'))
begin
update cost_of_services
set cold_water_price = convert(decimal(6,2),(((convert(decimal(6,2),(select cold_water_this_month from houses_and_apartments where id_houses = (select fk_houses from inserted))))-
(convert(decimal(6,2),(select cold_water_last_month from houses_and_apartments where id_houses = (select fk_houses from inserted))))) *
(convert(decimal(6,2),(select sub_cold_water_tariff from sub_tariffs where id_sub_tar = (select fk_sub_tar from inserted))))) / 2)
where id_cost =(select id_cost from inserted)
end
else
begin
update cost_of_services
set cold_water_price = convert(decimal(6,2),(((convert(decimal(6,2),(select cold_water_this_month from houses_and_apartments where id_houses = (select fk_houses from inserted))))-
(convert(decimal(6,2),(select cold_water_last_month from houses_and_apartments where id_houses = (select fk_houses from inserted))))) *
(convert(decimal(6,2),(select cold_water_tariff from tariffs where id_tar = (select fk_tar from inserted))))) / 2)
where id_cost =(select id_cost from inserted)
end
-- Расчет остального
update cost_of_services
set maintenance_price = ((convert(decimal(6,2),(select maintenance from houses_and_apartments where id_houses = (select fk_houses from inserted)))) *
(convert(decimal(6,2),(select maintenance_tariff from tariffs where id_tar = (select fk_tar from inserted)))) / 2),
overhaul_price = ((convert(decimal(6,2),(select overhaul from houses_and_apartments where id_houses = (select fk_houses from inserted)))) *
(convert(decimal(6,2),(select overhaul_tariff from tariffs where id_tar = (select fk_tar from inserted))))) / 2
where id_cost =(select id_cost from inserted)
end
begin
update cost_of_services
set full_price = ((convert(decimal(6,2), (select gas_price from inserted))) + (convert(decimal(6,2), (select hot_water_price from inserted))) + 
(convert(decimal(6,2), (select cold_water_price from inserted))) + (convert(decimal(6,2), (select electricity_price from inserted))) + (convert(decimal(6,2), (select lift_price from inserted))) + 
(convert(decimal(6,2), (select garbage_price from inserted))) + (convert(decimal(6,2), (select maintenance_price from inserted))) + (convert(decimal(6,2), (select overhaul_price from inserted)))+
(convert(decimal(6,2), (select sewage_price from inserted)))) - (convert(decimal(6,2), (select pay from inserted)))
where id_cost =(select id_cost from inserted)
end
if((select payday_date from inserted) >= (select deadline_payday_date from inserted))
begin
update cost_of_services
set price_with_p = convert(decimal(6,2),(convert(decimal(6,2), (select full_price from inserted))) + (((convert(decimal(6,2), (select full_price from inserted))) * 0.3 / 100) *
datediff(day, (select deadline_payday_date from inserted), (select payday_date from inserted))))
where id_cost =(select id_cost from inserted)
end
end
go



create trigger calc_full
on cost_of_services 
after insert, update
as 
begin 
SET NOCOUNT ON;
IF TRIGGER_NESTLEVEL() > 1 RETURN 
update cost_of_services
set full_price = ((convert(decimal(6,2), (select gas_price from inserted))) + (convert(decimal(6,2), (select hot_water_price from inserted))) + 
(convert(decimal(6,2), (select cold_water_price from inserted))) + (convert(decimal(6,2), (select electricity_price from inserted))) + (convert(decimal(6,2), (select lift_price from inserted))) + 
(convert(decimal(6,2), (select garbage_price from inserted))) + (convert(decimal(6,2), (select maintenance_price from inserted))) + (convert(decimal(6,2), (select overhaul_price from inserted)))+
(convert(decimal(6,2), (select sewage_price from inserted)))) - (convert(decimal(6,2), (select pay from inserted)))
where id_cost =(select id_cost from inserted)
end
go



create trigger calc_sewage_price
on cost_of_services
after insert, update
as 
begin 
SET NOCOUNT ON;
IF TRIGGER_NESTLEVEL() > 1 RETURN 
update cost_of_services
set sewage_price = (((convert(decimal(6,2),(select hot_water_this_month from houses_and_apartments where id_houses = (select fk_houses from inserted))))-
(convert(decimal(6,2),(select hot_water_last_month from houses_and_apartments where id_houses = (select fk_houses from inserted))))) + 
((convert(decimal(6,2),(select cold_water_this_month from houses_and_apartments where id_houses = (select fk_houses from inserted)))) -
(convert(decimal(6,2),(select cold_water_last_month from houses_and_apartments where id_houses = (select fk_houses from inserted)))))) *
(convert(decimal(6,2),(select sewage_tariff from tariffs where id_tar = (select fk_tar from inserted))))
where id_cost =(select id_cost from inserted)
end
go



create trigger calc_price_with_p
on cost_of_services 
after insert, update
as 
begin 
SET NOCOUNT ON;
IF TRIGGER_NESTLEVEL() > 1 RETURN 
if((select payday_date from inserted) >= (select deadline_payday_date from inserted))
begin
update cost_of_services
set price_with_p = (convert(decimal(6,2), (select full_price from inserted))) + (((convert(decimal(6,2), (select full_price from inserted))) * 0.3 / 100) *
datediff(day, (select deadline_payday_date from inserted), (select payday_date from inserted)))
where id_cost = (select id_cost from inserted)
end
end
go



create trigger calc_gas
on tariffs
after insert, update
as 
begin 
SET NOCOUNT ON;
update tariffs
set gas_tariff = gas_tariff + (convert(decimal(6,2),(select gas_tariff_pe from periodds_tariffs where id_pe = (select fk_pe from inserted))))
where id_tar = (select id_tar from inserted)
end
go



create trigger calc_sub_gas
on sub_tariffs
after insert, update
as 
begin 
SET NOCOUNT ON;
update sub_tariffs
set sub_gas_tariff = sub_gas_tariff + (convert(decimal(6,2),(select sub_gas_tariff_pe from sub_periodds_tariffs where id_sub_pe = (select fk_sub_pe from inserted))))
where id_sub_tar = (select id_sub_tar from inserted)
end
go



create trigger calc_report
on report
after insert, update
as 
begin 
SET NOCOUNT ON;
update report
set gas_rep = (convert(decimal(6,2),(select gas_price from cost_of_services where id_cost = (select fk_cost from inserted)))),
hot_water_rep = (convert(decimal(6,2),(select hot_water_price from cost_of_services where id_cost = (select fk_cost from inserted)))),
cold_water_rep = (convert(decimal(6,2),(select cold_water_price from cost_of_services where id_cost = (select fk_cost from inserted)))),
electricity_rep = (convert(decimal(6,2),(select electricity_price from cost_of_services where id_cost = (select fk_cost from inserted)))),
garbage_rep = (convert(decimal(6,2),(select garbage_price from cost_of_services where id_cost = (select fk_cost from inserted)))),
full_rep = (convert(decimal(6,2),(select full_price from cost_of_services where id_cost = (select fk_cost from inserted)))),
price_with_p_rep = (convert(decimal(6,2),(select price_with_p from cost_of_services where id_cost = (select fk_cost from inserted)))),
pay_rep = (convert(decimal(6,2),(select pay from cost_of_services where id_cost = (select fk_cost from inserted)))),
payday_date_rep = (select payday_date from cost_of_services where id_cost = (select fk_cost from inserted)),
deadline_payday_date_rep = (select deadline_payday_date from cost_of_services where id_cost = (select fk_cost from inserted)),
lift_rep = (select lift_price from cost_of_services where id_cost = (select fk_cost from inserted)),
maintenance_rep = (select maintenance_price from cost_of_services where id_cost = (select fk_cost from inserted)),
overhaul_rep = (select overhaul_price from cost_of_services where id_cost = (select fk_cost from inserted)),
sewage_rep = (select sewage_price from cost_of_services where id_cost = (select fk_cost from inserted))
where id_rep = (select id_rep from inserted)
end
go



create trigger calc_houses_rep
on report_houses_and_apartments 
after insert, update
as 
begin 
SET NOCOUNT ON;
update report_houses_and_apartments 
set adres_rep = (select adres from houses_and_apartments where id_houses = (select fk_houses_rep from inserted)),
numbers_of_tenants_rep = (convert(decimal(6,2),(select numbers_of_tenants from houses_and_apartments where id_houses = (select fk_houses_rep from inserted)))),
gas_this_month_rep = (convert(decimal(6,2),(select gas_this_month from houses_and_apartments where id_houses = (select fk_houses_rep from inserted)))),
hot_water_this_month_rep = (convert(decimal(6,2),(select hot_water_this_month from houses_and_apartments where id_houses = (select fk_houses_rep from inserted)))),
cold_water_this_month_rep = (convert(decimal(6,2),(select cold_water_this_month from houses_and_apartments where id_houses = (select fk_houses_rep from inserted)))),
electricity_this_month_rep = (convert(decimal(6,2),(select electricity_this_month from houses_and_apartments where id_houses = (select fk_houses_rep from inserted)))),
gas_last_month_rep = (convert(decimal(6,2),(select gas_last_month from houses_and_apartments where id_houses = (select fk_houses_rep from inserted)))),
hot_water_last_month_rep = (convert(decimal(6,2),(select hot_water_last_month from houses_and_apartments where id_houses = (select fk_houses_rep from inserted)))),
cold_water_last_month_rep = (convert(decimal(6,2),(select cold_water_last_month from houses_and_apartments where id_houses = (select fk_houses_rep from inserted)))),
electricity_last_month_rep = (convert(decimal(6,2),(select electricity_last_month from houses_and_apartments where id_houses = (select fk_houses_rep from inserted)))),
maintenance_rep_houses = (convert(decimal(6,2),(select maintenance from houses_and_apartments where id_houses = (select fk_houses_rep from inserted)))),
overhaul_rep_houses = (convert(decimal(6,2),(select overhaul from houses_and_apartments where id_houses = (select fk_houses_rep from inserted)))),
area_rep = (convert(decimal(6,2),(select area from houses_and_apartments where id_houses = (select fk_houses_rep from inserted)))),
garbage_chute_rep = (convert(decimal(6,2),(select garbage_chute from houses_and_apartments where id_houses = (select fk_houses_rep from inserted)))),
electric_stoves_rep = (convert(decimal(6,2),(select electric_stoves from houses_and_apartments where id_houses = (select fk_houses_rep from inserted)))),
priveleges_rep = (convert(decimal(6,2),(select priveleges from houses_and_apartments where id_houses = (select fk_houses_rep from inserted)))),
lift_rep_houses = (convert(decimal(6,2),(select lift from houses_and_apartments where id_houses = (select fk_houses_rep from inserted)))),
sub_rep = (convert(decimal(6,2),(select sub from houses_and_apartments where id_houses = (select fk_houses_rep from inserted)))),
FIO_rep = (select FIO from houses_and_apartments where id_houses = (select fk_houses_rep from inserted)),
date_add_rep = (select date_add from houses_and_apartments where id_houses = (select fk_houses_rep from inserted))
where id_houses_rep = (select id_houses_rep from inserted)
end
go


create trigger auto_same_houses on houses_and_apartments 
for insert,update
as 
begin 
SET NOCOUNT ON; 
IF TRIGGER_NESTLEVEL() > 1 RETURN 
if exists (select h.adres from houses_and_apartments h, inserted i where h.adres = i.adres and h.id_houses < i.id_houses) 
begin
update houses_and_apartments 
set gas_last_month = (select MAX(h.gas_this_month) from houses_and_apartments h  inner join inserted i on h.id_houses < i.id_houses where h.[adres] = i.[adres] and h.adres = i.adres),
hot_water_last_month = (select MAX(h.hot_water_this_month) from houses_and_apartments h  inner join inserted i on h.id_houses < i.id_houses where h.[adres] = i.[adres] and h.adres = i.adres),
cold_water_last_month = (select MAX(h.cold_water_this_month) from houses_and_apartments h  inner join inserted i on h.id_houses < i.id_houses where h.[adres] = i.[adres] and h.adres = i.adres),
electricity_last_month = (select MAX(h.electricity_this_month) from houses_and_apartments h  inner join inserted i on h.id_houses < i.id_houses where h.[adres] = i.[adres] and h.adres = i.adres)
where id_houses = (select id_houses from inserted)
end
end
go



insert into houses_and_apartments 
(adres, numbers_of_tenants, gas_this_month, hot_water_this_month, cold_water_this_month, electricity_this_month, gas_last_month, hot_water_last_month, 
cold_water_last_month, electricity_last_month, maintenance, overhaul, electric_stoves, priveleges, area, garbage_chute, lift, sub, FIO, date_add)
values('ул.Колесникова 3', '4', '200', '120', '808', '800', '100', '110', '100', '400',  '30', '', '1', '1', '30', '1', '1', '1', 'Рубин А.С.', '15.07.2019') 
go 
insert into houses_and_apartments 
(adres, numbers_of_tenants, gas_this_month, hot_water_this_month, cold_water_this_month, electricity_this_month, gas_last_month, hot_water_last_month, 
cold_water_last_month, electricity_last_month, maintenance, overhaul, electric_stoves, priveleges, area, garbage_chute, lift, sub, FIO, date_add) 
values('ул.Ленина 5', '5', '300', '270', '150', '840', '130', '150', '125', '414', '23', '45', '0', '0', '25', '0', '1', '0', 'Валицкий А.Б.', '16.06.2019') 
go
insert into houses_and_apartments 
(adres, numbers_of_tenants, gas_this_month, hot_water_this_month, cold_water_this_month, electricity_this_month, gas_last_month, hot_water_last_month, 
cold_water_last_month, electricity_last_month, maintenance, overhaul, electric_stoves, priveleges, area, garbage_chute, lift, sub, FIO, date_add) 
values('ул.Пушкина 8', '3', '400', '370', '250', '940', '212', '225', '215', '414', '10', '22', '0', '1', '40', '1', '0', '1', 'Горбель В.К.', '17.06.2019') 
go
insert into houses_and_apartments 
(adres, numbers_of_tenants, gas_this_month, hot_water_this_month, cold_water_this_month, electricity_this_month, gas_last_month, hot_water_last_month, 
cold_water_last_month, electricity_last_month, maintenance, overhaul, electric_stoves, priveleges, area, garbage_chute, lift, sub, FIO, date_add) 
values('ул.Рубина 8', '4', '500', '470', '350', '1040', '312', '205', '315', '514', '', '56', '1', '0', '20', '0', '0', '1', 'Уткин Н.И.', '18.06.2019') 
go
insert into houses_and_apartments 
(adres, numbers_of_tenants, gas_this_month, hot_water_this_month, cold_water_this_month, electricity_this_month, gas_last_month, hot_water_last_month, 
cold_water_last_month, electricity_last_month, maintenance, overhaul, electric_stoves, priveleges, area, garbage_chute, lift, sub, FIO, date_add) 
values('ул.Скарины 5', '2', '510', '480', '360', '1050', '322', '215', '325', '524', '0', '66', '0', '0', '20', '0', '0', '1', 'Хацкевич П.А.', '19.06.2019') 
go
insert into houses_and_apartments 
(adres, numbers_of_tenants, gas_this_month, hot_water_this_month, cold_water_this_month, electricity_this_month, gas_last_month, hot_water_last_month, 
cold_water_last_month, electricity_last_month, maintenance, overhaul, electric_stoves, priveleges, area, garbage_chute, lift, sub, FIO, date_add) 
values('ул.Рубина 8', '4', '550', '490', '370', '1342', '', '', '', '', '', '56', '1', '0', '20', '0', '0', '1', 'Уткин Н.И.', '15.07.2019') 
go
insert into houses_and_apartments 
(adres, numbers_of_tenants, gas_this_month, hot_water_this_month, cold_water_this_month, electricity_this_month, gas_last_month, hot_water_last_month, 
cold_water_last_month, electricity_last_month, maintenance, overhaul, electric_stoves, priveleges, area, garbage_chute, lift, sub, FIO, date_add) 
values('ул.Скарины 5', '2', '642', '490', '373', '1250', '', '', '', '', '0', '66', '0', '0', '20', '0', '0', '1', 'Хацкевич П.А.', '19.07.2019') 
go
insert into houses_and_apartments 
(adres, numbers_of_tenants, gas_this_month, hot_water_this_month, cold_water_this_month, electricity_this_month, gas_last_month, hot_water_last_month, 
cold_water_last_month, electricity_last_month, maintenance, overhaul, electric_stoves, priveleges, area, garbage_chute, lift, sub, FIO, date_add) 
values('ул.Рубина 8', '4', '600', '500', '393', '1551', '', '', '', '', '', '56', '1', '0', '20', '0', '0', '1', 'Уткин Н.И.', '15.08.2019') 
go
insert into houses_and_apartments 
(adres, numbers_of_tenants, gas_this_month, hot_water_this_month, cold_water_this_month, electricity_this_month, gas_last_month, hot_water_last_month, 
cold_water_last_month, electricity_last_month, maintenance, overhaul, electric_stoves, priveleges, area, garbage_chute, lift, sub, FIO, date_add) 
values('ул.Скарины 5', '2', '680', '505', '401', '1462', '', '', '', '', '0', '66', '0', '0', '20', '0', '0', '1', 'Хацкевич П.А.', '19.08.2019') 
go
insert into houses_and_apartments 
(adres, numbers_of_tenants, gas_this_month, hot_water_this_month, cold_water_this_month, electricity_this_month, gas_last_month, hot_water_last_month, 
cold_water_last_month, electricity_last_month, maintenance, overhaul, electric_stoves, priveleges, area, garbage_chute, lift, sub, FIO, date_add) 
values('ул.Ленина 5', '5', '480', '305', '201', '1062', '', '', '', '', '0', '66', '0', '0', '20', '0', '0', '1', 'Хацкевич П.А.', '19.08.2019') 
go




insert into report_houses_and_apartments 
(adres_rep, numbers_of_tenants_rep, gas_this_month_rep, hot_water_this_month_rep, cold_water_this_month_rep, electricity_this_month_rep, 
gas_last_month_rep, hot_water_last_month_rep, cold_water_last_month_rep, electricity_last_month_rep, maintenance_rep_houses, overhaul_rep_houses, electric_stoves_rep, 
priveleges_rep, area_rep, garbage_chute_rep, lift_rep_houses, sub_rep, fk_houses_rep, FIO_rep, date_add_rep)
values('', '', '', '', '', '', '', '', '', '',  '', '', '', '', '', '', '', '', '1', '', '') 
go 



insert into periodds_tariffs
(periodd, gas_tariff_pe)
values('Зима 1', '0.1143')
go
insert into periodds_tariffs
(periodd, gas_tariff_pe)
values('Зима 2', '0.1190')
go
insert into periodds_tariffs
(periodd, gas_tariff_pe)
values('Лето', '0.4114')
go
insert into periodds_tariffs
(periodd, gas_tariff_pe)
values('Обычный', '0.4319')
go



insert into sub_periodds_tariffs
(sub_periodd, sub_gas_tariff_pe)
values('Зима 1', '0.1015')
go
insert into sub_periodds_tariffs
(sub_periodd, sub_gas_tariff_pe)
values('Зима 2', '0.1190')
go
insert into sub_periodds_tariffs
(sub_periodd, sub_gas_tariff_pe)
values('Лето', '0.3275')
go
insert into sub_periodds_tariffs
(sub_periodd, sub_gas_tariff_pe)
values('Обычный', '0.4011')
go


 
insert into tariffs 
(gas_tariff, hot_water_tariff, cold_water_tariff, electricity_tariff, garbage_tariff, lift_tariff, maintenance_tariff, overhaul_tariff, sewage_tariff, fk_pe, ses) 
values('', '0.9204', '0.9204', '0.1746', '8.4061', '1.4000', '0.1187', '0.1001', '0.7449', '2', 'Зима2') 
go
insert into tariffs 
(gas_tariff, hot_water_tariff, cold_water_tariff, electricity_tariff, garbage_tariff, lift_tariff, maintenance_tariff, overhaul_tariff, sewage_tariff, fk_pe, ses) 
values('', '0.9204', '0.9204', '0.1746', '8.4061', '1.4000', '0.1187', '0.1001', '0.7449', '3', 'Лето') 
go
insert into tariffs 
(gas_tariff, hot_water_tariff, cold_water_tariff, electricity_tariff, garbage_tariff, lift_tariff, maintenance_tariff, overhaul_tariff, sewage_tariff, fk_pe, ses) 
values('', '0.9204', '0.9204', '0.1746', '8.4061', '1.4000', '0.1187', '0.1001', '0.7449', '1', 'Зима1') 
go
insert into tariffs 
(gas_tariff, hot_water_tariff, cold_water_tariff, electricity_tariff, garbage_tariff, lift_tariff, maintenance_tariff, overhaul_tariff, sewage_tariff, fk_pe, ses) 
values('', '0.9204', '0.9204', '0.1746', '8.4061', '1.4000', '0.1187', '0.1001', '0.7449', '4', 'Обычный') 
go



insert into sub_tariffs 
(sub_gas_tariff, sub_hot_water_tariff, sub_cold_water_tariff, sub_electricity_tariff, sub_garbage_tariff, sub_lift_tariff, sub_maintenance_tariff, sub_overhaul_tariff, sub_sewage_tariff, 
fk_sub_pe, sub_ses) 
values('', '0.8338', '0.8338', '0.1746', '8.4061', '1.4000', '0.1187', '0.1001', '0.6383', '2', 'Зима2') 
go
insert into sub_tariffs 
(sub_gas_tariff, sub_hot_water_tariff, sub_cold_water_tariff, sub_electricity_tariff, sub_garbage_tariff, sub_lift_tariff, sub_maintenance_tariff, sub_overhaul_tariff, sub_sewage_tariff, 
fk_sub_pe, sub_ses) 
values('', '0.8338', '0.8338', '0.1746', '8.4061', '1.4000', '0.1187', '0.1001', '0.6383', '3', 'Лето') 
go
insert into sub_tariffs 
(sub_gas_tariff, sub_hot_water_tariff, sub_cold_water_tariff, sub_electricity_tariff, sub_garbage_tariff, sub_lift_tariff, sub_maintenance_tariff, sub_overhaul_tariff, sub_sewage_tariff, 
fk_sub_pe, sub_ses) 
values('', '0.8338', '0.8338', '0.1746', '8.4061', '1.4000', '0.1187', '0.1001', '0.6383', '1', 'Зима1') 
go
insert into sub_tariffs 
(sub_gas_tariff, sub_hot_water_tariff, sub_cold_water_tariff, sub_electricity_tariff, sub_garbage_tariff, sub_lift_tariff, sub_maintenance_tariff, sub_overhaul_tariff, sub_sewage_tariff, 
fk_sub_pe, sub_ses) 
values('', '0.8338', '0.8338', '0.1746', '8.4061', '1.4000', '0.1187', '0.1001', '0.6383', '4', 'Обычный') 
go
 


insert into cost_of_services 
(gas_price, cold_water_price, hot_water_price, electricity_price, garbage_price, lift_price, pay, full_price, price_with_p, maintenance_price, overhaul_price, sewage_price, fk_houses, fk_tar, 
fk_sub_tar, payday_date, deadline_payday_date) 
values('', '', '', '', '', '', '700', '', '', '', '', '', '1', '1', '1', '30.06.2019', '25.06.2019') 
go
insert into cost_of_services 
(gas_price, cold_water_price, hot_water_price, electricity_price, garbage_price, lift_price, pay, full_price, price_with_p, maintenance_price, overhaul_price, sewage_price, fk_houses, fk_tar, 
fk_sub_tar, payday_date, deadline_payday_date) 
values('', '', '', '', '', '', '', '', '', '', '', '', '2', '2', '2', '', '25.06.2019') 
go
insert into cost_of_services 
(gas_price, cold_water_price, hot_water_price, electricity_price, garbage_price, lift_price, pay, full_price, price_with_p, maintenance_price, overhaul_price, sewage_price, fk_houses, fk_tar, 
fk_sub_tar, payday_date, deadline_payday_date) 
values('', '', '', '', '', '', '', '', '', '', '', '', '3', '3', '3', '', '25.06.2019') 
go
insert into cost_of_services 
(gas_price, cold_water_price, hot_water_price, electricity_price, garbage_price, lift_price, pay, full_price, price_with_p, maintenance_price, overhaul_price, sewage_price, fk_houses, fk_tar, 
fk_sub_tar, payday_date, deadline_payday_date) 
values('', '', '', '', '', '', '200', '', '', '', '', '', '4', '3', '4', '27.06.2019', '25.06.2019') 
go
insert into cost_of_services 
(gas_price, cold_water_price, hot_water_price, electricity_price, garbage_price, lift_price, pay, full_price, price_with_p, maintenance_price, overhaul_price, sewage_price, fk_houses, fk_tar, 
fk_sub_tar, payday_date, deadline_payday_date) 
values('', '', '', '', '', '', '0', '', '', '', '', '', '5', '4', '4', '23.06.2019', '25.06.2019') 
go
insert into cost_of_services 
(gas_price, cold_water_price, hot_water_price, electricity_price, garbage_price, lift_price, pay, full_price, price_with_p, maintenance_price, overhaul_price, sewage_price, fk_houses, fk_tar, 
fk_sub_tar, payday_date, deadline_payday_date) 
values('', '', '', '', '', '', '0', '', '', '', '', '', '6', '4', '4', '23.06.2019', '25.06.2019') 
go



insert into report 
(gas_rep, cold_water_rep, hot_water_rep, electricity_rep, garbage_rep, lift_rep, maintenance_rep, overhaul_rep, pay_rep, full_rep, price_with_p_rep, sewage_rep, fk_cost, payday_date_rep, 
deadline_payday_date_rep) 
values('', '', '', '', '', '', '', '', '', '', '', '', '1', '', '') 
go



select * from periodds_tariffs
select * from tariffs
select * from sub_tariffs
select * from houses_and_apartments
select * from cost_of_services
select * from report
select * from report_houses_and_apartments
 