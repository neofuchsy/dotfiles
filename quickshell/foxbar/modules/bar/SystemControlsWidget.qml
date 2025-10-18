import QtQuick
import Quickshell

import qs.modules.common
import qs.services

Rectangle {
    id: systemControls

    implicitHeight: Metrics.bar.height
    implicitWidth: controlsContainer.implicitWidth + languageSelector.implicitWidth - 6 // Remove the overlap from total width
    radius: height / 2
    color: Theme.colors.surfaceHigh

    Rectangle {
        id: languageSelector
        implicitHeight: Metrics.bar.height
        implicitWidth: 40
        topLeftRadius: implicitHeight / 2
        bottomLeftRadius: implicitHeight / 2
        color: "transparent"

        Behavior on color {
            ColorAnimation { duration: 150 }
        }

        MouseArea {
            anchors.fill: parent
            hoverEnabled: true

            BarText {
                anchors.centerIn: parent
                text: KeyboardLayout.displayLayoutName
            }

            onClicked: () => {
                KeyboardLayout.cycleLayout()
            }

            onEntered: () => {
                languageSelector.color = Theme.colors.hoverOverlay
            }

            onExited: () => {
                languageSelector.color = "transparent"
            }
        }
    }

    Rectangle {
        id: controlsContainer
        implicitHeight: Metrics.bar.height
        implicitWidth: controlsRow.implicitWidth
        radius: implicitHeight / 2
        color: Theme.colors.surface

        anchors {
            left: parent.left
            leftMargin: languageSelector.width - 6
        }


        Row {
            id: controlsRow

            SystemTrayWidget { }
            
            SystemControlButton {
                iconName: "volume_up"
                onClickHandler: () => {
                    BarContext.triggerPanel(panel.screen.name, "sound")
                }
            }
            
            SystemControlButton {
                iconName: "bluetooth"
            }

            BatterySystemButton {
            }

            SystemControlButton {
                iconName: "drag_indicator"
            }
        }
    }
}