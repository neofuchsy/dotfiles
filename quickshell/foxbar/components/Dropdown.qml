import QtQuick
import QtQuick.Controls
import Quickshell

import qs.modules.common

Rectangle {
    id: dropdown
    property string initialValue: ""
    property var temporaryInitialValue: ""
    property var options: []
    property int currentIndex: 0

    signal valueChanged(value: string)

    ListModel { id: comboModel }

    color: "transparent"
    implicitHeight: Metrics.component.height

    ComboBox {
        id: control

        anchors {
            left: parent.left
            right: parent.right
        }

        textRole: "name"
        valueRole: "value"
        model: comboModel

        onCurrentValueChanged: {
            if (dropdown.temporaryInitialValue === control.currentValue) {
                dropdown.temporaryInitialValue = -1
                return;
            }
            dropdown.valueChanged(control.currentValue)
        }

        contentItem: Text {
            text: control.displayText
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignLeft
            leftPadding: Metrics.component.innerPadding
            font.family: Theme.typography.component.family
            font.pixelSize: Theme.typography.component.size
            font.weight: Theme.typography.component.weight
            color: Theme.colors.surfaceForeground
            elide: Text.ElideRight
            clip: true
        }

        indicator: Item {
            width: 24
            height: 24
            anchors {
                right: parent.right
                verticalCenter: parent.verticalCenter
                rightMargin: 4
            }    

            MaterialSymbol {
                anchors.centerIn: parent
                text: "arrow_drop_down"
                color: Theme.colors.surfaceForeground
                iconSize: Metrics.component.iconSize
            }
        }

        background: Rectangle {
            implicitHeight: Metrics.component.height
            radius: Metrics.component.radius
            color: control.hovered ? Theme.colors.surfaceHighest : Theme.colors.surfaceHigh
        }

        popup: Popup {
            y: control.height
            width: control.width
            padding: 1

            contentItem: ListView {
                id: listView
                clip: true
                implicitHeight: contentHeight
                model: control.delegateModel
                currentIndex: control.highlightedIndex

                delegate: ItemDelegate {
                    required property var model
                    width: listView.width
                    leftPadding: Metrics.component.innerPadding
                    text: model.name
                    highlighted: ListView.isCurrentItem
                    palette.text: Theme.colors.surfaceForeground
                    palette.highlightedText: Theme.colors.surfaceForeground
                    font.family: Theme.typography.component.family
                    font.pixelSize: Theme.typography.component.size
                    font.weight: Theme.typography.component.weight

                    background: Rectangle {
                        color: highlighted ? Theme.colors.hoverOverlay : "transparent"
                        // color: Theme.colors.surfaceHigh
                    }
                }

                highlight: Rectangle {
                    color: Theme.colors.hoverOverlay;
                    radius: Metrics.component.radius
                }

                ScrollIndicator.vertical: ScrollIndicator { }
            }

            background: Rectangle {
                color: Theme.colors.surfaceHighest
                radius: Metrics.component.radius
            }
        }
    }

    Component.onCompleted: {
        temporaryInitialValue = initialValue;
        comboModel.clear()
        let index = -1;
        for (let i = 0; i < options.length; i++) {
            comboModel.append(options[i]);
            if (options[i].value === initialValue) index = i;
        }
        control.currentIndex = index;
    }
}