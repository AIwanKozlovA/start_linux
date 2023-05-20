#!/bin/bash
yv(){
	echo "Начать установку ПО?"
	#echo "Вводите [Д/н]:"
	read -p "Вводите [Д/н]:" y
	#read -p "ВВедите строку:" num
	echo "$y"
	if [ $y == "Д" ]; then
		echo "установка началась!!!"
	else
		echo "установка отменена!!!"
		exit
	fi
}
Arch(){
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
	sudo pacman -Syu pycharm-community-edition
	sudo pacman -Syu qtcreator cmake base-devel
	sudo pacman -Syu python-pip
	pip3 install django
	pip3 install pyqt5
	pip3 install pyinstaller

	sudo pacman -Syu libreoffice-fresh-ru
	sudo dpkg -i libreoffice-impress-templates-all_2.2-1.deb #установка в либер офис дополнительных слайдов для презентаций

}
Debian(){
	yv
	echo "Выбран Debian"
	sudo apt install -y qtcreator qtbase5-dev qt5-qmake cmake
	sudo apt install gimp
	sudo apt install python3
	sudo apt install python3-pip
	pip3 install django
	pip3 install pyqt5
	pip3 install pyinstaller
	sudo snap install pycharm-community --classic
	sudo apt install g++
	sudo apt install timeshift
	sudo apt install vim
	sudo apt install git
	# sudo dpkg -i Yandex.deb

	wget -q -O — https://repo.yandex.ru/yandex-browser/YANDEX-BROWSER-KEY.GPG | sudo apt-key add —
	sudo sh -c ‘echo «deb [arch=amd64] http://repo.yandex.ru/yandex-browser/deb beta main» > /etc/apt/sources.list.d/yandex-browser-beta.list’
	sudo apt update
	sudo apt install yandex-browser-beta


	sudo dpkg -i libreoffice-impress-templates-all_2.2-1.deb
	sudo snap install code --classic # установка vs code
	sudo snap install vlc
	sudo apt --fix-broken install # устранение возможных ошибок в apt
	sudo apt update
	sudo apt full-upgrade

}
echo "Введите 1, если ваш дистребутив Linux основан на Debian, например Ubuntu, Linux Mint и т.д."
echo "Введите 2, если ваш дистребутив Linux основан на Arch, например Monjaro, EndeavourOS и т.д."
read -p "Вводите:" num
if [ "$num" == 1 ]; then 
        echo "Введено 1"
	Debian
elif [ "$num" == 2 ]; then
        echo "Введено 2"
	Arch
else
	echo "Вы ввели, что-то не так!!!"
fi

