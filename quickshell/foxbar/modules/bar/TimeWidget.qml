import QtQuick
import Quickshell

import qs.modules.common
import qs.services

Rectangle {
    id: timeWidget

    implicitHeight: Metrics.bar.height
    implicitWidth: timeText.implicitWidth + Metrics.bar.margins
    radius: height / 2
    color: Theme.colors.surface

    BarText {
        id: timeText

        anchors {
            horizontalCenter: parent.horizontalCenter
            verticalCenter: parent.verticalCenter
        }

        text: DateTime.longTime + "  •  " + DateTime.shortDate                
    }
}