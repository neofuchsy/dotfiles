import QtQuick
import Quickshell
import Quickshell.Io 
import Quickshell.Hyprland

pragma Singleton

Singleton {
    id: keyboardLayout

    property list<string> layoutCodes: []
    property string currentLayoutCode: ""
    property string displayLayoutName: ""
    property string nextLayoutCode: ""
    property bool needsLayoutRefresh: true

    function mapDisplayLayout(code): string {
        switch (code) {
            case 'us':
                return 'en';
            default:
                return code;
        }
    }

    function mapLayoutCode(fullName): string {
        switch (fullName) {
            case 'Lithuanian':
                return 'lt';
            case 'English (US)':
                return 'us';
        }
    }

    function cycleLayout() {
        if (layoutCodes.length <= 1) return;
        const index = layoutCodes.indexOf(currentLayoutCode);
        if (index == -1) keyboardLayout.nextLayoutCode = "next";
        else keyboardLayout.nextLayoutCode = index + 1 === layoutCodes.length ? 0 : index + 1;
        switchLayout.running = true
    }

    Process {
        id: switchLayout
        running: false
        command: ["hyprctl", "switchxkblayout", "all", keyboardLayout.nextLayoutCode]
    }

    Process {
        id: fetchLayoutsProc
        running: true
        command: ["hyprctl", "-j", "devices"]

        stdout: StdioCollector {
            id: devicesCollector
            onStreamFinished: {
                const parsedOutput = JSON.parse(devicesCollector.text);
                const hyprlandKeyboard = parsedOutput["keyboards"].find(kb => kb.main === true);
                keyboardLayout.layoutCodes = hyprlandKeyboard["layout"].split(",");
                keyboardLayout.currentLayoutCode = mapLayoutCode(hyprlandKeyboard["active_keymap"]);
                keyboardLayout.displayLayoutName = mapDisplayLayout(keyboardLayout.currentLayoutCode);
            }
        }
    }

    Connections {
        target: Hyprland
        function onRawEvent(event) {
            if (event.name === "activelayout") {
                if (keyboardLayout.needsLayoutRefresh) {
                    keyboardLayout.needsLayoutRefresh = false;
                    fetchLayoutsProc.running = true;
                }

                // If there's only one layout, the updated layout is always the same
                if (keyboardLayout.layoutCodes.length <= 1) return;

                // Update when layout might have changed
                const dataString = event.data;
                keyboardLayout.currentLayoutCode = mapLayoutCode(dataString.split(",")[1]);
                keyboardLayout.displayLayoutName = mapDisplayLayout(keyboardLayout.currentLayoutCode);
            } else if (event.name == "configreloaded") {
                // Mark layout code list to be updated when config is reloaded
                keyboardLayout.needsLayoutRefresh = true;
            }
        }
    }
}