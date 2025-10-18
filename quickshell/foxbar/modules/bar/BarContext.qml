import QtQuick
import Quickshell

pragma Singleton

Singleton {
    id: barContext

    property var soundPanelOpen: false
    property var openPanels: ({})

    function triggerPanel(monitor: string, panel: string) {
        if (openPanels[monitor] === panel) {
            openPanels[monitor] = undefined;
        } else {
            const activeMonitors = Object.keys(openPanels);
            for (let m of activeMonitors) {
                if (openPanels[m] === panel) {
                    openPanels[m] = undefined;
                }
            }
            openPanels[monitor] = panel;
        }

        openPanels = Object.assign({}, openPanels);
    }
}