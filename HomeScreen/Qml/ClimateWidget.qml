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
        id: idBackgroud
        source: ""
        width: root.implicitWidth
        height: root.implicitHeight
    }
    Image {
        id: bgBlur
        x:10
        y:10
        width: 615
        height: 488
        source: "qrc:/Img/Climate/bg_climate_info_01.png"
    }
    FastBlur {
        anchors.fill: bgBlur
        source: bgBlur
        radius: 18
    }
    Text {
        id: title
        anchors.horizontalCenter: parent.horizontalCenter
        y: 40
        text: "Climate"
        color: "white"
        font.pixelSize: 34
    }
    //Driver
    Text {
        x: 67
        y: 117
        width: 184
        text: "DRIVER"
        color: "white"
        font.pixelSize: 34
        horizontalAlignment: Text.AlignHCenter
    }
    Image {
        x:58
        y: 158
        width: 214
        source: "qrc:/Img/Climate/bg_climate_line.png"
    }
    Image {
        x: 124
        y: 177
        width: 110
        height: 120
        source: "qrc:/Img/HomeScreen/widget_climate_arrow_seat.png"
    }
    Image {
        x: 98
        y: 211
        width: 70
        height: 50
        source: climateModel.driver_wind_mode == 0 || climateModel.driver_wind_mode == 2 ?
                    "qrc:/Img/HomeScreen/widget_climate_arrow_01_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_01_n.png"

    }
    Image {
        x: 74
        y: 235
        width: 70
        height: 50
        source: climateModel.driver_wind_mode == 1 || climateModel.driver_wind_mode == 2 ?
                    "qrc:/Img/HomeScreen/widget_climate_arrow_02_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_02_n.png"
    } //cli
    Text {
        id: driver_temp
        x: 62
        y: 323
        width: 184
        text: "°C"
        color: "white"
        font.pixelSize: 42
        horizontalAlignment: Text.AlignHCenter
    }

    //Passenger
    Text {
        x: 344
        y: 117
        width: 210
        text: "PASSENGER"
        color: "white"
        font.pixelSize: 34
        horizontalAlignment: Text.AlignHCenter
    }
    Image {
        x: 342
        y: 158
        width: 214
        source: "qrc:/Img/Climate/bg_climate_line.png"
    }
    Image {
        x: 411
        y: 177
        width: 110
        height: 120
        source: "qrc:/Img/HomeScreen/widget_climate_arrow_seat.png"
    }
    Image {
        x: 385
        y: 211
        width: 70
        height: 50
        source: climateModel.passenger_wind_mode == 0 || climateModel.passenger_wind_mode == 2 ?
                    "qrc:/Img/HomeScreen/widget_climate_arrow_01_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_01_n.png"
    }
    Image {
        x: 361
        y: 235
        width: 70
        height: 50
        source: climateModel.passenger_wind_mode == 1 || climateModel.passenger_wind_mode == 2 ?
                    "qrc:/Img/HomeScreen/widget_climate_arrow_02_s_b.png" : "qrc:/Img/HomeScreen/widget_climate_arrow_02_n.png"
    }
    Text {
        id: passenger_temp
        x: 352
        y: 323
        width: 184
        text: "°C"
        color: "white"
        font.pixelSize: 42
        horizontalAlignment: Text.AlignHCenter
    }
    //Wind level
    Image {
        x: 154
        y: 232
        width: 290
        height: 100
        source: "qrc:/Img/HomeScreen/widget_climate_wind_level_bg.png"
    }
    Image {
        id: fan_level
        x: 154
        y: 232
        width: 290
        height: 100
        source: "qrc:/Img/HomeScreen/widget_climate_wind_level_01.png"
    }
    Connections{
        target: climateModel
        onDataChanged: {
            //set data for fan level
            if (climateModel.fan_level < 1) {
                fan_level.source = "qrc:/Img/HomeScreen/widget_climate_wind_level_01.png"
            }
            else if (climateModel.fan_level < 10) {
                fan_level.source = "qrc:/Img/HomeScreen/widget_climate_wind_level_0"+climateModel.fan_level+".png"
            } else {
                fan_level.source = "qrc:/Img/HomeScreen/widget_climate_wind_level_"+climateModel.fan_level+".png"
            }
            //set data for driver temp
            if (climateModel.driver_temp == 16.5) {
                driver_temp.text = "LOW"
            } else if (climateModel.driver_temp == 31.5) {
                driver_temp.text = "HIGH"
            } else {
                driver_temp.text = climateModel.driver_temp+"°C"
            }

            //set data for passenger temp
            if (climateModel.passenger_temp == 16.5) {
                passenger_temp.text = "LOW"
            } else if (climateModel.passenger_temp == 31.5) {
                passenger_temp.text = "HIGH"
            } else {
                passenger_temp.text = climateModel.passenger_temp+"°C"
            }
        }
    }

    //Fan
    Image {
        x: 267
        y: 323
        width: 60
        height: 60
        source: "qrc:/Img/HomeScreen/widget_climate_ico_wind.png"
    }
    //Bottom
    Text {
        x: 58
        y: 409
        width: 172
        horizontalAlignment: Text.AlignHCenter
        text: "AUTO"
        color: !climateModel.auto_mode ? "white" : "gray"
        font.pixelSize: 40
    }
    Text {
        x: 211
        y: 387
        width: 171
        horizontalAlignment: Text.AlignHCenter
        text: "OUTSIDE"
        color: "white"
        font.pixelSize: 22
    }
    Text {
        x: 211
        y: 425
        width: 171
        horizontalAlignment: Text.AlignHCenter
        text: "27.5°C"
        color: "white"
        font.pixelSize: 34
    }
    Text {
        x: 358
        y: 409
        width: 171
        horizontalAlignment: Text.AlignHCenter
        text: "SYNC"
        color: !climateModel.sync_mode ? "white" : "gray"
        font.pixelSize: 40
    }
    //
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
}
