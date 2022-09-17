CREATE view [dbo].[vFilmDetayTur]
		as
		select f.Id, f.Adi as FilmAdi, f.YapimYili, f.YonetmenId, f.Gisesi, fd.Maliyeti, fd.Aciklamasi, t.Adi TurAdi from Film f left outer join FilmDetay fd on f.Id = fd.FilmId left outer join FilmTur ft on f.Id = ft.FilmId left outer join Tur t on ft.TurId = t.Id



