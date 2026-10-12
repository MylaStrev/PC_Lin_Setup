import QtQuick
import qs.theme
import qs.components

// Wifi.qml
//
// Your network, and how strong the signal runs.
Pill {
  // The Android ramp. An empty fan fills up as signal improves.
  // No connection gets a struck-through fan.
  icon: {
    const bars = parseInt(strength.text);
    if (isNaN(bars))
      return "\udb82\udd28";
    if (bars >= 75)
      return "\udb82\udd25"; 
    if (bars >= 55)
      return "\udb82\udd22";
    if (bars >= 35)
      return "\udb82\udd1f";
    if (bars >= 15)
      return "\udb82\udd20";
    return "\udb82\udd2e";
  }
  iconColor: Theme.red
  text: name.text

  Poll {
    id: name
    cmd: "nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2"
    every: 10000
  }

  // 0 to 100. QML reserves signal, so this reads strength.
  Poll {
    id: strength
    cmd: "nmcli -t -f active,signal dev wifi | grep '^yes' | cut -d: -f2"
    every: 10000
  }
}
