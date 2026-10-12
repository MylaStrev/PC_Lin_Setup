import QtQuick
import qs.theme

// PillIcon.qml
//
// The lighter square at the left end of a module.
// Holds one Material Symbols icon.
//
// Both left corners round to follow the pill around them.
// The right edge stays square, so the edge meets the text in a clean line.
Rectangle {
  id: root

  property string icon: ""
  property color iconColor: Theme.text

  // Rounding away the two left corners drags the centre visually left.
  // A nudge right lands the icon back on centre.
  property real nudge: 1.5

  width: height // as wide as tall, so a square
  height: parent.height
  color: Theme.pillIcon
  topLeftRadius: Theme.radius
  bottomLeftRadius: Theme.radius

  Text {
    anchors.centerIn: parent
    anchors.horizontalCenterOffset: root.nudge

    text: root.icon
    color: root.iconColor
    font.family: Theme.iconFont
    font.pixelSize: Theme.iconSize
    font.variableAxes: Theme.iconAxes
  }
}
