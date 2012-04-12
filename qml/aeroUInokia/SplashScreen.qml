import QtQuick 1.1

Item {
    id: splashScreen
    anchors.fill: parent

    z: 100
    Image {
        anchors.fill: parent
//        fillMode: Image.PreserveAspectFit
        source: "images/meegotouch-wallpaper-portrait2.jpg"
    }
    Behavior on opacity { NumberAnimation { duration: 1000 } }
}
