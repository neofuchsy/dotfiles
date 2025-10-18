import QtQuick
import Quickshell

import qs.modules.common
import qs.components
import qs.services

Rectangle {
    id: batterySystemButton

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
            text: getBatteryIcon(Battery.percentage * 100, Battery.charging, Battery.fullyCharged, Battery.pluggedIn)
            iconSize: 24

            function getBatteryIcon(percentage, isCharging, isFullyCharged, isPlugggedIn) {
                if (isPlugggedIn) return "battery_android_frame_bolt";
                if (percentage < 6) return "battery_android_0";
                if (percentage < 16) return "battery_android_frame_1";
                if (percentage < 30) return "battery_android_frame_2";
                if (percentage < 45) return "battery_android_frame_3";
                if (percentage < 60) return "battery_android_frame_4";
                if (percentage < 75) return "battery_android_frame_5";
                if (percentage < 90) return "battery_android_frame_6";
                if (percentage < 101) return "battery_android_frame_full";

                return "battery_android_frame_question"
            }
        }

        onClicked: () => {
            console.log(Battery.onBattery);
        }

        onEntered: () => {
            batterySystemButton.color = Theme.colors.hoverOverlay
        }

        onExited: () => {
            batterySystemButton.color = "transparent"
        }
    }
}