-- SELECT: Bir veritabanýndaki bir veya daha fazla tablo üzerinden veri sorgulamak ve getirmek için kullanýlýr.

use Filmler -- Filmler veritabanýný kullan

-- *: tüm sütunlar, select: nelerin döneceði, from: hangi tablodan
select * from Film

select Id, adi, yapimyili, yonetmenId, gisesi from Film

-- SQL sorgularýnda sadece ihtiyacýmýz olan sütunlarý getirmekte fayda var.

-- select ile getirilen bir sütun adý as veya as kullanmadan geçici olarak deðiþtirilebilir (alias). Bu iþleme aliasing denir.
-- Sütunlara alias tanýmlayabildiðimiz gibi alias'larý tablolara da tanýmlayabiliriz, yani sorguda kullandýðýmýz
-- isimlerini geçici olarak deðiþtirebiliriz.
-- Eðer arada boþluk karakteri ile alias tanýmlanmak isteniyorsa [] arasýna sütun adý yazýlmalýdýr.
select Id as [Film ID], adi as [Film Adi], yapimyili [Yapim Yili], yonetmenId YonetmenID, gisesi [Gisesi] from Film

-- SQL'de metinsel ifadeler tek týrnakla ifade edilir. Burada adi ile soyadi sütunlarýný arada boþluk ile 
-- birleþtiriyoruz (concatenation), yonetmenadisoyadi isimli bir sütuna alias vererek dogumtarihi ile birlikte çekiyoruz.
select adi + ' ' + soyadi as yonetmenadisoyadi, dogumtarihi from Yonetmen

-- select ile çekilen veriler bir veya birden çok sütun üzerinden order by kullanýlarak sýralanabilir. 
-- order by ile asc, ascending yani artan veya desc, descending yani azalan sýralama yapýlabilir.
-- Default'u yani yazýlmadýðýnda varsayýlaný ascending (asc)'dir.
select * from Yonetmen order by adi -- artan sýralama
select * from Yonetmen order by adi desc -- azalan sýralama

select * from Yonetmen order by adi, soyadi 
-- önce adi sütununa göre artan sýralama yapar, sonra adi sütununa göre sýraladýklarýný soyadi sütununa göre artan sýralar.

select * from Yonetmen order by adi, soyadi desc
-- önce adi sütununa göre artan sýralama yapar, sonra adi sütununa göre sýraladýklarýný soyadi sütununa göre azalan sýralar.

-- Bir tablodaki kayýt (satýr) sayýsýný getirmek için SQL'in count fonksiyonu kullanýlýr.
select COUNT(*) from Film
select COUNT(adi) as toplamfilm from Film -- count(*) yerine count(sütun adý) da kullanýlabilir.
select COUNT(dogumtarihi) from Yonetmen -- count(sütun adý): NULL olanlarý saymaz.

-- Bir tablodaki sayýsal veri tipindeki bir sütunun maksimum deðeri max fonksiyonu ile getirilebilir.
select MAX(gisesi) as [En Cok Gise] from Film -- MAX(sütun adý): o sütundaki verilerden en büyük deðeri ver.

-- Bir tablodaki sayýsal veri tipindeki bir sütunun minimum deðeri min fonksiyonu ile getirilebilir.
select MIN(gisesi) as [En Az Gise] from Film -- MIN(sütun adý): o sütundaki verilerden en küçük deðeri ver.

-- Bir tablodaki sayýsal veri tipindeki bir sütunun verilerinin toplamý sum fonksiyonu ile getirilebilir.
select SUM(gisesi) as [Toplam Gise] from Film -- SUM(sütun adý): o sütundaki verilerin toplamýný ver.

-- Bir tablodaki sayýsal veri tipindeki bir sütunun verilerinin ortalamasý avg fonksiyonu ile getirilebilir.
select AVG(gisesi) as [Ortalama Gise] from Film -- AVG(sütun adý): o sütundaki verilerin ortalama deðerini ver.

-- Bir tablodaki veriler top ile sýralamaya göre baþtan kaç kayýt çekileceði belirtilerek getirilebilir.
select top 3 * from Yonetmen -- TOP sayý sütun adý: ilk üç kaydý getirir.

select top 3 * from Yonetmen order by Id desc -- order by desc'den dolayý son üç kaydý getirir.

select top 1 * from Film order by Id -- film tablosundaki ilk kaydý getirir.
select top 1 * from Film order by Id desc -- film tablosundaki son kaydý getirir.

-- Eðer baþka bir veritabaný üzerinden çalýþýlýyorsa, örneðin master, Filmler veritabanýndaki Film tablosuna
-- veritabaný.dbo.tablo þeklinde ulaþýlabilir, dbo tablonun þemasýdýr (schema).
use master
select * from Filmler.dbo.Film

-- WHERE: Sorgu için koþul (þart) veya koþullar (þartlar) belirtmek için kullanýlýr. Belirtilen koþul veya koþullara uyan satýrlar etkilenir.
-- Update, delete ve select sorgularýnda kullanýlýr. Birden çok koþul için and (ve) ile or (veya) operatörleri kullanýlabilir.
-- Bir koþulun deðilini almak için de not operatörü kullanýlýr.
-- Where koþulundaki sütunlar ile =, !=, >, <, >= ve <= operatörleri kullanýlabilir.

use Filmler
select * from Film where Id = 5 -- id'si 5 olan filmi getir.
select * from Film where Id != 5 -- id'si 5 olmayan filmleri getir.
select * from Film where not Id = 5 -- id'si 5 olmayan filmleri getir.
select * from Film where Id < 4 order by Id desc -- id'si 4'ten küçük olan filmleri id'ye göre azalan þekilde getir.
select * from Film where Id > 4 -- id'si 4'ten büyük olan filmleri id'ye göre artan þekilde getir.

-- id'ye göre artan sýralama için order by id yazmaya gerek yoktur 
-- çünkü id primary key ve index olduðundan otomatikman id'ye göre artan sýralý gelir.

select * from Yonetmen where Id >= 2 and Id <= 4 -- id'si 2 ile 2'den büyük ve 4 ile 4'den küçük yönetmenleri getir.

-- id'si 2'den küçük veya 4'ten büyük yönetmenleri getir.
select * from Yonetmen where Id < 2 or Id > 4 -- 1. sorgu
select * from Yonetmen where not (Id >= 2 and Id <= 4) -- 2. sorgu
-- Üstteki iki sorgu ayný sonucu verir çünkü 1. sorgu 2. sorgunun deðil operatörü parantez içerisindeki koþullara daðýtýlmýþ halidir.

-- WHERE ile birden çok koþul kullanýmý:
-- Aþaðýdaki sorgularda parantez içinde Koþul 1 ve Koþul 2, parantez dýþýnda da and'den sonra aranan veriler yazýlmýþtýr.

select Id from Yonetmen where (Id >= 2 and Id <= 4)

select Id from Yonetmen where (Id >= 2 and Id <= 4) and Id = 2 -- *
select Id from Yonetmen where (Id >= 2 and Id <= 4) and Id = 3 -- *
select Id from Yonetmen where (Id >= 2 and Id <= 4) and Id = 4 -- *

select Id from Yonetmen where (Id >= 2 and Id <= 4) and Id = 5 -- **

select Id from Yonetmen where (Id >= 2 and Id <= 4) and Id = 1 -- ***

select Id from Yonetmen where (Id > 4 and Id < 2) and Id = 3 -- ****

/*
Koþul 1 		and			Koþul 2				Sonuç Koþulu		Yonetmen Tablosunda Aranan Veriler (id)		Yonetmen Tablosundan Dönen Sonuç Verileri (id)
id >= 2						id <= 4
1 (true)					1 (true)			1 (true)			2, 3, 4	*									2, 3, 4
1 (true)					0 (false)			0 (false)			5 **										Veri dönmez
0 (false)					1 (true)			0 (false)			1 ***										Veri dönmez
id > 4						id < 2
0 (false)					0 (false)			0 (false)			3 ****										Veri dönmez
*/

select Id from Yonetmen where (Id >= 2 or Id <= 4)

select Id from Yonetmen where (Id >= 2 or Id <= 4) and Id = 2 -- *
select Id from Yonetmen where (Id >= 2 or Id <= 4) and Id = 3 -- *
select Id from Yonetmen where (Id >= 2 or Id <= 4) and Id = 4 -- *

select Id from Yonetmen where (Id >= 2 or Id <= 4) and Id = 5 -- **

select Id from Yonetmen where (Id >= 2 or Id <= 4) and Id = 1 -- ***

select Id from Yonetmen where (Id > 4 or Id < 2) and Id = 3 -- ****

/*
Koþul 1 		or			Koþul 2				Sonuç Koþulu		Yonetmen Tablosunda Aranan Veriler (id)		Yonetmen Tablosundan Dönen Sonuç Verileri (id)
id >= 2						id <= 4
1 (true)					1 (true)			1 (true)			2, 3, 4	*									2, 3, 4
1 (true)					0 (false)			1 (true)			5 **										5
0 (false)					1 (true)			1 (true)			1 ***										1
id > 4						id < 2
0 (false)					0 (false)			0 (false)			3 ****										Veri dönmez
*/

-- SELECT sorgu örnekleri:
select * from Yonetmen where adi = 'James' and soyadi = 'Cameron' and dogumtarihi = '1954-08-16'
-- adý James ve soyadý Cameron ve doðum tarihi 06.08.1954 olan yönetmenleri getir.

-- Eðer aþaðýdaki örneklerde olduðu gibi birden çok and ve or operatörü kullanýldýðýnda
-- mutlaka öncelikli koþul veya koþullar için parantez kullanýlmalýdýr.
select * from Yonetmen where (adi = 'James' and soyadi = 'Cameron') or adi = 'Ridley'
-- adý James ve soyadý Cameron olan veya adý Ridley olan yönetmenleri getir.

select * from Yonetmen where (adi = 'James' and soyadi = 'Cameron') or (adi = 'Ridley' and soyadi = 'Scott')
-- adý James ve soyadý Cameron olan veya adý Ridley ve soyadý Scott olan yönetmenleri getir.

select * from Yonetmen where ((adi = 'James' and soyadi = 'Cameron') or (adi = 'Ridley' and soyadi = 'Scott')) and dogumtarihi > '1950-01-01'
-- adý James ve soyadý Cameron olan veya adý Ridley ve soyadý Scott olan ve doðum tarihi 01.01.1950'den büyük olan yönetmenleri getir.

select * from Tur where Id = 1 or Id = 3 or Id = 5
select * from Tur where Id in (1, 3, 5)
-- in (deðerler): küme içerisinden seçim yapar, deðerleri parantez içindeki parametreler olanlarý getir.
-- id'si 1 veya 3 veya 5 olan türleri getir.
-- id'si 1, 3, 5 kümesi içerisinde olan türleri getir.

select * from Tur where Id not in (1, 3, 5)
-- not in (deðerler): küme dýþýndan seçim yapar, deðerleri parantez dýþýndaki parametreler olanlarý getir.
-- id'si 1 ve 3 ve 5 olmayan türleri getir.
-- id'si 1, 3, 5 kümesi dýþýnda olan türleri getir.

select * from Tur where Id between 2 and 4
-- id'si 2 (dahil) ve 4 (dahil) arasýndaki türleri getir.

select * from Film where yapimyili is NULL
-- yapým yýlý null olan filmleri getir. where koþulunda yapimyili = null yazýlmaz.

select * from Film where yapimyili is not null
-- yapým yýlý null olmayan filmleri getir. where koþulunda yapimyili != null yazýlmaz.

select * from Film where adi = 'avatar'
-- adý avatar olan filmleri getir. 
-- Veritabaný collation'ý TURKISH_CI_AS 
-- yani TURKISH: Türkçe, CI: case insensitive, büyük küçük harf duyarsýz ve AS: accent sensitive, aksan duyarlý (bizim için önemsiz)
-- olduðundan Avatar veya avatar koþulu ayný sonucu döner.

select * from Film where adi like 'avatar'
-- içerisinde tamamen avatar geçen filmleri getir. adi = 'avatar' ile ayný sonucu döner yani like = operatörü gibi davranýr.

select * from Film where adi like 'a%'
-- adý a ile baþlayan sonu ne olursa olsun filmleri getir. % yerine herhangi bir veya daha fazla karakter gelebilir demektir.

select * from Film where adi like '%ata%'
-- içinde ata geçen filmleri getir, baþý ve sonu önemli deðil. ata baþýnda veya sonunda geçse de veri döner.

select * from Film where adi like '%ar'
-- sonu ar ile biten filmleri getir.

select * from Film where adi not like '%ar'
-- sonu ar ile bitmeyen filmleri getir.

select distinct yapimyili from Film where yapimyili is not null order by yapimyili desc
-- null olmayan yapým yýllarýný yapým yýlýna göre azalan sýrada çoklayan satýrlarý teke düþürerek getir.

select 'Çaðýl' + ' ' + 'Alsaç' AdýSoyadý
-- Çaðýl Alsaç AdýSoyadý sütununu döner.
-- select her zaman bir tablo ile kullanýlmaz, istenilen veriler yazýlýp ihtiyaca göre üzerinde iþlemler yapýlarak çekilebilir.
-- Burada olduðu gibi from ile herhangi bir tablo kullanýlmadan da select ile istenilen veri dönülebilir.

select 1 + 2 + 3 as Toplam
-- 6 Toplam sütununu döner.

select adi, soyadi, 'Yönetmen' [Tablo Adý] from yonetmen 
-- adi ve soyadi ile birlikte 'Yönetmen' metinsel verisini de tablo adý olarak getir.
-- yonetmen: SQL sorgularýnda tablo adlarý ile sütun adlarý büyük küçük harf duyarsýz þekilde yazýlabilir.
-- Ancak i harfine dikkat etmek gerekir. Örneðin eðer sütun adý Id tanýmlandýysa id ile select sorgusu yazmak hata verir.