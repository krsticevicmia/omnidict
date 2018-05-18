
CREATE TABLE [je_uradio]
( 
	[TestID]             integer  NOT NULL ,
	[Korisnicko_ime]     varchar(20)  NOT NULL 
)
go

ALTER TABLE [je_uradio]
	ADD CONSTRAINT [XPKje_uradio] PRIMARY KEY  CLUSTERED ([TestID] ASC,[Korisnicko_ime] ASC)
go

CREATE TABLE [Jezik]
( 
	[Korisnicko_ime]     varchar(20)  NULL ,
	[JezikID]            integer  NOT NULL ,
	[Naziv]              varchar(20)  NULL 
)
go

ALTER TABLE [Jezik]
	ADD CONSTRAINT [XPKJezik] PRIMARY KEY  CLUSTERED ([JezikID] ASC)
go

CREATE TABLE [Korisnik]
( 
	[Korisnicko_ime]     varchar(20)  NOT NULL ,
	[Password]           varchar(20)  NULL ,
	[Email]              varchar(20)  NULL 
)
go

ALTER TABLE [Korisnik]
	ADD CONSTRAINT [XPKKorisnik] PRIMARY KEY  CLUSTERED ([Korisnicko_ime] ASC)
go

CREATE TABLE [Kurs]
( 
	[Korisnicko_ime]     varchar(20)  NULL ,
	[KursID]             integer  NOT NULL ,
	[Naziv]              varchar(20)  NULL ,
	[JezikID]            integer  NOT NULL 
)
go

ALTER TABLE [Kurs]
	ADD CONSTRAINT [XPKKurs] PRIMARY KEY  CLUSTERED ([KursID] ASC)
go

CREATE TABLE [Lekcija]
( 
	[KursID]             integer  NULL ,
	[JezikID]            integer  NULL 
)
go

CREATE TABLE [Odgovor]
( 
	[Tekst_odgovora]     varchar(20)  NULL ,
	[Tacan_odgovor]      varchar(20)  NULL ,
	[Ponudjen_odgovor]   char(18)  NULL ,
	[PitanjeID]          integer  NOT NULL 
)
go

ALTER TABLE [Odgovor]
	ADD CONSTRAINT [XPKOdgovor] PRIMARY KEY  CLUSTERED ([PitanjeID] ASC)
go

CREATE TABLE [Pitanja]
( 
	[PitanjeID]          integer  NOT NULL ,
	[Pitanje]            varchar(20)  NULL ,
	[TestID]             integer  NULL 
)
go

ALTER TABLE [Pitanja]
	ADD CONSTRAINT [XPKPitanja] PRIMARY KEY  CLUSTERED ([PitanjeID] ASC)
go

CREATE TABLE [Profesor]
( 
	[Korisnicko_ime]     varchar(20)  NOT NULL 
)
go

ALTER TABLE [Profesor]
	ADD CONSTRAINT [XPKProfesor] PRIMARY KEY  CLUSTERED ([Korisnicko_ime] ASC)
go

CREATE TABLE [Test]
( 
	[KursID]             integer  NULL ,
	[TestID]             integer  NOT NULL ,
	[Naziv]              varchar(20)  NULL ,
	[Pitanje]            varchar(20)  NULL 
)
go

ALTER TABLE [Test]
	ADD CONSTRAINT [XPKTest] PRIMARY KEY  CLUSTERED ([TestID] ASC)
go

CREATE TABLE [Ucenik]
( 
	[Korisnicko_ime]     varchar(20)  NOT NULL 
)
go

ALTER TABLE [Ucenik]
	ADD CONSTRAINT [XPKUcenik] PRIMARY KEY  CLUSTERED ([Korisnicko_ime] ASC)
go

CREATE TABLE [Vrsta_reci]
( 
	[JezikID]            integer  NULL ,
	[VrstaID]            integer  NOT NULL ,
	[Rec]                varchar(20)  NULL ,
	[Znacenje]           varchar(20)  NULL 
)
go

ALTER TABLE [Vrsta_reci]
	ADD CONSTRAINT [XPKVrsta_reci] PRIMARY KEY  CLUSTERED ([VrstaID] ASC)
go

CREATE TABLE [Vrsta_reci_Lekcija]
( 
	[VrstaID]            integer  NOT NULL 
)
go

ALTER TABLE [Vrsta_reci_Lekcija]
	ADD CONSTRAINT [XPKVrsta_reci_Lekcija] PRIMARY KEY  CLUSTERED ([VrstaID] ASC)
go


ALTER TABLE [je_uradio]
	ADD CONSTRAINT [R_12] FOREIGN KEY ([TestID]) REFERENCES [Test]([TestID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [je_uradio]
	ADD CONSTRAINT [R_13] FOREIGN KEY ([Korisnicko_ime]) REFERENCES [Ucenik]([Korisnicko_ime])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [Jezik]
	ADD CONSTRAINT [R_14] FOREIGN KEY ([Korisnicko_ime]) REFERENCES [Korisnik]([Korisnicko_ime])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [Kurs]
	ADD CONSTRAINT [R_3] FOREIGN KEY ([Korisnicko_ime]) REFERENCES [Profesor]([Korisnicko_ime])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Kurs]
	ADD CONSTRAINT [R_17] FOREIGN KEY ([JezikID]) REFERENCES [Jezik]([JezikID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [Lekcija]
	ADD CONSTRAINT [R_9] FOREIGN KEY ([KursID]) REFERENCES [Kurs]([KursID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go

ALTER TABLE [Lekcija]
	ADD CONSTRAINT [R_18] FOREIGN KEY ([JezikID]) REFERENCES [Jezik]([JezikID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [Odgovor]
	ADD CONSTRAINT [R_22] FOREIGN KEY ([PitanjeID]) REFERENCES [Pitanja]([PitanjeID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [Pitanja]
	ADD CONSTRAINT [R_23] FOREIGN KEY ([TestID]) REFERENCES [Test]([TestID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [Profesor]
	ADD CONSTRAINT [R_1] FOREIGN KEY ([Korisnicko_ime]) REFERENCES [Korisnik]([Korisnicko_ime])
		ON DELETE CASCADE
		ON UPDATE CASCADE
go


ALTER TABLE [Test]
	ADD CONSTRAINT [R_8] FOREIGN KEY ([KursID]) REFERENCES [Kurs]([KursID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [Ucenik]
	ADD CONSTRAINT [R_2] FOREIGN KEY ([Korisnicko_ime]) REFERENCES [Korisnik]([Korisnicko_ime])
		ON DELETE CASCADE
		ON UPDATE CASCADE
go


ALTER TABLE [Vrsta_reci]
	ADD CONSTRAINT [R_15] FOREIGN KEY ([JezikID]) REFERENCES [Jezik]([JezikID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


ALTER TABLE [Vrsta_reci_Lekcija]
	ADD CONSTRAINT [R_20] FOREIGN KEY ([VrstaID]) REFERENCES [Vrsta_reci]([VrstaID])
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
go


CREATE TRIGGER tD_je_uradio ON je_uradio FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on je_uradio */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Ucenik  je_uradio on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00026b62", PARENT_OWNER="", PARENT_TABLE="Ucenik"
    CHILD_OWNER="", CHILD_TABLE="je_uradio"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_13", FK_COLUMNS="Korisnicko_ime" */
    IF EXISTS (SELECT * FROM deleted,Ucenik
      WHERE
        /* %JoinFKPK(deleted,Ucenik," = "," AND") */
        deleted.Korisnicko_ime = Ucenik.Korisnicko_ime AND
        NOT EXISTS (
          SELECT * FROM je_uradio
          WHERE
            /* %JoinFKPK(je_uradio,Ucenik," = "," AND") */
            je_uradio.Korisnicko_ime = Ucenik.Korisnicko_ime
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last je_uradio because Ucenik exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Test  je_uradio on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Test"
    CHILD_OWNER="", CHILD_TABLE="je_uradio"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_12", FK_COLUMNS="TestID" */
    IF EXISTS (SELECT * FROM deleted,Test
      WHERE
        /* %JoinFKPK(deleted,Test," = "," AND") */
        deleted.TestID = Test.TestID AND
        NOT EXISTS (
          SELECT * FROM je_uradio
          WHERE
            /* %JoinFKPK(je_uradio,Test," = "," AND") */
            je_uradio.TestID = Test.TestID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last je_uradio because Test exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_je_uradio ON je_uradio FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on je_uradio */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insTestID integer, 
           @insKorisnicko_ime varchar(20),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Ucenik  je_uradio on child update no action */
  /* ERWIN_RELATION:CHECKSUM="000297e4", PARENT_OWNER="", PARENT_TABLE="Ucenik"
    CHILD_OWNER="", CHILD_TABLE="je_uradio"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_13", FK_COLUMNS="Korisnicko_ime" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Korisnicko_ime)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Ucenik
        WHERE
          /* %JoinFKPK(inserted,Ucenik) */
          inserted.Korisnicko_ime = Ucenik.Korisnicko_ime
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update je_uradio because Ucenik does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Test  je_uradio on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Test"
    CHILD_OWNER="", CHILD_TABLE="je_uradio"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_12", FK_COLUMNS="TestID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(TestID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Test
        WHERE
          /* %JoinFKPK(inserted,Test) */
          inserted.TestID = Test.TestID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update je_uradio because Test does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Jezik ON Jezik FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Jezik */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Jezik  Lekcija on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0003e208", PARENT_OWNER="", PARENT_TABLE="Jezik"
    CHILD_OWNER="", CHILD_TABLE="Lekcija"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_18", FK_COLUMNS="JezikID" */
    IF EXISTS (
      SELECT * FROM deleted,Lekcija
      WHERE
        /*  %JoinFKPK(Lekcija,deleted," = "," AND") */
        Lekcija.JezikID = deleted.JezikID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Jezik because Lekcija exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Jezik  Kurs on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Jezik"
    CHILD_OWNER="", CHILD_TABLE="Kurs"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_17", FK_COLUMNS="JezikID" */
    IF EXISTS (
      SELECT * FROM deleted,Kurs
      WHERE
        /*  %JoinFKPK(Kurs,deleted," = "," AND") */
        Kurs.JezikID = deleted.JezikID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Jezik because Kurs exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Jezik  Vrsta_reci on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Jezik"
    CHILD_OWNER="", CHILD_TABLE="Vrsta_reci"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="JezikID" */
    IF EXISTS (
      SELECT * FROM deleted,Vrsta_reci
      WHERE
        /*  %JoinFKPK(Vrsta_reci,deleted," = "," AND") */
        Vrsta_reci.JezikID = deleted.JezikID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Jezik because Vrsta_reci exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Korisnik  Jezik on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Jezik"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_14", FK_COLUMNS="Korisnicko_ime" */
    IF EXISTS (SELECT * FROM deleted,Korisnik
      WHERE
        /* %JoinFKPK(deleted,Korisnik," = "," AND") */
        deleted.Korisnicko_ime = Korisnik.Korisnicko_ime AND
        NOT EXISTS (
          SELECT * FROM Jezik
          WHERE
            /* %JoinFKPK(Jezik,Korisnik," = "," AND") */
            Jezik.Korisnicko_ime = Korisnik.Korisnicko_ime
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Jezik because Korisnik exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Jezik ON Jezik FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Jezik */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insJezikID integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Jezik  Lekcija on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="000473d5", PARENT_OWNER="", PARENT_TABLE="Jezik"
    CHILD_OWNER="", CHILD_TABLE="Lekcija"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_18", FK_COLUMNS="JezikID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(JezikID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Lekcija
      WHERE
        /*  %JoinFKPK(Lekcija,deleted," = "," AND") */
        Lekcija.JezikID = deleted.JezikID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Jezik because Lekcija exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Jezik  Kurs on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Jezik"
    CHILD_OWNER="", CHILD_TABLE="Kurs"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_17", FK_COLUMNS="JezikID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(JezikID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Kurs
      WHERE
        /*  %JoinFKPK(Kurs,deleted," = "," AND") */
        Kurs.JezikID = deleted.JezikID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Jezik because Kurs exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Jezik  Vrsta_reci on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Jezik"
    CHILD_OWNER="", CHILD_TABLE="Vrsta_reci"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="JezikID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(JezikID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Vrsta_reci
      WHERE
        /*  %JoinFKPK(Vrsta_reci,deleted," = "," AND") */
        Vrsta_reci.JezikID = deleted.JezikID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Jezik because Vrsta_reci exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Korisnik  Jezik on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Jezik"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_14", FK_COLUMNS="Korisnicko_ime" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Korisnicko_ime)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Korisnik
        WHERE
          /* %JoinFKPK(inserted,Korisnik) */
          inserted.Korisnicko_ime = Korisnik.Korisnicko_ime
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.Korisnicko_ime IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Jezik because Korisnik does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Korisnik ON Korisnik FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Korisnik */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Korisnik  Jezik on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000299e7", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Jezik"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_14", FK_COLUMNS="Korisnicko_ime" */
    IF EXISTS (
      SELECT * FROM deleted,Jezik
      WHERE
        /*  %JoinFKPK(Jezik,deleted," = "," AND") */
        Jezik.Korisnicko_ime = deleted.Korisnicko_ime
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Korisnik because Jezik exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Korisnik  Ucenik on parent delete cascade */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Ucenik"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="Korisnicko_ime" */
    DELETE Ucenik
      FROM Ucenik,deleted
      WHERE
        /*  %JoinFKPK(Ucenik,deleted," = "," AND") */
        Ucenik.Korisnicko_ime = deleted.Korisnicko_ime

    /* erwin Builtin Trigger */
    /* Korisnik  Profesor on parent delete cascade */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Profesor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="Korisnicko_ime" */
    DELETE Profesor
      FROM Profesor,deleted
      WHERE
        /*  %JoinFKPK(Profesor,deleted," = "," AND") */
        Profesor.Korisnicko_ime = deleted.Korisnicko_ime


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Korisnik ON Korisnik FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Korisnik */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insKorisnicko_ime varchar(20),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Korisnik  Jezik on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00040eac", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Jezik"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_14", FK_COLUMNS="Korisnicko_ime" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Korisnicko_ime)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Jezik
      WHERE
        /*  %JoinFKPK(Jezik,deleted," = "," AND") */
        Jezik.Korisnicko_ime = deleted.Korisnicko_ime
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Korisnik because Jezik exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Korisnik  Ucenik on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Ucenik"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="Korisnicko_ime" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Korisnicko_ime)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insKorisnicko_ime = inserted.Korisnicko_ime
        FROM inserted
      UPDATE Ucenik
      SET
        /*  %JoinFKPK(Ucenik,@ins," = ",",") */
        Ucenik.Korisnicko_ime = @insKorisnicko_ime
      FROM Ucenik,inserted,deleted
      WHERE
        /*  %JoinFKPK(Ucenik,deleted," = "," AND") */
        Ucenik.Korisnicko_ime = deleted.Korisnicko_ime
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Korisnik update because more than one row has been affected.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Korisnik  Profesor on parent update cascade */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Profesor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="Korisnicko_ime" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Korisnicko_ime)
  BEGIN
    IF @numrows = 1
    BEGIN
      SELECT @insKorisnicko_ime = inserted.Korisnicko_ime
        FROM inserted
      UPDATE Profesor
      SET
        /*  %JoinFKPK(Profesor,@ins," = ",",") */
        Profesor.Korisnicko_ime = @insKorisnicko_ime
      FROM Profesor,inserted,deleted
      WHERE
        /*  %JoinFKPK(Profesor,deleted," = "," AND") */
        Profesor.Korisnicko_ime = deleted.Korisnicko_ime
    END
    ELSE
    BEGIN
      SELECT @errno = 30006,
             @errmsg = 'Cannot cascade Korisnik update because more than one row has been affected.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Kurs ON Kurs FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Kurs */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Kurs  Lekcija on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000400b0", PARENT_OWNER="", PARENT_TABLE="Kurs"
    CHILD_OWNER="", CHILD_TABLE="Lekcija"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_9", FK_COLUMNS="KursID" */
    IF EXISTS (
      SELECT * FROM deleted,Lekcija
      WHERE
        /*  %JoinFKPK(Lekcija,deleted," = "," AND") */
        Lekcija.KursID = deleted.KursID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Kurs because Lekcija exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Kurs  Test on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurs"
    CHILD_OWNER="", CHILD_TABLE="Test"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="KursID" */
    IF EXISTS (
      SELECT * FROM deleted,Test
      WHERE
        /*  %JoinFKPK(Test,deleted," = "," AND") */
        Test.KursID = deleted.KursID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Kurs because Test exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Jezik  Kurs on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Jezik"
    CHILD_OWNER="", CHILD_TABLE="Kurs"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_17", FK_COLUMNS="JezikID" */
    IF EXISTS (SELECT * FROM deleted,Jezik
      WHERE
        /* %JoinFKPK(deleted,Jezik," = "," AND") */
        deleted.JezikID = Jezik.JezikID AND
        NOT EXISTS (
          SELECT * FROM Kurs
          WHERE
            /* %JoinFKPK(Kurs,Jezik," = "," AND") */
            Kurs.JezikID = Jezik.JezikID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Kurs because Jezik exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Profesor  Kurs on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Profesor"
    CHILD_OWNER="", CHILD_TABLE="Kurs"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="Korisnicko_ime" */
    IF EXISTS (SELECT * FROM deleted,Profesor
      WHERE
        /* %JoinFKPK(deleted,Profesor," = "," AND") */
        deleted.Korisnicko_ime = Profesor.Korisnicko_ime AND
        NOT EXISTS (
          SELECT * FROM Kurs
          WHERE
            /* %JoinFKPK(Kurs,Profesor," = "," AND") */
            Kurs.Korisnicko_ime = Profesor.Korisnicko_ime
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Kurs because Profesor exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Kurs ON Kurs FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Kurs */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insKursID integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Kurs  Lekcija on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="0004bf86", PARENT_OWNER="", PARENT_TABLE="Kurs"
    CHILD_OWNER="", CHILD_TABLE="Lekcija"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_9", FK_COLUMNS="KursID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(KursID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Lekcija
      WHERE
        /*  %JoinFKPK(Lekcija,deleted," = "," AND") */
        Lekcija.KursID = deleted.KursID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Kurs because Lekcija exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Kurs  Test on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurs"
    CHILD_OWNER="", CHILD_TABLE="Test"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="KursID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(KursID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Test
      WHERE
        /*  %JoinFKPK(Test,deleted," = "," AND") */
        Test.KursID = deleted.KursID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Kurs because Test exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Jezik  Kurs on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Jezik"
    CHILD_OWNER="", CHILD_TABLE="Kurs"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_17", FK_COLUMNS="JezikID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(JezikID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Jezik
        WHERE
          /* %JoinFKPK(inserted,Jezik) */
          inserted.JezikID = Jezik.JezikID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Kurs because Jezik does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Profesor  Kurs on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Profesor"
    CHILD_OWNER="", CHILD_TABLE="Kurs"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="Korisnicko_ime" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Korisnicko_ime)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Profesor
        WHERE
          /* %JoinFKPK(inserted,Profesor) */
          inserted.Korisnicko_ime = Profesor.Korisnicko_ime
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.Korisnicko_ime IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Kurs because Profesor does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Lekcija ON Lekcija FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Lekcija */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Jezik  Lekcija on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00023ddc", PARENT_OWNER="", PARENT_TABLE="Jezik"
    CHILD_OWNER="", CHILD_TABLE="Lekcija"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_18", FK_COLUMNS="JezikID" */
    IF EXISTS (SELECT * FROM deleted,Jezik
      WHERE
        /* %JoinFKPK(deleted,Jezik," = "," AND") */
        deleted.JezikID = Jezik.JezikID AND
        NOT EXISTS (
          SELECT * FROM Lekcija
          WHERE
            /* %JoinFKPK(Lekcija,Jezik," = "," AND") */
            Lekcija.JezikID = Jezik.JezikID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Lekcija because Jezik exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Kurs  Lekcija on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurs"
    CHILD_OWNER="", CHILD_TABLE="Lekcija"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_9", FK_COLUMNS="KursID" */
    IF EXISTS (SELECT * FROM deleted,Kurs
      WHERE
        /* %JoinFKPK(deleted,Kurs," = "," AND") */
        deleted.KursID = Kurs.KursID AND
        NOT EXISTS (
          SELECT * FROM Lekcija
          WHERE
            /* %JoinFKPK(Lekcija,Kurs," = "," AND") */
            Lekcija.KursID = Kurs.KursID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Lekcija because Kurs exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Lekcija ON Lekcija FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Lekcija */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Jezik  Lekcija on child update no action */
  /* ERWIN_RELATION:CHECKSUM="0002c1a7", PARENT_OWNER="", PARENT_TABLE="Jezik"
    CHILD_OWNER="", CHILD_TABLE="Lekcija"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_18", FK_COLUMNS="JezikID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(JezikID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Jezik
        WHERE
          /* %JoinFKPK(inserted,Jezik) */
          inserted.JezikID = Jezik.JezikID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.JezikID IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Lekcija because Jezik does not exist.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Kurs  Lekcija on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurs"
    CHILD_OWNER="", CHILD_TABLE="Lekcija"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_9", FK_COLUMNS="KursID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(KursID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Kurs
        WHERE
          /* %JoinFKPK(inserted,Kurs) */
          inserted.KursID = Kurs.KursID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.KursID IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Lekcija because Kurs does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Odgovor ON Odgovor FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Odgovor */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Pitanja  Odgovor on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="000141a9", PARENT_OWNER="", PARENT_TABLE="Pitanja"
    CHILD_OWNER="", CHILD_TABLE="Odgovor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="PitanjeID" */
    IF EXISTS (SELECT * FROM deleted,Pitanja
      WHERE
        /* %JoinFKPK(deleted,Pitanja," = "," AND") */
        deleted.PitanjeID = Pitanja.PitanjeID AND
        NOT EXISTS (
          SELECT * FROM Odgovor
          WHERE
            /* %JoinFKPK(Odgovor,Pitanja," = "," AND") */
            Odgovor.PitanjeID = Pitanja.PitanjeID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Odgovor because Pitanja exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Odgovor ON Odgovor FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Odgovor */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insPitanjeID integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Pitanja  Odgovor on child update no action */
  /* ERWIN_RELATION:CHECKSUM="000170c0", PARENT_OWNER="", PARENT_TABLE="Pitanja"
    CHILD_OWNER="", CHILD_TABLE="Odgovor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="PitanjeID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(PitanjeID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Pitanja
        WHERE
          /* %JoinFKPK(inserted,Pitanja) */
          inserted.PitanjeID = Pitanja.PitanjeID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Odgovor because Pitanja does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Pitanja ON Pitanja FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Pitanja */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Pitanja  Odgovor on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0002192c", PARENT_OWNER="", PARENT_TABLE="Pitanja"
    CHILD_OWNER="", CHILD_TABLE="Odgovor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="PitanjeID" */
    IF EXISTS (
      SELECT * FROM deleted,Odgovor
      WHERE
        /*  %JoinFKPK(Odgovor,deleted," = "," AND") */
        Odgovor.PitanjeID = deleted.PitanjeID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Pitanja because Odgovor exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Test  Pitanja on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Test"
    CHILD_OWNER="", CHILD_TABLE="Pitanja"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_23", FK_COLUMNS="TestID" */
    IF EXISTS (SELECT * FROM deleted,Test
      WHERE
        /* %JoinFKPK(deleted,Test," = "," AND") */
        deleted.TestID = Test.TestID AND
        NOT EXISTS (
          SELECT * FROM Pitanja
          WHERE
            /* %JoinFKPK(Pitanja,Test," = "," AND") */
            Pitanja.TestID = Test.TestID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Pitanja because Test exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Pitanja ON Pitanja FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Pitanja */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insPitanjeID integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Pitanja  Odgovor on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00026801", PARENT_OWNER="", PARENT_TABLE="Pitanja"
    CHILD_OWNER="", CHILD_TABLE="Odgovor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_22", FK_COLUMNS="PitanjeID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(PitanjeID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Odgovor
      WHERE
        /*  %JoinFKPK(Odgovor,deleted," = "," AND") */
        Odgovor.PitanjeID = deleted.PitanjeID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Pitanja because Odgovor exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Test  Pitanja on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Test"
    CHILD_OWNER="", CHILD_TABLE="Pitanja"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_23", FK_COLUMNS="TestID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(TestID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Test
        WHERE
          /* %JoinFKPK(inserted,Test) */
          inserted.TestID = Test.TestID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.TestID IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Pitanja because Test does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Profesor ON Profesor FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Profesor */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Profesor  Kurs on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00024995", PARENT_OWNER="", PARENT_TABLE="Profesor"
    CHILD_OWNER="", CHILD_TABLE="Kurs"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="Korisnicko_ime" */
    IF EXISTS (
      SELECT * FROM deleted,Kurs
      WHERE
        /*  %JoinFKPK(Kurs,deleted," = "," AND") */
        Kurs.Korisnicko_ime = deleted.Korisnicko_ime
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Profesor because Kurs exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Korisnik  Profesor on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Profesor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="Korisnicko_ime" */
    IF EXISTS (SELECT * FROM deleted,Korisnik
      WHERE
        /* %JoinFKPK(deleted,Korisnik," = "," AND") */
        deleted.Korisnicko_ime = Korisnik.Korisnicko_ime AND
        NOT EXISTS (
          SELECT * FROM Profesor
          WHERE
            /* %JoinFKPK(Profesor,Korisnik," = "," AND") */
            Profesor.Korisnicko_ime = Korisnik.Korisnicko_ime
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Profesor because Korisnik exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Profesor ON Profesor FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Profesor */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insKorisnicko_ime varchar(20),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Profesor  Kurs on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00027d66", PARENT_OWNER="", PARENT_TABLE="Profesor"
    CHILD_OWNER="", CHILD_TABLE="Kurs"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_3", FK_COLUMNS="Korisnicko_ime" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Korisnicko_ime)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Kurs
      WHERE
        /*  %JoinFKPK(Kurs,deleted," = "," AND") */
        Kurs.Korisnicko_ime = deleted.Korisnicko_ime
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Profesor because Kurs exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Korisnik  Profesor on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Profesor"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_1", FK_COLUMNS="Korisnicko_ime" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Korisnicko_ime)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Korisnik
        WHERE
          /* %JoinFKPK(inserted,Korisnik) */
          inserted.Korisnicko_ime = Korisnik.Korisnicko_ime
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Profesor because Korisnik does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Test ON Test FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Test */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Test  Pitanja on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="0002d4b6", PARENT_OWNER="", PARENT_TABLE="Test"
    CHILD_OWNER="", CHILD_TABLE="Pitanja"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_23", FK_COLUMNS="TestID" */
    IF EXISTS (
      SELECT * FROM deleted,Pitanja
      WHERE
        /*  %JoinFKPK(Pitanja,deleted," = "," AND") */
        Pitanja.TestID = deleted.TestID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Test because Pitanja exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Test  je_uradio on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Test"
    CHILD_OWNER="", CHILD_TABLE="je_uradio"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_12", FK_COLUMNS="TestID" */
    IF EXISTS (
      SELECT * FROM deleted,je_uradio
      WHERE
        /*  %JoinFKPK(je_uradio,deleted," = "," AND") */
        je_uradio.TestID = deleted.TestID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Test because je_uradio exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Kurs  Test on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurs"
    CHILD_OWNER="", CHILD_TABLE="Test"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="KursID" */
    IF EXISTS (SELECT * FROM deleted,Kurs
      WHERE
        /* %JoinFKPK(deleted,Kurs," = "," AND") */
        deleted.KursID = Kurs.KursID AND
        NOT EXISTS (
          SELECT * FROM Test
          WHERE
            /* %JoinFKPK(Test,Kurs," = "," AND") */
            Test.KursID = Kurs.KursID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Test because Kurs exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Test ON Test FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Test */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insTestID integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Test  Pitanja on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="000370a7", PARENT_OWNER="", PARENT_TABLE="Test"
    CHILD_OWNER="", CHILD_TABLE="Pitanja"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_23", FK_COLUMNS="TestID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(TestID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Pitanja
      WHERE
        /*  %JoinFKPK(Pitanja,deleted," = "," AND") */
        Pitanja.TestID = deleted.TestID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Test because Pitanja exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Test  je_uradio on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Test"
    CHILD_OWNER="", CHILD_TABLE="je_uradio"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_12", FK_COLUMNS="TestID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(TestID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,je_uradio
      WHERE
        /*  %JoinFKPK(je_uradio,deleted," = "," AND") */
        je_uradio.TestID = deleted.TestID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Test because je_uradio exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Kurs  Test on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Kurs"
    CHILD_OWNER="", CHILD_TABLE="Test"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="KursID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(KursID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Kurs
        WHERE
          /* %JoinFKPK(inserted,Kurs) */
          inserted.KursID = Kurs.KursID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.KursID IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Test because Kurs does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Ucenik ON Ucenik FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Ucenik */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Ucenik  je_uradio on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000241e1", PARENT_OWNER="", PARENT_TABLE="Ucenik"
    CHILD_OWNER="", CHILD_TABLE="je_uradio"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_13", FK_COLUMNS="Korisnicko_ime" */
    IF EXISTS (
      SELECT * FROM deleted,je_uradio
      WHERE
        /*  %JoinFKPK(je_uradio,deleted," = "," AND") */
        je_uradio.Korisnicko_ime = deleted.Korisnicko_ime
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Ucenik because je_uradio exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Korisnik  Ucenik on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Ucenik"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="Korisnicko_ime" */
    IF EXISTS (SELECT * FROM deleted,Korisnik
      WHERE
        /* %JoinFKPK(deleted,Korisnik," = "," AND") */
        deleted.Korisnicko_ime = Korisnik.Korisnicko_ime AND
        NOT EXISTS (
          SELECT * FROM Ucenik
          WHERE
            /* %JoinFKPK(Ucenik,Korisnik," = "," AND") */
            Ucenik.Korisnicko_ime = Korisnik.Korisnicko_ime
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Ucenik because Korisnik exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Ucenik ON Ucenik FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Ucenik */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insKorisnicko_ime varchar(20),
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Ucenik  je_uradio on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00027f61", PARENT_OWNER="", PARENT_TABLE="Ucenik"
    CHILD_OWNER="", CHILD_TABLE="je_uradio"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_13", FK_COLUMNS="Korisnicko_ime" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(Korisnicko_ime)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,je_uradio
      WHERE
        /*  %JoinFKPK(je_uradio,deleted," = "," AND") */
        je_uradio.Korisnicko_ime = deleted.Korisnicko_ime
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Ucenik because je_uradio exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Korisnik  Ucenik on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Korisnik"
    CHILD_OWNER="", CHILD_TABLE="Ucenik"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_2", FK_COLUMNS="Korisnicko_ime" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(Korisnicko_ime)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Korisnik
        WHERE
          /* %JoinFKPK(inserted,Korisnik) */
          inserted.Korisnicko_ime = Korisnik.Korisnicko_ime
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Ucenik because Korisnik does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Vrsta_reci ON Vrsta_reci FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Vrsta_reci */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Vrsta_reci  Vrsta_reci_Lekcija on parent delete no action */
    /* ERWIN_RELATION:CHECKSUM="000244cb", PARENT_OWNER="", PARENT_TABLE="Vrsta_reci"
    CHILD_OWNER="", CHILD_TABLE="Vrsta_reci_Lekcija"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_20", FK_COLUMNS="VrstaID" */
    IF EXISTS (
      SELECT * FROM deleted,Vrsta_reci_Lekcija
      WHERE
        /*  %JoinFKPK(Vrsta_reci_Lekcija,deleted," = "," AND") */
        Vrsta_reci_Lekcija.VrstaID = deleted.VrstaID
    )
    BEGIN
      SELECT @errno  = 30001,
             @errmsg = 'Cannot delete Vrsta_reci because Vrsta_reci_Lekcija exists.'
      GOTO error
    END

    /* erwin Builtin Trigger */
    /* Jezik  Vrsta_reci on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Jezik"
    CHILD_OWNER="", CHILD_TABLE="Vrsta_reci"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="JezikID" */
    IF EXISTS (SELECT * FROM deleted,Jezik
      WHERE
        /* %JoinFKPK(deleted,Jezik," = "," AND") */
        deleted.JezikID = Jezik.JezikID AND
        NOT EXISTS (
          SELECT * FROM Vrsta_reci
          WHERE
            /* %JoinFKPK(Vrsta_reci,Jezik," = "," AND") */
            Vrsta_reci.JezikID = Jezik.JezikID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Vrsta_reci because Jezik exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Vrsta_reci ON Vrsta_reci FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Vrsta_reci */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insVrstaID integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Vrsta_reci  Vrsta_reci_Lekcija on parent update no action */
  /* ERWIN_RELATION:CHECKSUM="00028e62", PARENT_OWNER="", PARENT_TABLE="Vrsta_reci"
    CHILD_OWNER="", CHILD_TABLE="Vrsta_reci_Lekcija"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_20", FK_COLUMNS="VrstaID" */
  IF
    /* %ParentPK(" OR",UPDATE) */
    UPDATE(VrstaID)
  BEGIN
    IF EXISTS (
      SELECT * FROM deleted,Vrsta_reci_Lekcija
      WHERE
        /*  %JoinFKPK(Vrsta_reci_Lekcija,deleted," = "," AND") */
        Vrsta_reci_Lekcija.VrstaID = deleted.VrstaID
    )
    BEGIN
      SELECT @errno  = 30005,
             @errmsg = 'Cannot update Vrsta_reci because Vrsta_reci_Lekcija exists.'
      GOTO error
    END
  END

  /* erwin Builtin Trigger */
  /* Jezik  Vrsta_reci on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00000000", PARENT_OWNER="", PARENT_TABLE="Jezik"
    CHILD_OWNER="", CHILD_TABLE="Vrsta_reci"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_15", FK_COLUMNS="JezikID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(JezikID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Jezik
        WHERE
          /* %JoinFKPK(inserted,Jezik) */
          inserted.JezikID = Jezik.JezikID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    select @nullcnt = count(*) from inserted where
      inserted.JezikID IS NULL
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Vrsta_reci because Jezik does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go




CREATE TRIGGER tD_Vrsta_reci_Lekcija ON Vrsta_reci_Lekcija FOR DELETE AS
/* erwin Builtin Trigger */
/* DELETE trigger on Vrsta_reci_Lekcija */
BEGIN
  DECLARE  @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)
    /* erwin Builtin Trigger */
    /* Vrsta_reci  Vrsta_reci_Lekcija on child delete no action */
    /* ERWIN_RELATION:CHECKSUM="00015f3d", PARENT_OWNER="", PARENT_TABLE="Vrsta_reci"
    CHILD_OWNER="", CHILD_TABLE="Vrsta_reci_Lekcija"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_20", FK_COLUMNS="VrstaID" */
    IF EXISTS (SELECT * FROM deleted,Vrsta_reci
      WHERE
        /* %JoinFKPK(deleted,Vrsta_reci," = "," AND") */
        deleted.VrstaID = Vrsta_reci.VrstaID AND
        NOT EXISTS (
          SELECT * FROM Vrsta_reci_Lekcija
          WHERE
            /* %JoinFKPK(Vrsta_reci_Lekcija,Vrsta_reci," = "," AND") */
            Vrsta_reci_Lekcija.VrstaID = Vrsta_reci.VrstaID
        )
    )
    BEGIN
      SELECT @errno  = 30010,
             @errmsg = 'Cannot delete last Vrsta_reci_Lekcija because Vrsta_reci exists.'
      GOTO error
    END


    /* erwin Builtin Trigger */
    RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


CREATE TRIGGER tU_Vrsta_reci_Lekcija ON Vrsta_reci_Lekcija FOR UPDATE AS
/* erwin Builtin Trigger */
/* UPDATE trigger on Vrsta_reci_Lekcija */
BEGIN
  DECLARE  @numrows int,
           @nullcnt int,
           @validcnt int,
           @insVrstaID integer,
           @errno   int,
           @severity int,
           @state    int,
           @errmsg  varchar(255)

  SELECT @numrows = @@rowcount
  /* erwin Builtin Trigger */
  /* Vrsta_reci  Vrsta_reci_Lekcija on child update no action */
  /* ERWIN_RELATION:CHECKSUM="00017579", PARENT_OWNER="", PARENT_TABLE="Vrsta_reci"
    CHILD_OWNER="", CHILD_TABLE="Vrsta_reci_Lekcija"
    P2C_VERB_PHRASE="", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_20", FK_COLUMNS="VrstaID" */
  IF
    /* %ChildFK(" OR",UPDATE) */
    UPDATE(VrstaID)
  BEGIN
    SELECT @nullcnt = 0
    SELECT @validcnt = count(*)
      FROM inserted,Vrsta_reci
        WHERE
          /* %JoinFKPK(inserted,Vrsta_reci) */
          inserted.VrstaID = Vrsta_reci.VrstaID
    /* %NotnullFK(inserted," IS NULL","select @nullcnt = count(*) from inserted where"," AND") */
    
    IF @validcnt + @nullcnt != @numrows
    BEGIN
      SELECT @errno  = 30007,
             @errmsg = 'Cannot update Vrsta_reci_Lekcija because Vrsta_reci does not exist.'
      GOTO error
    END
  END


  /* erwin Builtin Trigger */
  RETURN
error:
   RAISERROR (@errmsg, -- Message text.
              @severity, -- Severity (0~25).
              @state) -- State (0~255).
    rollback transaction
END

go


