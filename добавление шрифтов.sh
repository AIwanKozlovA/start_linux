#!/bin/bash

# Этот bash скрипт для автоматического добавления шрифтов на ПК.
# Он устонавливает шрифты: Times New Roman, Calibri, Arial, Arial Bold
# и обновляет системный кэш шрифтов,
# настраивая тем самым ПК для работы.
# Данный скрипт идиально подходит для меня, поэтому перед его использованием рекомендую изучить его содержимое!!!
# Скрипт создал ИVан КоZлоV.

echo "Установка шрифтов на Linux"
echo "Будут уствновлены шрифты: Times New Roman, Calibri, Arial, Arial Bold."
echo "Начать установку шрифтов на Linux?"
read -p "Вводите [Д/н]:" y
echo "$y"
if [ $y == "Д" ]; then
	echo "установка началась!!!"
	if [ ! -d "$~/.fonts" ]; then # проверяет есть ли папка fonts, если её нет, то директория создаётся
		mkdir ~/.fonts
	fi
	cp arial_bolditalicmt.ttf ~/.fonts
	cp calibri_bold.ttf ~/.fonts
	cp timesnewromanpsmt.ttf ~/.fonts
	cp arialmt.ttf ~/.fonts
	cp calibri.ttf ~/.fonts
	fc-cache -f -v # обновление системного кэша шрифтов
	echo "Всё успех. Если шрифты не добавяться, то перезагрузите систему!"
else
	echo "установка шрифтов отменена!!!"
fi
