import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.modules.common
import qs.components
import qs.services

Rectangle {
    id: deviceControl
    property string type: "output"
    property bool isMuted: false
    property string currentDevice: ""
    property var availableDevices: []
    property var onDeviceUpdate

    anchors {
        right: parent.right
        left: parent.left
    }

    implicitHeight: 50
    color: "#0affffff"

    ColumnLayout {
        anchors {
            left: parent.left
            right: parent.right
        }

        RowLayout {
            Layout.fillWidth: true
            spacing: 16

            Rectangle {
                id: deviceIcon

                implicitWidth: Metrics.component.height
                implicitHeight: Metrics.component.height
                radius: implicitHeight / 2
                color: Theme.colors.surfaceHigh

                MaterialSymbol {
                    anchors.centerIn: parent
                    color: Theme.colors.surfaceForeground
                    text: deviceControl.type === "output" ? "volume_up" : "mic"
                    iconSize: Metrics.component.iconSize
                }

                MouseArea {
                    anchors.fill: parent
                    hoverEnabled: true

                    onEntered: () => {
                        deviceIcon.color = Theme.colors.surfaceHighest
                    }

                    onExited: () => {
                        deviceIcon.color = Theme.colors.surfaceHigh
                    }
                }
            }

            Dropdown {
                Layout.fillWidth: true
                initialValue: deviceControl.currentDevice
                options: deviceControl.availableDevices.map(x => ({ name: x.description, value: x.name }));
                onValueChanged: (device) => {
                    if (deviceControl.onDeviceUpdate) {
                        deviceControl.onDeviceUpdate(device);
                    }
                }
            }
        }
    }
}