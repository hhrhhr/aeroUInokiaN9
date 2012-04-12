import QtQuick 1.1
import "../content"

Rectangle {
    //    id: turnCoordinator
    width: parent.width < parent.height ? parent.width/2 : parent.height/2
    height: width
    color: "#00000000"

    property real value1: 0 // roll
    property real value2: 0 // accel left/right
    property real gm: width / 24
    property real gw: gm * 22

    function update() {
        if (!visible) return

        value1 = root.roll
        value2 = root.accelX
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
            source: "../images/turn_background.png"
        }

        Image {
            id: needle
            smooth: true
            anchors.fill: parent
            source: "../images/turn_needle.png"

            transform: [
                Rotation {
                    origin.x: needle.width/2
                    origin.y: -400
                    angle: value2
                }
            ]
        }

        Image {
            id: needleForeground
            smooth: true
            anchors.fill: parent
            source: "../images/turn_needle_foreground.png"
        }

        Image {
            id: plane
            smooth: true
            anchors.fill: parent
            source: "../images/turn_plane.png"

            rotation: (value1 > 30) ? 30 : (value1 < -30) ? -30 : value1
        }

        Image {
            id: foreground
            smooth: true
            anchors.fill: parent
            source: "../images/turn_foreground.png"
        }

        DbgTxt {
            h: gm
            txt1: "roll:"
            val1: value1
            txt2: "\taccel:"
            val2: value2
        }
    }

    //    Component.onCompleted: console.log("turnCoordinator ready")
}
