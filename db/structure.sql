
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
DROP TABLE IF EXISTS `annotations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `annotations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `x_tl` int(11) DEFAULT NULL,
  `y_tl` int(11) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `page_id` int(11) DEFAULT NULL,
  `transcription_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `date_time_id` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_group_id` int(11) DEFAULT NULL,
  `observation_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `by_transcription` (`transcription_id`),
  KEY `by_field_group` (`field_group_id`),
  KEY `by_page` (`page_id`),
  KEY `by_date_time` (`date_time_id`),
  KEY `annotations_x_tl_IDX` (`x_tl`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=427682 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `annotations_and_data_entries`;
/*!50001 DROP VIEW IF EXISTS `annotations_and_data_entries`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `annotations_and_data_entries` AS SELECT 
 1 AS `annotation_id`,
 1 AS `transcription_id`,
 1 AS `page_id`,
 1 AS `page_type_id`,
 1 AS `page_start_date`,
 1 AS `observation_date`,
 1 AS `created_at`,
 1 AS `updated_at`,
 1 AS `field_group_id`,
 1 AS `user_id`,
 1 AS `data_entry_id`,
 1 AS `value`,
 1 AS `value_as_number`,
 1 AS `field_options_ids`,
 1 AS `field_id`,
 1 AS `internal_name`,
 1 AS `field_key`*/;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `ar_internal_metadata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ar_internal_metadata` (
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `audit_data_entry_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `audit_data_entry_versions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `item_type` varchar(255) NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `event` varchar(255) NOT NULL,
  `whodunnit` varchar(255) DEFAULT NULL,
  `object` longtext,
  `object_changes` longtext,
  `created_at` datetime(6) DEFAULT NULL,
  `whodunnit_as_id` int(11) GENERATED ALWAYS AS (cast(`whodunnit` as unsigned)) STORED,
  `value` text,
  `prev_value` text,
  `user_id` int(11) DEFAULT NULL,
  `prev_user_id` int(11) DEFAULT NULL,
  `notes` text,
  PRIMARY KEY (`id`),
  KEY `index_audit_data_entry_versions_on_item_type_and_item_id` (`item_type`,`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `content_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `content_images` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image_file_name` varchar(255) DEFAULT NULL,
  `image_content_type` varchar(255) DEFAULT NULL,
  `image_file_size` int(11) DEFAULT NULL,
  `image_updated_at` datetime DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=285 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `data_entries`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `data_entries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` text COLLATE utf8_unicode_ci,
  `data_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `page_id` int(11) DEFAULT NULL,
  `annotation_id` int(11) DEFAULT NULL,
  `field_id` int(11) DEFAULT NULL,
  `field_options_ids` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `annotation_field` (`annotation_id`,`field_id`),
  KEY `index_data_entries_on_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1917414 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `data_entries_audit_details`;
/*!50001 DROP VIEW IF EXISTS `data_entries_audit_details`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `data_entries_audit_details` AS SELECT 
 1 AS `id`,
 1 AS `user_id`,
 1 AS `user_name`,
 1 AS `page_id`,
 1 AS `page_title`,
 1 AS `location`,
 1 AS `transcription_id`,
 1 AS `annotation_id`,
 1 AS `observation_date`,
 1 AS `field_id`,
 1 AS `field_key`,
 1 AS `value`,
 1 AS `prev_value`,
 1 AS `notes`,
 1 AS `whodunnit`,
 1 AS `change_time`,
 1 AS `event`,
 1 AS `who_id`,
 1 AS `who_name`*/;
SET character_set_client = @saved_cs_client;
DROP TABLE IF EXISTS `field_group_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `field_group_translations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `field_group_id` int(11) NOT NULL,
  `locale` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `display_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `help` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `index_field_group_translations_on_field_group_id` (`field_group_id`),
  KEY `index_field_group_translations_on_locale` (`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `field_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `field_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `colour_class` varchar(255) NOT NULL DEFAULT '',
  `internal_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `field_groups_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `field_groups_fields` (
  `field_group_id` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sort_order` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_field_groups_fields_on_field_group_id` (`field_group_id`),
  KEY `index_field_groups_fields_on_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=141 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `field_option_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `field_option_translations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `field_option_id` int(11) NOT NULL,
  `locale` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `help` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `index_field_option_translations_on_field_option_id` (`field_option_id`),
  KEY `index_field_option_translations_on_locale` (`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=258 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `field_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `field_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image_file_name` varchar(255) DEFAULT NULL,
  `image_content_type` varchar(255) DEFAULT NULL,
  `image_file_size` int(11) DEFAULT NULL,
  `image_updated_at` datetime DEFAULT NULL,
  `value` varchar(255) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `text_symbol` varchar(255) DEFAULT NULL,
  `display_attribute` varchar(255) DEFAULT 'name',
  `internal_name` varchar(255) DEFAULT NULL,
  `is_default` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=148 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `field_options_fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `field_options_fields` (
  `field_option_id` int(11) NOT NULL,
  `field_id` int(11) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sort_order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_field_options_fields_on_field_option_id` (`field_option_id`),
  KEY `index_field_options_fields_on_field_id` (`field_id`)
) ENGINE=InnoDB AUTO_INCREMENT=730 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `field_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `field_translations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `field_id` int(11) NOT NULL,
  `locale` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `full_name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `help` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`id`),
  KEY `index_field_translations_on_field_id` (`field_id`),
  KEY `index_field_translations_on_locale` (`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=160 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `fields`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `field_key` varchar(255) DEFAULT NULL,
  `html_field_type` varchar(255) DEFAULT NULL,
  `data_type` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `multi_select` tinyint(1) DEFAULT '0',
  `internal_name` varchar(255) DEFAULT NULL,
  `period` varchar(255) DEFAULT NULL,
  `time_of_day` varchar(255) DEFAULT NULL,
  `measurement_type` varchar(255) DEFAULT NULL,
  `measurement_unit_original` varchar(255) DEFAULT NULL,
  `measurement_unit_si` varchar(255) DEFAULT NULL,
  `odr_type` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=86 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `ledgers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ledgers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `ledger_type` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_ledgers_on_ledger_type` (`ledger_type`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `mobility_string_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mobility_string_translations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `locale` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `translatable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `translatable_id` bigint(20) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_mobility_string_translations_on_keys` (`translatable_id`,`translatable_type`,`locale`,`key`),
  KEY `index_mobility_string_translations_on_translatable_attribute` (`translatable_id`,`translatable_type`,`key`),
  KEY `index_mobility_string_translations_on_query_keys` (`translatable_type`,`key`,`value`,`locale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `mobility_text_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `mobility_text_translations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `locale` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `value` text COLLATE utf8_unicode_ci,
  `translatable_type` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `translatable_id` bigint(20) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_mobility_text_translations_on_keys` (`translatable_id`,`translatable_type`,`locale`,`key`),
  KEY `index_mobility_text_translations_on_translatable_attribute` (`translatable_id`,`translatable_type`,`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `page_days`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `page_days` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `num_observations` int(11) DEFAULT NULL,
  `page_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `lock_version` int(11) NOT NULL DEFAULT '0',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  KEY `by_page` (`page_id`),
  KEY `by_user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=21336 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `page_infos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `page_infos` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `observer` varchar(255) DEFAULT NULL,
  `lat` varchar(255) DEFAULT NULL,
  `lon` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `page_id` bigint(20) DEFAULT NULL,
  `user_id` bigint(20) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `elevation` varchar(255) DEFAULT NULL,
  `month` int(11) DEFAULT NULL,
  `year` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_page_infos_on_page_id` (`page_id`),
  KEY `index_page_infos_on_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `page_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `page_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `ledger_type` varchar(255) DEFAULT NULL,
  `number` varchar(255) DEFAULT NULL,
  `description` text,
  `ledger_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `visible` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_page_types_on_title_and_ledger_type_and_number` (`title`,`ledger_type`,`number`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `page_types_field_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `page_types_field_groups` (
  `page_type_id` int(11) NOT NULL,
  `field_group_id` int(11) NOT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sort_order` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `index_page_types_field_groups_on_page_type_id` (`page_type_id`),
  KEY `index_page_types_field_groups_on_field_group_id` (`field_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=246 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `width` int(11) DEFAULT NULL,
  `page_type_id` int(11) DEFAULT NULL,
  `done` tinyint(1) NOT NULL DEFAULT '0',
  `accession_number` varchar(255) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `image_file_name` varchar(255) DEFAULT NULL,
  `image_content_type` varchar(255) DEFAULT NULL,
  `image_file_size` int(11) DEFAULT NULL,
  `image_updated_at` datetime DEFAULT NULL,
  `volume` varchar(255) DEFAULT NULL,
  `visible` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `unque_page_ldgr_vol` (`title`,`page_type_id`,`accession_number`,`volume`),
  UNIQUE KEY `index_pages_on_image_file_name` (`image_file_name`),
  KEY `index_pages_on_page_type_id` (`page_type_id`),
  CONSTRAINT `fk_rails_beb8abcb8d` FOREIGN KEY (`page_type_id`) REFERENCES `page_types` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7166 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `schema_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schema_migrations` (
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  UNIQUE KEY `unique_schema_migrations` (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `session_id` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `data` longtext COLLATE utf8_unicode_ci,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_sessions_on_session_id` (`session_id`),
  KEY `index_sessions_on_updated_at` (`updated_at`)
) ENGINE=InnoDB AUTO_INCREMENT=1041129 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `static_page_translations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `static_page_translations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `static_page_id` int(11) NOT NULL,
  `locale` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `body` longtext COLLATE utf8_unicode_ci,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `meta_keywords` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `meta_title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `meta_description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_static_page_translations_on_static_page_id` (`static_page_id`),
  KEY `index_static_page_translations_on_locale` (`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `static_pages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `static_pages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `show_in_header` tinyint(1) NOT NULL DEFAULT '0',
  `show_in_footer` tinyint(1) NOT NULL DEFAULT '0',
  `visible` tinyint(1) NOT NULL DEFAULT '1',
  `position` int(11) NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `title_as_header` tinyint(1) DEFAULT '1',
  `parent_id` int(11) DEFAULT NULL,
  `show_in_transcriber` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fk_rails_7542642651` (`parent_id`),
  CONSTRAINT `fk_rails_7542642651` FOREIGN KEY (`parent_id`) REFERENCES `static_pages` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `transcriptions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `transcriptions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `page_id` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `complete` tinyint(1) NOT NULL DEFAULT '0',
  `field_groups_fields_count` int(11) NOT NULL DEFAULT '0',
  `data_entries_count` int(11) NOT NULL DEFAULT '0',
  `started_rows_count` int(11) NOT NULL DEFAULT '0',
  `expected_rows_count` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_page` (`user_id`,`page_id`),
  KEY `fk_rails_fa14a87e4a` (`page_id`),
  CONSTRAINT `fk_rails_ebe9957a54` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  CONSTRAINT `fk_rails_fa14a87e4a` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4317 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL DEFAULT '',
  `encrypted_password` varchar(255) NOT NULL DEFAULT '',
  `reset_password_token` varchar(255) DEFAULT NULL,
  `reset_password_sent_at` datetime DEFAULT NULL,
  `remember_created_at` datetime DEFAULT NULL,
  `sign_in_count` int(11) NOT NULL DEFAULT '0',
  `current_sign_in_at` datetime DEFAULT NULL,
  `last_sign_in_at` datetime DEFAULT NULL,
  `current_sign_in_ip` varchar(255) DEFAULT NULL,
  `last_sign_in_ip` varchar(255) DEFAULT NULL,
  `confirmation_token` varchar(255) DEFAULT NULL,
  `confirmed_at` datetime DEFAULT NULL,
  `confirmation_sent_at` datetime DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) DEFAULT NULL,
  `bio` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `avatar_file_name` varchar(255) DEFAULT NULL,
  `avatar_content_type` varchar(255) DEFAULT NULL,
  `avatar_file_size` int(11) DEFAULT NULL,
  `avatar_updated_at` datetime DEFAULT NULL,
  `dismissed_box_tutorial` tinyint(1) NOT NULL DEFAULT '0',
  `full_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_users_on_email` (`email`),
  UNIQUE KEY `index_users_on_reset_password_token` (`reset_password_token`),
  UNIQUE KEY `index_users_on_confirmation_token` (`confirmation_token`)
) ENGINE=InnoDB AUTO_INCREMENT=761 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
DROP TABLE IF EXISTS `versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `versions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `item_type` varchar(191) NOT NULL,
  `item_id` bigint(20) NOT NULL,
  `event` varchar(255) NOT NULL,
  `whodunnit` varchar(255) DEFAULT NULL,
  `object` longtext,
  `object_changes` longtext,
  `created_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_versions_on_item_type_and_item_id` (`item_type`,`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50001 DROP VIEW IF EXISTS `annotations_and_data_entries`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY INVOKER */
/*!50001 VIEW `annotations_and_data_entries` AS select `a`.`id` AS `annotation_id`,`a`.`transcription_id` AS `transcription_id`,`a`.`page_id` AS `page_id`,`p`.`page_type_id` AS `page_type_id`,`p`.`start_date` AS `page_start_date`,`a`.`observation_date` AS `observation_date`,`a`.`created_at` AS `created_at`,`a`.`updated_at` AS `updated_at`,`a`.`field_group_id` AS `field_group_id`,`d`.`user_id` AS `user_id`,`d`.`id` AS `data_entry_id`,`d`.`value` AS `value`,if((`d`.`value` regexp '^-?[0-9]+.?[0-9]*$'),cast(`d`.`value` as decimal(14,4)),NULL) AS `value_as_number`,`d`.`field_options_ids` AS `field_options_ids`,`d`.`field_id` AS `field_id`,`field_stuff`.`internal_name` AS `internal_name`,`field_stuff`.`field_key` AS `field_key` from (((`draw_development`.`annotations` `a` join `draw_development`.`data_entries` `d` on((`d`.`annotation_id` = `a`.`id`))) join `draw_development`.`pages` `p` on((`p`.`id` = `a`.`page_id`))) join (select `f`.`id` AS `field_id`,`f`.`field_key` AS `field_key`,`f`.`internal_name` AS `internal_name`,`f`.`period` AS `period`,`f`.`measurement_type` AS `measurement_type`,`f`.`measurement_unit_original` AS `measurement_unit_original`,`f`.`measurement_unit_si` AS `measurement_unit_si`,`f`.`time_of_day` AS `time_of_day`,`ptfg`.`page_type_id` AS `page_type_id`,`fgf`.`field_group_id` AS `field_group_id` from ((`draw_development`.`fields` `f` join `draw_development`.`field_groups_fields` `fgf` on((`fgf`.`field_id` = `f`.`id`))) join `draw_development`.`page_types_field_groups` `ptfg` on((`ptfg`.`field_group_id` = `fgf`.`field_group_id`)))) `field_stuff` on(((`field_stuff`.`field_id` = `d`.`field_id`) and (`field_stuff`.`page_type_id` = `p`.`page_type_id`)))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!50001 DROP VIEW IF EXISTS `data_entries_audit_details`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY INVOKER */
/*!50001 VIEW `data_entries_audit_details` AS select `adev`.`id` AS `id`,`u`.`id` AS `user_id`,`u`.`display_name` AS `user_name`,`p`.`id` AS `page_id`,`p`.`title` AS `page_title`,`pi`.`location` AS `location`,`t`.`id` AS `transcription_id`,`a`.`id` AS `annotation_id`,`a`.`observation_date` AS `observation_date`,`de`.`field_id` AS `field_id`,`f`.`field_key` AS `field_key`,`adev`.`value` AS `value`,`adev`.`prev_value` AS `prev_value`,`adev`.`notes` AS `notes`,`adev`.`whodunnit` AS `whodunnit`,`adev`.`created_at` AS `change_time`,`adev`.`event` AS `event`,`who`.`id` AS `who_id`,`who`.`display_name` AS `who_name` from ((((((((`pages` `p` left join `page_infos` `pi` on((`pi`.`page_id` = `p`.`id`))) join `transcriptions` `t` on((`t`.`page_id` = `p`.`id`))) join `annotations` `a` on((`a`.`transcription_id` = `t`.`id`))) join `data_entries` `de` on((`de`.`annotation_id` = `a`.`id`))) join `fields` `f` on((`de`.`field_id` = `f`.`id`))) join `users` `u` on((`de`.`user_id` = `u`.`id`))) join `audit_data_entry_versions` `adev` on((`adev`.`item_id` = `de`.`id`))) join `users` `who` on((`who`.`id` = `adev`.`whodunnit_as_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

INSERT INTO `schema_migrations` (version) VALUES
('20150503202809'),
('20150504175714'),
('20150504180209'),
('20150504181401'),
('20150504181423'),
('20150504181838'),
('20150504181957'),
('20150504181962'),
('20150504182107'),
('20150504185427'),
('20150504201242'),
('20160310011306'),
('20160317002211'),
('20160317011631'),
('20160328185727'),
('20160331213030'),
('20160331213952'),
('20160404015639'),
('20160404015952'),
('20160404020411'),
('20160406235534'),
('20160407001538'),
('20160417150700'),
('20160426205819'),
('20160426210010'),
('20160509032602'),
('20160515211048'),
('20160515213104'),
('20160523193802'),
('20160523202122'),
('20160523211934'),
('20160524115800'),
('20160525003123'),
('20160711015645'),
('20160711020107'),
('20160711024227'),
('20160726034746'),
('20160822000312'),
('20160822002059'),
('20160828232558'),
('20160901004242'),
('20160910230147'),
('20160911092302'),
('20160911201950'),
('20160915003746'),
('20161109024937'),
('20161213013633'),
('20161213013650'),
('20170115192851'),
('20170115204254'),
('20170115205322'),
('20170123191325'),
('20170130003321'),
('20170304173943'),
('20170502020626'),
('20170512050201'),
('20170512050312'),
('20170512054051'),
('20170626211544'),
('20170804013628'),
('20170928025357'),
('20170928031559'),
('20171004041222'),
('20171004041329'),
('20171007022052'),
('20171007193140'),
('20171107024341'),
('20190223195457'),
('20190223195458'),
('20190224040555'),
('20190425130144'),
('20190924175201'),
('20190924181456'),
('20191001204101'),
('20200128013758'),
('20200131040933'),
('20200202145051'),
('20200203142051'),
('20200211232706'),
('20200217020739'),
('20200826195658'),
('20200909175105'),
('20201102224030'),
('20201102224953'),
('20201103000220'),
('20201103000221'),
('20201103000222'),
('20201231200247'),
('20201231221221'),
('20210425202809'),
('20210623185258'),
('20221018160139'),
('20221018160140'),
('20221018232624'),
('20230210204547'),
('20230215205558'),
('20230226155950'),
('20230226161316'),
('20230227192645'),
('20230305154341'),
('20230316214752'),
('20250224161953'),
('20250224180604'),
('20250224180941');


