import QtQuick
import qs.theme
import qs.components

// Battery.qml
//
// Charge left, read from the kernel.
Pill {
  icon: "󰁹"
  iconColor: Theme.green
  text: charge.text

  Poll {
    id: charge
    cmd: "awk '{print $1 \"%\"}' /sys/class/power_supply/BAT1/capacity"
    every: 30000
  }
}
