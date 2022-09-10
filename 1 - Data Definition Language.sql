-- SQL: Structured Query Language: Veritabanýnda sorgular üzerinden veritabaný iþlemleri yapabildiðimiz dildir.
-- T-SQL: Transact Structured Query Language: Microsoft SQL Server'ýn kullandýðý özelleþtirilmiþ SQL'dir.

-- T-SQL'de yorum satýrlarý -- ... ile ... olan yer için tek satýr olarak veya /* ... */ ile ... olan yer için birden çok
-- satýr þeklinde yazýlýr.

-- DATA DEFINITION LANGUAGE (DDL): Veritabanýnda veriyi sakladýðýmýz veya kullandýðýmýz yapýlarý oluþturmak, deðiþtirmek 
-- veya silmek için kullanýlýr.

-- Örnek olarak database (veritabaný), table (tablo), column(sütun) ve view'ler (dinamik görünümler) için 
-- DDL sorgularý çalýþtýrýlabilir.

-- DDL sorgularý kullanýlmadan da Microsoft SQL Server design sayfalarý üzerinden veritabaný, tablo, tablolar arasý iliþkiler
-- vb. iþlemleri yapýlabilir.

-- master: Sunucudaki veritabanlarýmýzýn yapýlarýyla ilgili verilerin saklandýðý veritabanýdýr.

-- Ýki çalýþtýrýlan SQL sorgusu arasýna go konularak mutlaka birincinin iþleminin bitmesi saðlanabilir, daha sonra diðeri çalýþýr.

-- Yeni bir veritabaný oluþturulurken önce master veritabaný üzerinden oluþturucaðýmýz veritabaný (Filmler) var mý kontrolü yapýlýr,
-- eðer varsa bu veritabaný drop database Filmler sorgusu ile silinir.

-- create database Filmler ile yeni veritabaný oluþturulur.

-- use Filmler ile Filmler veritabanýnýn kullanýlmasý saðlanýr, sonrasýnda sorgular Filmler veritabaný üzerinde çalýþacaktýr.

-- create table Film ile yeni tablo oluþturulur. Bu tablo Yonetmen ile 1 to many, Tur ile many to many iliþkilidir.

-- primary key (birincil anahtar): Bir tablodaki her bir satýrda tanýmlandýðý sütun için tekil veri tutulmasýný saðlar.

-- identity(1, 1): identity ile bu verinin soldaki 1 deðeri ile 1'den baþlamasý, saðdaki 1 deðeri ile de birer birer artmasý saðlanýr.
-- Eðer veritabanýnýn bu veriyi otomatik arttýrmasý istenmiyorsa identity(1, 1) yazmaya gerek yoktur.

-- foreign key (yabancýl anahtar): Bir tabloya iliþkili olduðu baþka tablodan taþýnan ve taþýndýðý tabloda primary key olan sütundur.

-- bigint, int, smallint, tinyint ve bit saklayabildikleri deðerler bakýmýndan büyükten küçüðe doðru tam sayý verilerinin 
-- tutulmasý için kullanýlan veri tipleridir.

-- varchar, char ve text metinsel verilerin tutulmasý için kullanýlan veri tipleridir.

-- varchar(uzunluk) ve char(uzunluk) ile parantez içinde maksimum kaç karakter metinsel veri tutulabileceði yani uzunluk belirtilir.
-- varchar(max) ve char(max) ile SQL Server'da tanýmlý olan ve versiyonlara göre deðiþen maksimum karakter sayýsý tanýmlanabilir.
-- text için max tanýmlamaya gerek yoktur, bu veri tipi çok büyük metinsel verilerin tutulmasý için kullanýlýr.

-- Tutulan varchar verisinin uzunluðu girilen veriye göre deðiþirken char verinin uzunluðu sabittir, 
-- veri girilmeyen karakterler boþluk olarak tutulur.

-- Eðer veritabanýnýn collation'ý (verileri saklamak için kullandýðý dil) Türkçe (TURKISH_CI_AS) olarak tanýmlanmamýþsa metinsel
-- veri tiplerinin baþýna n konularak (nvarchar, nchar, ntext) bu verilerin unicode karakter kümesi kullanýlarak saklanmasý 
-- saðlanýr ki Türkçe veriler için bir sorun olmasýn. Bu þekilde tanýmlanan sütunlara veri girilirken de baþýna N eklenir.

-- null: Veri giriþi yapýlan sütunda hiç bir verinin saklanmamasý için kullanýlýr, özel bir boþ veri olarak düþünülebilir.

-- Ondalýk veriler için genel olarak float veri tipi kullanýlýr.

-- Ondalýk sayýlarda tam kýsým ile ondalýklý kýsým özelleþtirmeleri için decimal veri tipi kullanýlabilir.
-- Örneðin decimal(9, 2) bize sayýnýn nokta ile beraber 9 hane olacaðýný, 2 ise noktadan sonraki hane sayýsýný belirtir.

-- Para verisi de ondalýk sayý olduðundan money veri tipi ile özelleþtirilmiþ ve kullanýmýmýza sunulmuþtur.

-- Tarih verilerinde sadece tarih için date veri tipi, tarih ve saat içinse datetime veri tipi tanýmlanabilir.
-- T-SQL tarih formatý: yýl-ay-gün saat:dakika:saniye.milisaniye (Örnek: 2021-09-07 17:25:50.123)

-- Metinsel olmayan yani ikilik sistemde oluþturulmuþ imaj gibi veriler image, varbinary(uzunluk) veya binary(uzunluk) veri tipleriyle saklanabilir.

-- alter komutu veritabaný dahil herhangi bir veritabaný yapýsýnýn deðiþtirilmesi için kullanýlýr.
-- Örneðin database, table, column ve view'ler için kullanýlabilir.

-- drop komutu veritabaný dahil herhangi bir veritabaný yapýsýnýn silinmesi için kullanýlýr.
-- Örneðin database, table, column ve view'ler için kullanýlabilir.

use master
go
if exists (select name from sys.databases where name = 'Filmler')
begin
	alter database Filmler set single_user with rollback immediate -- veritabaný baðlantýsýný koparmak için özel sorgu
	drop database Filmler -- veritabanýný silen esas sorgu
end
go
create database Filmler
go
use Filmler
go
create table Film -- Yonetmen ile 1 to many tablosu, Tur ile many to many tablosu, FilmDetay ile 1 to 1 tablosu
(
	Id int primary key identity(1, 1), -- 1. primary key tanýmlama yöntemi
	Adi varchar(300) not null,
	YapimYili char(4),
	YonetmenId int null, -- null: Herhangi bir filmin yönetmeni olmayabilir, not null: Her filmin bir yönetmeni olmalýdýr.
						 -- Yonetmen tablosundan taþýndýðý için foreign key'dir.
						 -- Eðer sütunda null verilere izin verilecekse null yazmaya gerek yoktur.
	Gisesi money,
	HataliSutun int -- örnek için silinecek sütun
)
create table FilmDetay -- Film ile 1 to 1 tablosu
(
	FilmId int primary key,
	Maliyeti decimal(9, 2) not null,
	Aciklamasi varchar(MAX)
)
create table Yonetmen
(
	Id int primary key identity(1, 1),
	Adi varchar(50) not null,
	Soyadi varchar(50) not null,
	DogumTarihi date,
	EmekliMi bit
)
create table Tur
(
	Id int primary key identity(1, 1),
	Adi varchar(1) -- örnek için düzeltilecek sütun
)
create table FilmTur -- Film ve Tur için many to many tablosu
(
	FilmId int not null, -- Film tablosundan taþýndýðý için foreign key'dir.
	TurId int not null, -- Tur tablosundan taþýndýðý için foreign key'dir.
	constraint PK_FilmTur PRIMARY KEY (FilmId, TurId) -- 2. primary key tanýmlama yöntemi, 
													  -- burada olduðu gibi birden çok sütun primary key olarak tanýmlanabilir.
)
create table Hatalitablo -- örnek için silinecek tablo
(
	Id int primary key
)

alter table Tur alter column Adi varchar(25) not null -- örnek için Tur tablosundaki adi sütununun veri tipini 
												      -- null girilemeyecek þekilde varchar(25) olarak deðiþtiriyoruz.
alter table Film drop column HataliSutun -- örnek için Film tablosundaki hatalý sütunu siliyoruz.

drop table Hatalitablo -- örnek için hatalý oluþturduðumuz tabloyu siliyoruz.

-- Tablolar arasý iliþkiler:

-- Film ile Yonetmen arasýndaki 1 to many iliþki için Film tablosuna bir foreign key constraint (kýsýtlama) ekleyerek
-- bu constraint'in Film tablosundaki yonetmenid ile Yonetmen tablosundaki id sütunlarý için olduðunu belirtiyoruz.
alter table Film add constraint FK_Film_Yonetmen foreign key (YonetmenId) references Yonetmen(Id)

-- Dolayýsýyla Film ile Yonetmen tablolarý arasýnda 1 to many iliþki oluþturmuþ oluyoruz.

-- Film ile FilmTur arasýndaki 1 to many iliþki için FilmTur tablosuna bir foreign key constraint ekleyerek
-- bu constraint'in FilmTur tablosundaki filmid ile Film tablosundaki id sütunlarý için olduðunu belirtiyoruz.
alter table FilmTur add constraint FK_FilmTur_Film foreign key (FilmId) references Film(Id)

-- Tur ile FilmTur arasýndaki 1 to many iliþki için FilmTur tablosuna bir foreign key constraint ekleyerek
-- bu constraint'in FilmTur tablosundaki turid ile Tur tablosundaki id sütunlarý için olduðunu belirtiyoruz.
alter table FilmTur add constraint FK_FilmTur_Tur foreign key (TurId) references Tur(Id)

-- Dolayýsýyla Film ile Tur tablolarý arasýnda many to many iliþki oluþturmuþ oluyoruz.

-- Film ile FilmDetay arasýndaki 1 to 1 iliþki için FilmDetay tablosuna bir foreign key constraint ekleyerek
-- bu constraint'in Film tablosundaki id ile FilmDetay tablosundaki filmid sütunlarý için olduðunu belirtiyoruz.
alter table FilmDetay add constraint FK_FilmDetay_Film foreign key (FilmId) references Film(Id)