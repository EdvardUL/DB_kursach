-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: db:3306
-- Время создания: Мар 13 2023 г., 21:16
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
-- Структура таблицы `Heroes`
--

CREATE TABLE `Heroes` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `fraction` varchar(30) NOT NULL,
  `side` varchar(30) NOT NULL,
  `status` varchar(30) NOT NULL,
  `army_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Дамп данных таблицы `Heroes`
--

INSERT INTO `Heroes` (`id`, `name`, `fraction`, `side`, `status`, `army_id`) VALUES
(1, 'Lemann Russ', 'Space wolves', 'loyalists', 'missing', 3);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `Heroes`
--
ALTER TABLE `Heroes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `army_id` (`army_id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `Heroes`
--
ALTER TABLE `Heroes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `Heroes`
--
ALTER TABLE `Heroes`
  ADD CONSTRAINT `Heroes_ibfk_1` FOREIGN KEY (`army_id`) REFERENCES `Armies` (`army_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
