create procedure spRaporOlustur @raporAdi varchar(200), @filmAdi varchar(300) = 'Avatar'
as
--declare @raporAdiNull varchar(200)
--set @raporAdiNull = ISNULL(@raporAdi, '')
--declare @raporAdiTrim varchar(200)
--set @raporAdiTrim = TRIM(@raporAdiNull)
--declare @raporAdiLength = LEN(@raporAdiTrim)
if LEN(TRIM(ISNULL(@raporAdi, ''))) = 0
begin
	print 'Rapor ad� bo� olamaz!'
end
else
begin
	declare @raporSayisi int
	select @raporSayisi = COUNT(*) from FilmRapor where Adi = @raporAdi
	if @raporSayisi > 0
	begin
		print 'Belirtti�iniz rapor ad�na sahip kay�t bulunmaktad�r!'
	end
	else
	begin
		declare @tarih datetime = GETDATE()
		declare @filmId int
		select @filmId = Id from Film where Adi = @filmAdi
		--print @filmId
		if @filmId is null
		begin
			print 'Belirtti�iniz film ad�na sahip kay�t bulunmaktad�r!'
		end
		else
		begin
			declare @karZarar decimal(18, 2)
			declare @turSayisi smallint
			select @karZarar = ISNULL(Gisesi - Maliyeti,0), @turSayisi = COUNT(TurAdi) from vwFilmDetayTur 
			where Id = @filmId
			group by Id, filmAdi, Gisesi - Maliyeti 

			insert into FilmRapor values (@tarih, @filmId, @karZarar, @turSayisi, @raporAdi)
		end
	end
end	