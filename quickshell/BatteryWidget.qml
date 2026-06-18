import QtQuick

Rectangle {
    // Nerd Fonts
    function getBatteryIcon() : string {
        // Maps percentage -> [Non-Charging Icon, Charging Icon]
        const batteryMap = new Map();
        batteryMap.set(80, ["\udb80\udc82", "\udb80\udc8b"]);
        batteryMap.set(70, ["\udb80\udc81", "\udb80\udc8a"]);
        batteryMap.set(60, ["\udb80\udc80", "\udb82\udc9e"]);
        batteryMap.set(50, ["\udb80\udc7f", "\udb80\udc89"]);
        batteryMap.set(40, ["\udb80\udc7e", "\udb82\udc9d"]);
        batteryMap.set(30, ["\udb80\udc7d", "\udb80\udc88"]);
        batteryMap.set(20, ["\udb80\udc7c", "\udb80\udc87"]);
        batteryMap.set(0, ["\udb80\udc7a", "\udb82\udc9f"]);
        for (let [percentage, value] of batteryMap) {
            if (BatteryState.percentage >= percentage) {
                switch (BatteryState.status) {
                case "Charging":
                    return value[1];
                    break;
                case "Discharging":
                case "Not charging":
                default:
                    return value[0];
                    break;
                }
            }
        }
        return "\udb80\udc7a";
    }

    implicitWidth: batteryText.implicitWidth + Settings.panelWidgetRightLeftPadding
    implicitHeight: Settings.panelWidgetHeight + Settings.panelWidgetTopBottomPadding
    radius: Settings.panelBorderRadius
    color: BatteryState.percentage < 20 ? Color.danger : Color.bgPanel

    Text {
        id: batteryText

        anchors.centerIn: parent
        font.bold: true
        color: Color.primary
        font.pixelSize: Settings.panelFontSize
        text: {
            let batteryIcon = getBatteryIcon();
            return `${batteryIcon} ${BatteryState.percentage}%`;
        }
    }

}
