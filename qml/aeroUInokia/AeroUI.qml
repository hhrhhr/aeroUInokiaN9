import QtQuick 1.1
import com.nokia.meego 1.0
import "gauges"
import "content"

Page {
    id: page

    Rectangle {
        id: canvas
//        anchors.fill: parent
        color: "#00000000"

        GroundSpeed     { id: speed }
        Attitude        { id: attit }
        Altimeter       { id: altim }
        TurnCoordinator { id: turnc }
        Compass         { id: comps }
        VerticalSpeed   { id: vsped }
    }

    CustomToolbar { id: toolbar }

    // connect root signal to gauge slot
    Component.onCompleted: {
        root.dataUpdated.connect(speed.update)
        root.dataUpdated.connect(attit.update)
        root.dataUpdated.connect(altim.update)
        root.dataUpdated.connect(turnc.update)
        root.dataUpdated.connect(comps.update)
        root.dataUpdated.connect(vsped.update)
    }

    state: currentOrientation()
    states: [
        State {
            name: "rightUp"
            PropertyChanges { target: canvas; width: parent.width-72; height: parent.height }
            PropertyChanges { target: toolbar; width: 72; height: parent.height}
            AnchorChanges { target: toolbar; anchors {top: parent.top; right: parent.right } }
            AnchorChanges { target: speed; anchors.top: parent.top; anchors.left: parent.left }
            AnchorChanges { target: attit; anchors.top: parent.top; anchors.left: speed.right }
            AnchorChanges { target: altim; anchors.top: parent.top; anchors.left: attit.right }
            AnchorChanges { target: turnc; anchors.top: speed.bottom; anchors.left: parent.left }
            AnchorChanges { target: comps; anchors.top: attit.bottom; anchors.left: turnc.right }
            AnchorChanges { target: vsped; anchors.top: altim.bottom; anchors.left: comps.right }
        },
        State {
            name: "topUp"
            PropertyChanges { target: canvas; width: parent.width; height: parent.height-72}
            PropertyChanges { target: toolbar; width: parent.width; height: 72}
            AnchorChanges { target: toolbar; anchors { bottom: parent.bottom; right: parent.right } }
            AnchorChanges { target: turnc; anchors.top: parent.top; anchors.left: parent.left }
            AnchorChanges { target: speed; anchors.top: parent.top; anchors.left: turnc.right }
            AnchorChanges { target: comps; anchors.top: turnc.bottom; anchors.left: parent.left }
            AnchorChanges { target: attit; anchors.top: speed.bottom; anchors.left: comps.right }
            AnchorChanges { target: vsped; anchors.top: comps.bottom; anchors.left: parent.left }
            AnchorChanges { target: altim; anchors.top: attit.bottom; anchors.left: vsped.right }
        }
    ]
}

