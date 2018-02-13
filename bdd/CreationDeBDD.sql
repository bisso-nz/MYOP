CREATE TABLE [dbo].[administrateur] (
    [Id]           INT           IDENTITY (1, 1) NOT NULL,
    [nom]          VARCHAR (25)  NULL,
    [prenom]       VARCHAR (25)  NULL,
    [no_telephone] VARCHAR (20)  NULL,
    [adresse]      VARCHAR (100) NULL,
    [email]        VARCHAR (45)  NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

CREATE TABLE [dbo].[client] (
    [Id]           INT            IDENTITY (1, 1) NOT NULL,
    [nom]          NVARCHAR (25)  NULL,
    [prenom]       NVARCHAR (25)  NULL,
    [adresse]      NVARCHAR (100) NULL,
    [no_telephone] NVARCHAR (20)  NULL,
    [email]        NVARCHAR (50)  NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

CREATE TABLE [dbo].[pizzeria] (
    [Id]                     INT           IDENTITY (1, 1) NOT NULL,
    [nom]                    VARCHAR (25)  NOT NULL,
    [nom_proprietaire]       VARCHAR (25)  NOT NULL,
    [prenom_proprietaire]    VARCHAR (25)  NOT NULL,
    [adresse]                VARCHAR (100) NOT NULL,
    [adresse_de_facturation] VARCHAR (100) NOT NULL,
    [email]                  VARCHAR (50)  NOT NULL,
    [no_telephone]           VARCHAR (20)  NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

CREATE TABLE [dbo].[horaires] (
    [Id]              INT          IDENTITY (1, 1) NOT NULL,
    [pizzeria_id]     INT          NOT NULL,
    [jour]            VARCHAR (15) NULL,
    [ouverture_matin] TIME (7)     NULL,
    [fermeture_matin] TIME (7)     NULL,
    [ouverture_soir]  TIME (7)     NULL,
    [fermeture_soir]  TIME (7)     NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_horaires_Pizzeria] FOREIGN KEY ([pizzeria_id]) REFERENCES [dbo].[pizzeria] ([Id])
);

CREATE TABLE [dbo].[compte] (
    [Id]                INT           IDENTITY (1, 1) NOT NULL,
    [nom_de_compte]     VARCHAR (100) NOT NULL,
    [mot_de_passe]      VARCHAR (100) NOT NULL,
    [administrateur_id] INT           NULL,
    [pizzeria_id]       INT           NULL,
    [client_id]         INT           NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_compte_toadministrateur] FOREIGN KEY ([administrateur_id]) REFERENCES [dbo].[administrateur] ([Id]),
    CONSTRAINT [FK_compte_topizzeria] FOREIGN KEY ([pizzeria_id]) REFERENCES [dbo].[pizzeria] ([Id]),
    CONSTRAINT [FK_compte_toclient] FOREIGN KEY ([client_id]) REFERENCES [dbo].[client] ([Id])
);


CREATE TABLE [dbo].[commande] (
    [Id]              INT           IDENTITY (1, 1) NOT NULL,
    [no_Commande]     INT           NOT NULL,
    [client_id]       INT           NOT NULL,
    [pizzeria_id]     INT           NOT NULL,
    [date_commande]   DATETIME      NOT NULL,
    [heure_livraison] TIME (7)      NULL,
    [livriaison]      BIT           NULL,
    [Commentaire]     VARCHAR (255) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_commande_ToClient] FOREIGN KEY ([client_id]) REFERENCES [dbo].[client] ([Id]),
    CONSTRAINT [FK_commande_ToPiezzria] FOREIGN KEY ([pizzeria_id]) REFERENCES [dbo].[pizzeria] ([Id])
);

---------------------------------------------------------------------------------------------

CREATE TABLE [dbo].[description] (
    [Id]         INT          IDENTITY (1, 1) NOT NULL,
    [image]      VARCHAR (50) NULL,
    [descriptif] VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

CREATE TABLE [dbo].[categorie] (
    [Id]  INT          IDENTITY (1, 1) NOT NULL,
    [nom] VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

CREATE TABLE [dbo].[ingredients] (
    [Id]             INT            IDENTITY (1, 1) NOT NULL,
    [nom]            VARCHAR (50)   NOT NULL,
    [categorie_id]   INT            NOT NULL,
    [pizzeria_id]    INT            NOT NULL,
    [prix]           DECIMAL (4, 2) NOT NULL,
    [disponible]     BIT            NOT NULL,
    [description_id] INT            NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_ingredients_categorie] FOREIGN KEY ([categorie_id]) REFERENCES [dbo].[categorie] ([Id]),
    CONSTRAINT [FK_ingredients_description] FOREIGN KEY ([description_id]) REFERENCES [dbo].[description] ([Id]),
    CONSTRAINT [FK_ingredients_pizzeria] FOREIGN KEY ([pizzeria_id]) REFERENCES [dbo].[pizzeria] ([Id])
);

CREATE TABLE [dbo].[produits] (
    [Id]             INT            IDENTITY (1, 1) NOT NULL,
    [nom]            VARCHAR (50)   NOT NULL,
    [categorie_id]   INT            NOT NULL,
    [pizzeria_id]    INT            NOT NULL,
    [prix]           DECIMAL (4, 2) NULL,
    [disponible]     BIT            NOT NULL,
    [description_id] INT            NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_produits_categorie] FOREIGN KEY ([categorie_id]) REFERENCES [dbo].[categorie] ([Id]),
    CONSTRAINT [FK_produits_description] FOREIGN KEY ([description_id]) REFERENCES [dbo].[description] ([Id]),
    CONSTRAINT [FK_produits_pizzeria] FOREIGN KEY ([pizzeria_id]) REFERENCES [dbo].[pizzeria] ([Id])
);


CREATE TABLE [dbo].[type] (
    [Id]          INT          IDENTITY (1, 1) NOT NULL,
    [nom]         VARCHAR (50) NOT NULL,
    [coefficient] DECIMAL (18) NULL,
    [pizzeria_id] INT          NULL,
    [disponible]  BIT          NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_type_pizzeria] FOREIGN KEY ([pizzeria_id]) REFERENCES [dbo].[pizzeria] ([Id])
);


CREATE TABLE [dbo].[pizza] (
    [Id]          INT          IDENTITY (1, 1) NOT NULL,
    [nom]         VARCHAR (50) NOT NULL,
    [type_id]     INT          NOT NULL,
    [pizzeria_id] INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC),
    CONSTRAINT [FK_pizza_type] FOREIGN KEY ([type_id]) REFERENCES [dbo].[type] ([Id]),
    CONSTRAINT [FK_pizza_pizzeria] FOREIGN KEY ([pizzeria_id]) REFERENCES [dbo].[pizzeria] ([Id])
);


CREATE TABLE [dbo].[menu] (
    [Id]   INT            IDENTITY (1, 1) NOT NULL,
    [nom]  VARCHAR (50)   NOT NULL,
    [prix] DECIMAL (4, 2) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);

CREATE TABLE [dbo].[composition] (
    [pizza_id]       INT NOT NULL,
    [ingredients_id] INT NOT NULL,
    CONSTRAINT [FK_composition_ingredients] FOREIGN KEY ([ingredients_id]) REFERENCES [dbo].[ingredients] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_composition_pizza] FOREIGN KEY ([pizza_id]) REFERENCES [dbo].[pizza] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [dbo].[composition_menu] (
    [menu_id]     INT NOT NULL,
    [pizza_id]    INT NOT NULL,
    [produits_id] INT NOT NULL,
    CONSTRAINT [FK_composition_menu_menu] FOREIGN KEY ([menu_id]) REFERENCES [dbo].[menu] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_composition_menu_pizza] FOREIGN KEY ([pizza_id]) REFERENCES [dbo].[pizza] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_composition_menu_produits] FOREIGN KEY ([produits_id]) REFERENCES [dbo].[produits] ([Id]) ON DELETE CASCADE
);


CREATE TABLE [dbo].[commande_menu] (
    [commande_id] INT NOT NULL,
    [menu_id]     INT NOT NULL,
    CONSTRAINT [FK_commande_menu_commande] FOREIGN KEY ([commande_id]) REFERENCES [dbo].[commande] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_commande_menu_menu] FOREIGN KEY ([menu_id]) REFERENCES [dbo].[menu] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [dbo].[commande_pizza] (
    [commande_id] INT NOT NULL,
    [pizza_id]    INT NOT NULL,
    CONSTRAINT [FK_commande_pizza_pizza] FOREIGN KEY ([pizza_id]) REFERENCES [dbo].[pizza] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_commande_pizza_commande] FOREIGN KEY ([commande_id]) REFERENCES [dbo].[commande] ([Id]) ON DELETE CASCADE
);

CREATE TABLE [dbo].[commande_produits] (
    [commande_id] INT NOT NULL,
    [produits_id] INT NOT NULL,
    CONSTRAINT [FK_commande_produits_commande] FOREIGN KEY ([commande_id]) REFERENCES [dbo].[commande] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_commande_produits_produits] FOREIGN KEY ([produits_id]) REFERENCES [dbo].[produits] ([Id]) ON DELETE CASCADE
);