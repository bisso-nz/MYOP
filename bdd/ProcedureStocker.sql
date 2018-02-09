
-------------------------------------------------------
CREATE PROCEDURE [dbo].[CreationComptePerso]
	@nom_de_compte varchar(45),
	@mot_de_passe varchar(100),
	@type_de_compte varchar(50),
	@nom varchar(50),
	@prenom varchar(50),
	@adresse varchar(50),
	@no_telephone varchar(50),
	@email varchar(50),
	@nom_pizzeria varchar(50),
	@adresse_pizzeria varchar(50)
AS
BEGIN

	IF(@type_de_compte = 'administrateur') 
	BEGIN

		INSERT INTO administrateur (nom,prenom,no_telephone,adresse,email) 
		VALUES (@nom,@prenom,@no_telephone,@adresse,@email)

		INSERT INTO compte(nom_de_compte,mot_de_passe,administrateur_id) 
		VALUES (@nom_de_compte,@mot_de_passe,SCOPE_IDENTITY())

	END
	if (@type_de_compte = 'client')
	BEGIN

		INSERT INTO client (nom,prenom,no_telephone,adresse,email) 
		VALUES (@nom,@prenom,@no_telephone,@adresse,@email)

		INSERT INTO compte(nom_de_compte,mot_de_passe,client_id) 
		VALUES (@nom_de_compte,@mot_de_passe,SCOPE_IDENTITY())

	END
	if (@type_de_compte = 'pizzeria')

	BEGIN

		INSERT INTO pizzeria(nom,adresse,nom_proprietaire,prenom_proprietaire,no_telephone,adresse_de_facturation,email) 
		VALUES (@nom_pizzeria,@adresse_pizzeria,@nom,@prenom,@no_telephone,@adresse,@email)

		INSERT INTO compte(nom_de_compte,mot_de_passe,pizzeria_id) 
		VALUES (@nom_de_compte,@mot_de_passe,SCOPE_IDENTITY())
	END

END
RETURN
-------------------------------------------------------
CREATE Procedure connection
(
@nomDeCompte varchar(50),
@motDePasse varchar(50) 
)
As
BEGIN
SELECT * FROM [compte]
WHERE [compte].[nom_de_compte] = @nomDeCompte 
AND [compte].[mot_de_passe] = @motDePasse
END
-------------------------------------------------------
CREATE Procedure recuperationDeCompte
(
@nomDeTable varchar(50),
@id varchar(7) 
)
as
BEGIN
declare @sqlcomd as varchar(255)
set @sqlcomd = 'SELECT * FROM ' + @nomDeTable +' WHERE Id = '+@id+';'
execute (@sqlcomd)
END
-------------------------------------------------------