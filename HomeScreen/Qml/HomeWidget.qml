import QtQuick 2.12
import QtQuick.Layouts 1.11
import QtQuick.Controls 2.4
import QtQml 2.12
import QtQml.Models 2.1

Item {
    id: root
    width: 1920
    height: 1080 - 104
    function openApplication(url){
        parent.push(url)
    }

    Keys.onPressed: {
        if (event.key === Qt.Key_Up) {
            console.log("Key Up Pressed")
            focusArea = 0
            lvWidget.currentIndex = 0
            focusIndex = lvWidget.currentIndex
        } else if (event.key === Qt.Key_Down) {
            console.log("Key Down Pressed")
            focusArea = 1
            lvApplication.currentIndex = 0
            focusIndex = lvApplication.currentIndex
        }

        if (focusArea === 0) {
            if (event.key === Qt.Key_Right
                    && lvWidget.currentIndex >= 0
                    && lvWidget.currentIndex < lvWidget.count - 1) {
                console.log("Key Right Pressed")
                lvWidget.currentIndex = lvWidget.currentIndex + 1
                focusIndex = lvWidget.currentIndex
                console.log(focusIndex + "----------> currentIndex: " + lvWidget.currentIndex)

            } else if (event.key === Qt.Key_Left
                       && focusIndex > 0
                       && focusIndex <= lvWidget.count - 1) {
                console.log("Key Left Pressed")
                lvWidget.currentIndex = lvWidget.currentIndex - 1
                focusIndex = lvWidget.currentIndex
                console.log(focusIndex + "----------> currentIndex: " + lvWidget.currentIndex)
            }
        }
        else if (focusArea === 1) {
            if (event.key === Qt.Key_Right
                    && focusIndex >= 0
                    && focusIndex < lvApplication.count - 1) {
                console.log("Key Right Pressed")
                //focusIndex = lvApplication.model.index + 1
                lvApplication.currentIndex = lvApplication.currentIndex + 1
                focusIndex = lvApplication.currentIndex
                console.log(focusIndex + "----------> currentIndex: " + lvApplication.currentIndex)
            } else if (event.key === Qt.Key_Left
                       && focusIndex > 0
                       && focusIndex <= lvApplication.count - 1) {
                console.log("Key Left Pressed")
                //focusIndex = lvApplication.model.index - 1
                lvApplication.currentIndex = lvApplication.currentIndex - 1
                focusIndex = lvApplication.currentIndex
                console.log(focusIndex + "----------> currentIndex: " + lvApplication.currentIndex)
            }
        }

        if (event.key === Qt.Key_Return && focusArea) {
            openApplication(lvApplication.model.items.get(focusIndex).model.url)
            console.log("Key Enter Pressed")
        }
        else if (event.key === Qt.Key_Return && focusArea === 0)
            switch (focusIndex) {
            case 0: {openApplication("qrc:/App/Map/Map.qml") ; break}
            case 1: {openApplication("qrc:/App/Climate/Climate.qml") ; break}
            case 2: {openApplication("qrc:/App/Media/Media.qml") ; break}
            }
    }

    property int focusArea: 1
    property int focusIndex: 0
    property bool isReorder: false

    ListView {
        id: lvWidget
        spacing: 10
        orientation: ListView.Horizontal
        width: 1920
        height: 508
        interactive: false

        displaced: Transition {
            NumberAnimation { properties: "x,y"; easing.type: Easing.OutQuad }
        }

        model: DelegateModel {
            id: visualModelWidget
            model: ListModel {
                id: widgetModel
                ListElement { type: "map" }
                ListElement { type: "climate" }
                ListElement { type: "media" }
            }

            delegate: DropArea {
                id: delegateRootWidget
                width: 635; height: 508
                keys: ["widget"]

                onEntered: {
                    visualModelWidget.items.move(drag.source.visualIndex, iconWidget.visualIndex)
                    iconWidget.item.enabled = false
                }
                property int visualIndex: DelegateModel.itemsIndex
                Binding { target: iconWidget; property: "visualIndex"; value: visualIndex }
                onExited: iconWidget.item.enabled = true
                onDropped: {
                    console.log(drop.source.visualIndex)
                }

                Loader {
                    id: iconWidget
                    property int visualIndex: 0
                    width: 635; height: 508

                    anchors {
                        horizontalCenter: parent.horizontalCenter;
                        verticalCenter: parent.verticalCenter
                    }

                    sourceComponent: {
                        switch(model.type) {
                        case "map": return mapWidget
                        case "climate": return climateWidget
                        case "media": return mediaWidget
                        }
                    }

                    Drag.active: iconWidget.item.drag.active
                    Drag.keys: "widget"
                    Drag.hotSpot.x: delegateRootWidget.width/2
                    Drag.hotSpot.y: delegateRootWidget.height/2

                    states: [
                        State {
                            when: iconWidget.Drag.active
                            ParentChange {
                                target: iconWidget
                                parent: root
                            }

                            AnchorChanges {
                                target: iconWidget
                                anchors.horizontalCenter: undefined
                                anchors.verticalCenter: undefined
                            }
                        }
                    ]
                }
            }
        }

        Component {
            id: mapWidget
            MapWidget{
                id: map
                isFocus: (focusArea === 0 && focusIndex === parent.visualIndex)
                onClicked: openApplication("qrc:/App/Map/Map.qml")
                onPressed: {
                    focusArea = 0
                    lvWidget.currentIndex = parent.visualIndex
                    focusIndex = parent.visualIndex
                    console.log(focusIndex)
                }
            }
        }
        Component {
            id: climateWidget
            ClimateWidget {
                id: climate
                isFocus: (focusArea === 0 && focusIndex === parent.visualIndex)
                onClicked: openApplication("qrc:/App/Climate/Climate.qml")
                onPressed: {
                    focusArea = 0
                    lvWidget.currentIndex = parent.visualIndex
                    focusIndex = parent.visualIndex
                    console.log(focusIndex)
                }
            }
        }
        Component {
            id: mediaWidget
            MediaWidget{
                id: media
                isFocus: (focusArea === 0 && focusIndex === parent.visualIndex)
                onClicked: openApplication("qrc:/App/Media/Media.qml")
                onPressed: {
                    focusArea = 0
                    lvWidget.currentIndex = parent.visualIndex
                    focusIndex = parent.visualIndex
                    console.log(focusIndex)
                }
            }
        }
    }

    ListView {
        id: lvApplication
        x: 0
        y: lvWidget.height
        width: 1920; height: 548
        orientation: ListView.Horizontal
        highlightMoveDuration: 100
        spacing: 5

        displaced: Transition {
            NumberAnimation { properties: "x,y"; easing.type: Easing.OutQuad }
        }

        model: DelegateModel {
            id: visualModel
            model: appsModel
            delegate: DropArea {
                id: delegateRoot
                width: 310; height: 548
                keys: "AppButton"

                onEntered: {
                    visualModel.items.move(drag.source.visualIndex, icon.visualIndex)
                    focusIndex = -1
                }
                property int visualIndex: DelegateModel.itemsIndex
                Binding { target: icon; property: "visualIndex"; value: visualIndex }
                onExited: focusIndex = visualIndex

                Item {
                    id: icon
                    property int visualIndex: 0
                    width: 310; height: 548
                    anchors {
                        horizontalCenter: parent.horizontalCenter;
                        verticalCenter: parent.verticalCenter
                    }

                    AppButton{
                        id: app
                        anchors.fill: parent
                        title: model.title
                        icon: model.iconPath

                        isFocus:(focusArea === 1 && focusIndex === parent.visualIndex)
                        drag.axis: Drag.XAxis
                        onClicked: openApplication(model.url)
                        onPressAndHold: {
                            drag.target = parent
                            isReorder = true
                        }
                        onPressed: {
                            focusArea = 1
                            lvApplication.currentIndex = parent.visualIndex
                            focusIndex = parent.visualIndex
                            console.log(focusIndex)
                        }

                        onReleased: {
                            drag.target = undefined
                            focusIndex = parent.visualIndex
                            console.log("-------------> "+focusIndex)

                            for (var pos = 0; pos < visualModel.items.count; pos++) {
                                var appsItem = visualModel.items.get(pos).model
                                console.log(visualModel.items.count)
                                appsModel.addApplication(pos, appsItem.ID, appsItem.title, appsItem.url, appsItem.iconPath)
                            }

                            if (isReorder)
                                saveXML.saveDataAppMenu()
                            isReorder = false
                        }
                    }

                    onFocusChanged: app.focus = icon.focus

                    Drag.active: app.drag.active
                    Drag.keys: "AppButton"

                    states: [
                        State {
                            when: icon.Drag.active
                            ParentChange {
                                target: icon
                                parent: root
                            }

                            AnchorChanges {
                                target: icon
                                anchors.horizontalCenter: undefined
                                anchors.verticalCenter: undefined
                            }
                        }
                    ]
                }
            }
        }

        ScrollBar.horizontal: ScrollBar{
            anchors.bottom: parent.top
            anchors.left: parent.left
            anchors.right: parent.right
            policy: ScrollBar.AsNeeded
        }
    }
}
