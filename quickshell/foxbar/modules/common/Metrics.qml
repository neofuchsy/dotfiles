import QtQuick
import Quickshell
pragma Singleton

Singleton {
    id: root

    property QtObject bar
    property QtObject panel
    property QtObject component

    bar: QtObject {
        property int totalHeight: 40
        property int height: 28
        property int margins: 24
        property int spacing: 8
        property int appIconSize: 18
    }

    panel: QtObject {
        property int padding: 16
        property int radius: 16
    }

    component: QtObject {
        property int height: 32
        property int iconSize: 20
        property int radius: 4
        property int innerPadding: 12
    }
}