#!/bin/bash


# Этот bash скрипт для автоматической настройки ПК для работы.
# Он предустанавливает программы: компилятор gcc и g++, текстовый редактор vim, программу для контроля версий git, visual studio code, пакетный менеджер dpkg, vlc, графический редактор gimp, timeshift, python3, pycharm, Qt Creator и базовые компоненты Qt, simple-scan, LibreOffice, pip и несколько пакетов pip
# и добавляет дополнительные слаиды в программу LibreOffice Impress
# на дистребутивы на базе Debian и Arch,
# настраивая тем самым ПК для работы.
# Данный скрипт идиально подходит для меня, поэтому перед его использованием рекомендую изучить его содержимое!!!
# Скрипт создал ИVан КоZлоV.


yv(){ # функция, которая спрашивает подтверждение начала установки
	echo "Начать установку ПО?"
	read -p "Вводите [Д/н]:" y
	echo "$y"
	if [ $y == "Д" ]; then
		echo "установка началась!!!"
	else
		echo "установка отменена!!!"
		exit
	fi
}


ys(){ # функция, которая добавляет дополнительные слаиды в программу LibreOffice Impress, если пользователь согласится
	echo "Добавить дополнительные слаиды в программу LibreOffice Impress?"
	read -p "Вводите [Д/н]:" y
	if [ $y == "Д" ]; then
		echo "установка дополнительных слаидов началась!!!"
		sudo dpkg -i libreoffice-impress-templates-all_2.2-1.deb #установка в либер офис дополнительных слайдов для презентаций
    else
        echo "установка дополнительных слаидов отменена!!!"
	fi
}


ys_pip_modules(){ # функция, которая устонавливает pip пакеты, если пользователь согласится
	echo "Устонавить pip пакеты для python?"
	read -p "Вводите [Д/н]:" y
	if [ $y == "Д" ]; then
		echo "установка pip пакетов началась!!!"
		pip3 install django
		pip3 install pyqt5
		pip3 install pyinstaller
   	else
        echo "установка pip пакетов отменена!!!"
	fi
}


Arch(){ # функция, которая устанавливает ПО на Arch или дистребутивы Linux на его основе
	yv
	echo "Выбран Arch"
	sudo pacman -Syu gcc
	sudo pacman -Syu vim
	sudo pacman -Syu git
	sudo pacman -Syu dpkg
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
	ys # вызов функции для подтверждения установки дополнительных слаидов
	sudo pacman -Syu flatpak
	flatpak install ru.yandex.Browser # установка яндекс браузера
	echo "Установка ПО на Arch подобный дистребутив Linux завершена!!!"
}


Debian(){ # функция, которая устанавливает ПО на Debian или дистребутивы Linux на его основе
	yv
	echo "Выбран Debian"
	sudo apt install qtcreator qtbase5-dev qt5-qmake cmake
	sudo apt install gimp
	sudo apt install python3
	sudo apt install python3-pip
	ys_pip_modules # установка модулей pip
	# sudo snap install pycharm-community --classic
	sudo apt install g++
	sudo apt install timeshift
	sudo apt install vim
	sudo apt install git
	sudo apt install wine winetricks
	sudo apt install mono-complete
	sudo apt install libreoffice-l10n-ru
	# sudo dpkg -i Yandex.deb
	sudo apt install flatpak
	sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak install ru.yandex.Browser
	
	#wget -q -O — https://repo.yandex.ru/yandex-browser/YANDEX-BROWSER-KEY.GPG | sudo apt-key add —
	#sudo sh -c ‘echo «deb [arch=amd64] http://repo.yandex.ru/yandex-browser/deb beta main» > /etc/apt/sources.list.d/yandex-browser-beta.list’
	#sudo apt update
	#sudo apt install yandex-browser-beta


	# sudo dpkg -i libreoffice-impress-templates-all_2.2-1.deb
	ys # вызов функции для подтверждения установки дополнительных слаидов
	flatpak install flathub com.jetbrains.PyCharm-Community
	flatpak install flathub com.visualstudio.code
	flatpak install flathub org.videolan.VLC
	#sudo snap install code --classic # установка vs code
	#sudo snap install vlc
	sudo apt --fix-broken install # устранение возможных ошибок в apt
	sudo apt update
	sudo apt full-upgrade
	echo "Установка ПО на Debian подобный дистребутив Linux завершена!!!"
}


Fedora(){ # функция, которая устанавливает ПО на Fedora или дистребутивы Linux на его основе
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
	
	ys # вызов функции для подтверждения установки дополнительных слаидов
	
	sudo dnf install flatpak
	flatpak install ru.yandex.Browser
	flatpak install flathub com.visualstudio.code
	flatpak install flathub org.videolan.VLC
	
	echo "Установка ПО на Fedora подобный дистребутив Linux завершена!!!"
}


echo "Введите 1, если ваш дистребутив Linux основан на Debian, например Ubuntu, Linux Mint и т.д."
echo "Введите 2, если ваш дистребутив Linux основан на Arch, например Monjaro, EndeavourOS и т.д."
echo "Введите 3, если ваш дистребутив Linux основан на Fedora, например Russian Fedora и т.д."
read -p "Вводите:" num
if [ "$num" == 1 ]; then 
        echo "Введено 1"
	Debian
elif [ "$num" == 2 ]; then
        echo "Введено 2"
	Arch
elif [ "$num" == 3 ]; then
        echo "Введено 3"
	Fedora
else
	echo "Вы ввели, что-то не так!!!"
fi
