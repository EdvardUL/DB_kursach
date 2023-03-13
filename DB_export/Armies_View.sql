-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: db:3306
-- Время создания: Мар 13 2023 г., 21:20
-- Версия сервера: 5.7.41
-- Версия PHP: 8.1.15

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `db`
--

-- --------------------------------------------------------

--
-- Структура для представления `Armies_View`
--

CREATE ALGORITHM=UNDEFINED DEFINER=`user`@`%` SQL SECURITY DEFINER VIEW `Armies_View`  AS SELECT `Armies`.`army_id` AS `army_id`, `Armies`.`user_id` AS `user_id`, `Armies`.`army_name` AS `army_name`, `Armies`.`faction` AS `faction`, `Armies`.`num_units` AS `num_units`, `Armies`.`points_total` AS `points_total`, `Armies`.`created_at` AS `created_at` FROM (`Armies` join `Armies_compound`) ;

--
-- VIEW `Armies_View`
-- Данные: Ни одного
--

COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
