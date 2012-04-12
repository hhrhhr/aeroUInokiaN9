import QtQuick 1.1
import com.nokia.meego 1.0
import "gauges"
import "content"

Page {
    id: page

    Rectangle {
        id: canvas
        color: "#00000000"

        MapWidget { id: mapwd }
        Attitude  { id: attit }
        Altimeter { id: altim }
    }

    CustomToolbar { id: toolbar }

    Component.onCompleted: {
        root.gpsUpdated.connect(mapwd.update)
        root.dataUpdated.connect(attit.update)
        root.dataUpdated.connect(altim.update)
    }

    state: root.currentOrientation()
    states: [
        State {
            name: "rightUp"
            PropertyChanges { target: canvas; width: parent.width-72; height: parent.height }
            PropertyChanges { target: toolbar; width: 72; height: parent.height}
            AnchorChanges { target: toolbar; anchors {top: parent.top; right: parent.right } }
            AnchorChanges { target: mapwd; anchors.top: parent.top; anchors.left: parent.left }
            AnchorChanges { target: attit; anchors.top: parent.top; anchors.left: mapwd.right }
            AnchorChanges { target: altim; anchors.top: attit.bottom; anchors.left: mapwd.right }
        },
        State {
            name: "topUp"
            PropertyChanges { target: canvas; width: parent.width; height: parent.height-72}
            PropertyChanges { target: toolbar; width: parent.width; height: 72}
            AnchorChanges { target: toolbar; anchors { bottom: parent.bottom; right: parent.right } }
            AnchorChanges { target: mapwd; anchors.top: parent.top; anchors.left: parent.left }
            AnchorChanges { target: attit; anchors.top: mapwd.bottom; anchors.left: parent.left }
            AnchorChanges { target: altim; anchors.top: mapwd.bottom; anchors.left: attit.right }
        }
    ]
}
