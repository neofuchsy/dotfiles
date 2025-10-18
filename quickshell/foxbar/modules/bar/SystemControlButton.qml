import QtQuick
import Quickshell

import qs.modules.common
import qs.components

Rectangle {
    id: systemButton
    property string iconName: ""
    property var onClickHandler

    implicitHeight: Metrics.bar.height
    implicitWidth: 32
    radius: implicitHeight / 2
    color: "transparent"

    Behavior on color {
        ColorAnimation { duration: 150 }
    }

    MouseArea {
        anchors.fill: parent
        hoverEnabled: true

        MaterialSymbol {
            anchors.centerIn: parent
            
            color: Theme.colors.surfaceForeground
            text: systemButton.iconName
            iconSize: 20
        }

        onClicked: systemButton.onClickHandler()

        onEntered: () => {
            systemButton.color = Theme.colors.hoverOverlay
        }

        onExited: () => {
            systemButton.color = "transparent"
        }
    }
}