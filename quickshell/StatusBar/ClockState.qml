import QtQuick
import Quickshell
pragma Singleton

Singleton {
    id: root

    readonly property string time: {
        Qt.formatDateTime(clock.date, "HH:mm:ss | d MMM yyyy");
    }

    SystemClock {
        id: clock

        precision: SystemClock.Seconds
    }

}
