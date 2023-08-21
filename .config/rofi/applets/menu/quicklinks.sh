#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@calendar.com
## Github  : @adi1090x
## Twitter : @adi1090x

style="$($HOME/.config/rofi/applets/menu/style.sh)"

dir="$HOME/.config/rofi/applets/menu/configs/$style"
rofi_command="rofi -theme $dir/quicklinks.rasi"

# Error msg
msg() {
	rofi -theme "$HOME/.config/rofi/applets/styles/message.rasi" -e "$1"
}

# Browser
if [[ -f /usr/bin/google-chrome ]]; then
	app="google-chrome"
elif [[ -f /usr/bin/firefox ]]; then
	app="firefox"
else
	msg "No suitable web browser found!"
	exit 1
fi

# Logos: glyphs from https://www.nerdfonts.com/cheat-sheet
mail="" #Hex: f6ef
calendar="" #Hex: f073
brainfm="" #Hex: f7ca
google="" #Hex: f1a0
twitter="" #Hex: f099
feedly="" #Hex: e27b
github="" #Hex: f09b
asana="⛬" #file-icons U+26EC (technically Julia)
website="" #Hex: f007
overleaf="" #FontAwesome: U+F1C9

# Variable passed to rofi
options="$mail\n$brainfm\n$calendar\n$feedly\n$github\n$twitter\n$asana\n$website\n$overleaf\n$google"

chosen="$(echo -e "$options" | $rofi_command -p "Open In  :  $app" -dmenu -selected-row 0)"
case $chosen in
    $mail)
        $app https://mail.google.com/mail/u/1/#starred &
        ;;
    $brainfm)
        $app https://my.brain.fm/ &
        ;;
    $calendar)
        $app https://calendar.vimcal.com/home &
        ;;
    $feedly)
        $app https://feedly.com/i/saved &
        ;;
    $github)
        $app https://github.com/levicrews &
        ;;
    $twitter)
        $app https://twitter.com/LeviGCrews/likes &
        ;;
    $asana)
        $app https://app.asana.com/0/home/1202371903456271 &
        ;;
    $website)
        $app https://www.levicrews.com/ &
        ;;
    $overleaf)
        $app https://www.overleaf.com/project &
        ;;
    $google)
        $app https://www.google.com/ &
        ;;
esac