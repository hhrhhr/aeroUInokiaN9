import QtQuick 1.1
import com.nokia.meego 1.0
import QtMobility.location 1.2
import "../content"

Rectangle {
    width: parent.width < parent.height ? parent.width : parent.height
    height: width
    color: "#00000000"

    property real mLon: 16
    property real mLat: 47
    property real mYaw: 0
    property real hLon: 16
    property real hLat: 47
    property real rMin: 100
    property real rMax: 500

    property real gw: width
    property real gm: width / 48

    function update() {
        if (!visible) return

        mLon = root.modelLongtitude
        mLat = root.modelLatitude
        mYaw = root.heading
        hLon = root.homeLongtitude
        hLat = root.homeLatitude
        rMin = root.radiusBase
        rMax = root.radiusMax

        // find center between model and home
        var lon = (root.modelLongtitude + root.homeLongtitude) * 0.5
        var lat = (root.modelLatitude + root.homeLatitude) * 0.5
        centerPosition.longitude = lon
        centerPosition.latitude = lat

        // circles colors
        var distanceToBase = modelPosition.distanceTo(homePosition)
        radiusBaseCircle.color = (distanceToBase < root.radiusBase) ? "#3366cc66" : "#11cccc66"
        radiusMaxCircle.border.color =
                (distanceToBase < root.radiusMax * 0.5)
                ? "#3366cc66" : (distanceToBase < root.radiusMax * 0.75)
                  ? "#33cccc66" : (distanceToBase < root.radiusMax)
                    ? "#33ff0000" : "#ff0000"

        drawModelImage(true)
    }

    function drawModelImage(autoZoom) {
        var mX, mY, hX, hY
        mX = map.toScreenPosition(modelPosition).x
        mY = map.toScreenPosition(modelPosition).y
        if (autoZoom) {
            if ((mX < 40) || (mX > map.size.width - 40) || (mY < 40) || (mY > map.size.height - 40)) {
                if (map.zoomLevel > map.minimumZoomLevel)
                    map.zoomLevel--
                console.log("autozoom to " + map.zoomLevel)
                mX = map.toScreenPosition(modelPosition).x
                mY = map.toScreenPosition(modelPosition).y
            }
        }
        modelImage.x = mX - modelImage.width * 0.5
        modelImage.y = mY - modelImage.height * 0.5
    }

/////////////////////////////////////////////////////////

    Rectangle {
        id: dataArea
        width: gw
        height: gw - gm*2
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.bottomMargin: gm
        color: "#00000000"

        Coordinate { id: homePosition; longitude: hLon; latitude: hLat }
        Coordinate { id: modelPosition; longitude: mLon; latitude: mLat }
        Coordinate { id: centerPosition; longitude: hLon; latitude: hLat }

        Map {
            id: map
            plugin: Plugin { name: "nokia" }
            anchors.fill: parent
            size.width: parent.width
            size.height: parent.height
            zoomLevel: 16
            connectivityMode: Map.OfflineMode
            center: centerPosition

            onZoomLevelChanged: drawModelImage(false)

            MapGroup {
                id: homeGroup
                MapImage {
                    id: homeImage
                    coordinate: homePosition
                    source: "../images/home2.png"
                    offset.x: -20   // half width of image
                    offset.y: -20   // half height of image
                }
                MapCircle {
                    id: radiusBaseCircle
                    center: homePosition
                    radius: rMin
                    color: "#3366cc66"
                    border {color: "#9966cc66"; width: 2}
                }
                MapCircle {
                    id: radiusMaxCircle
                    center: homePosition
                    radius: rMax
                    border {color: "#3366cc66"; width: 30}
                }
            }

            MapGroup {
                id: modelGroup
                Image {
                    id: modelImage
                    source: "../images/plane2.png"
                    smooth: true
                    x: map.size.width * 0.5 - modelImage.width * 0.5
                    y: map.size.height * 0.5 - modelImage.height * 0.5
                    rotation: mYaw
                }
            }

            Column {
                id: mapButtons
                anchors { top: parent.top; left: parent.left }
                ToolIcon {
                    platformIconId: "toolbar-refresh"
                    onClicked: {
                        root.modelLongtitude = 31.2483
                        root.modelLatitude = 58.5009
                        root.homeLongtitude = 31.2482
                        root.homeLatitude = 58.4988
                    }
                }
                ToolIcon {
                    id: zoomMinus
                    enabled: (map.zoomLevel < map.maximumZoomLevel)
                    platformIconId: (enabled) ? "toolbar-up" : "toolbar-up-dimmed"
                    onClicked: map.zoomLevel++
                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 3
                        color: "#33888888"
                    }
                }
                Rectangle {
                    id: currentZoom
                    width: zoomMinus.width
                    height: zoomMinus.height
                     color: "#00000000"
                    Label {
                        anchors.centerIn: parent
                        font.bold: true
                        text: map.zoomLevel
                    }
                }
                ToolIcon {
                    id: zoomPlus
                    enabled: (map.zoomLevel > map.minimumZoomLevel)
                    platformIconId: (enabled) ? "toolbar-down" : "toolbar-down-dimmed"
                    onClicked: map.zoomLevel--
                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 6
                        color: "#33888888"
                    }
                }
                ToolIcon {
                    id: showMapMenu
                    platformIconId: "toolbar-view-menu"
                    onClicked: mapTypeSelect.open()
                    Rectangle {
                        anchors.fill: parent
                        anchors.margins: 3
                        color: "#33888888"
                    }
                }
            }
        }

        Menu {
            id: mapTypeSelect
            MenuLayout {
                MenuItem {
                    text: "StreetMap"
                    onClicked: { map.mapType = Map.StreetMap }
                }
                MenuItem {
                    text: "SatelliteMapDay"
                    onClicked: { map.mapType = Map.SatelliteMapDay }
                }
                MenuItem {
                    text: "TerrainMap"
                    onClicked: { map.mapType = Map.TerrainMap }
                }
            }
        }

        DbgTxt {
            h: gm
            prec: 6
            txt1: "longtitude:"
            val1: modelPosition.longitude
            txt2: "\tlatitude:"
            val2: modelPosition.latitude
        }
    }

//    Component.onCompleted: { console.log("MapWidget ready") }
}
