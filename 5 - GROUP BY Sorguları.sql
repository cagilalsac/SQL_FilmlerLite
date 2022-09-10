-- GROUP BY: select sorgularında ihtiyaca göre bir veya daha fazla sütun gruplanarak
-- gruplanan sütun ile birlikte sayısal veri tipindeki diğer bir veya daha fazla sütun
-- üzerinde SUM, MIN, MAX, AVG ve COUNT aggregate function'ları çalıştırılabilir.
-- Tarih tipindeki veriler için de MAX, MIN ve COUNT aggregate function'ları çalıştırılabilir.
-- Aggregate function'larla kullanılan sütunlar dışında select yanına yazılan tüm sütunlar
-- group by'dan sonra yazılmalıdır.

-- 1) COUNT: Gruplanan sütun veya sütunlara göre kayıt sayısını başka bir sütunda getirir.
use Filmler
select yapimyili, COUNT(*) sayi from Film group by yapimyili
-- Yapım yılına göre film sayısını getiren sorgu.

-- group by join sorgularından sonra da kullanılabilir.
-- count(*) genelde kayıt sayısını getirmek için kullanılır ancak null verilerin sayılıp sayılmayacağına göre
-- count(sütun adı) da kullanılabilir.
select y.adi, y.soyadi, count(f.Id) filmsayisi
from Yonetmen y inner join Film f on y.Id = f.yonetmenId
group by y.adi, y.soyadi
-- Örneğimizde her bir yönetmen için bir film kaydı oluşturduğumuzdan her bir yönetmen için film sayısı 1 olarak gelecektir.

-- HAVING: group by'dan sonra herhangi bir aggregate function (COUNT, SUM, MIN, MAX, AVG) kullanılan sütun üzerinden 
-- filtreleme yapılmasını sağlar.
select y.adi, y.soyadi, count(f.Id) filmsayisi
from Yonetmen y inner join Film f on y.Id = f.yonetmenId
group by y.adi, y.soyadi
having count(f.Id) > 1
-- Örneğimizde her bir yönetmen için bir film kaydı oluşturduğumuzdan her bir yönetmen için film sayısı 1 olarak gelecektir,
-- bu yüzden having filtresi ile kayıt sayısı 1'den büyük olan kayıtları getir dediğimizden sonuç dönmeyecektir.

select t.adi as turadi, count(*) filmsayisi 
from tur t inner join filmtur ft on t.Id = ft.turId
inner join film f on ft.filmId = f.Id
group by t.adi
-- Tür adına göre film sayısını getiren sorgu.

-- 2) SUM: Gruplanan sütun veya sütunlara göre başka bir sütunun toplam sonucunun hesaplanması için kullanılır.
select f.yapimyili, sum(f.gisesi) as toplamgise, sum(fd.maliyeti) as toplammaliyet from Film f left outer join FilmDetay fd on f.Id = fd.FilmId
group by f.yapimyili
-- Yapım yılına göre filmlerin toplam gişesini ve maliyetini getiren sorgu.

select t.adi as turadi, sum(f.gisesi) as filmtoplamgise 
from tur t left outer join filmtur ft on t.Id = ft.turId
left outer join film f on ft.filmId = f.Id
group by t.adi
having sum(f.gisesi) >= 1000000.00 and sum(f.gisesi) <= 2000000.00
-- Tür adına göre filmlerin toplam gişelerini 1000000 ile 2000000 arasında olacak şekilde filtreleyerek getiren sorgu.

-- 3) MAX: Gruplanan sütun veya sütunlara göre başka bir sütunun maksimum sonucunun hesaplanması için kullanılır.
select emeklimi, max(dogumtarihi) maksimumdogumtarihi from yonetmen where emeklimi is not null group by emeklimi
-- Yönetmen tablosunda emekli verisi null olmayan kayıtlar üzerinden emeklimi sütununa göre gruplama yap ve 
-- bu gruplamaya göre maksimum emeklilik tarihlerini getir.

-- 4) MIN: Gruplanan sütun veya sütunlara göre başka bir sütunun minimum sonucunun hesaplanması için kullanılır.
select yapimyili YapımYılı, min(gisesi) Gişesi from film group by yapimyili having yapimyili < 2000
-- Film tablosunda yapım yılına göre minimum gişeye sahip filmlerin yapım yılı ve gişelerini 2000 yılından öncesi olarak getirir.

-- 5) AVG: Gruplanan sütun veya sütunlara göre başka bir sütunun ortalama sonucunun hesaplanması için kullanılır.
select t.Id as turid, t.adi as turadi, AVG(f.gisesi) as filmortalamagise 
from tur t inner join filmtur ft on t.Id = ft.turId
inner join film f on ft.filmId = f.Id
where t.Id in (2, 3, 4) -- bilim kurgu, aksiyon, dram
group by t.Id, t.adi
-- Türü bilim kurgu, aksiyon ve dram olan film tür join sorgusu sonucu üzerinden tür id ve tür adı sütunlarına 
-- göre gruplama yaparak film gişelerinin ortalama sonucunu getirir.