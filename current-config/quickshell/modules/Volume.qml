import QtQuick
import qs.theme
import qs.components

// Volume.qml
//
// Output volume of your default sink.
Pill {
  icon: ""
  iconColor: Theme.cyan
  text: level.text

  Poll {
    id: level
    cmd: "wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100) \"%\"}'"
    every: 1000
  }
}
