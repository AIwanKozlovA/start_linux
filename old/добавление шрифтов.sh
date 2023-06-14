#!/bin/bash
if [ ! -d "$~/.fonts" ]; then
	 mkdir ~/.fonts
fi
cp arial_bolditalicmt.ttf ~/.fonts
cp calibri_bold.ttf ~/.fonts
cp timesnewromanpsmt.ttf ~/.fonts
cp arialmt.ttf ~/.fonts
cp calibri.ttf ~/.fonts
fc-cache -f -v
echo "Всё успех. Если шрифты не добавятся, то перезагрузите систему"
