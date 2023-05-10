-- MySQL Workbench Synchronization

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

ALTER TABLE `chaye`.`ask_for_collaboration` 
DROP FOREIGN KEY ``;

ALTER TABLE `chaye`.`announcments` 
DROP FOREIGN KEY ``;

ALTER TABLE `chaye`.`colis` 
DROP FOREIGN KEY ``;

ALTER TABLE `chaye`.`confirm_catch_colis` 
DROP FOREIGN KEY ``;

ALTER TABLE `chaye`.`claims_alert` 
DROP FOREIGN KEY ``;

ALTER TABLE `chaye`.`claims_details` 
DROP FOREIGN KEY ``;

ALTER TABLE `chaye`.`bank_account` 
DROP FOREIGN KEY ``;

ALTER TABLE `chaye`.`rib_bank` 
DROP FOREIGN KEY ``;

ALTER TABLE `chaye`.`wallet_btc` 
DROP FOREIGN KEY ``;

ALTER TABLE `chaye`.`reserved_payment` 
DROP FOREIGN KEY ``;

ALTER TABLE `chaye`.`payment` 
DROP FOREIGN KEY ``;

ALTER TABLE `chaye`.`trajet` 
DROP FOREIGN KEY ``;

ALTER TABLE `chaye`.`position` 
DROP FOREIGN KEY ``;

ALTER TABLE `chaye`.`tchat_discussions` 
DROP FOREIGN KEY ``;

ALTER TABLE `chaye`.`tchat_messages` 
DROP FOREIGN KEY ``;

CREATE TABLE IF NOT EXISTS `chaye`.`recipients` (
  `id` INT(11) NULL DEFAULT NULL,
  `member_id` INT(11) NULL DEFAULT NULL,
  `lastname` VARCHAR(50) NULL DEFAULT NULL,
  `phone` VARCHAR(20) NULL DEFAULT NULL,
  `delivery_adress` TEXT NULL DEFAULT NULL,
  `delivery_validation_key` VARCHAR(60) NULL DEFAULT NULL,
  `created_at` DATETIME NULL DEFAULT NULL,
  `updated_at` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  CONSTRAINT `fk_0f4ef02c-edc1-11ed-9b59-d85ed3a42bd8`
    FOREIGN KEY (`member_id`)
    REFERENCES `chaye`.`members` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

ALTER TABLE `chaye`.`ask_for_collaboration` 
ADD INDEX `fk_0f4ef64e-edc1-11ed-9b59-d85ed3a42bd8` (`sender` ASC),
ADD INDEX `fk_0f4ef6ee-edc1-11ed-9b59-d85ed3a42bd8` (`transporter` ASC),
DROP INDEX  ;
;

ALTER TABLE `chaye`.`announcments` 
ADD INDEX `fk_0f4efc52-edc1-11ed-9b59-d85ed3a42bd8` (`member_id` ASC),
DROP INDEX  ;
;

ALTER TABLE `chaye`.`colis` 
ADD INDEX `fk_0f4f02ba-edc1-11ed-9b59-d85ed3a42bd8` (`collaboration_key` ASC),
DROP INDEX  ;
;

ALTER TABLE `chaye`.`confirm_catch_colis` 
DROP COLUMN `create_date`,
ADD COLUMN `created_at` DATETIME NULL DEFAULT NULL AFTER `state`,
ADD INDEX `fk_0f4f08c8-edc1-11ed-9b59-d85ed3a42bd8` (`collaboration_key` ASC),
ADD INDEX `fk_0f4f0972-edc1-11ed-9b59-d85ed3a42bd8` (`colis_id` ASC),
DROP INDEX  ;
;

ALTER TABLE `chaye`.`claims_alert` 
ADD INDEX `fk_0f4f0ecc-edc1-11ed-9b59-d85ed3a42bd8` (`send_by` ASC),
ADD INDEX `fk_0f4f0f58-edc1-11ed-9b59-d85ed3a42bd8` (`collaboration_key` ASC),
DROP INDEX  ;
;

ALTER TABLE `chaye`.`claims_details` 
ADD INDEX `fk_0f4f1354-edc1-11ed-9b59-d85ed3a42bd8` (`claims_alert_id` ASC),
DROP INDEX  ;
;

ALTER TABLE `chaye`.`bank_account` 
ADD INDEX `fk_0f4f1854-edc1-11ed-9b59-d85ed3a42bd8` (`membre_id` ASC),
DROP INDEX  ;
;

ALTER TABLE `chaye`.`rib_bank` 
ADD INDEX `fk_0f4f1c32-edc1-11ed-9b59-d85ed3a42bd8` (`bank_account_id` ASC),
DROP INDEX  ;
;

ALTER TABLE `chaye`.`wallet_btc` 
ADD INDEX `fk_0f4f2024-edc1-11ed-9b59-d85ed3a42bd8` (`bank_account_id` ASC),
DROP INDEX  ;
;

ALTER TABLE `chaye`.`reserved_payment` 
ADD INDEX `fk_0f4f251a-edc1-11ed-9b59-d85ed3a42bd8` (`collaboration_key` ASC),
ADD INDEX `fk_0f4f25b0-edc1-11ed-9b59-d85ed3a42bd8` (`from_bank_account_id` ASC),
DROP INDEX  ;
;

ALTER TABLE `chaye`.`payment` 
ADD INDEX `fk_0f4f2b14-edc1-11ed-9b59-d85ed3a42bd8` (`to_bank_account_id` ASC),
DROP INDEX  ;
;

ALTER TABLE `chaye`.`trajet` 
ADD INDEX `fk_0f4f34d8-edc1-11ed-9b59-d85ed3a42bd8` (`transporteur_id` ASC),
ADD INDEX `fk_0f4f356e-edc1-11ed-9b59-d85ed3a42bd8` (`colis_id` ASC),
DROP INDEX  ;
;

ALTER TABLE `chaye`.`position` 
ADD INDEX `fk_0f4f3a64-edc1-11ed-9b59-d85ed3a42bd8` (`membres_id` ASC),
DROP INDEX  ;
;

ALTER TABLE `chaye`.`tchat_discussions` 
ADD INDEX `fk_0f4f3f3c-edc1-11ed-9b59-d85ed3a42bd8` (`discussion_opener_id` ASC),
ADD INDEX `fk_0f4f3fd2-edc1-11ed-9b59-d85ed3a42bd8` (`discussion_receiver_id` ASC),
DROP INDEX  ;
;

ALTER TABLE `chaye`.`tchat_messages` 
ADD INDEX `fk_0f4f455e-edc1-11ed-9b59-d85ed3a42bd8` (`discussion_id` ASC),
ADD INDEX `fk_0f4f45ea-edc1-11ed-9b59-d85ed3a42bd8` (`member_id` ASC),
DROP INDEX  ;
;

DROP TABLE IF EXISTS `chaye`.`member_types` ;

DROP TABLE IF EXISTS `chaye`.`member_connections` ;

DROP TABLE IF EXISTS `chaye`.`message` ;

DROP TABLE IF EXISTS `chaye`.`discussion` ;

DROP TABLE IF EXISTS `chaye`.`annonce` ;

DROP TABLE IF EXISTS `chaye`.`Destinataire` ;

ALTER TABLE `chaye`.`ask_for_collaboration` 
ADD CONSTRAINT `fk_0f4ef64e-edc1-11ed-9b59-d85ed3a42bd8`
  FOREIGN KEY (`sender`)
  REFERENCES `chaye`.`members` (`id`),
ADD CONSTRAINT `fk_0f4ef6ee-edc1-11ed-9b59-d85ed3a42bd8`
  FOREIGN KEY (`transporter`)
  REFERENCES `chaye`.`members` (`id`);

ALTER TABLE `chaye`.`announcments` 
ADD CONSTRAINT `fk_0f4efc52-edc1-11ed-9b59-d85ed3a42bd8`
  FOREIGN KEY (`member_id`)
  REFERENCES `chaye`.`members` (`id`);

ALTER TABLE `chaye`.`colis` 
ADD CONSTRAINT `fk_0f4f02ba-edc1-11ed-9b59-d85ed3a42bd8`
  FOREIGN KEY (`collaboration_key`)
  REFERENCES `chaye`.`ask_for_collaboration` (`keygen`);

ALTER TABLE `chaye`.`confirm_catch_colis` 
ADD CONSTRAINT `fk_0f4f08c8-edc1-11ed-9b59-d85ed3a42bd8`
  FOREIGN KEY (`collaboration_key`)
  REFERENCES `chaye`.`ask_for_collaboration` (`keygen`),
ADD CONSTRAINT `fk_0f4f0972-edc1-11ed-9b59-d85ed3a42bd8`
  FOREIGN KEY (`colis_id`)
  REFERENCES `chaye`.`colis` (`id`);

ALTER TABLE `chaye`.`claims_alert` 
ADD CONSTRAINT `fk_0f4f0ecc-edc1-11ed-9b59-d85ed3a42bd8`
  FOREIGN KEY (`send_by`)
  REFERENCES `chaye`.`members` (`id`),
ADD CONSTRAINT `fk_0f4f0f58-edc1-11ed-9b59-d85ed3a42bd8`
  FOREIGN KEY (`collaboration_key`)
  REFERENCES `chaye`.`ask_for_collaboration` (`keygen`);

ALTER TABLE `chaye`.`claims_details` 
ADD CONSTRAINT `fk_0f4f1354-edc1-11ed-9b59-d85ed3a42bd8`
  FOREIGN KEY (`claims_alert_id`)
  REFERENCES `chaye`.`claims_alert` (`id`),
ADD CONSTRAINT `fk_0f4f13e0-edc1-11ed-9b59-d85ed3a42bd8`
  FOREIGN KEY (`membre_id`)
  REFERENCES `chaye`.`membres` (`id`);

ALTER TABLE `chaye`.`bank_account` 
ADD CONSTRAINT `fk_0f4f1854-edc1-11ed-9b59-d85ed3a42bd8`
  FOREIGN KEY (`membre_id`)
  REFERENCES `chaye`.`membres` (`id`);

ALTER TABLE `chaye`.`rib_bank` 
ADD CONSTRAINT `fk_0f4f1c32-edc1-11ed-9b59-d85ed3a42bd8`
  FOREIGN KEY (`bank_account_id`)
  REFERENCES `chaye`.`bank_account` (`id`);

ALTER TABLE `chaye`.`wallet_btc` 
ADD CONSTRAINT `fk_0f4f2024-edc1-11ed-9b59-d85ed3a42bd8`
  FOREIGN KEY (`bank_account_id`)
  REFERENCES `chaye`.`bank_account` (`id`);

ALTER TABLE `chaye`.`reserved_payment` 
ADD CONSTRAINT `fk_0f4f251a-edc1-11ed-9b59-d85ed3a42bd8`
  FOREIGN KEY (`collaboration_key`)
  REFERENCES `chaye`.`ask_for_collaboration` (`keygen`),
ADD CONSTRAINT `fk_0f4f25b0-edc1-11ed-9b59-d85ed3a42bd8`
  FOREIGN KEY (`from_bank_account_id`)
  REFERENCES `chaye`.`bank_account` (`id`);

ALTER TABLE `chaye`.`payment` 
ADD CONSTRAINT `fk_0f4f2b14-edc1-11ed-9b59-d85ed3a42bd8`
  FOREIGN KEY (`to_bank_account_id`)
  REFERENCES `chaye`.`bank_account` (`id`);

ALTER TABLE `chaye`.`trajet` 
ADD CONSTRAINT `fk_0f4f34d8-edc1-11ed-9b59-d85ed3a42bd8`
  FOREIGN KEY (`transporteur_id`)
  REFERENCES `chaye`.`members` (`id`),
ADD CONSTRAINT `fk_0f4f356e-edc1-11ed-9b59-d85ed3a42bd8`
  FOREIGN KEY (`colis_id`)
  REFERENCES `chaye`.`colis` (`id`);

ALTER TABLE `chaye`.`position` 
ADD CONSTRAINT `fk_0f4f3a64-edc1-11ed-9b59-d85ed3a42bd8`
  FOREIGN KEY (`membres_id`)
  REFERENCES `chaye`.`membres` (`id`);

ALTER TABLE `chaye`.`tchat_discussions` 
ADD CONSTRAINT `fk_0f4f3f3c-edc1-11ed-9b59-d85ed3a42bd8`
  FOREIGN KEY (`discussion_opener_id`)
  REFERENCES `chaye`.`members` (`id`),
ADD CONSTRAINT `fk_0f4f3fd2-edc1-11ed-9b59-d85ed3a42bd8`
  FOREIGN KEY (`discussion_receiver_id`)
  REFERENCES `chaye`.`members` (`id`);

ALTER TABLE `chaye`.`tchat_messages` 
ADD CONSTRAINT `fk_0f4f455e-edc1-11ed-9b59-d85ed3a42bd8`
  FOREIGN KEY (`discussion_id`)
  REFERENCES `chaye`.`tchat_discussions` (`id`),
ADD CONSTRAINT `fk_0f4f45ea-edc1-11ed-9b59-d85ed3a42bd8`
  FOREIGN KEY (`member_id`)
  REFERENCES `chaye`.`members` (`id`);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
