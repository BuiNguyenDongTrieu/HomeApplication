import QtQuick 2.0
import QtGraphicalEffects 1.0
import QtQml 2.12

MouseArea {
    id: root
    property bool isFocus: false
    implicitWidth: 635
    implicitHeight: 508
    Rectangle {
        anchors{
            fill: parent
            margins: 10
        }
        opacity: 0.7
        color: "#111419"
    }
    Image {
        id: bgBlur
        x:10
        y:10
        width: 615
        height: 488
        source: {
            if (myModel.rowCount() > 0 && myModel.rowCount() >  player.playlist.currentIndex)
                return myModel.data(myModel.index(player.playlist.currentIndex,0), 260)
            else
                return "qrc:/Img/HomeScreen/cover_art.jpg"
        }
    }
    FastBlur {
        anchors.fill: bgBlur
        source: bgBlur
        radius: 18
    }
    Image {
        id: idBackgroud
        source: ""
        width: root.implicitWidth
        height: root.implicitHeight
    }
    Text {
        id: title
        anchors.horizontalCenter: parent.horizontalCenter
        y: 40
        text: "Media"
        color: "white"
        font.pixelSize: 34
    }
    Image {
        id: bgInner
        x:200
        y:96
        width: 235
        height: 235
        source: {
            if (myModel.rowCount() > 0 && myModel.rowCount() >  player.playlist.currentIndex)
                return myModel.data(myModel.index(player.playlist.currentIndex,0), 260)
            else
                return "qrc:/Img/HomeScreen/cover_art.jpg"
        }
    }
    Image{
        x:200
        y:96
        width: 235
        height: 235
        source: "qrc:/Img/HomeScreen/widget_media_album_bg.png"
    }
    Text {
        id: txtSinger
        x: 42
        y: 350
        width: 551
        horizontalAlignment: Text.AlignHCenter
        text: {
            if (myModel.rowCount() > 0 && myModel.rowCount() >  player.playlist.currentIndex)
                return myModel.data(myModel.index(player.playlist.currentIndex,0), 258)
        }
        elide: Text.ElideRight
        color: "white"
        font.pixelSize: 30
    }
    Text {
        id: txtTitle
        x: 42
        y: 400
        width: 551
        horizontalAlignment: Text.AlignHCenter
        text: {
            if (myModel.rowCount() > 0 && myModel.rowCount() >  player.playlist.currentIndex)
                return myModel.data(myModel.index(player.playlist.currentIndex,0), 257)
        }
        elide: Text.ElideRight
        color: "white"
        font.pixelSize: 48
    }
    Image{
        id: imgDuration
        x: 62
        y: 472
        width: 511
        source: "qrc:/Img/HomeScreen/widget_media_pg_n.png"
    }
    Image{
        id: imgPosition
        x: 62
        y: 472
        width: 0
        source: "qrc:/Img/HomeScreen/widget_media_pg_s.png"
    }

    states: [
        State {
            name: "Focus"
            PropertyChanges {
                target: idBackgroud
                source: "qrc:/Img/HomeScreen/bg_widget_f.png"
            }
        },
        State {
            name: "Pressed"
            PropertyChanges {
                target: idBackgroud
                source: "qrc:/Img/HomeScreen/bg_widget_p.png"
            }
        },
        State {
            name: "Normal"
            PropertyChanges {
                target: idBackgroud
                source: ""
            }
        }
    ]
    onPressed: root.state = "Pressed"
    onReleased:{
        root.focus = true
        root.state = "Focus"
    }
    onIsFocusChanged: {
        root.focus = isFocus
        if (root.focus == true )
            root.state = "Focus"
        else
            root.state = "Normal"
    }

    Connections{
        target: player.playlist
        onCurrentIndexChanged:{
            if (myModel.rowCount() > 0 && myModel.rowCount() >  player.playlist.currentIndex) {
                bgBlur.source = myModel.data(myModel.index(player.playlist.currentIndex,0), 260)
                bgInner.source = myModel.data(myModel.index(player.playlist.currentIndex,0), 260)
                txtSinger.text = myModel.data(myModel.index(player.playlist.currentIndex,0), 258)
                txtTitle.text = myModel.data(myModel.index(player.playlist.currentIndex,0), 257)
            }
        }
    }

    Connections{
        target: player
        onDurationChanged:{
            imgDuration.width = 511
        }
        onPositionChanged: {
            imgPosition.width = (player.position / player.duration)*(511);
        }
    }
}
