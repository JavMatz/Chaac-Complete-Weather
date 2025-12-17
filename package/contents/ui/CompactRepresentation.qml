import QtQuick 2.15
import QtQuick.Layouts
import QtQuick.Controls 2.15
import org.kde.plasma.plasmoid
import org.kde.kirigami as Kirigami
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.components 3.0 as PlasmaComponents3
import org.kde.plasma.plasma5support as Plasma5Support
import "components" as Components

Item {
    id: compactRep

    readonly property bool isVertical: Plasmoid.formFactor === PlasmaCore.Types.Vertical
    property string undefanchors: activeweathershottext ? undefined : parent.verticalCenter
    property bool textweather: Plasmoid.configuration.textweather
    property bool activeweathershottext: heightH > 36
    property int heightH: root.height
    property var widthWidget: activeweathershottext ? temperature.implicitWidth : temperature.implicitWidth + wrapper_weathertext.width
    property var widthReal: isVertical ? root.width : horizontalView.implicitWidth
    property var hVerti: verticalView.implicitHeight
    property var heightReal: isVertical ? hVerti : root.height

    Components.WeatherData {
        id: weatherData
    }
    MouseArea {
        id: compactMouseArea
        anchors.fill: parent

        hoverEnabled: true

        onClicked: root.expanded = !root.expanded
    }
    RowLayout {
        id: horizontalView
        visible: !isVertical

        Kirigami.Icon {
            id: horizontalWeatherIcon
            source: weatherData.iconWeatherCurrent
            Layout.alignment: Qt.AlignBaseline
        }

        ColumnLayout {
            id: columntemandweathertext

            RowLayout {
                id: temperature

                Label {
                    id: tempValue
                    text: weatherData.temperaturaActual
                    color: PlasmaCore.Theme.textColor
                }
                Label {
                    id: tempUnit
                    text: (root.temperatureUnit === "0") ? " °C" : " °F"
                    color: PlasmaCore.Theme.textColor
                }
            }

            Label {
                id: shortWeatherStatus
                text: weatherData.weatherShottext
                font.bold: true
                visible: activeweathershottext & textweather
            }
        }
    }
    ColumnLayout {
        id: verticalView
        visible: isVertical
        Kirigami.Icon {
            id: verticalWeatherIcon
            source: weatherData.iconWeatherCurrent
        }
        RowLayout {
            id: verticalTemperature

            Label {
                id: verticalTempValue
                text: weatherData.temperaturaActual
                color: PlasmaCore.Theme.textColor
            }

            Label {
                id: verticalTempUnit
                text: (root.temperatureUnit === "0") ? " °C" : " °F"
                color: PlasmaCore.Theme.textColor
            }
        }
    }

}
