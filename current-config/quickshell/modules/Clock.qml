import QtQuick
import Quickshell
import qs.theme
import qs.components

// Clock.qml
//
// The time, to the minute.
Pill {
  icon: "\uf017"
  iconColor: Theme.magenta
  text: Qt.formatDateTime(clock.date, "hh:mm")

  // Ticks once a minute, matching what the bar draws.
  // Add seconds to the format above and switch this to SystemClock.Seconds.
  SystemClock {
    id: clock
    precision: SystemClock.Minutes
  }
}
