import QtQuick
import qs.theme
import qs.components

// Bluetooth.qml
//
// Whether your adapter has power.
//
// grep -q prints nothing and answers through the exit status.
// && and || turn the answer into a word.
Pill {
  icon: "󰂯"
  iconColor: Theme.yellow
  text: powered.text

  Poll {
    id: powered
    cmd: "bluetoothctl show | grep -q 'Powered: yes' && echo \uf294 || echo \udb80\udcb2"
    every: 10000
  }
}
