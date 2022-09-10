-- JOIN: İki veya daha fazla tablonun verilerini birleştirerek tek bir tabloymuş gibi sonuç olarak getirmemizi sağlar.
-- Join sorgularında bir tablonun primary key sütunu ile diğer tablodaki foreign key karşılığı olan sütun eşitlenir.

-- 1) INNER JOIN: Birleştirilen tablolarda sadece id'ler üzerinden eşleşen kayıtları getirir.
-- Kullanım: select sütunlar from tablo1 inner join tablo2 on tablo1.tablo2id = tablo2.id
-- Aşağıdaki örnekte hem sütun adları hem de tablo adları alias kullanılarak sorguda değiştirilmiştir.
-- Örneğin Film tablosu f olarak kısaltılmıştır, f.id sütunu ise Film ID olarak sorguda değiştirilmiştir.

use Filmler

-- Film ve Yonetmen tablolarını inner join ile birleştirelim: * ile birleştirilen tablolardaki tüm sütunlar döner.
-- Sorgu sonucunda 5 satır döner.
select *
from Film f inner join Yonetmen y on f.yonetmenId = y.Id

-- Film, Yonetmen ve Tur tablolarını inner join ile birleştirelim:
-- Join sorgularından sonra where kullanılarak kayıtlar filtrelenebilir, order by ile de sıralanabilir.
-- Türü Aksiyon, film gişesi de 50000 ile 700000 arasında olan kayıtları film yapım yılına göre artan sıralayarak getir.
select f.Id as [Film ID], f.adi as [Film Adı], f.yapimyili as [Film Yapım Yılı], f.gisesi as [Film Gişesi],
y.Id as [Yönetmen ID], y.adi + ' ' + y.soyadi as [Yönetmen], y.dogumtarihi as [Yönetmen Doğum Tarihi], t.adi as [Tür]
from Film f inner join Yonetmen y on f.yonetmenId = y.Id
inner join FilmTur ft on f.Id = ft.filmId
inner join Tur t on ft.turId = t.Id
where t.adi = 'Aksiyon' and f.gisesi >= 50000 and f.gisesi <= 700000
order by f.yapimyili

-- Inner join ile birleştirilen Film, Yonetmen ve Tur tabloları üzerinden film adı ve yönetmen adı ile soyadını birleştirerek
-- getir ve çoklayan satırları teke düşür.
select distinct f.adi as [Film], y.adi + ' ' + y.soyadi as [Yönetmen]
from Film f inner join Yonetmen y on f.yonetmenId = y.Id
inner join FilmTur ft on f.Id = ft.filmId
inner join Tur t on ft.turId = t.Id

-- 2) LEFT OUTER JOIN: Birleştirilen tablolarda hem id'ler üzerinden eşleşen kayıtları hem de tabloların yazım sırasına göre
-- soldaki tablonun tüm kayıtları ile sağdaki tabloda eşleşmeyen karşılıkları null olacak şekilde getirir.
-- Kullanım: select sütunlar from tablo1 left outer join tablo2 on tablo1.tablo2id = tablo2.id

-- Film, FilmDetay ve Yonetmen tablolarını left outer join ile birleştirelim:
-- Aşağıdaki sorgu sonucunda Avatar filminin yönetmen id'si null
-- olduğu için yönetmen tablosundan çekilen Yönetmen ID, Yönetmen ve Yönetmen Doğum Tarihi verileri null gelecektir.
-- Dolaysıyla join kullanılarak soldaki tablonun tüm verileri getirilmek isteniyorsa
-- ve sağdaki tabloda kayıtlar eşleşse de eşleşmese de gelsin isteniyorsa left outer join kullanılmalıdır.
-- Aynı durum FilmDetay tablosu için de geçerlidir.
-- Sorgu sonucunda 6 satır döner.
select f.Id as [Film ID], f.adi as [Film Adı], f.yapimyili as [Film Yapım Yılı], f.gisesi as [Film Gişesi],
fd.Maliyeti, fd.Aciklamasi as Açıklaması,
y.Id as [Yönetmen ID], y.adi + ' ' + y.soyadi as [Yönetmen], y.dogumtarihi as [Yönetmen Doğum Tarihi]
from Film f left outer join FilmDetay fd on f.Id = fd.FilmId left outer join Yonetmen y on f.yonetmenId = y.Id

-- Film, Yonetmen ve Tur tablolarını left outer join ile birleştirelim:
-- Aşağıdaki sorgu sonucunda Adalet Peşinde filminin herhangi bir film tür kaydı 
-- olmadığı için tür tablosundan çekilen Tür verisi null olarak gelecektir,
-- Avatar filminin de yönetmen id'si null olduğu için yönetmen tablosundan çekilen 
-- Yönetmen ID, Yönetmen ve Yönetmen Doğum Tarihi verileri null olarak gelecektir.
select f.Id as [Film ID], f.adi as [Film Adı], f.yapimyili as [Film Yapım Yılı], f.gisesi as [Film Gişesi],
y.Id as [Yönetmen ID], y.adi + ' ' + y.soyadi as [Yönetmen], y.dogumtarihi as [Yönetmen Doğum Tarihi],
t.adi as [Tür]
from Film f left outer join Yonetmen y on f.yonetmenId = y.Id
left outer join FilmTur ft on f.Id = ft.filmId
left outer join Tur t on ft.turId = t.Id
order by f.adi -- film adına göre artan sıralama

-- 3) RIGHT OUTER JOIN: Birleştirilen tablolarda hem id'ler üzerinden eşleşen kayıtları hem de tabloların yazım sırasına göre
-- sağdaki tablonun tüm kayıtları ile soldaki tabloda eşleşmeyen karşılıkları null olacak şekilde getirir.
-- Kullanım: select sütunlar from tablo1 right outer join tablo2 on tablo1.tablo2id = tablo2.id

-- Film, FilmDetay ve Yonetmen tablolarını right outer join ile birleştirelim:
-- Aşağıdaki sorgu sonucunda Avatar filminin yönetmen id'si null
-- olduğu için yönetmen tablosundan çekilen Yönetmen ID, Yönetmen ve Yönetmen Doğum Tarihi verileri null gelecektir.
-- Dolaysıyla join kullanılarak sağdaki tablonun tüm verileri getirilmek isteniyorsa
-- ve soldaki tabloda kayıtlar eşleşse de eşleşmese de gelsin isteniyorsa right outer join kullanılmalıdır.
-- Aynı durum FilmDetay tablosu için de geçerlidir.
-- Sorgu sonucunda 6 satır döner.
select f.Id as [Film ID], f.adi as [Film Adı], f.yapimyili as [Film Yapım Yılı], f.gisesi as [Film Gişesi],
fd.Maliyeti, fd.Aciklamasi as Açıklaması,
y.Id as [Yönetmen ID], y.adi + ' ' + y.soyadi as [Yönetmen], y.dogumtarihi as [Yönetmen Doğum Tarihi]
from Yonetmen y right outer join Film f on y.Id = f.yonetmenId right outer join FilmDetay fd on f.Id = fd.FilmId

-- Film, Yonetmen ve Tur tablolarını right outer join ile birleştirelim:
-- Aşağıdaki sorgu sonucunda Adalet Peşinde filminin herhangi bir film tür kaydı 
-- olmadığı için tür tablosundan çekilen Tür verisi null olarak gelecektir.
select f.Id as [Film ID], f.adi as [Film Adı], f.yapimyili as [Film Yapım Yılı], f.gisesi as [Film Gişesi],
y.Id as [Yönetmen ID], y.adi + ' ' + y.soyadi as [Yönetmen], y.dogumtarihi as [Yönetmen Doğum Tarihi],
t.adi as [Tür]
from Tur t right outer join FilmTur ft on t.Id = ft.turId
right outer join Film f on ft.filmId = f.Id
right outer join Yonetmen y on f.yonetmenId = y.Id
order by f.adi -- film adına göre artan sıralama

-- Sorgulanmak istenen veriye göre bazen inner join, left outer join ve right outer join aynı sorguda kullanılabilir.