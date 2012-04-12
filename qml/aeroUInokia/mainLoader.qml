import QtQuick 1.1

Item {
    width: 480
    height: 854

    signal loadCompleted    // signal to C++

    Loader {
        id: mainLoader
        anchors.fill: parent
        onLoaded: secondTimer.start()
    }

    Loader {
        id: splashScreenLoader
        anchors.fill: parent
        source: Qt.resolvedUrl("SplashScreen.qml");
        onLoaded: firstTimer.start()
    }

    Timer {
        id: firstTimer
        interval: 1000
        running: false
        repeat: false
        onTriggered: mainLoader.source = Qt.resolvedUrl("main.qml")
    }

    Timer {
        id: secondTimer
        interval: 500
        running: false
        repeat: true
        onTriggered: {
            if ( splashScreenLoader.item.opacity === 1 )
                splashScreenLoader.item.opacity = 0
            else if ( splashScreenLoader.item.opacity === 0 ) {
                stop()
                splashScreenLoader.source = ""
                loadCompleted()
            }
        }
    }
}
