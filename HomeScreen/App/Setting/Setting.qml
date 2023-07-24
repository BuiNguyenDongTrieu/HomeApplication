import QtQuick 2.11
import QtQuick.Controls 2.4
import QtLocation 5.6
import QtPositioning 5.6
import QtQml 2.12

Item {
    id: root
    width: 1920
    height: 1080 - 104

    Item {
        id: startAnimation
        XAnimator{
            target: root
            from: 1920
            to: 0
            duration: 200
            running: true
        }
    }

    Image {
        id: headerItem
        source: "qrc:/App/Media/Image/title.png"

        Text {
            id: headerTitleText
            text: qsTr("SETTING")
            anchors.centerIn: parent
            color: "white"
            font.pixelSize: 46
        }
    }

    Keys.onEscapePressed: {
        parent.pop()
        console.log("Key Escape Pressed")
    }
}
