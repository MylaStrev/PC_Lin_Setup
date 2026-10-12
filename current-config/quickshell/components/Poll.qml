import QtQuick
import Quickshell
import Quickshell.Io

Scope {
  id: root

  property string cmd: ""
  property int every: 5000
  property string text: ""

  Process {
    id: process

    command: ["sh", "-c", root.cmd]
    running: true

    stdout: StdioCollector {
      id: output
      onStreamFinished: root.text = output.text.trim()
    }
  }

  Timer {
    interval: root.every
    running: true
    repeat: true
    onTriggered: process.running = true
  }
}