import QtQuick 2.0

MouseArea {
    id: root
    implicitWidth: 310
    implicitHeight: 548
    property string icon
    property string title
    property bool isFocus: false
    property bool isReorder: false

    Image {
        id: idBackgroud
        width: root.width
        height: root.height
        source: icon + "_n.png"
    }
    Text {
        id: appTitle
        anchors.horizontalCenter: parent.horizontalCenter
        y: 300
        text: title
        font.pixelSize: 36
        color: "white"
    }

    states: [
        State {
            name: "Focus"
            PropertyChanges {
                target: idBackgroud
                source: icon + "_f.png"
            }
        },
        State {
            name: "Pressed"
            PropertyChanges {
                target: idBackgroud
                source: icon + "_p.png"
            }
        },
        State {
            name: "Normal"
            PropertyChanges {
                target: idBackgroud
                source: icon + "_n.png"
            }
        }
    ]
    onPressed: root.state = "Pressed"
    onReleased:{
        root.focus = true
        root.state = "Focus"
    }
    onCanceled: {
        root.focus = isFocus
        if (root.focus == true )
            root.state = "Focus"
        else
            root.state = "Normal"
    }

    onIsFocusChanged: {
        root.focus = isFocus
        if (isReorder == true) root.state = "Focus"
        else if (root.focus == true )
            root.state = "Focus"
        else
            root.state = "Normal"
    }

}
