import QtQuick
import Quickshell
import Quickshell.Services.Pipewire

pragma Singleton

Singleton {
    id: sound

    property string currentOutput: Pipewire.defaultAudioSink?.name ?? ""
    property string currentInput: Pipewire.defaultAudioSource?.name ?? ""

    property int timerTicks: 0

    signal ready(state: bool);

    function init() {
        if (Pipewire.ready) {
            ready(true);
        } else {
            ready(false);
            readyPollTimer.running = true
        }
    }

    function setOutput(name, callback) {
        if (!Pipewire.ready) {
            if (callback) callback({ success: false, error: 'Pipewire not ready' });
            return;
        }

        const nodes = Pipewire.nodes?.values ?? [];
        const prefferedNode = nodes.find(n => n.name === name);
        if (prefferedNode) {
            Pipewire.preferredDefaultAudioSink = prefferedNode;
        }
        if (callback) callback({ success: !!prefferedNode });
    }

    function setInput(name, callback) {
        if (!Pipewire.ready) {
            if (callback) callback({ success: false, error: 'Pipewire not ready' });
            return;
        }

        const nodes = Pipewire.nodes?.values ?? [];
        const prefferedNode = nodes.find(n => n.name === name);
        if (prefferedNode) {
            Pipewire.preferredDefaultAudioSource = prefferedNode;
        }

        if (callback) callback({ success: !!prefferedNode });
    }

    function getDevices(callback) {
        if (!Pipewire.ready) {
            if (callback) callback({ success: false, error: 'Pipewire not ready' });
            return;
        }
        
        const nodes = Pipewire.nodes?.values ?? [];

        const outputs = [];
        const inputs = [];

        for (let node of nodes) {
            if (!node.audio || node.isStream) continue;
            if (node.isSink) {
                outputs.push({
                    name: node.name,
                    description: node.description,
                });
            } else {
                inputs.push({
                    name: node.name,
                    description: node.description,
                });
            }
        }

        if (callback) callback({ success: true, outputs, inputs });
    }

    Timer {
        id: readyPollTimer

        running: false;
        repeat: true;
        interval: 500;

        onTriggered: () => {
            sound.timerTicks++;
            if (Pipewire.ready) {
                readyPollTimer.running = false;
                sound.ready(true);
                sound.timerTicks = 0
            }
            if (sound.timerTicks >= 10) {
                readyPollTimer.running = false;
            }
        }
    }

    Component.onCompleted: init()
}