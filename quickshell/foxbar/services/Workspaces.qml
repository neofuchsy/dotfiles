import QtQuick
import Quickshell
import Quickshell.Io
import Quickshell.Hyprland

pragma Singleton

Singleton {
    id: hyprland

    property var workspaceClients: ({})

    Process {
        id: getClients
        running: true
        command: ["hyprctl", "-j", "clients"]

        stdout: StdioCollector {
            id: clientsCollector
            onStreamFinished: {
                const updatedWorkspaceClients = {};
                const clients = JSON.parse(clientsCollector.text);
                const visibleClients = clients.filter(x => x.hidden === false);

                for (const client of visibleClients) {
                    client.area = (client.size?.[0] ?? 1) * (client.size?.[1] ?? 1)
                    if (!updatedWorkspaceClients[client.workspace.id]) {
                        updatedWorkspaceClients[client.workspace.id] = [];
                    }
                    updatedWorkspaceClients[client.workspace.id] = [
                        ...updatedWorkspaceClients[client.workspace.id],
                        client
                    ];
                }

                workspaceClients = updatedWorkspaceClients;
            }
        }
    }

    Connections {
        target: Hyprland
        function onRawEvent(event) {
            getClients.running = true
        }
    }
}