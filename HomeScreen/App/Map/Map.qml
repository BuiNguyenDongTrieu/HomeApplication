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

    Plugin {
        id: mapPlugin
        name: "mapboxgl" //"osm" // , "esri", ...
    }
    MapQuickItem {
        id: marker
        anchorPoint.x: image.width/4
        anchorPoint.y: image.height
        coordinate: QtPositioning.coordinate(10.7873, 106.6665)

        sourceItem: Image {
            id: image
            source: "qrc:/Img/Map/car_icon.png"
        }
    }
    Map {
        id: map
        anchors.fill: parent
        plugin: mapPlugin
        center: QtPositioning.coordinate(10.7873, 106.6665)
        zoomLevel: 14
        copyrightsVisible: false
        Component.onCompleted: {
            map.addMapItem(marker)
        }
    }

    Keys.onEscapePressed: {
        parent.pop()
        console.log("Key Escape Pressed")
    }
}
