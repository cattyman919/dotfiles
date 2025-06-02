// Modify this file to change what commands output to your statusbar, and
// recompile using the make command.
static const Block blocks[] = {
    /*Icon*/ /*Command*/ /*Update Interval*/ /*Update Signal*/
    {"", "/home/senohebat/suckless/dwmblocks/scripts/sb-audio-icon.sh", 5, 10},
    {"", "/home/senohebat/suckless/dwmblocks/scripts/sb-volume.sh", 1, 0},
    {"", "/home/senohebat/suckless/dwmblocks/scripts/sb-battery.sh",           1,                     12},
    {"", "/home/senohebat/suckless/dwmblocks/scripts/sb-battery-status.sh",    1,                     13},
    {"", "/home/senohebat/suckless/dwmblocks/scripts/sb-cpu.sh",               1,                      14},
    {"", "/home/senohebat/suckless/dwmblocks/scripts/sb-ram.sh",               1,                     15},
    {"", "/home/senohebat/suckless/dwmblocks/scripts/sb-wifi.sh",              1,                     16},
    {"", "/home/senohebat/suckless/dwmblocks/scripts/sb-date.sh",              60,                     17}, // Updates once a minute, changes reflect at the turn of the minute
    {"", "/home/senohebat/suckless/dwmblocks/scripts/sb-time.sh",              1,                      18}, // Updates every 5 seconds for H:M
};

// sets delimiter between status commands. NULL character ('\0') means no
// delimiter.
static char delim[] = " | ";
static unsigned int delimLen = 3;
