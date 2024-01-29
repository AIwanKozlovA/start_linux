#!/bin/bash


# Этот bash скрипт для автоматической настройки ПК для работы.
# Он предустанавливает программы: компилятор gcc и g++, текстовый редактор vim, программу для контроля версий git, visual studio code, пакетный менеджер dpkg, vlc, графический редактор gimp, timeshift, python3, pycharm, Qt Creator и базовые компоненты Qt, simple-scan, LibreOffice, pip и несколько пакетов pip
# и добавляет дополнительные слаиды в программу LibreOffice Impress
# на дистребутивы на базе Debian, Arch и Fedora
# настраивая тем самым ПК для работы.
# Данный скрипт идиально подходит для меня, поэтому перед его использованием рекомендую изучить его содержимое!!!
# Скрипт создал ИVан КоZлоV.


yv(){ # функция, которая спрашивает подтверждение начала установки
	echo "Начать установку ПО?"
	read -p "Вводите [Д/н]:" y
	echo "$y"
	if [ $y == "Д" ] || [ $y == "y" ]; then
		echo "установка началась!!!"
	else
		echo "установка отменена!!!"
		exit
	fi
}


ys(){ # функция, которая добавляет дополнительные слаиды в программу LibreOffice Impress, если пользователь согласится
	echo "Добавить дополнительные слаиды в программу LibreOffice Impress?"
	read -p "Вводите [Д/н]:" y
	if [ $y == "Д" ] || [ $y == "y" ]; then
		echo "установка дополнительных слаидов началась!!!"
		sudo dpkg -i libreoffice-impress-templates-all_2.2-1.deb #установка в либер офис дополнительных слайдов для презентаций
    else
        echo "установка дополнительных слаидов отменена!!!"
	fi
}

av(){ # функция, которая спрашивает у пользователя включить ли режим автоматической установки
	echo "Включить режим автоматической установки ПО?"
	echo "Установка пройдёт быстрее, но при выборе ручной устаноки вы можете настроить свой компьютер более детально."
	read -p "Вводите [Д/н]:" y
	echo "$y"
	if [ $y == "Д" ] || [ $y == "y" ]; then
		echo "Автоматическая установка началась!!!"
		yes "y" | $1 # включение режима автоматической	установки
	else
		echo "Выбрана ручная установка!!!"
		$1
	fi

}


ys_pip_modules(){ # функция, которая устонавливает pip пакеты, если пользователь согласится
	echo "Устонавить pip пакеты для python?"
	read -p "Вводите [Д/н]:" y
	if [ $y == "Д" ] || [ $y == "y" ]; then
		echo "установка pip пакетов началась!!!"
		pip3 install django
		pip3 install pyqt5
		pip3 install pyinstaller
   	else
        echo "установка pip пакетов отменена!!!"
	fi
}


sozdanie_ssilki_flatpak(){ # функция, которая проверяет установлен ли flatpak пакет, если он установлен, то создаётся системная ссылка нанего, чтобы пакет был виден в списке установленых программ
    if [ -x "$(command -v flatpak)" ]; then # проверка установлен ли сам flatpak, существует ли такая команда
        #c=$((`flatpak list | grep -c "$1"`))
        # echo "$c"
        if [ -f "/var/lib/flatpak/exports/bin/$1" ]; then
                # sudo ln -s /var/lib/flatpak/exports/bin/com.jetbrains.PyCharm-Community /usr/local/bin/
                sudo ln -s "/var/lib/flatpak/exports/bin/$1" /usr/local/bin/ # создание ссылки
        fi
    fi
}


Arch(){ # функция, которая устанавливает ПО на Arch или дистребутивы Linux на его основе
	if [ -x "$(command -v pacman)" ]; then # проверка правильно ли выбрана ветвь дистребутивов. Сущетвует ли команда apt
		yv
		echo "Выбран Arch"
		sudo pacman -Syu gcc
		sudo pacman -Syu vim
		sudo pacman -Syu git
		sudo pacman -Syu dpkg|| [ $y == "y" ]
		sudo pacman -Syu code
		sudo pacman -Syu vlc
		sudo pacman -Syu gimp
		sudo pacman -Syu timeshift
		sudo pacman -Syu python3
		sudo pacman -Syu pycharm-community-edition
		sudo pacman -Syu qtcreator cmake base-devel
		sudo pacman -Syu simple-scan
		sudo pacman -Syu python-pip
		ys_pip_modules # установка модулей pip
		sudo pacman -Syu wine winetricks wine-mono wine_gecko zenity

		sudo pacman -Syu libreoffice-fresh-ru
		# sudo dpkg -i libreoffice-impress-templates-all_2.2-1.deb #установка в либер офис дополнительных слайдов для презентаций

		if [ -x "$(command -v dpkg)" ]; then
			ys # вызов функции для подтверждения установки дополнительных слаидов
		fi
		sudo pacman -Syu flatpak
		if [ -x "$(command -v flatpak)" ]; then # проверка установлен ли flatpak, существует ли такая команда
			if [ $y == "Д" ] || [ $y == "y" ]; then
				echo "Автоматическая установка flatpak пакетов началась!!!"
				# flatpak не работает с командой yes поэтому необходимо вручную прописовать флаг -y для автоматической установки
				flatpak -y install ru.yandex.Browser # установка яндекс браузера
				sozdanie_ssilki_flatpak "ru.yandex.Browser" # Создание ссылки, чтобы приложение отображалось в системе
			else
				flatpak install ru.yandex.Browser # установка яндекс браузера
				sozdanie_ssilki_flatpak "ru.yandex.Browser" # Создание ссылки, чтобы приложение отображалось в системе
			fi
		fi

		echo "Установка ПО на Arch подобный дистребутив Linux завершена!!!"
		echo "Рекомендуется перезагрузить компьютер."
	else
		echo "Не правильно выбрана ветвь дистребутивов!!!"
	fi
}


Debian(){ # функция, которая устанавливает ПО на Debian или дистребутивы Linux на его основе
	if [ -x "$(command -v apt)" ]; then # проверка правильно ли выбрана ветвь дистребутивов. Сущетвует ли команда apt
		yv
		echo "Выбран Debian"
		sudo apt install qtcreator qtbase5-dev qt5-qmake cmake
		sudo apt install gimp
		sudo apt install python3
		sudo apt install python3-pip
		ys_pip_modules # установка модулей pip
		sudo apt install g++
		sudo apt install timeshift
		sudo apt install vim
		sudo apt install git
		sudo apt install wine winetricks
		sudo apt install mono-complete
		sudo apt install libreoffice-l10n-ru
		sudo apt install dpkg

		if [ -x "$(command -v dpkg)" ]; then
			ys # вызов функции для подтверждения установки дополнительных слаидов
		fi

		sudo apt install flatpak
		sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
		if [ -x "$(command -v flatpak)" ]; then # проверка установлен ли flatpak, существует ли такая команда
			echo "Установить автоматически flatpak пакеты ?"
			read -p "Вводите [Д/н]:" y
			if [ $y == "Д" ] || [ $y == "y" ]; then
				echo "Автоматическая установка flatpak пакетов началась!!!"
				# flatpak не работает с командой yes поэтому необходимо вручную прописовать флаг -y для автоматической установки
				flatpak -y install ru.yandex.Browser
				sozdanie_ssilki_flatpak "ru.yandex.Browser" # Создание ссылки, чтобы приложение отображалось в системе


				flatpak -y install flathub com.jetbrains.PyCharm-Community
				sozdanie_ssilki_flatpak "com.jetbrains.PyCharm-Community" # Создание ссылки, чтобы приложение отображалось в системе

				flatpak -y install flathub com.visualstudio.code
				sozdanie_ssilki_flatpak "com.visualstudio.code" # Создание ссылки, чтобы приложение отображалось в системе

				flatpak -y install flathub org.videolan.VLC
				sozdanie_ssilki_flatpak "org.videolan.VLC" # Создание ссылки, чтобы приложение отображалось в системе
				
		   	else
		   		echo "Выбрана ручная установка!!!"
				flatpak install ru.yandex.Browser
				sozdanie_ssilki_flatpak "ru.yandex.Browser" # Создание ссылки, чтобы приложение отображалось в системе


				flatpak install flathub com.jetbrains.PyCharm-Community
				sozdanie_ssilki_flatpak "com.jetbrains.PyCharm-Community" # Создание ссылки, чтобы приложение отображалось в системе

				flatpak install flathub com.visualstudio.code
				sozdanie_ssilki_flatpak "com.visualstudio.code" # Создание ссылки, чтобы приложение отображалось в системе

				flatpak install flathub org.videolan.VLC
				sozdanie_ssilki_flatpak "org.videolan.VLC" # Создание ссылки, чтобы приложение отображалось в системе
			fi
			
		fi
		sudo apt --fix-broken install # устранение возможных ошибок в apt
		sudo apt update
		sudo apt full-upgrade
		echo "Установка ПО на Debian подобный дистребутив Linux завершена!!!"
		echo "Рекомендуется перезагрузить компьютер."
	else
		echo "Не правильно выбрана ветвь дистребутивов!!!"
	fi
}


Fedora(){ # функция, которая устанавливает ПО на Fedora или дистребутивы Linux на его основе
	if [ -x "$(command -v dnf)" ]; then # проверка правильно ли выбрана ветвь дистребутивов. Сущетвует ли команда dnf
		yv
		echo "Выбран Fedora"

		sudo dnf install gcc
		sudo dnf install vim
		sudo dnf install git
		sudo dnf install qtcreator cmake qt5-designer qt5-*-devel qt5-*-doc
		sudo dnf install gimp
		sudo dnf install python3
		sudo dnf install python3-pip
		ys_pip_modules # установка модулей pip
		sudo dnf install timeshift
		sudo dnf install wine winetricks wine-mono mingw64-wine-gecko.noarch
		sudo dnf install pycharm-community.x86_64
		sudo dnf install dpkg
		sudo dnf install libreoffice-langpack-ru.x86_64

		if [ -x "$(command -v dpkg)" ]; then
			ys # вызов функции для подтверждения установки дополнительных слаидов
		fi

		sudo dnf install flatpak
		if [ -x "$(command -v flatpak)" ]; then # проверка установлен ли flatpak, существует ли такая команда
			echo "Установить автоматически flatpak пакеты ?"
			read -p "Вводите [Д/н]:" y
			if [ $y == "Д" ] || [ $y == "y" ]; then
				echo "Автоматическая установка flatpak пакетов началась!!!"
				# flatpak не работает с командой yes поэтому необходимо вручную прописовать флаг -y для автоматической установки
				flatpak -y install ru.yandex.Browser
				flatpak -y install flathub com.visualstudio.code
				flatpak -y install flathub org.videolan.VLC
			else
				echo "Выбрана ручная установка!!!"
				flatpak install ru.yandex.Browser
				flatpak install flathub com.visualstudio.code
				flatpak install flathub org.videolan.VLC
			fi
		fi
		echo "Установка ПО на Fedora подобный дистребутив Linux завершена!!!"
		echo "Рекомендуется перезагрузить компьютер."
	else
		echo "Не правильно выбрана ветвь дистребутивов!!!"
	fi
}


echo "Введите 1, если ваш дистребутив Linux основан на Debian, например Ubuntu, Linux Mint и т.д."
echo "Введите 2, если ваш дистребутив Linux основан на Arch, например Monjaro, EndeavourOS и т.д."
echo "Введите 3, если ваш дистребутив Linux основан на Fedora, например Russian Fedora и т.д."
read -p "Вводите:" num
if [ "$num" == 1 ]; then
	echo "Введено 1"
	av Debian
elif [ "$num" == 2 ]; then
	echo "Введено 2"
	av Arch
elif [ "$num" == 3 ]; then
	echo "Введено 3"
	av Fedora
else
	echo "Вы ввели, что-то не так!!!"
fi
