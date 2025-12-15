import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.11
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.kirigami 2.4 as Kirigami
import org.kde.plasma.components 3.0 as PlasmaComponents3

Kirigami.FormLayout {
    id: configRoot
    wideMode: true

    QtObject {
        id: unidWeatherValue
        property var value
    }

    ButtonGroup {
        id: locationModeGroup
    }

    ButtonGroup {
        id: temperatureUnitGroup
    }

    signal configurationChanged

    property alias cfg_temperatureUnit: unidWeatherValue.value
    property alias cfg_latitudeC: latitude.text
    property alias cfg_longitudeC: longitude.text
    property alias cfg_useAutomaticLocation: useAutomaticLocation.checked
    property alias cfg_textweather: textweather.checked

    PlasmaComponents3.CheckBox {
        id: textweather
        Kirigami.FormData.label: i18n("General: ")
        text: "Display weather conditions text on panel"
    }

    PlasmaComponents3.RadioButton {
        id: useAutomaticLocation
        Kirigami.FormData.label: i18n("Location: ")
        text: i18n("Automatic")
        ButtonGroup.group: locationModeGroup
        ToolTip.visible: hovered
        ToolTip.delay: PlasmaCore.Units.shortDuration
        ToolTip.text: i18n("Location service provided by ip-api.com")
    }

    ColumnLayout {
        id: manualLocationConfiguration
        PlasmaComponents3.RadioButton {
            id: useManualLocation
            text: i18n("Manual")
            ButtonGroup.group: locationModeGroup
        }
        RowLayout {
            ColumnLayout {
                PlasmaComponents3.Label {
                    text: i18n("Latitude")
                }
                PlasmaComponents3.TextField {
                    id: latitude
                    enabled: useManualLocation.checked
                }
            }
            ColumnLayout {
                PlasmaComponents3.Label {
                    text: i18n("Longitude")
                }
                PlasmaComponents3.TextField {
                    id: longitude
                    enabled: useManualLocation.checked
                }
            }
        }
    }

    PlasmaComponents3.RadioButton {
        id: useSystemLocale
        Kirigami.FormData.label: i18n("Temp units: ")
        text: i18n("Use system's locale")
        ButtonGroup.group: temperatureUnitGroup
    }

    ColumnLayout {
        PlasmaComponents3.RadioButton {
            id: useManualTempUnit
            text: i18n("Set temp unit manually")
            ButtonGroup.group: temperatureUnitGroup
        }
        PlasmaComponents3.Label {
            text: i18n("Temperature unit:")
        }
        ComboBox {
            id: positionComboBox
            textRole: "text"
            valueRole: "value"
            enabled: useManualTempUnit.checked
            model: [
                {
                    text: i18n("Celsius (°C)"),
                    value: 0
                },
                {
                    text: i18n("Fahrenheit (°F)"),
                    value: 1
                },
            ]
            onActivated: unidWeatherValue.value = currentValue
            Component.onCompleted: currentIndex = indexOfValue(unidWeatherValue.value)
        }
    }
}
