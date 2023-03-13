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
-- Структура таблицы `Armies_compound`
--

CREATE TABLE `Armies_compound` (
  `id` int(11) NOT NULL,
  `id_army` int(11) NOT NULL,
  `unit_name` varchar(30) NOT NULL,
  `unit_type` varchar(30) NOT NULL,
  `num_unit` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Дамп данных таблицы `Armies_compound`
--

INSERT INTO `Armies_compound` (`id`, `id_army`, `unit_name`, `unit_type`, `num_unit`) VALUES
(1, 3, 'spacemarines', 'heavy', 20);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `Armies_compound`
--
ALTER TABLE `Armies_compound`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_army` (`id_army`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `Armies_compound`
--
ALTER TABLE `Armies_compound`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `Armies_compound`
--
ALTER TABLE `Armies_compound`
  ADD CONSTRAINT `Armies_compound_ibfk_1` FOREIGN KEY (`id_army`) REFERENCES `Armies` (`army_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
