SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Pizzeria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Pizzeria` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Pizzeria` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(25) NOT NULL,
  `adresse` VARCHAR(100) NOT NULL,
  `no_telephone` VARCHAR(20) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `mot_de_passe` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Type` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pizzeria _id` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `coefficient` DECIMAL(2,2) NOT NULL,
  `disponible` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`, `pizzeria _id`),
  INDEX `fk_pizzeria_idx` (`pizzeria _id` ASC),
  CONSTRAINT `fk_pizzeria`
    FOREIGN KEY (`pizzeria _id`)
    REFERENCES `mydb`.`Pizzeria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pizza`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Pizza` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Pizza` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(25) NULL,
  `type_id` INT NOT NULL,
  `pizzeria_id` INT NOT NULL,
  PRIMARY KEY (`id`, `type_id`, `pizzeria_id`),
  INDEX `fk_Pizza_Taille1_idx` (`type_id` ASC),
  INDEX `fk_Pizza_Pizzeria1_idx` (`pizzeria_id` ASC),
  CONSTRAINT `fk_pizza_1`
    FOREIGN KEY (`type_id`)
    REFERENCES `mydb`.`Type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pizza_2`
    FOREIGN KEY (`pizzeria_id`)
    REFERENCES `mydb`.`Pizzeria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Client`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Client` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Client` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `pizzeria_id` INT NOT NULL,
  `nom` VARCHAR(25) NULL,
  `prenom` VARCHAR(25) NULL,
  `mot_de_passe` VARCHAR(45) NULL,
  `adresse` VARCHAR(45) NULL,
  `no_telephone` VARCHAR(20) NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Client_Pizzeria1_idx` (`pizzeria_id` ASC),
  CONSTRAINT `fk_Client_Pizzeria1`
    FOREIGN KEY (`pizzeria_id`)
    REFERENCES `mydb`.`Pizzeria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Commande`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Commande` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Commande` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `no_commande` INT NOT NULL,
  `client_id` INT NOT NULL,
  `pizzeria_id` INT NOT NULL,
  `date_commande` DATETIME NOT NULL,
  `heure_livraison` TIME NULL,
  `livraison` TINYINT(1) NULL,
  `Commentaire` VARCHAR(255) NULL,
  PRIMARY KEY (`id`, `client_id`, `pizzeria_id`),
  INDEX `fk_Client_has_Pizza_Client1_idx` (`client_id` ASC),
  INDEX `fk_pizzeria_id_idx` (`pizzeria_id` ASC),
  CONSTRAINT `fk_Client_has_Pizza_Client1`
    FOREIGN KEY (`client_id`)
    REFERENCES `mydb`.`Client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_pizzeria_id`
    FOREIGN KEY (`pizzeria_id`)
    REFERENCES `mydb`.`Pizzeria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Categorie`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Categorie` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Categorie` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Description`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Description` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Description` (
  `id` INT NOT NULL,
  `image` VARCHAR(45) NULL,
  `descriptif` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ingredients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Ingredients` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Ingredients` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `categorie_id` INT NOT NULL,
  `pizzeria_id` INT NOT NULL,
  `prix` DECIMAL(3,2) NOT NULL,
  `disponible` TINYINT(1) NOT NULL,
  `Description_id` INT NOT NULL,
  PRIMARY KEY (`id`, `categorie_id`, `pizzeria_id`, `Description_id`),
  INDEX `fk_Integredients_Categorie1_idx` (`categorie_id` ASC),
  INDEX `fk_Ingredients_Pizzeria1_idx` (`pizzeria_id` ASC),
  INDEX `fk_Ingredients_Description1_idx` (`Description_id` ASC),
  CONSTRAINT `fk_Integredients_Categorie1`
    FOREIGN KEY (`categorie_id`)
    REFERENCES `mydb`.`Categorie` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ingredients_Pizzeria1`
    FOREIGN KEY (`pizzeria_id`)
    REFERENCES `mydb`.`Pizzeria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ingredients_Description1`
    FOREIGN KEY (`Description_id`)
    REFERENCES `mydb`.`Description` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Composition`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Composition` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Composition` (
  `pizza_id` INT NOT NULL,
  `ingredients_id` INT NOT NULL,
  PRIMARY KEY (`pizza_id`, `ingredients_id`),
  INDEX `fk_Pizza_has_Integredients_Integredients1_idx` (`ingredients_id` ASC),
  INDEX `fk_Pizza_has_Integredients_Pizza1_idx` (`pizza_id` ASC),
  CONSTRAINT `fk_Pizza_has_Integredients_Pizza1`
    FOREIGN KEY (`pizza_id`)
    REFERENCES `mydb`.`Pizza` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pizza_has_Integredients_Integredients1`
    FOREIGN KEY (`ingredients_id`)
    REFERENCES `mydb`.`Ingredients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Historique_commande`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Historique_commande` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Historique_commande` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date_histo` DATETIME NOT NULL,
  `no_commande` INT NOT NULL,
  `date_commande` DATETIME NULL,
  `pizzeria_id` INT NOT NULL,
  `livraison` TINYINT(1) NOT NULL,
  `heure_livraison` DATETIME NULL,
  PRIMARY KEY (`id`, `date_histo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Erreurs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Erreurs` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Erreurs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `erreur` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `erreur_UNIQUE` (`erreur` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produits`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Produits` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Produits` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `categorie_id` INT NOT NULL,
  `pizzeria_id` INT NOT NULL,
  `prix` DECIMAL(3,2) NOT NULL,
  `disponible` TINYINT(1) NOT NULL,
  `Description_id` INT NOT NULL,
  PRIMARY KEY (`id`, `categorie_id`, `pizzeria_id`, `Description_id`),
  INDEX `fk_Produits_Categorie1_idx` (`categorie_id` ASC),
  INDEX `fk_Produits_Pizzeria1_idx` (`pizzeria_id` ASC),
  INDEX `fk_Produits_Description1_idx` (`Description_id` ASC),
  CONSTRAINT `fk_Produits_Categorie1`
    FOREIGN KEY (`categorie_id`)
    REFERENCES `mydb`.`Categorie` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produits_Pizzeria1`
    FOREIGN KEY (`pizzeria_id`)
    REFERENCES `mydb`.`Pizzeria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produits_Description1`
    FOREIGN KEY (`Description_id`)
    REFERENCES `mydb`.`Description` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Commande_Produits`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Commande_Produits` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Commande_Produits` (
  `commande_id` INT NOT NULL,
  `produits_id` INT NULL,
  PRIMARY KEY (`commande_id`),
  INDEX `fk_Commande_has_Produits_Produits1_idx` (`produits_id` ASC),
  INDEX `fk_Commande_has_Produits_Commande1_idx` (`commande_id` ASC),
  CONSTRAINT `fk_Commande_has_Produits_Commande1`
    FOREIGN KEY (`commande_id`)
    REFERENCES `mydb`.`Commande` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Commande_has_Produits_Produits1`
    FOREIGN KEY (`produits_id`)
    REFERENCES `mydb`.`Produits` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Archive`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Archive` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Archive` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date_archive` DATETIME NULL,
  `no_commande` INT NULL,
  `date_commande` DATETIME NULL,
  `pizzeria_id` INT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`table1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`table1` ;

CREATE TABLE IF NOT EXISTS `mydb`.`table1` (
)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Commande_Pizza`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Commande_Pizza` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Commande_Pizza` (
  `commande_id` INT NOT NULL,
  `pizza_id` INT NULL,
  PRIMARY KEY (`commande_id`),
  INDEX `fk_Commande_has_Pizza_Pizza1_idx` (`pizza_id` ASC),
  INDEX `fk_Commande_has_Pizza_Commande1_idx` (`commande_id` ASC),
  CONSTRAINT `fk_commande_pizza_1`
    FOREIGN KEY (`commande_id`)
    REFERENCES `mydb`.`Commande` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_commande_pizza_2`
    FOREIGN KEY (`pizza_id`)
    REFERENCES `mydb`.`Pizza` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Horaires`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Horaires` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Horaires` (
  `id` INT NOT NULL,
  `pizzeria_id` INT NOT NULL,
  `jour` VARCHAR(15) NOT NULL,
  `ouverture_matin` TIME NULL,
  `fermerture_matin` TIME NULL,
  `ouverture_soir` TIME NULL,
  `fermeture_soir` TIME NULL,
  PRIMARY KEY (`id`, `pizzeria_id`),
  INDEX `fk_Horaires_Pizzeria1_idx` (`pizzeria_id` ASC),
  CONSTRAINT `fk_Horaires_Pizzeria1`
    FOREIGN KEY (`pizzeria_id`)
    REFERENCES `mydb`.`Pizzeria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Menu` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Menu` (
  `id` INT NOT NULL,
  `nom` VARCHAR(45) NULL,
  `prix` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Composition_Menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Composition_Menu` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Composition_Menu` (
  `Menu_id` INT NOT NULL,
  `Pizza_id` INT NULL,
  `Produits_id` INT NULL,
  PRIMARY KEY (`Menu_id`),
  INDEX `fk_Pizza_has_Menu_Menu1_idx` (`Menu_id` ASC),
  INDEX `fk_Pizza_has_Menu_Pizza1_idx` (`Pizza_id` ASC),
  INDEX `fk_Pizza_has_Menu_Produits1_idx` (`Produits_id` ASC),
  CONSTRAINT `fk_Pizza_has_Menu_Pizza1`
    FOREIGN KEY (`Pizza_id`)
    REFERENCES `mydb`.`Pizza` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pizza_has_Menu_Menu1`
    FOREIGN KEY (`Menu_id`)
    REFERENCES `mydb`.`Menu` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pizza_has_Menu_Produits1`
    FOREIGN KEY (`Produits_id`)
    REFERENCES `mydb`.`Produits` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Commande_Menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Commande_Menu` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Commande_Menu` (
  `Commande_id` INT NOT NULL,
  `Menu_id` INT NULL,
  PRIMARY KEY (`Commande_id`),
  INDEX `fk_Commande_has_Menu_Menu1_idx` (`Menu_id` ASC),
  INDEX `fk_Commande_has_Menu_Commande1_idx` (`Commande_id` ASC),
  CONSTRAINT `fk_Commande_has_Menu_Commande1`
    FOREIGN KEY (`Commande_id`)
    REFERENCES `mydb`.`Commande` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Commande_has_Menu_Menu1`
    FOREIGN KEY (`Menu_id`)
    REFERENCES `mydb`.`Menu` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`table2`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`table2` ;

CREATE TABLE IF NOT EXISTS `mydb`.`table2` (
)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
