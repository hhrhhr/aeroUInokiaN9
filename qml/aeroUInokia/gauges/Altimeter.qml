import QtQuick 1.1
import "../content"

Rectangle {
    //    id: altimeter
    width: parent.width < parent.height ? parent.width/2 : parent.height/2
    height: width
    color: "#00000000"

    property real value: 0
    property real gm: width / 24
    property real gw: gm * 22

    function update() {
        if (!visible) return

        value = root.altitude
    }

    Rectangle {
        width: gw
        height: gw
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: gm
        anchors.bottomMargin: gm
        color: "#00000000"

        Image {
            id: background
            smooth: true
            anchors.fill: parent
            source: "../images/background.png"
        }

        Image {
            id: grid
            smooth: true
            anchors.fill: parent
            source: "../images/altimeter_grid.png"
        }

        Image {
            id: bigNeedle
            smooth: true
            anchors.fill: parent
            source: "../images/big_needle.png"

            rotation: value * 3.6
        }

        Image {
            id: smallNeedle
            smooth: true
            anchors.fill: parent
            source: "../images/small_needle.png"

            rotation: value * 0.36
        }

        Image {
            id: foreground
            smooth: true
            anchors.fill: parent
            source: "../images/foreground1.png"
        }

        DbgTxt {
            h: gm
            txt1: "altitude: "
            val1: value
        }
    }

    //    Component.onCompleted: console.log("altimeter ready")
}
