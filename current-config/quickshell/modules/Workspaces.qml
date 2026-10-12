import QtQuick
import Quickshell
import Quickshell.Hyprland
import qs.theme
import qs.components

// Workspaces.qml
//
// A thumb in a groove, with a dot per workspace.
//
// Three things read at a glance, none of them text:
//   where you are       the accent thumb
//   what holds windows  a bright dot. Empty workspaces get a small faint one.
//   which way you went  the thumb stretches toward the target, then settles,
//                       so you catch direction from the corner of your eye
//
// Hyprland applies your workspace rules already. Asking Hyprland which
// workspaces belong to this monitor returns what your Lua config assigned.
Rectangle {
  id: root

  required property var screen

  property int padding: 5    // groove edge to the first slot
  property int cellWidth: 28 // one workspace slot

  // The thumb stands still as a circle.
  // Travel stretches the thumb into a pill. Arrival rounds the thumb back off.
  property int thumbSize: Theme.moduleHeight - 12

  // Both thumb edges chase the same target at different speeds.
  // The trailing edge lags, so the thumb pulls long, then snaps back to
  // width once the slow edge catches up.
  property int leadTime: 260
  property int trailTime: 440

  property var monitor: Hyprland.monitorFor(root.screen)
  property var list: !root.monitor ? [] : Hyprland.workspaces.values.filter(w => w.id > 0 && w.monitor === root.monitor)
  property int activeIndex: root.list.findIndex(w => w.active)

  // Where the thumb left edge belongs at rest.
  property real target: root.padding + (root.cellWidth - root.thumbSize) / 2 + root.activeIndex * root.cellWidth

  // Two bindings on one target. Same value, different speeds.
  property real leadEdge: root.target
  property real trailEdge: root.target

  Behavior on leadEdge {
    NumberAnimation {
      duration: root.leadTime
      easing.type: Easing.OutCubic
    }
  }
  Behavior on trailEdge {
    NumberAnimation {
      duration: root.trailTime
      easing.type: Easing.OutCubic
    }
  }

  implicitWidth: root.list.length * root.cellWidth + root.padding * 2
  implicitHeight: Theme.moduleHeight
  radius: Theme.radius
  color: Theme.pill
  visible: root.list.length > 0

  Shadow {}

  // The thumb. Declared first, so the dots paint on top.
  Rectangle {
    x: Math.min(root.leadEdge, root.trailEdge)
    width: Math.abs(root.leadEdge - root.trailEdge) + root.thumbSize
    height: root.thumbSize
    anchors.verticalCenter: parent.verticalCenter
    visible: root.activeIndex >= 0
    radius: height / 2
    color: Theme.accent
  }

  Row {
    x: root.padding
    height: parent.height

    Repeater {
      model: root.list

      Item {
        required property var modelData

        // Windows here earn a bigger, brighter dot.
        readonly property bool busy: modelData.toplevels.values.length > 0

        width: root.cellWidth
        height: parent.height

        Rectangle {
          anchors.centerIn: parent
          width: parent.busy || parent.modelData.active ? 8 : 6
          height: width
          radius: height / 2

          // On the thumb the dot goes dark and punches a hole in the accent.
          color: parent.modelData.urgent ? Theme.red : parent.modelData.active ? Theme.pill : parent.busy ? Theme.text : Theme.pillIcon

          Behavior on width {
            NumberAnimation {
              duration: root.leadTime
              easing.type: Easing.OutCubic
            }
          }
          Behavior on color {
            ColorAnimation {
              duration: root.leadTime
            }
          }
        }

        MouseArea {
          anchors.fill: parent
          cursorShape: Qt.PointingHandCursor
          onClicked: parent.modelData.activate()
        }
      }
    }
  }
}
