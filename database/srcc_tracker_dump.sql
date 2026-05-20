-- MySQL dump 10.13  Distrib 8.0.45, for Linux (x86_64)
--
-- Host: localhost    Database: srcc_tracker
-- ------------------------------------------------------
-- Server version	8.0.45-0ubuntu0.24.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `srcc_tracker`
--

/*!40000 DROP DATABASE IF EXISTS `srcc_tracker`*/;

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `srcc_tracker` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `srcc_tracker`;

--
-- Table structure for table `certifications`
--

DROP TABLE IF EXISTS `certifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `certifications` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `cert_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `issuing_body` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `issue_date` date DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `cert_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `certifications_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `certifications`
--

LOCK TABLES `certifications` WRITE;
/*!40000 ALTER TABLE `certifications` DISABLE KEYS */;
INSERT INTO `certifications` (`id`, `student_id`, `cert_name`, `issuing_body`, `issue_date`, `expiry_date`, `cert_url`, `created_at`) VALUES (1,1,'CFA Level 1','CFA Institute','2023-01-15',NULL,NULL,'2026-05-20 18:35:07'),(2,2,'CFA Level 2','CFA Institute','2023-06-10',NULL,NULL,'2026-05-20 18:35:07'),(3,2,'Bloomberg Market Concepts','Bloomberg','2022-09-01',NULL,NULL,'2026-05-20 18:35:07'),(4,4,'Case Interview Prep (McKinsey)','Coursera','2022-03-20',NULL,NULL,'2026-05-20 18:35:07'),(5,5,'Financial Modelling & Valuation','CFI','2022-11-05','2025-11-05',NULL,'2026-05-20 18:35:07'),(6,8,'CMA','ICMAI','2023-04-18',NULL,NULL,'2026-05-20 18:35:07'),(7,8,'CFA Level 1','CFA Institute','2022-12-10',NULL,NULL,'2026-05-20 18:35:07'),(8,9,'Six Sigma Yellow Belt','KPMG Academy','2023-02-14','2026-02-14',NULL,'2026-05-20 18:35:07'),(9,11,'Bloomberg Market Concepts','Bloomberg','2023-01-20',NULL,NULL,'2026-05-20 18:35:07'),(10,11,'NSE Academy - Derivatives','NSE India','2022-08-05',NULL,NULL,'2026-05-20 18:35:07'),(11,12,'Google Analytics Certified','Google','2023-03-10','2024-03-10',NULL,'2026-05-20 18:35:07'),(12,12,'HubSpot Content Marketing','HubSpot Academy','2023-01-25','2024-01-25',NULL,'2026-05-20 18:35:07'),(13,14,'CFA Level 1','CFA Institute','2023-06-15',NULL,NULL,'2026-05-20 18:35:07'),(14,15,'PMP Foundation','PMI','2021-11-30',NULL,NULL,'2026-05-20 18:35:07'),(15,17,'FRM Part 1','GARP','2023-05-20',NULL,NULL,'2026-05-20 18:35:07'),(16,18,'CFA Level 1','CFA Institute','2022-01-12',NULL,NULL,'2026-05-20 18:35:07'),(17,18,'CFA Level 2','CFA Institute','2022-07-08',NULL,NULL,'2026-05-20 18:35:07'),(18,20,'Bloomberg Market Concepts','Bloomberg','2023-02-28',NULL,NULL,'2026-05-20 18:35:07');
/*!40000 ALTER TABLE `certifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `competitions`
--

DROP TABLE IF EXISTS `competitions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `competitions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `comp_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `organiser` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `result` enum('Winner','Runner-up','Finalist','Participant') COLLATE utf8mb4_unicode_ci NOT NULL,
  `comp_date` date DEFAULT NULL,
  `domain_type` enum('Consulting','Finance','Marketing','General') COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `competitions_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `competitions`
--

LOCK TABLES `competitions` WRITE;
/*!40000 ALTER TABLE `competitions` DISABLE KEYS */;
INSERT INTO `competitions` (`id`, `student_id`, `comp_name`, `organiser`, `result`, `comp_date`, `domain_type`, `created_at`) VALUES (1,4,'Consult Club Case Comp','IIM Ahmedabad','Winner','2022-10-15','Consulting','2026-05-20 18:35:07'),(2,1,'BCG Strategy Challenge','BCG India','Finalist','2023-02-20','Consulting','2026-05-20 18:35:07'),(3,2,'NSE Stock Pitch','NSE India','Runner-up','2023-03-05','Finance','2026-05-20 18:35:07'),(4,3,'HUL L.I.M.E.','HUL','Participant','2023-01-20','Marketing','2026-05-20 18:35:07'),(5,8,'IIM Finance Conclave','IIM Calcutta','Winner','2022-11-30','Finance','2026-05-20 18:35:07'),(6,6,'McKinsey Solve','McKinsey','Finalist','2023-04-10','Consulting','2026-05-20 18:35:07'),(7,12,'Ad Mad Show','SRCC Crossroads','Winner','2022-09-18','Marketing','2026-05-20 18:35:07'),(8,9,'Deloitte TechConsult','Deloitte India','Runner-up','2023-03-25','Consulting','2026-05-20 18:35:07'),(9,15,'CFA Research Challenge','CFA Institute','Finalist','2022-12-05','Finance','2026-05-20 18:35:07'),(10,18,'Bain Case Cracker','Bain & Company','Winner','2022-08-22','Consulting','2026-05-20 18:35:07'),(11,11,'Dalal Street Investomania','SRCC Enactus','Runner-up','2023-02-14','Finance','2026-05-20 18:35:07'),(12,7,'Marketing Maverick','FMS Delhi','Participant','2023-01-30','Marketing','2026-05-20 18:35:07');
/*!40000 ALTER TABLE `competitions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `internships`
--

DROP TABLE IF EXISTS `internships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `internships` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `company_name` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `domain_type` enum('Consulting','Finance','Marketing','Other') COLLATE utf8mb4_unicode_ci NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `stipend_pm` decimal(8,2) DEFAULT NULL,
  `is_ppo` tinyint(1) DEFAULT '0',
  `description` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `student_id` (`student_id`),
  CONSTRAINT `internships_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `internships`
--

LOCK TABLES `internships` WRITE;
/*!40000 ALTER TABLE `internships` DISABLE KEYS */;
INSERT INTO `internships` (`id`, `student_id`, `company_name`, `role`, `domain_type`, `start_date`, `end_date`, `stipend_pm`, `is_ppo`, `description`, `created_at`) VALUES (1,1,'McKinsey & Company','Business Analyst Intern','Consulting','2023-05-01','2023-07-31',80000.00,0,'Market entry strategy for FMCG client','2026-05-20 18:34:46'),(2,2,'Goldman Sachs','Summer Analyst - IBD','Finance','2023-06-01','2023-08-15',90000.00,1,'M&A deal modelling and pitchbook preparation','2026-05-20 18:34:46'),(3,3,'Hindustan Unilever','Marketing Intern','Marketing','2023-04-01','2023-06-30',25000.00,0,'Campaign analytics for rural markets','2026-05-20 18:34:46'),(4,4,'BCG','Consulting Intern','Consulting','2022-05-01','2022-07-31',85000.00,1,'Cost optimisation for pharma client','2026-05-20 18:34:46'),(5,5,'ICICI Bank','Credit Analyst Intern','Finance','2022-06-01','2022-08-31',30000.00,0,'Retail credit risk assessment','2026-05-20 18:34:46'),(6,6,'Bain & Company','Associate Consultant Intern','Consulting','2023-05-15','2023-07-15',75000.00,0,'Due diligence for PE firm','2026-05-20 18:34:46'),(7,8,'JP Morgan','Markets Intern','Finance','2022-06-01','2022-08-15',95000.00,1,'Fixed income desk rotation','2026-05-20 18:34:46'),(8,9,'Deloitte','Strategy & Ops Intern','Consulting','2023-06-01','2023-08-31',60000.00,0,'Process improvement for telecom client','2026-05-20 18:34:46'),(9,11,'Morgan Stanley','Equity Research Intern','Finance','2023-05-01','2023-07-31',70000.00,0,'Sector coverage: FMCG & Retail','2026-05-20 18:34:46'),(10,12,'Ogilvy','Brand Strategy Intern','Marketing','2022-06-01','2022-08-31',20000.00,0,'Rebranding project for NBFC','2026-05-20 18:34:46'),(11,14,'HDFC Securities','Research Analyst Intern','Finance','2023-05-01','2023-07-15',35000.00,0,'Fundamental analysis of mid-cap stocks','2026-05-20 18:34:46'),(12,15,'A.T. Kearney','Strategy Consultant Intern','Consulting','2022-05-01','2022-07-31',78000.00,1,'Supply chain restructuring for auto OEM','2026-05-20 18:34:46'),(13,17,'Kotak Mahindra Bank','Treasury Intern','Finance','2023-06-15','2023-08-30',40000.00,0,'FX risk management desk','2026-05-20 18:34:46'),(14,18,'Oliver Wyman','Financial Services Intern','Consulting','2022-06-01','2022-08-31',82000.00,1,'Regulatory compliance for private bank','2026-05-20 18:34:46');
/*!40000 ALTER TABLE `internships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `skills`
--

DROP TABLE IF EXISTS `skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `skills` (
  `id` int NOT NULL AUTO_INCREMENT,
  `skill_name` varchar(80) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `skill_name` (`skill_name`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `skills`
--

LOCK TABLES `skills` WRITE;
/*!40000 ALTER TABLE `skills` DISABLE KEYS */;
INSERT INTO `skills` (`id`, `skill_name`) VALUES (13,'Bloomberg Terminal'),(11,'Business Strategy'),(6,'Case Frameworks'),(18,'Cold Calling'),(9,'Data Analysis'),(20,'DCF Analysis'),(12,'Digital Marketing'),(1,'Excel'),(5,'Financial Modelling'),(15,'Google Analytics'),(7,'Market Research'),(19,'Pitch Decks'),(2,'PowerPoint'),(3,'Python'),(8,'SEO'),(16,'SPSS'),(4,'SQL'),(17,'Tableau'),(14,'Tally'),(10,'Valuation');
/*!40000 ALTER TABLE `skills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `student_skills`
--

DROP TABLE IF EXISTS `student_skills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student_skills` (
  `student_id` int NOT NULL,
  `skill_id` int NOT NULL,
  PRIMARY KEY (`student_id`,`skill_id`),
  KEY `skill_id` (`skill_id`),
  CONSTRAINT `student_skills_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE,
  CONSTRAINT `student_skills_ibfk_2` FOREIGN KEY (`skill_id`) REFERENCES `skills` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `student_skills`
--

LOCK TABLES `student_skills` WRITE;
/*!40000 ALTER TABLE `student_skills` DISABLE KEYS */;
INSERT INTO `student_skills` (`student_id`, `skill_id`) VALUES (1,1),(2,1),(5,1),(8,1),(11,1),(14,1),(17,1),(20,1),(1,2),(4,2),(13,2),(15,2),(18,2),(3,3),(6,3),(9,3),(19,3),(14,4),(17,4),(20,4),(2,5),(5,5),(8,5),(11,5),(14,5),(17,5),(20,5),(1,6),(4,6),(6,6),(9,6),(13,6),(15,6),(18,6),(3,7),(7,7),(10,7),(12,7),(16,7),(19,7),(3,8),(7,8),(10,8),(12,8),(16,8),(19,8),(1,9),(4,9),(6,9),(9,9),(11,9),(13,9),(15,9),(18,9),(20,9),(2,10),(5,10),(8,10),(11,10),(14,10),(17,10),(20,10),(1,11),(4,11),(6,11),(9,11),(10,11),(13,11),(15,11),(18,11),(3,12),(7,12),(10,12),(12,12),(16,12),(19,12),(2,13),(8,13),(11,13),(17,13),(5,14),(3,15),(7,15),(10,15),(12,15),(16,15),(19,15),(6,16),(7,17),(12,17),(16,17),(4,19),(9,19),(13,19),(15,19),(18,19),(2,20),(5,20),(8,20),(14,20);
/*!40000 ALTER TABLE `student_skills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `students`
--

DROP TABLE IF EXISTS `students`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `students` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roll_no` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(120) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `year` tinyint NOT NULL,
  `programme` enum('B.Com(H)','B.Com','BA(H) Economics','M.Com') COLLATE utf8mb4_unicode_ci NOT NULL,
  `domain` enum('Consulting','Finance','Marketing') COLLATE utf8mb4_unicode_ci NOT NULL,
  `gpa` decimal(4,2) DEFAULT NULL,
  `linkedin_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `placed` tinyint(1) DEFAULT '0',
  `placement_pkg` decimal(10,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roll_no` (`roll_no`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `students`
--

LOCK TABLES `students` WRITE;
/*!40000 ALTER TABLE `students` DISABLE KEYS */;
INSERT INTO `students` (`id`, `name`, `roll_no`, `email`, `phone`, `year`, `programme`, `domain`, `gpa`, `linkedin_url`, `placed`, `placement_pkg`, `created_at`, `updated_at`) VALUES (1,'Aarav Mehta','22BC001','aarav@srcc.edu','9876543210',2,'B.Com(H)','Consulting',8.90,'https://linkedin.com/in/aaravmehta',0,NULL,'2026-05-20 18:34:19','2026-05-20 18:34:19'),(2,'Priya Sharma','22BC002','priya@srcc.edu','9876543211',2,'B.Com(H)','Finance',9.10,'https://linkedin.com/in/priyasharma',1,14.50,'2026-05-20 18:34:19','2026-05-20 18:34:19'),(3,'Rohan Gupta','23BC003','rohan@srcc.edu','9876543212',1,'B.Com(H)','Marketing',7.80,NULL,0,NULL,'2026-05-20 18:34:19','2026-05-20 18:34:19'),(4,'Sneha Iyer','21BC004','sneha@srcc.edu','9876543213',3,'B.Com(H)','Consulting',9.30,'https://linkedin.com/in/snehaiyer',1,18.00,'2026-05-20 18:34:19','2026-05-20 18:34:19'),(5,'Karan Verma','21BC005','karan@srcc.edu','9876543214',3,'B.Com','Finance',8.40,'https://linkedin.com/in/karanverma',1,12.00,'2026-05-20 18:34:19','2026-05-20 18:34:19'),(6,'Ananya Reddy','22BC006','ananya@srcc.edu','9876543215',2,'BA(H) Economics','Consulting',8.70,'https://linkedin.com/in/ananyareddy',0,NULL,'2026-05-20 18:34:19','2026-05-20 18:34:19'),(7,'Vikram Singh','23BC007','vikram@srcc.edu','9876543216',1,'B.Com(H)','Marketing',7.50,NULL,0,NULL,'2026-05-20 18:34:19','2026-05-20 18:34:19'),(8,'Nisha Kapoor','21BC008','nisha@srcc.edu','9876543217',3,'M.Com','Finance',9.60,'https://linkedin.com/in/nishakapoor',1,22.00,'2026-05-20 18:34:19','2026-05-20 18:34:19'),(9,'Dev Malhotra','22BC009','dev@srcc.edu','9876543218',2,'B.Com(H)','Consulting',8.20,'https://linkedin.com/in/devmalhotra',0,NULL,'2026-05-20 18:34:19','2026-05-20 18:34:19'),(10,'Tanya Bose','23BC010','tanya@srcc.edu','9876543219',1,'B.Com','Marketing',8.00,NULL,0,NULL,'2026-05-20 18:34:19','2026-05-20 18:34:19'),(11,'Arjun Nair','22BC011','arjun@srcc.edu','9876543220',2,'B.Com(H)','Finance',8.60,'https://linkedin.com/in/arjunnair',0,NULL,'2026-05-20 18:34:19','2026-05-20 18:34:19'),(12,'Divya Patel','21BC012','divya@srcc.edu','9876543221',3,'B.Com(H)','Marketing',8.10,'https://linkedin.com/in/divyapatel',1,9.50,'2026-05-20 18:34:19','2026-05-20 18:34:19'),(13,'Rahul Joshi','23BC013','rahul@srcc.edu','9876543222',1,'BA(H) Economics','Consulting',7.90,NULL,0,NULL,'2026-05-20 18:34:19','2026-05-20 18:34:19'),(14,'Meera Bhatia','22BC014','meera@srcc.edu','9876543223',2,'B.Com(H)','Finance',9.00,'https://linkedin.com/in/meerabhatia',0,NULL,'2026-05-20 18:34:19','2026-05-20 18:34:19'),(15,'Sahil Khanna','21BC015','sahil@srcc.edu','9876543224',3,'M.Com','Consulting',8.80,'https://linkedin.com/in/sahilkhanna',1,16.00,'2026-05-20 18:34:19','2026-05-20 18:34:19'),(16,'Pooja Agarwal','23BC016','pooja@srcc.edu','9876543225',1,'B.Com','Marketing',7.70,NULL,0,NULL,'2026-05-20 18:34:19','2026-05-20 18:34:19'),(17,'Nikhil Sood','22BC017','nikhil@srcc.edu','9876543226',2,'B.Com(H)','Finance',8.50,'https://linkedin.com/in/nikhilsood',0,NULL,'2026-05-20 18:34:19','2026-05-20 18:34:19'),(18,'Simran Walia','21BC018','simran@srcc.edu','9876543227',3,'B.Com(H)','Consulting',9.10,'https://linkedin.com/in/simranwalia',1,20.00,'2026-05-20 18:34:19','2026-05-20 18:34:19'),(19,'Harsh Goyal','23BC019','harsh@srcc.edu','9876543228',1,'B.Com(H)','Marketing',7.60,NULL,0,NULL,'2026-05-20 18:34:19','2026-05-20 18:34:19'),(20,'Kritika Lal','22BC020','kritika@srcc.edu','9876543229',2,'BA(H) Economics','Finance',8.30,'https://linkedin.com/in/kritikalal',0,NULL,'2026-05-20 18:34:19','2026-05-20 18:34:19');
/*!40000 ALTER TABLE `students` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_cert_leaders`
--

DROP TABLE IF EXISTS `v_cert_leaders`;
/*!50001 DROP VIEW IF EXISTS `v_cert_leaders`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_cert_leaders` AS SELECT 
 1 AS `name`,
 1 AS `roll_no`,
 1 AS `domain`,
 1 AS `cert_count`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_competition_winners`
--

DROP TABLE IF EXISTS `v_competition_winners`;
/*!50001 DROP VIEW IF EXISTS `v_competition_winners`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_competition_winners` AS SELECT 
 1 AS `name`,
 1 AS `domain`,
 1 AS `comp_name`,
 1 AS `organiser`,
 1 AS `result`,
 1 AS `comp_date`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_domain_count`
--

DROP TABLE IF EXISTS `v_domain_count`;
/*!50001 DROP VIEW IF EXISTS `v_domain_count`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_domain_count` AS SELECT 
 1 AS `domain`,
 1 AS `total_students`,
 1 AS `placed_count`,
 1 AS `avg_gpa`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_top_companies`
--

DROP TABLE IF EXISTS `v_top_companies`;
/*!50001 DROP VIEW IF EXISTS `v_top_companies`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_top_companies` AS SELECT 
 1 AS `domain_type`,
 1 AS `company_name`,
 1 AS `intern_count`,
 1 AS `ppo_count`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `v_year_breakdown`
--

DROP TABLE IF EXISTS `v_year_breakdown`;
/*!50001 DROP VIEW IF EXISTS `v_year_breakdown`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_year_breakdown` AS SELECT 
 1 AS `year`,
 1 AS `domain`,
 1 AS `total`*/;
SET character_set_client = @saved_cs_client;

--
-- Current Database: `srcc_tracker`
--

USE `srcc_tracker`;

--
-- Final view structure for view `v_cert_leaders`
--

/*!50001 DROP VIEW IF EXISTS `v_cert_leaders`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_cert_leaders` AS select `s`.`name` AS `name`,`s`.`roll_no` AS `roll_no`,`s`.`domain` AS `domain`,count(`c`.`id`) AS `cert_count` from (`students` `s` left join `certifications` `c` on((`c`.`student_id` = `s`.`id`))) group by `s`.`id` order by `cert_count` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_competition_winners`
--

/*!50001 DROP VIEW IF EXISTS `v_competition_winners`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_competition_winners` AS select `s`.`name` AS `name`,`s`.`domain` AS `domain`,`comp`.`comp_name` AS `comp_name`,`comp`.`organiser` AS `organiser`,`comp`.`result` AS `result`,`comp`.`comp_date` AS `comp_date` from (`competitions` `comp` join `students` `s` on((`s`.`id` = `comp`.`student_id`))) where (`comp`.`result` in ('Winner','Runner-up')) order by `comp`.`comp_date` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_domain_count`
--

/*!50001 DROP VIEW IF EXISTS `v_domain_count`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_domain_count` AS select `students`.`domain` AS `domain`,count(0) AS `total_students`,sum(`students`.`placed`) AS `placed_count`,round(avg(`students`.`gpa`),2) AS `avg_gpa` from `students` group by `students`.`domain` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_top_companies`
--

/*!50001 DROP VIEW IF EXISTS `v_top_companies`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_top_companies` AS select `i`.`domain_type` AS `domain_type`,`i`.`company_name` AS `company_name`,count(0) AS `intern_count`,sum(`i`.`is_ppo`) AS `ppo_count` from `internships` `i` group by `i`.`domain_type`,`i`.`company_name` order by `i`.`domain_type`,`intern_count` desc */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `v_year_breakdown`
--

/*!50001 DROP VIEW IF EXISTS `v_year_breakdown`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = latin1 */;
/*!50001 SET character_set_results     = latin1 */;
/*!50001 SET collation_connection      = latin1_swedish_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_year_breakdown` AS select `students`.`year` AS `year`,`students`.`domain` AS `domain`,count(0) AS `total` from `students` group by `students`.`year`,`students`.`domain` order by `students`.`year`,`students`.`domain` */;
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

-- Dump completed on 2026-05-20 18:35:30
