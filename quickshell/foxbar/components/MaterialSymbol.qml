import QtQuick
import Quickshell

Text {
    property real iconSize: 16
    property int fill: 1

    renderType: fill === 1 ? Text.CurveRendering : Text.NativeRendering

    font {
        hintingPreference: Font.PreferFullHinting
        family: "Material Symbols Rounded"
        pixelSize: iconSize

        variableAxes: { 
            "FILL": fill,
            // "wght": font.weight,
            // "GRAD": 0,
            "opsz": iconSize,
        }
    }
}