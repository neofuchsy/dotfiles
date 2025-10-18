import QtQuick
import Quickshell
import Quickshell.Io 
import Quickshell.Services.UPower

pragma Singleton

Singleton {
    id: battery

    property bool charging: UPower.displayDevice.state == UPowerDeviceState.Charging
    property bool fullyCharged: UPower.displayDevice.state == UPowerDeviceState.FullyCharge
    property bool pluggedIn: charging || UPower.displayDevice.state == UPowerDeviceState.PendingCharge
    property real percentage: UPower.displayDevice?.percentage ?? 1

    property real timeToEmpty: UPower.displayDevice.timeToEmpty
    property real timeToFull: UPower.displayDevice.timeToFull
}