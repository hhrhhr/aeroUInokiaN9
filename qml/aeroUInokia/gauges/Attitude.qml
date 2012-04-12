import QtQuick 1.1
import "../content"

Rectangle {
    //    id: attitude
    width: parent.width < parent.height ? parent.width/2 : parent.height/2
    height: width
    color: "#00000000"

    property real value1: 0     // roll
    property real value2: 0     // pitch
    property real gm: width / 24
    property real gw: gm * 22

    function update() {
        if (!visible) return

        value1 = root.roll
        value2 = root.pitch
    }

    Rectangle {
        width: gw
        height: gw
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: gm
        anchors.bottomMargin: gm
        color: "#00000000"

        Rectangle {
            width: parent.width * 0.95
            height: width
            anchors.centerIn: parent
            clip: true

            Image {
                id: horizon
                width: gw / 220 * 216
                height: gw / 220 * 677
                anchors.centerIn: parent
                smooth: true
                source: "../images/attitude_horizon.png"

                transform: [
                    Translate { y: value2 * horizon.height / 264 },
                    Rotation {
                        origin.x: horizon.width / 2
                        origin.y: horizon.height / 2
                        angle: value1
                    }
                ]
            }
        }

        Image {
            id: needle
            smooth: true
            anchors.fill: parent
            source: "../images/attitude_needle.png"

            rotation: value1
        }

        Image {
            id: foreground
            smooth: true
            anchors.fill: parent
            source: "../images/attitude_foreground.png"
        }

        DbgTxt {
            h: gm
            txt1: "roll:"
            val1: value1
            txt2: "\tpitch:"
            val2: value2
        }
    }

    //    Component.onCompleted: console.log("attitude ready"
}
