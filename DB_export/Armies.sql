-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: db:3306
-- Время создания: Мар 13 2023 г., 21:15
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
-- Структура таблицы `Armies`
--

CREATE TABLE `Armies` (
  `army_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `army_name` varchar(50) NOT NULL,
  `faction` varchar(50) NOT NULL,
  `num_units` int(11) DEFAULT NULL,
  `points_total` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Дамп данных таблицы `Armies`
--

INSERT INTO `Armies` (`army_id`, `user_id`, `army_name`, `faction`, `num_units`, `points_total`, `created_at`) VALUES
(3, 1, 'Salamanders 107th', 'loyalists', 1000, 2001, '2023-03-13 19:19:10');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `Armies`
--
ALTER TABLE `Armies`
  ADD PRIMARY KEY (`army_id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `Armies`
--
ALTER TABLE `Armies`
  MODIFY `army_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `Armies`
--
ALTER TABLE `Armies`
  ADD CONSTRAINT `Armies_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Players` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
