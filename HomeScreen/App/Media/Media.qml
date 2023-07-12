import QtQuick 2.6
import QtQuick.Controls 2.4

Item {
    id: rootID
    width: 1920
    height: 1080 - 104
    //Header
    AppHeader{
        id: headerItem
        width: parent.width
        height: 141
        onClickPlaylistButton: {
            console.log("playlistButtonStatus " + playlistButtonStatus)
            playlistButtonStatus ? playlist.open() : playlist.close()
        }
    }

    //Playlist
    PlaylistView{
        id: playlist
        y: headerItem.height + 104
        width: 675
        height: parent.height - headerItem.height - 104
    }

    //Media Info
    MediaInfoControl{
        id: mediaInfoControl
        width: rootID.width - (playlist.position * playlist.width)
        anchors.top: headerItem.bottom
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        mediaCount: playlist.mediaPlaylist.count
        clip: true
    }

    Keys.onEscapePressed: {
        parent.pop()
        console.log("Key Escape Pressed")
    }
}
