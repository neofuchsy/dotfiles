import QtQuick
import Quickshell
pragma Singleton

// This is probably not great for performance, so I will turn it off
// pragma ComponentBehavior: Bound

Singleton {
    id: root

    property QtObject colors
    property QtObject typography

    colors: QtObject {
        property color surface: "#1B110C"
        property color surfaceForeground: "#F3DED5"
        property color surfaceHigh: "#332721"
        property color surfaceHighest: "#3F322C"
        
        property color primary: "#E27124"
        property color primaryForeground: "#3B1600"

        property color secondary: "#E27124"
    }

    typography: QtObject {
        property QtObject bar

        bar: QtObject {
            property string family: "IBM Plex Sans"
            property int size: 14
            property int weight: 500
        }
    }
}