import QtQuick
import Quickshell
import qs.theme
import qs.modules

// shell.qml
//
// The bar. Where the bar sits, and what goes in the bar.
//
// Nothing here knows how a module works. Each module lives in its own file,
// brings its own data, and sizes itself. Adding to the bar means dropping
// a name into one of the three rows below.
//
// Run with:  qs -p shell.qml
ShellRoot {
  Variants {
    model: Quickshell.screens

    PanelWindow {
      id: bar

      required property var modelData
      screen: modelData

      anchors { top: true; left: true; right: true }

      // One module tall, plus room above and below for shadows to fall into.
      // A shadow gets clipped at the window surface edge, so the window runs
      // taller than the part you see.
      implicitHeight: Theme.moduleHeight + Theme.shadowRoom * 1.5

      // Float clear of all three anchored edges. The top margin gives back
      // the room added above, so modules land where the margin says instead
      // of dropping by their own shadow gap.
      margins {
        top: Theme.margin + 5 - Theme.shadowRoom
        left: Theme.margin - 13
        right: Theme.margin - 13
      }

      // Reserve only the visible part. The zone measures from the window top
      // edge, so the zone covers the shadow room above the module plus the
      // module. Skip this and the invisible gap pushes every window down.
      exclusiveZone: Theme.moduleHeight + Theme.shadowRoom

      // A see-through window shows the modules and nothing else.
      color: "transparent"
      

      // Set Theme.bg to a colour for a solid bar behind the modules.
      Rectangle {
        anchors.fill: parent
        radius: Theme.radius - 30
        //color: Theme.bg
        gradient: Gradient {
          GradientStop { position: 0.0; color: '#7d000000'}
          GradientStop { position: 1.0; color: '#00ee1919'}
        }
      }

      // ---------- modules-left ----------
      Row {
        anchors.left: parent.left
        anchors.leftMargin: Theme.spacing
        anchors.verticalCenter: parent.verticalCenter
        spacing: Theme.spacing
        Workspaces {
          screen: bar.screen
        }
        Media {}
      }

      // ---------- modules-centre ----------
      // Centred on the screen, not between the other two rows. A longer
      // track title leaves this row where the row stands.
      Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        spacing: Theme.spacing

        Clock {}

      }

      // ---------- modules-right ----------
      Row {
        anchors.right: parent.right
        anchors.rightMargin: Theme.spacing
        anchors.verticalCenter: parent.verticalCenter
        spacing: Theme.spacing

        Volume {}
        Battery {}
        Brightness{}
        Bluetooth {}
        Wifi {}
      }
    }
  }
}
