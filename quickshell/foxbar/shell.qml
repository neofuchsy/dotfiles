import QtQuick
import Quickshell
import qs.modules.bar

ShellRoot {
    id: root

    Loader {
        active: true
        sourceComponent: Bar {}
    }
}
