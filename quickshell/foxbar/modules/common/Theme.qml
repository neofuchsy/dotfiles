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
        property color surface: "#1d1011"
        property color surfaceForeground: "#f7dcde"
        property color surfaceHigh: "#362628"
        property color surfaceHighest: "#413132"
        
        property color primary: "#af1444"
        property color primaryForeground: "#ffc1c8"
        property color primaryHover: '#92113a'

        property color secondary: '#692835'

        property color hoverOverlay: "#0cffffff"
    }

    typography: QtObject {
        property QtObject bar
        property QtObject component

        bar: QtObject {
            property string family: "IBM Plex Sans"
            property int size: 14
            property int weight: 500
        }

        component: QtObject {
            property string family: "IBM Plex Sans"
            property int size: 14
            property int weight: 500
        }
    }
}