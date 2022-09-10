-- VIEW: Eðer istenirse herhangi bir select sonucu veritabanýnda dinamik bir görünümde saklanabilir ve
-- bu görünüm üzerinden select yapýlarak özellikle join ve group by sorgularýnýn tekrar tekrar yazýlmasýnýn önüne geçilir.

use Filmler

-- Film, Yonetmen ve Tur tablolarýný inner join ile birleþtirelim ve vFilmTurYonetmen adlý view'da sorguyu saklayalým:
-- Aþaðýdaki örnekte create view'ýn baþýndan itibaren sorgu seçilerek çalýþtýrýlmalýdýr 
-- çünkü create view sorgusu her zaman ilk satýr olarak çalýþtýrýlmalýdýr.
create view vFilmTurYonetmen
as
select f.Id as [Film ID], f.adi as [Film Adý], f.yapimyili as [Film Yapým Yýlý], f.gisesi as [Film Giþesi],
y.Id as [Yönetmen ID], y.adi + ' ' + y.soyadi as [Yönetmen], y.dogumtarihi as [Yönetmen Doðum Tarihi], t.adi as [Tür]
from Film f inner join Yonetmen y on f.yonetmenId = y.Id
inner join FilmTur ft on f.Id = ft.filmId
inner join Tur t on ft.turId = t.Id

-- vFilmTurYonetmen view'ýný oluþturduktan sonra istediðimiz zaman aþaðýdaki gibi view içerisindeki 
-- sorgu üzerinden sorgulama yapabiliriz. Ayrýca bu view üzerinden where, group by ve order by da kullanabiliriz. 
select * from vFilmTurYonetmen where [Film Yapým Yýlý] is not null order by [Film Adý]

-- Ýstenirse bir view'ýn sorgusu alter ile deðiþtirilebilir:
-- Aþaðýdaki örnekte sorgudan film id'sini çýkardýk. 
-- alter view da create view gibi ilk satýr olarak çalýþtýrýlmalýdýr.
alter view vFilmTurYonetmen
as
select f.adi as [Film Adý], f.yapimyili as [Film Yapým Yýlý], f.gisesi as [Film Giþesi],
y.Id as [Yönetmen ID], y.adi + ' ' + y.soyadi as [Yönetmen], y.dogumtarihi as [Yönetmen Doðum Tarihi], t.adi as [Tür]
from Film f inner join Yonetmen y on f.yonetmenId = y.Id
inner join FilmTur ft on f.Id = ft.filmId
inner join Tur t on ft.turId = t.Id

-- Ýstenirse bir view drop ile silinebilir:
drop view vFilmTurYonetmen