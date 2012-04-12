import QtQuick 1.1

Rectangle {
    id: bar
    color: "#00000000"

    property real bw: 10
    property real bh: 10

    Rectangle {
        id: btnConfig
        width: bw
        height: bh
        color: "#00000000"
        Image {
            anchors.centerIn: parent
            source: setsUI.visible ? "../images/config-on.png" : "../images/config-off.png"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    pageStack.pop()
                }
            }
        }
    }
    Rectangle {
        id: btnFlData
        width: bw
        height: bh
        color: "#00000000"
        Image {
            anchors.centerIn: parent
            source: aeroUI.visible ? "../images/flightdata-on.png" : "../images/flightdata-off.png"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (setsUI.visible) pageStack.push(aeroUI)
                    else if (!aeroUI.visible) pageStack.replace(aeroUI)
                }
            }
        }
    }
    Rectangle {
        id: btnNavMap
        width: bw
        height: bh
        color: "#00000000"
        Image {
            anchors.centerIn: parent
            source: mapUI.visible ? "../images/planner-on.png" : "../images/planner-off.png"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    if (setsUI.visible) pageStack.push(mapUI)
                    else if (!mapUI.visible) pageStack.replace(mapUI)
                }
            }
        }
    }
    Rectangle {
        id: btnMenu
        width: bw
        height: bh
        color: "#00000000"
        Image {
            anchors.centerIn: parent
            source: "../images/planner-off.png"
            MouseArea {
                anchors.fill: parent
                onClicked: {
                    root.showToolBar = false;
                    myMenu.open();
                }
            }
        }
    }

    state: currentOrientation()
    states: [
        State {
            name: "rightUp"
            PropertyChanges { target: bar; bw: 72; bh: parent.height / 4 }
            AnchorChanges { target: btnConfig; anchors.bottom: parent.bottom; anchors.right: parent.right }
            AnchorChanges { target: btnFlData; anchors.bottom: btnConfig.top; anchors.right: parent.right }
            AnchorChanges { target: btnNavMap; anchors.bottom: btnFlData.top; anchors.right: parent.right }
            AnchorChanges { target: btnMenu; anchors.bottom: btnNavMap.top; anchors.right: parent.right }
        },
        State {
            name: "topUp"
            PropertyChanges { target: bar; bw: parent.width / 4; bh: 72 }
            AnchorChanges { target: btnConfig; anchors.left: parent.left; anchors.top: parent.top }
            AnchorChanges { target: btnFlData; anchors.left: btnConfig.right; anchors.top: parent.top }
            AnchorChanges { target: btnNavMap; anchors.left: btnFlData.right; anchors.top: parent.top }
            AnchorChanges { target: btnMenu; anchors.left: btnNavMap.right; anchors.top: parent.top }
        }
    ]

//    onStateChanged: {    }
}
