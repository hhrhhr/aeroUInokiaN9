import QtQuick 1.1
import com.nokia.meego 1.0
import "content"

Page {
    id: page

    signal connectStart
    signal connectStop

    property string title: "Settings"

    Rectangle {
        id: canvas
        color: "#00000000"
        clip: true

        Image {
            id: pageHeader
//            width: parent.width
            height: 72
            anchors { top: parent.top; left: parent.left; right: parent.right }
            source: "image://theme/meegotouch-view-header-fixed" + (theme.inverted ? "-inverted" : "")
            z: 1

            Label {
                id: header
                anchors {
                    verticalCenter: parent.verticalCenter
                    left: parent.left
                    leftMargin: 16
                }
                font.pixelSize: 32
                text: page.title
            }
        }

        Flickable {
            id: pageFlickableContent
            anchors {
                top: pageHeader.bottom; bottom: parent.bottom; left: parent.left; right: parent.right
            }
            anchors.margins: 16
//            width: parent.width
            height: parent.height - pageHeader.height
            contentHeight: pageContent.height
            contentWidth: pageContent.width
            flickableDirection: Flickable.VerticalFlick

            Column {
                id: pageContent
                width: canvas.width - pageFlickableContent.anchors.margins * 2
                spacing: 32
/*
                move: Transition {
                    NumberAnimation { properties: "y"; duration: 500; easing.type: Easing.OutCirc}
                }
                add: Transition {
                    NumberAnimation { properties: "y"; duration: 500; easing.type: Easing.OutCirc}
                }
*/
                Rectangle {
                    width: parent.width
                    height: pageHeader.height / 2
                    color: "#00000000"

                    Button {
                        id: btcDisconnect
                        width: parent.width/2.5
                        anchors.left: parent.left
                        text: "Disconnect"
                        onClicked: {
                            conInd.running = false
                            conInd.visible = false
                            btnConnect.text = "Connect"
                            root.dbgTimerRun = false
                            connectStop()
                        }
                    }
                    BusyIndicator {
                        id: conInd
                        visible: false
                        platformStyle: BusyIndicatorStyle { size: "small" }
                        anchors.centerIn: parent
                    }
                    Button {
                        id: btnConnect
                        width: parent.width/2.5
                        anchors.right: parent.right
                        text: "Connect"
                        onClicked: {
                            conInd.running = true
                            conInd.visible = true
                            text = "Connecting..."
                            root.dbgTimerRun = true
                            connectStart()
                        }
                    }
                }

                Label {
                    width: parent.width
                    text: "Remote ip address"
                    TextField {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        placeholderText: parent.text
                        text: "192.168.0.100"
                    }
                }

                Label {
                    width: parent.width
                    text: "Remote port"
                    TextField {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        placeholderText: parent.text
                        text: "40100"
                    }
                }

                Label {
                    width: parent.width
                    text: "Local ip address: "
                    TextField {
                        readOnly: true
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        placeholderText: parent.text
                        text: "192.168.0.102"
                    }
                }

                Label {
                    width: parent.width
                    text: "Local port"
                    TextField {
                        anchors.right: parent.right
                        anchors.verticalCenter: parent.verticalCenter
                        placeholderText: parent.text
                        text: "40200"
                    }
                }

                Label {
                    width: parent.width
                    text: "Show numeric values";
                    Switch {
                        anchors.right: parent.right
                        checked: true
                        onCheckedChanged: root.showNumeric = checked
                    }
                }

                Label { text: "Settings3" }
                Label { text: "Settings4" }
                Label { text: "Settings5" }
                Label { text: "Settings6" }
                Label { text: "Settings7" }
                Label { text: "Settings8" }
                Label { text: "Settings9" }
                Label { text: "Settings10" }
                Label { text: "Settings11" }
                Label { text: "Settings12" }
                Label { text: "Settings13" }
                Label { text: "Settings14" }
                Label { text: "Settings15" }
                Label { text: "Settings16" }
            }
        }

        ScrollDecorator { flickableItem: pageFlickableContent }
    }

    CustomToolbar { id: toolbar }

    state: currentOrientation()
    states: [
        State {
            name: "rightUp"
            PropertyChanges { target: canvas; width: parent.width-72; height: parent.height }
            PropertyChanges { target: toolbar; width: 72; height: parent.height}
            AnchorChanges { target: toolbar; anchors {top: parent.top; right: parent.right } }
        },
        State {
            name: "topUp"
            PropertyChanges { target: canvas; width: parent.width; height: parent.height-72}
            PropertyChanges { target: toolbar; width: parent.width; height: 72}
            AnchorChanges { target: toolbar; anchors { bottom: parent.bottom; right: parent.right } }
        }
    ]
    //    Component.onCompleted: { }
}
