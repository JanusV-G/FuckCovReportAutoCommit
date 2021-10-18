CREATE DATABASE CovReportAutoCommitDB;

USE `CovReportAutoCommitDB`;

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user`(
	`user_name` VARCHAR(32),
	`student_number` VARCHAR(32),
	`password` VARCHAR(32),
	`email` VARCHAR(32),
	`api_key` VARCHAR(128),
	PRIMARY KEY (`student_number`)
) ENGINE=INNODB DEFAULT CHARSET=utf8mb4;