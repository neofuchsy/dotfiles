import QtQuick
import Quickshell
import Quickshell.Widgets
import Quickshell.Hyprland
import qs.modules.common
import qs.services

Rectangle {
    id: workspaceWidget

    implicitHeight: Metrics.bar.height
    implicitWidth: workspaceContainer.implicitWidth
    radius: height / 2
    color: Theme.colors.surface

    Row {
        id: workspaceContainer

        spacing: Metrics.bar.spacing

        Repeater {
            model: Hyprland.workspaces

            Rectangle {
                id: workspaceItem

                property bool hovered: false
                property bool active: modelData.active
                property bool activeInMonitor: panel.screen.name === modelData.monitor?.name && modelData.active

                implicitHeight: Metrics.bar.height
                implicitWidth: Metrics.bar.height + workspaceAppRow.width
                radius: height / 2
                color: activeInMonitor ?
                    (hovered ? Theme.colors.primaryHover : Theme.colors.secondary) :
                    (hovered ? Theme.colors.surfaceHighest : Theme.colors.surfaceHigh)

                Behavior on color {
                    ColorAnimation { duration: 150 }
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    onClicked: () => {
                        if (!workspaceItem.activeInMonitor) Hyprland.dispatch("workspace " + modelData.id)
                    }
                }

                HoverHandler {
                    onHoveredChanged: workspaceItem.hovered = hovered
                }

                Rectangle {
                    id: workspaceButton
                    implicitHeight: Metrics.bar.height
                    implicitWidth: Metrics.bar.height
                    radius: height / 2
                    color: workspaceItem.active ?
                        (workspaceItem.hovered ? Theme.colors.primaryHover : Theme.colors.primary) :
                        Theme.colors.surfaceHighest

                    Behavior on color {
                        ColorAnimation { duration: 150 }
                    }

                    BarText {
                        text: modelData.id
                        anchors.centerIn: parent
                        color: workspaceItem.activeInMonitor ? Theme.colors.primaryForeground : Theme.colors.surfaceForeground
                    }
                }

                Rectangle {
                    anchors {
                        left: parent.left
                        leftMargin: Metrics.bar.height
                    }

                    Row {
                        id: workspaceAppRow

                        Repeater {
                            model: Workspaces.workspaceClients[modelData.id]

                            Rectangle {
                                id: clientContainer

                                implicitHeight: Metrics.bar.height
                                implicitWidth: Metrics.bar.height
                                radius: implicitHeight / 2
                                color: "transparent"

                                Behavior on color {
                                    ColorAnimation { duration: 150 }
                                }

                                IconImage {
                                    property var iconSrc: AppIcons.getIcon(modelData.class)
                                    property var appIcon: Quickshell.iconPath(iconSrc, "image-missing")
                                    visible: !!iconSrc
                                    source: appIcon
                                    implicitSize: Metrics.bar.appIconSize
                                    
                                    anchors.centerIn: parent
                                }

                                MouseArea {
                                    anchors.fill: parent
                                    hoverEnabled: true

                                    onClicked: () => {
                                        Hyprland.dispatch(`focuswindow address:${modelData.address}`)
                                    }

                                    onEntered: () => {
                                        clientContainer.color = Theme.colors.hoverOverlay
                                    }

                                    onExited: () => {
                                        clientContainer.color = "transparent"
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}