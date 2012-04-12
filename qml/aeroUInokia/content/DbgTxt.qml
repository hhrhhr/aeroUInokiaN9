import QtQuick 1.1

Text {
    id: dbgTxt
    visible: root.showNumeric

    property real h: 10
    property real prec: 3
    property string txt1: ""
    property string txt2: ""
    property real val1: 0
    property real val2: 0

    width: parent.width
    anchors.top: parent.bottom

    font.pixelSize: h*1.6
    text: txt1 + " " + (val1).toPrecision(prec) +
          (txt2.length > 3 ? txt2 + " " + (val2).toPrecision(prec) : "")
    horizontalAlignment: Text.AlignHCenter
    color: theme.inverted ? "#00ff00" : "#000000"
}
