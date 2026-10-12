// Theme.qml
//
// Every colour, size and font for the bar lives here.
// Change a value once and the whole bar follows.
//
// pragma Singleton means one shared instance exists.
// Other files read Theme.pink without building anything first.

pragma Singleton
import QtQuick
import Quickshell

Singleton {
  id: root

  // ---------- palette ----------
  // Ariadne. bg0 runs darkest, each step up sits one shade lighter.
  QtObject {
    id: palette

    readonly property color bg0: "#040e0d"
    readonly property color bg1: "#0a1816"
    readonly property color bg2: "#0f211f"
    readonly property color bg3: "#152a26"
    readonly property color bg4: "#1d3631"

    readonly property color fg: "#f5e2c5"

    readonly property color red: "#ff6048"
    readonly property color orange: "#ffa478"
    readonly property color yellow: "#f5cd5b"
    readonly property color green: "#7ad9a8"
    readonly property color aqua: "#3dd1b0"
    readonly property color blue: "#5fc8d4"
    readonly property color purple: "#e89aa8"

    readonly property color grey0: "#3a1a35"
    readonly property color grey1: "#5a4d3e"
    readonly property color grey2: "#c4b09a"
  }

  // ---------- colours ----------
  // Bar names on the left, palette names on the right.
  // Remap a colour here and every module picks up the change.
  //
  // bg is the strip behind the modules. Transparent leaves the modules as
  // separate islands on your wallpaper. Set bg to palette.bg0 for a solid bar.
  property color bg: "transparent"

  readonly property color pill: "#20000000"      // body of a module
  readonly property color pillIcon: '#20353434'// icon square, one shade lighter
  readonly property color text: '#df89df'      // every piece of text

  readonly property color red: palette.red
  readonly property color orange: palette.orange
  readonly property color yellow: palette.yellow
  readonly property color green: palette.green
  readonly property color cyan: palette.aqua
  readonly property color teal: palette.blue
  readonly property color blue: palette.blue
  readonly property color purple: palette.purple
  readonly property color magenta: palette.purple
  readonly property color pink: palette.purple

  // Marks the active workspace.
  readonly property color accent: '#7e2e73'

  // ---------- sizes ----------
  property int barHeight: 50    // total height of the bar
  property int moduleHeight: 30 // height of every module
  property int spacing: 8       // gap between modules and screen edges
  property int radius: moduleHeight        // corner rounding
  property int margin: 13       // how far the bar floats off the screen edges

  // ---------- shadows ----------
  // A shadow gets clipped at the window edge.
  // Give the window shadowRoom above and below the modules.
  // Keep shadowRoom above blur plus offset, or the shadow ends in a straight line.
  property int shadowRoom: 24
  property real shadowBlur: 16
  property real shadowSpread: 1
  property real shadowOffset: 3
  property color shadowColor: Qt.rgba(0, 0, 0, 0.45)

  // ---------- fonts ----------
  // The font for every word on the bar.
  property string font: "Meslo Nerd Font"
  property real letterSpacing: 0

  // The font for icons.
  //
  // Material Symbols works by ligature. You write the icon name, like "wifi"
  // or "battery_full". The font swaps those letters for the icon.
  //
  // Keep this a Material Symbols family. Any other font draws the word "wifi".
  // Browse names at https://fonts.google.com/icons
  property string iconFont: "Nerd Fonts"

  // Material Symbols ships as one variable font.
  // Four axes shape every icon on the bar:
  //   FILL  0 outlined, 1 solid. Values between work.
  //   wght  stroke thickness, 100 thin to 700 bold
  //   GRAD  emphasis tweak, -25 to 200
  //   opsz  the size you draw at, so the font tunes proportions
  property var iconAxes: ({
    "FILL": 0,
    "wght": 700,
    "GRAD": 0,
    "opsz": 20
  })

  property real textSize: 15
  property int iconSize: 16
}
