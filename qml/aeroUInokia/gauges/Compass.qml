import QtQuick 1.1
import "../content"

Rectangle {
    //    id: compass
    width: parent.width < parent.height ? parent.width/2 : parent.height/2
    height: width
    color: "#00000000"

    property real value: 0
    property bool gridRotation: false   // rotate grid or plane
    property real gm: width / 24
    property real gw: gm * 22

    function update() {
        if (!visible) return

        value = root.heading
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
            source: "../images/compass_grid.png"

            rotation: gridRotation ? -value : 0
        }

        Image {
            id: plane
            smooth: true
            anchors.fill: parent
            source: "../images/compass_plane.png"

            rotation: gridRotation ? 0 : value
        }

        DbgTxt {
            h: gm
            txt1: "heading:"
            val1: value
        }
    }

    //    Component.onCompleted: console.log("compass ready")
}
