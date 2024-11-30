/*
SQLyog Community v13.2.1 (64 bit)
MySQL - 10.4.32-MariaDB : Database - dy_library
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`dy_library` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `dy_library`;

/*Table structure for table `authors` */

DROP TABLE IF EXISTS `authors`;

CREATE TABLE `authors` (
  `authorid` int(9) NOT NULL AUTO_INCREMENT,
  `name` char(255) NOT NULL,
  PRIMARY KEY (`authorid`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `authors` */

insert  into `authors`(`authorid`,`name`) values 
(5,'Kuro'),
(6,'amba'),
(7,'ambatu'),
(8,'renz'),
(9,'jeryk'),
(12,'vvvvv'),
(13,'AAAAA');

/*Table structure for table `books` */

DROP TABLE IF EXISTS `books`;

CREATE TABLE `books` (
  `bookid` int(9) NOT NULL AUTO_INCREMENT,
  `title` char(255) NOT NULL,
  PRIMARY KEY (`bookid`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `books` */

insert  into `books`(`bookid`,`title`) values 
(1,'WutheringWWWW'),
(2,'ambasing'),
(3,'ambas'),
(4,'renz'),
(5,'blah'),
(7,'Sentinels'),
(8,'wotwot'),
(9,'WWWWWWW');

/*Table structure for table `books_author` */

DROP TABLE IF EXISTS `books_author`;

CREATE TABLE `books_author` (
  `collectionid` int(9) NOT NULL AUTO_INCREMENT,
  `bookid` int(9) NOT NULL,
  `authorid` int(9) NOT NULL,
  PRIMARY KEY (`collectionid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `books_author` */

/*Table structure for table `user_tokens` */

DROP TABLE IF EXISTS `user_tokens`;

CREATE TABLE `user_tokens` (
  `id` int(9) NOT NULL AUTO_INCREMENT,
  `userid` int(9) NOT NULL,
  `token` varchar(255) DEFAULT NULL,
  `created_at` year(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `user_tokens` */

insert  into `user_tokens`(`id`,`userid`,`token`,`created_at`) values 
(1,1,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbGlicmFyeS5vcmciLCJhdWQiOiJodHRwOi8vbGlicmFyeS5jb20iLCJpYXQiOjE3Mjk0NDQzMjYsImV4cCI6MTcyOTQ0NzkyNiwiZGF0YSI6eyJ1c2VyaWQiOjF9fQ.El29u0e_RW_sF-lmGTDZlT3zn-NfBRC4_a7VHKsf5G8',NULL),
(3,1,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbGlicmFyeS5vcmciLCJhdWQiOiJodHRwOi8vbGlicmFyeS5jb20iLCJpYXQiOjE3Mjk0NDQ2NjIsImV4cCI6MTcyOTQ0ODI2MiwiZGF0YSI6eyJ1c2VyaWQiOjF9fQ.Ytla9KavnYTnc8RID_Io7EhUSBSLPHy3TYmuDbnd7Bw',NULL),
(4,1,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbGlicmFyeS5vcmciLCJhdWQiOiJodHRwOi8vbGlicmFyeS5jb20iLCJpYXQiOjE3MzAwMTM5MDksImV4cCI6MTczMDAxNzUwOSwiZGF0YSI6eyJ1c2VyaWQiOjF9fQ.UFo9063KpCeq3_57DFSnoZC2iuoq1KAAl_sgvQvHFeg',NULL),
(5,1,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbGlicmFyeS5vcmciLCJhdWQiOiJodHRwOi8vbGlicmFyeS5jb20iLCJpYXQiOjE3MzAwMTQxMTIsImV4cCI6MTczMDAxNzcxMiwiZGF0YSI6eyJ1c2VyaWQiOjF9fQ.eC2EMv4j1hogqZiJZcsIjycxbWoi1cXDtMiNIXiHf2A',NULL),
(7,1,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbGlicmFyeS5vcmciLCJhdWQiOiJodHRwOi8vbGlicmFyeS5jb20iLCJpYXQiOjE3MzAwMTQyMjEsImV4cCI6MTczMDAxNzgyMSwiZGF0YSI6eyJ1c2VyaWQiOjF9fQ.eGhhPRBGHRSbTFbMj9SFS3OXXsnHQ00XnAHEZar3LRM',NULL),
(8,1,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbGlicmFyeS5vcmciLCJhdWQiOiJodHRwOi8vbGlicmFyeS5jb20iLCJpYXQiOjE3MzAwMjgyNjcsImV4cCI6MTczMDAzMTg2NywiZGF0YSI6eyJ1c2VyaWQiOjF9fQ.5_aNWt_u06aXjHCS0kBq3KsEbSIl7eRk-nYZl9kSCEI',NULL),
(10,5,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbGlicmFyeS5vcmciLCJhdWQiOiJodHRwOi8vbGlicmFyeS5jb20iLCJpYXQiOjE3MzAwMjgzOTgsImV4cCI6MTczMDAzMTk5OCwiZGF0YSI6eyJ1c2VyaWQiOjV9fQ.FrGNWXtLknaC0yog2M9MD0b1SVshP-H64rgXNOL0Grw',NULL),
(12,5,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbGlicmFyeS5vcmciLCJhdWQiOiJodHRwOi8vbGlicmFyeS5jb20iLCJpYXQiOjE3MzAwMjg4NjIsImV4cCI6MTczMDAzMjQ2MiwiZGF0YSI6eyJ1c2VyaWQiOjV9fQ.KXNkNAt7xi5UnHvaAr-RYW1qIRIp4Qb7MPaDrv23mvQ',NULL),
(14,5,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbGlicmFyeS5vcmciLCJhdWQiOiJodHRwOi8vbGlicmFyeS5jb20iLCJpYXQiOjE3MzAwMjkxOTksImV4cCI6MTczMDAzMjc5OSwiZGF0YSI6eyJ1c2VyaWQiOjV9fQ.kCIIfb9VgMNH1g3oreQFBAutbUKvOsqdmDVMECSM1vk',NULL),
(16,5,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbGlicmFyeS5vcmciLCJhdWQiOiJodHRwOi8vbGlicmFyeS5jb20iLCJpYXQiOjE3MzAwMzA3NzQsImV4cCI6MTczMDAzNDM3NCwiZGF0YSI6eyJ1c2VyaWQiOjV9fQ.h6G63viOVNWNfWWD5DLcvA3JEhQ27rWNEmdzHGauEvU',NULL),
(18,5,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbGlicmFyeS5vcmciLCJhdWQiOiJodHRwOi8vbGlicmFyeS5jb20iLCJpYXQiOjE3MzAwMzE0ODMsImV4cCI6MTczMDAzNTA4MywiZGF0YSI6eyJ1c2VyaWQiOjV9fQ.3AbzqdZ_Y0qJLjmxdVuZgvikdLn6Z0XPkFHG3TWdzSY',NULL),
(19,5,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbGlicmFyeS5vcmciLCJhdWQiOiJodHRwOi8vbGlicmFyeS5jb20iLCJpYXQiOjE3MzAwMzkxNzMsImV4cCI6MTczMDA0Mjc3MywiZGF0YSI6eyJ1c2VyaWQiOjV9fQ.VE7_Jub-fBG7UxpBNxjE3C9JWMNCtEfvRcZdKnlN-co',NULL),
(20,5,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbGlicmFyeS5vcmciLCJhdWQiOiJodHRwOi8vbGlicmFyeS5jb20iLCJpYXQiOjE3MzAwMzk5OTAsImV4cCI6MTczMDA0MzU5MCwiZGF0YSI6eyJ1c2VyaWQiOjV9fQ.pXRzmztMbgH48sRFIpzqq7_IKhbvqbrrD2_9qf0Wvd4',NULL),
(22,10,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbGlicmFyeS5vcmciLCJhdWQiOiJodHRwOi8vbGlicmFyeS5jb20iLCJpYXQiOjE3MzI1NDYxNjYsImV4cCI6MTczMjU0OTc2NiwiZGF0YSI6eyJ1c2VyaWQiOjEwfX0.9f4R4jUGyQQdn4h7Y_xh906fii8-UX2u86Z5k5lkPsg',NULL),
(24,10,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbGlicmFyeS5vcmciLCJhdWQiOiJodHRwOi8vbGlicmFyeS5jb20iLCJpYXQiOjE3MzI1NDg1MzYsImV4cCI6MTczMjU1MjEzNiwiZGF0YSI6eyJ1c2VyaWQiOjEwfX0.bM9L10o-s-bXPncIT-e9zWxyM2vrmFj4NLGYJlGwgpY',NULL),
(25,10,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbGlicmFyeS5vcmciLCJhdWQiOiJodHRwOi8vbGlicmFyeS5jb20iLCJpYXQiOjE3MzI1NDg1NTYsImV4cCI6MTczMjU1MjE1NiwiZGF0YSI6eyJ1c2VyaWQiOjEwfX0.qKrrQH_dVA4-7MN_OHOv-jcqVupCVcrayzD_PRdcW2A',NULL),
(26,10,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbGlicmFyeS5vcmciLCJhdWQiOiJodHRwOi8vbGlicmFyeS5jb20iLCJpYXQiOjE3MzI1NDg1ODQsImV4cCI6MTczMjU1MjE4NCwiZGF0YSI6eyJ1c2VyaWQiOjEwfX0.5BG780vpUm5t9DIpEP3cZ5UwJ1NZu28ruYC0sCRyGBs',NULL),
(27,10,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbGlicmFyeS5vcmciLCJhdWQiOiJodHRwOi8vbGlicmFyeS5jb20iLCJpYXQiOjE3MzI1NDg2MDUsImV4cCI6MTczMjU1MjIwNSwiZGF0YSI6eyJ1c2VyaWQiOjEwfX0.yhoFAGLtV5nR9rQEaXjCMbnY14Iu3icCILdPjup-bAM',NULL),
(28,10,'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vbGlicmFyeS5vcmciLCJhdWQiOiJodHRwOi8vbGlicmFyeS5jb20iLCJpYXQiOjE3MzI1NDg2MzYsImV4cCI6MTczMjU1MjIzNiwiZGF0YSI6eyJ1c2VyaWQiOjEwfX0.PwrQWR3YfHu5mtiJZ-W1-PSCiqKBtmJrQ6efPHUgSr4',NULL);

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `userid` int(9) NOT NULL AUTO_INCREMENT,
  `username` char(255) NOT NULL,
  `password` text DEFAULT NULL,
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Data for the table `users` */

insert  into `users`(`userid`,`username`,`password`) values 
(1,'RenzBenJerykDy','$2y$10$AXDPnoCFhPxhjrC23aGkcO8Rqa4mO71EF5GdmT3KeJwNSi0htjZAK'),
(2,'RenzBenJerykDy','$2y$10$uO1XoUcyArOypSBtEXjrCudR1SKRAks0PUDGH59ngT5gL7Qd0uMja'),
(3,'RenzBenJerykDy','$2y$10$ErLfLKqwQtAkIRlVA1eK..eoLL0pv10N.MgRFspoik4ifzT9m/Ai2'),
(4,'RenzBenJerykDy','$2y$10$ECsWCXXP8nPPpe2AKzkv3es0AsGoDRNJilIDGcfW2KRnsTGPvV0.i'),
(5,'jeryk','$2y$10$Wg.28LdbL9LntC/DPsTFuuzsEesvecZ6RD1ReiagslDrDLBKfeQOO'),
(6,'jeryk','$2y$10$kVd1qpZfH2/VheaUXDIzRulfNZYh/3hbldzyy8bTVqbAi1Nf6o/xW'),
(7,'jeryk','$2y$10$BrUlsWmJ/OyURJ7bpIaXBep5iNgSgCX4KkFEbX2vvKohUtw5UwSq.'),
(8,'jeryk','$2y$10$Kjxpqcxt3Z1Dvv4Eat21Zu6M7MNbKylWn/x1pkkD7WlnbCN08a5sS'),
(9,'jeryk','$2y$10$Th7vIcQczr2wqzqrOfKRI.pPxew2P8InKnlIpLyMdhWiDpXmxQJiq'),
(10,'QWERTY','$2y$10$xal4VrNRcfVseBm7FgVzwewxsoG21JF57PqyVN96mRDQtBNzGla/i'),
(11,'QWERTY','$2y$10$j3zkPR00GEJluE0PwvgJU.eUk0R7zGXdrr.XUTtm/tWDQZvw8WLM6');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
