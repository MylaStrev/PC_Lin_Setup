import QtQuick
import Quickshell.Services.Mpris
import qs.theme
import qs.components

// Media.qml
//
// One module. Shows the track playing.
// The module hides when nothing loads, and the row closes up behind.
Rectangle {
  id: root

  property int padding: 12 // room after the track text

  // Sorts real music apps from anything else registering with MPRIS,
  // like a browser tab.
  function isPlayerApp(p) {
    const name = (p.identity + " " + p.dbusName).toLowerCase();
    return ["spotify", "youtube music", "ytmusic", "tidal", "deezer", "plexamp", "mpd", "mpv", "vlc", "elisa", "amberol", "rhythmbox", "strawberry", "clementine", "audacious", "lollypop", "cmus", "moc", "netease"].some(n => name.includes(n));
  }

  // Anything playing wins.
  // With everything paused, prefer a real player over a browser on a stopped tab.
  // Then fall back to anything holding a track.
  property var player: {
    const all = Mpris.players.values;
    const playing = all.find(p => p.isPlaying);
    if (playing)
      return playing;
    const app = all.find(p => root.isPlayerApp(p) && p.trackTitle !== "");
    if (app)
      return app;
    const loaded = all.find(p => p.trackTitle !== "");
    if (loaded)
      return loaded;
    return all[0];
  }

  implicitWidth: row.width + root.padding
  implicitHeight: Theme.moduleHeight
  radius: Theme.radius
  color: Theme.pill
  visible: root.player !== undefined

  Shadow {}

  Row {
    id: row
    height: parent.height
    spacing: Theme.spacing

    // The same left-hand icon square every other module carries.
    PillIcon {
      icon: "󰝚"
      iconColor: Theme.blue
    }

    Text {
      anchors.verticalCenter: parent.verticalCenter
      text: root.player ? root.player.trackArtist + " — " + root.player.trackTitle : ""
      color: Theme.text
      font.family: Theme.font
      font.pixelSize: Theme.textSize
      font.weight: 600
      font.letterSpacing: Theme.letterSpacing
    }
  }
}
