import QtQuick 1.1
import com.nokia.meego 1.0

PageStackWindow {
    id: root
    showStatusBar: false
    showToolBar: false

    property bool showNumeric: true
    property alias dbgTimerRun: dbgTimer.running

    // flight data
    property real roll:     10
    property real pitch:    20
    property real heading:  45
    property real altitude: 123
    property real groundspeed: 45
    property real accelX:   0
    property real verticalspeed: 0
    property real modelLongtitude: 31.2483
    property real modelLatitude: 58.5009
    property real homeLongtitude: 31.2482
    property real homeLatitude: 58.4988
    property real radiusBase: 100
    property real radiusMax: 500

    // functions
    signal dataUpdated()
    signal gpsUpdated()

    function currentOrientation() {
        var state = ""
        if      (screen.currentOrientation === Screen.Portrait)             state = "topUp"
        else if (screen.currentOrientation === Screen.Landscape)            state = "rightUp"
        else if (screen.currentOrientation === Screen.PortraitInverted)     state = "downUp"
        else if (screen.currentOrientation === Screen.LandscapeInverted)    state = "leftUp"
        return state
    }

    // TODO: remove dbg timer
    property int axt: 1
    property int vst: 1
    Timer {
        id: dbgTimer
        interval: 100
        running: false
        repeat: true
        onTriggered: {
            roll += 1;      if (roll > 180) roll = -179
            pitch += 1;     if (pitch > 90) pitch = -89
            heading += 2;   if (heading > 360) heading = 2

            altitude += 13;     if (altitude > 1000) altitude = 13
            groundspeed += 1.7; if (groundspeed > 200) groundspeed = 0

            accelX += 0.1 * axt;        if (accelX > 6 || accelX < -6) axt = -axt
            verticalspeed += 0.1 * vst; if (verticalspeed > 10 || verticalspeed < -10) vst = -vst

            dataUpdated()
        }
    }
    Timer {
        interval: 500
        running: dbgTimer.running
        repeat: true
        onTriggered: {
            modelLongtitude -= 0.00005
            modelLatitude -= 0.0001

            gpsUpdated()
        }
    }
    // TODO

    // pages
    Settings    { id: setsUI }
    AeroUI      { id: aeroUI }
    MapUI       { id: mapUI }

    initialPage: setsUI

    // dialogs
    QueryDialog {
        id: aboutDialog
        titleText: "Application Title"
        message: "(C) [2012] [hhrhhr]\n[0.0.5]\n\n" +
                 "Images from OpenPilot project\n" +
                 "http://www.openpilot.org/"
    }

    QueryDialog {
        id: quitDialog
        titleText: "Quit"
        message: "Ready to exit?"
        acceptButtonText: "Yes, exit app"
        rejectButtonText: "No, return to app"
        onAccepted: { Qt.quit() }
    }

    // global menu
    Menu {
        id: myMenu
        visualParent: pageStack
        MenuLayout {
            MenuItem {
                text: root.showStatusBar ? "Hide status bar" : "Show status bar"
                onClicked: root.showStatusBar = !root.showStatusBar
            }
            MenuItem {
                text: theme.inverted ? "Set light theme" : "Set dark theme"
                onClicked: theme.inverted = !theme.inverted;
            }
            MenuItem {
                text: "About"
                onClicked: aboutDialog.open()
            }
            MenuItem {
                text: "Quit"
                onClicked: quitDialog.open()
            }
        }
    }

    Component.onCompleted: theme.inverted = true
}
