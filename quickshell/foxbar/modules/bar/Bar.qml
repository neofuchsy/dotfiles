import QtQuick
import Quickshell
import qs.modules.common
import qs.modules.bar.panels
import qs.services

Variants {
    model: Quickshell.screens;

    PanelWindow {
        id: panel
        required property var modelData

        screen: modelData

        color: "transparent"

        anchors {
            top: true
            left: true
            right: true
        }

        implicitHeight: Metrics.bar.totalHeight

        Rectangle {
            id: bar
            color: "transparent"
            
            anchors {
                fill: parent
                leftMargin: Metrics.bar.margins
                rightMargin: Metrics.bar.margins
            }

            WorkspaceWidget {
                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                }
            }

            TimeWidget {
                anchors {
                    horizontalCenter: parent.horizontalCenter
                    verticalCenter: parent.verticalCenter
                }
            }

            SystemControlsWidget {
                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }
            }
        }

        Loader {
            active: BarContext.openPanels[panel.screen.name] === "sound"

            sourceComponent: SoundPanel { }
        }
    }

}
