#!/usr/bin/env bash

## Author  : Aditya Shakya
## Mail    : adi1090x@gmail.com
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
ucmail="" #Hex: f19d
gmail="" #Hex: f6ef
brainfm="" #Hex: f7ca
google="" #Hex: f1a0
twitter="" #Hex: f099
feedly="" #Hex: e27b
github="" #Hex: f09b
# asana="" #Hex: f7b0
asana="⛬" #file-icons U+26EC (technically Julia)
website="" #Hex: f2c3
# website="Ⓗ" #file-icons U+24bBD (Hugo)

# Variable passed to rofi
options="$ucmail\n$gmail\n$brainfm\n$google\n$twitter\n$feedly\n$github\n$asana\n$website"

chosen="$(echo -e "$options" | $rofi_command -p "Open In  :  $app" -dmenu -selected-row 0)"
case $chosen in
    $ucmail)
        $app https://mail.google.com/mail/u/1/#starred &
        ;;
    $gmail)
        $app https://mail.google.com/mail/u/0/#starred &
        ;;
    $brainfm)
        $app https://my.brain.fm/ &
        ;;
    $google)
        $app https://www.google.com/ &
        ;;
    $twitter)
        $app https://twitter.com/LeviGCrews/likes &
        ;;
    $feedly)
        $app https://feedly.com/i/saved &
        ;;
    $github)
        $app https://github.com/levicrews &
        ;;
    $asana)
        $app https://app.asana.com/0/home/1202371903456271 &
        ;;
    $website)
        $app https://www.levicrews.com/ &
        ;;
esac