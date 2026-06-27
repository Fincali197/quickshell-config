pragma Singleton

import Quickshell.Io
import Quickshell
import QtQuick

Singleton {
    id: root
    // an expression can be broken across multiple lines using {}
    property real memoryTotal: 1
    property real memoryFree: 0
    property real memoryUsage: 0
    property real cpuUsage: 0
    property real cpuMaxFreq: Number(fileCpuFreqMax.text()) ?? 0
    property real cpuFreq: 0

    property var previousCpuStats: null

    FileView {
        id: fileMemInfo
        path: "/proc/meminfo"
    }
    FileView {
        id: fileStat
        path: "/proc/stat"
    }
    FileView {
        id: fileCpuFreqLive
        path: "/sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq"
    }
    FileView {
        id: fileCpuFreqMax
        path: "/sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq"
    }

    Timer {
        interval: 1000
        running: true
        repeat: true

        onTriggered: {
            fileMemInfo.reload();
            fileStat.reload();
            fileCpuFreqLive.reload();

            const textMemInfo = fileMemInfo.text();
            memoryTotal = Number(textMemInfo.match(/MemTotal: *(\d+)/)?.[1] ?? 1);
            memoryFree = Number(textMemInfo.match(/MemAvailable: *(\d+)/)?.[1] ?? 0);
            memoryUsage = 1 - memoryFree / memoryTotal;

            const textCpuFreqLive = fileCpuFreqLive.text();
            cpuFreq = Number(textCpuFreqLive);

            const textStat = fileStat.text();
            const cpuLine = textStat.match(/^cpu\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)\s+(\d+)/);
            if (cpuLine) {
                const stats = cpuLine.slice(1).map(Number);
                const total = stats.reduce((a, b) => a + b, 0);
                const idle = stats[3];

                if (previousCpuStats) {
                    const totalDiff = total - previousCpuStats.total;
                    const idleDiff = idle - previousCpuStats.idle;
                    cpuUsage = totalDiff > 0 ? (1 - idleDiff / totalDiff) : 0;
                }

                previousCpuStats = {
                    total,
                    idle
                };
            }
        }
    }
}
