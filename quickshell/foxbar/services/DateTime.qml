import QtQuick
import Quickshell

pragma Singleton

Singleton {
    id: dateTime
    property string longTime: ""
    property string shortDate: ""

    function refreshDate() {
        const date = new Date()
        longTime = Qt.formatTime(date, "hh:mm:ss")
        shortDate = Qt.formatDate(date, "MMM dd")
    }

    Timer {
        interval: 1000
        running: true
        repeat: true

        onTriggered: dateTime.refreshDate()
    }

    Component.onCompleted: refreshDate()                  
}