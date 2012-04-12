import QtQuick 1.1
import "../content"

Rectangle {
    //    id: groundspeed
    width: parent.width < parent.height ? parent.width/2 : parent.height/2
    height: width
    color: "#00000000"

    property real value: 0
    property real gm: width / 24
    property real gw: gm * 22

    function update() {
        if (!visible) return

        value = root.groundspeed
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
            source: "../images/speed_grid.png"
        }

        Image {
            id: needle
            smooth: true
            anchors.fill: parent
            source: "../images/big_needle.png"

            rotation: value * 1.6
        }

        Image {
            id: foreground
            smooth: true
            anchors.fill: parent
            source: "../images/foreground1.png"
        }

        DbgTxt {
            h: gm
            txt1: "speed:"
            val1: value
        }
    }

    //    Component.onCompleted: console.log("speed ready")
}