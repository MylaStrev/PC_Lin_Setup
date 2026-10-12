import QtQuick
import QtQuick.Effects
import qs.theme

// Shadow.qml
//
// A soft shadow under whatever module you drop this into.
// The shadow copies the parent shape:
//
//     Rectangle { radius: Theme.radius; Shadow {} }
//
// A negative z puts the shadow behind, because a parent paints its own
// background before painting children.
//
// This draws the shape directly instead of blurring a snapshot.
// Nothing renders into a layer, so text inside keeps full antialiasing.
RectangularShadow {
  anchors.fill: parent
  z: -1

  radius: parent.radius
  blur: Theme.shadowBlur
  spread: Theme.shadowSpread
  offset: Qt.vector2d(0, Theme.shadowOffset)
  color: Theme.shadowColor
}
