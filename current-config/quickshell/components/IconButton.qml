import QtQuick
import qs.theme

Rectangle {
  id: root

  property string icon: ""
  property color iconColor: Theme.text
  property int iconSize: Theme.iconSize

  signal clicked

  implicitWidth: Theme.moduleHeight
  implicitHeight: Theme.moduleHeight
  radius: Theme.radius
  color: "transparent"

  Text {
    anchors.centerIn: parent
    text: root.icon
    color: root.iconColor
    font.family: Theme.iconFont
    font.pixelSize: root.iconSize
    font.variableAxes: Theme.iconAxes
  }

  MouseArea {
    anchors.fill: parent
    cursorShape: Qt.PointingHandCursor
    onClicked: root.clicked()
  }
}