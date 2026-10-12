import QtQuick
import qs.theme
import qs.components

//

Pill {
    icon: "\udb80\udcde"
    iconColor: Theme.green
    text: brightness.text

    Poll {
        id: brightness
        cmd: "brightnessctl -m | awk -F, '{print $4}'"
        every: 500
    }
}