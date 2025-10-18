import QtQuick
import QtQuick.Layouts
import Quickshell

import qs.modules.common
import qs.modules.bar
import qs.components
import qs.services

pragma ComponentBehavior: Bound

PopupWindow {
    id: soundPanel

    property bool soundLoaded: false
    property var outputs: []
    property var inputs: []

    anchor {
        window: panel
        rect.x: parentWindow.width - width - Metrics.bar.margins
        rect.y: Metrics.bar.totalHeight
    }

    implicitHeight: 500
    implicitWidth: 400
    visible: true
    color: "transparent"

    Rectangle {
        anchors.fill: parent
        color: Theme.colors.surface
        radius: Metrics.panel.radius

        Loader {
            anchors.fill: parent
            active: soundPanel.soundLoaded

            sourceComponent: Column {
                anchors {
                    fill: parent
                    margins: Metrics.panel.padding
                }

                DeviceControl {
                    type: "output"
                    currentDevice: Sound.currentOutput
                    availableDevices: soundPanel.outputs
                    onDeviceUpdate: (device) => {
                        Sound.setOutput(device);
                    }
                }

                DeviceControl {
                    type: "input"
                    currentDevice: Sound.currentInput
                    availableDevices: soundPanel.inputs
                    onDeviceUpdate: (device) => {
                        Sound.setInput(device);
                    }
                }
            }
        }
    }

    function getDevices() {
        Sound.getDevices((data) => {
            if (!data.success) {
                outputs = [];
                inputs = [];
            } else {
                outputs = data.outputs;
                inputs = data.inputs;
                soundLoaded = true;
            }
        })
    }

    Connections {
        target: Sound

        function onReady(state) {
            if (state) soundPanel.getDevices();
        }
    }

    Component.onCompleted: Sound.init();
}