-- DATA MANIPULATION LANGUAGE (DML): Veritabanında Data Definition Language (DDL) ile oluşturduğumuz yapılarda, 
-- örneğin sütunlar üzerinden tablolarda, yeni kayıt ekleme, mevcut bir kaydı güncelleme ve silme vb. veri işlemleri için kullanılır.

-- SQL veri tipleri ve veri örnekleri:
-- Sayısal veri tipleri (Tam sayı):
-- 1 byte = 8 bit

-- bigint: 123
-- 64 bit büyüklüğünde -9,223,372,036,854,775,808 ile 9,223,372,036,854,775,807 arasında değer tutabilen tam sayı veri tipidir.

-- int: -321
-- 32 bit büyüklüğünde -2,147,483,648 ile 2,147,483,647 arasında değer tutabilen tam sayı veri tipidir.

-- smallint: -98
-- 16 bit büyüklüğünde -32,768 ile 32,767 arasında değer tutabilen tam sayı veri tipidir.

-- tinyint: 89
-- 8 bit büyüklüğünde 0 ile 255 arasında değer tutabilen tam sayı veri tipidir.

-- bit: 1
-- 8 bit büyüklüğünde 0 ile 1 arasında değer tutabilen tam sayı veri tipidir.

-- Sayısal veri tipleri (Ondalık sayı):
-- float: 57.35
-- -1.79E+308 ile 1.79E+308 arasında değer tutabilen ondalık sayı veri tipidir.

-- decimal(9, 2): -12345.6
-- -10^38 + 1 ile 10^38 - 1 arasında değer tutabilen ondalık sayı veri tipidir.
-- Bu örnekte 9 ondalık işareti dahil toplam maksimum hane sayısını, 2 ise ondalık işaretinden sonraki maksimum hane sayısını belirtir.

-- numeric (18, 3): 987654321.123
-- -10^38 + 1 ile 10^38 - 1 arasında değer tutabilen ondalık sayı veri tipidir.
-- Bu örnekte 18 ondalık işareti dahil toplam maksimum hane sayısını, 3 ise ondalık işaretinden sonraki maksimum hane sayısını belirtir.

-- money: 100.50
-- -922,337,203,685,477.5808 ile +922,337,203,685,477.5807 arasında değer tutabilen ondalık sayı veri tipidir.

-- smallmoney: 100.50
-- -214,748.3648 ile +214,748.3647 arasında değer tutabilen ondalık sayı veri tipidir.

-- Metinsel veri tipleri: Metinsel veriler için aşağıdaki maksimum karakter sayıları Microsoft SQL Server 2019 için geçerlidir.
-- text: 'Türkiye, Çankaya, Ankara'
-- Maksimum 2,147,483,647 karakter metinsel veri tutabilir. Tutulan verinin boyutu girilen karakter sayısına göre değişir.

-- varchar(10): 'Bilge Adam'
-- varchar(max) ile maksimum 8000 karakter metinsel veri tutabilir. Tutulan verinin boyutu girilen karakter sayısına göre değişir.

-- char(4): '2021'
-- char(max) ile maksimum 8000 karakter metinsel veri tutabilir. Tutulan verinin boyutu tanımlanan karakter sayısı üzerinden sabittir.
-- Yıl verisi sabit 4 karakter olduğu için char veri tipi kullanılabilir.
-- Örneğin sadece '1' verisini char(4) veri tipindeki bir sütuna eklesek veri sütunda '   1' olarak saklanacaktır.

-- ntext: N'Türkiye, Çankaya, Ankara'
-- Unicode karakter kümesi kullandığı için (Türkçe karakterler de bu veri kümesine dahildir) 
-- maksimum 1,073,741,823 karakter metinsel veri tutabilir.

-- nvarchar(10): N'Bilge Adam'
-- Unicode karakter kümesi kullandığı için nvarchar(max) ile maksimum 4000 karakter metinsel veri tutabilir.

-- nchar: N'2021'
-- Unicode karakter kümesi kullandığı için nchar(max) ile maksimum 4000 karakter metinsel veri tutabilir.

-- Diğer veri tipleri:
-- datetime: '2021-09-08 18:55.44.135'
-- Ocak 1, 1753 ile	Aralık 31, 9999 arasında 'yıl-ay-gün saat:dakika:saniye.milisaniye' özel formatında değer tutabilen veri tipidir.

-- smalldatetime: '2021-09-08 18:55.44.135'
-- Ocak 1, 1900 ile	Haziran 6, 2079 arasında 'yıl-ay-gün saat:dakika:saniye.milisaniye' özel formatında değer tutabilen veri tipidir.

-- date: '2021-09-08'
-- Ocak 1, 1753 ile	Aralık 31, 9999 arasında 'yıl-ay-gün' özel formatında değer tutabilen veri tipidir.

-- binary: Örneğin binary(1000) olarak tanımlanır.
-- İçerisine ikilik sayı sistemi yapısında veri alabilir. Tutulan verinin boyutu tanımlanan byte uzunluğu üzerinden sabittir.
-- Örneğin imaj verisi, mp3 verisi, Word veya Excel dökümanı verisi tutulabilir. 
-- binary(max) ile maksimum 8000 byte uzunluğunda veri tutabilir.

-- varbinary: Örneğin varbinary(4000) olarak tanımlanır.
-- İçerisine binary gibi ikilik sayı sistemi yapısında veri alabilir. Tutulan verinin boyutu girilen verinin byte uzunluğuna göre değişir.
-- varbinary(max) ile maksimum 8000 byte uzunluğunda veri tutabilir.

-- image:
-- Maksimum 2,147,483,647 byte uzunluğunda veri tutabilen ve imaj verileri için kullanılan özel bir varbinary veri tipidir.

-- 1) INSERT: Bir tabloya sütunlar üzerinden yeni bir satır olarak verileri eklemek için kullanılır.

-- Bir tabloya kayıt ekleme işleminden önce eğer tabloda foreign key varsa tablonun foreign key üzerinden ilişkili olduğu 
-- diğer tabloya önce veriler eklenir ki kayıt ekleme işlemini yaptığımız tablo foreign key üzerinden diğer tabloyla ilişki kurabilsin.

use Filmler
go

-- 1. kullanım: İstenilen sütun adları values'dan önce parantez içinde belli bir sırada yazılır, değerler ise values'dan sonra
-- aynı sırayla parantez içinde girilir. Bu örnekte dogumtarihi ve emeklimi sütun verileri null girilecektir.
insert into Yonetmen (Adi, Soyadi, DogumTarihi, EmekliMi) values ('James', 'Cameron', '1954-08-16', 0) -- id otomatik olarak verilir: 1

-- 2. kullanım: values'dan önce parantez ile sütun adları yazılmaz, değerler ise values'dan sonra tablonun sütunları sırasıyla
-- parantez içinde girilir. Bu kullanımda eğer null değere izin veren bir sütun varsa ve null değer girilmek isteniyorsa
-- parantez içinde aşağıdaki örnekte olduğu gibi bu sütun için null veri girilmelidir.
insert into Yonetmen values ('Guy', 'Ritchie', null, 0) -- id otomatik olarak verilir: 2

-- Bu örnekte dogumtarihi ve emeklimi sütun verileri null olacaktır.
insert into Yonetmen (Adi, Soyadi) values ('F. Gary', 'Gray') -- id otomatik olarak verilir: 3

insert into Yonetmen values ('Ridley', 'Scott', null, 1) -- örnek için düzeltilecek, id otomatik olarak verilir: 4
insert into Yonetmen values ('David', 'Fincher', '1962-08-28', 0) -- id otomatik olarak verilir: 5
insert into Yonetmen values ('Hatalı Giriş Ad', 'Hatalı Giriş Soyad', null, null) -- örnek için silinecek, id otomatik olarak verilir: 6
insert into Yonetmen values ('David', 'Lynch', null, 0) -- id otomatik olarak verilir: 7

go

insert into Film values ('Hatalı Giriş', 'Hata', 1, 1000000) -- örnek için düzeltilecek, id otomatik olarak verilir: 1
insert into Film (Adi, YonetmenId, Gisesi) values ('Sherlock Holmes', 2, 50000) -- id otomatik olarak verilir: 2
insert into Film (Adi, YonetmenId) values ('Hatalı Giriş', 1) -- örnek için silinecek, id otomatik olarak verilir: 3
insert into Film (Adi, YapimYili, YonetmenId, Gisesi) values ('Adalet Peşinde', '2009', null, 30000) -- örnek için düzeltilecek, id otomatik olarak verilir: 4
insert into Film values ('Yaratık', '1979', 4, 1000000) -- id otomatik olarak verilir: 5
insert into Film values ('Yaratık 2', '1986', 1, 700000) -- id otomatik olarak verilir: 6
insert into Film values ('Yaratık 3', '1992', 5, 400000) -- id otomatik olarak verilir: 7

insert into Tur values ('Hatalı Giriş') -- örnek için düzeltilecek, id otomatik olarak verilir: 1
insert into Tur values ('Bilim Kurgu') -- id otomatik olarak verilir: 2
insert into Tur values ('Aksiyon') -- id otomatik olarak verilir: 3
insert into Tur values ('Dram') -- id otomatik olarak verilir: 4
insert into Tur values ('Gizem') -- id otomatik olarak verilir: 5
insert into Tur values ('Suç') -- id otomatik olarak verilir: 6
insert into Tur values ('Macera') -- id otomatik olarak verilir: 7
insert into Tur values ('Korku') -- id otomatik olarak verilir: 8
insert into Tur values ('Uzay') -- id otomatik olarak verilir: 9

-- Film ve Tur verilerini girdikten sonra Film ve Tur arasındaki many to many ilişkiyi sağlayan FilmTur
-- ara tablosuna film id ve tür id üzerinden ilişki verilerini girebiliriz.
insert into FilmTur values (1, 1)
insert into FilmTur values (1, 2)
insert into FilmTur values (1, 3)
insert into FilmTur values (2, 1)	
insert into FilmTur values (2, 4)	
insert into FilmTur values (2, 3)	
insert into FilmTur values (2, 6)
insert into FilmTur values (5, 7)
insert into FilmTur values (5, 8)
insert into FilmTur values (5, 2)
insert into FilmTur values (5, 9)
insert into FilmTur values (6, 3)
insert into FilmTur values (6, 8)
insert into FilmTur values (6, 2)
insert into FilmTur values (6, 9)
insert into FilmTur values (7, 1)
insert into FilmTur values (7, 3)
insert into FilmTur values (7, 2)
insert into FilmTur values (7, 9)
insert into FilmTur values (4, 3)
insert into FilmTur values (4, 4)

insert into FilmDetay values (2, 60000, 'Sherlock Holmes ve Dr. Watson''ın maceraları.') 
insert into FilmDetay values (5, 200000, 'Yaratık serisinin ilk filmi.') 

-- 2) UPDATE: Bir tablodaki bir veya daha fazla satırın sütunlarındaki verilerin belli bir koşul kümesine göre veya koşul olmadan 
-- güncellenmesi için kullanılır.

-- Eğer update işleminde bir foreign key sütun verisi güncellenmek isteniyorsa foreign key üzerinden ilişkili olan diğer tabloda
-- güncellenecek id verisinin bulunup bulunmadığı kontrol edilmelidir. Eğer yoksa hata alınacaktır.

--update Film set yonetmenid = 3 
-- Eğer bu şekilde sorgu çalıştırılırsa Film tablosundaki tüm yonetmen id'ler 3 olarak güncellenir.

update Film set YonetmenId = 3 where Adi = 'Adalet Peşinde' 
-- Eğer bu şekilde sorgu çalıştırılırsa Film tablosunda sadece adı Adalet Peşinde olan filmin yönetmen id'si 3 olarak güncellenir.

-- WHERE: Sorgu için koşul (şart) veya koşullar (şartlar) belirtmek için kullanılır. Belirtilen koşul veya koşullara uyan satırlar etkilenir.
-- Update, delete ve select sorgularında kullanılır. Birden çok koşul için and (ve) ile or (veya) operatörleri kullanılabilir.
-- Bir koşulun değilini almak için de not operatörü kullanılır.
-- Where koşulundaki sütunlar ile =, !=, >, <, >= ve <= operatörleri kullanılabilir.
-- Select konusunda kullanımı daha detaylı gösterilecektir.

-- update ile birden çok sütun virgül ile ayrılarak güncellenebilir.
update Film set Adi = 'Avatar', YapimYili = '2009', YonetmenId = null where Id = 1 -- id'si 1 olan filmin adını Avatar, yapım yılını 2009 ve yönetmen id'sini null olarak günceller.

update Yonetmen set DogumTarihi = '1937-11-30' where Id = 4 -- id'si 4 olan yönetmenin doğum tarihini 30.11.1937 olarak günceller.

update Tur set Adi = 'Gerilim' where Id = 1 -- id'si 1 olan türün adını Gerilim olarak günceller.

-- 3) DELETE: Bir tablodaki bir veya daha fazla satırın belli bir koşul kümesine göre veya koşul olmadan 
-- silinmesi için kullanılır.
--delete from Film 
-- Eğer bu şekilde sorgu çalıştırılırsa Film tablosundaki tüm satırlar silinir.

delete from Film where Id = 3
-- Eğer bu şekilde sorgu çalıştırılırsa film tablosunda sadece id'si 3 olan satır silinir.

delete from Yonetmen where Adi = 'Hatalı Giriş Ad' -- adı Hatalı Giriş Ad olan satır yönetmen tablosundan silinir.

delete from FilmTur where FilmId = 4 -- film id'si 4 olan satırlar film tür tablosundan silinir.