#библиотеки для работы
library(tidyverse)
library(dplyr)
library(readr)

#Читаем файл с компа и проверяем что все ок (сет изначально только на Московскую область)
#Выбрать одно из двух, второе закомментить, остальной код универсально чистит оба сета

file_path <- ".../migration.csv" #Миграции
file_path <- ".../migration.csv" #Половозрастная структура

data <- read_csv(file_path)
head(data)

#Ищем свое МО из списка
unique(data$municipality)

#Фильтруем только нужное по МО и индикатору, можно + нужно импровизировать
filtered_data <- data %>%
  filter (municipality == "Пущино",
          grup_2 == "Всего") %>%
    arrange(year)
filtered_data

#Бонус трек для фильтрации для тех, у кого МО менял название, предикат "ИЛИ"
filtered_data <- data %>%
  filter(municipality == 'old_name' | 
           municipality == "new_name") %>%
    filter (grup_2 == "Всего") %>%
      arrange(year)
filtered_data

# Чистим данные чтобы остались только "чистые" промежутки разбивки
groups_years <- c("0—4", "5—9", "10—14", "15—19","20—24", "25—29", "30—34", "35—39", "40—44", "45—49", "50—54", "55—59", "60—64", "65—69", "70—74", "75—79", "80—84 года", "85—89 лет", "90—94 года", "95—99 лет", "100 и более лет")

filter_years <- data %>%
  filter(vozr %in% groups_years) %>%
  arrange(year) %>%
  arrange(match(vozr, groups_years))
filter_years

# Наслаждаемся чистым датасетом, дальше можно рассматривать в любом нужном/интересном разрезе и строить графички


