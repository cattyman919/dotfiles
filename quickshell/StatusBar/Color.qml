pragma Singleton
import QtQuick
import Quickshell

Singleton {
    // ==========================================
    // 1. CATPPUCCIN MOCHA PALETTE
    // ==========================================
    // ==========================================
    // 2. SEMANTIC ASSIGNMENTS (How you use them)
    // ==========================================
    // For hovered buttons/widgets
    // Low battery, errors

    id: root

    // Backgrounds (Darkest to Lightest)
    property color crust: "#11111b"
    property color mantle: "#181825"
    property color base: "#1e1e2e"
    property color surface0: "#313244"
    property color surface1: "#45475a"
    property color surface2: "#585b70"
    // Text & Overlays
    property color overlay0: "#6c7086"
    property color overlay1: "#7f849c"
    property color overlay2: "#9399b2"
    property color subtext0: "#a6adc8"
    property color subtext1: "#bac2de"
    property color textMain: "#cdd6f4"
    // Accents
    property color rosewater: "#f5e0dc"
    property color flamingo: "#f2cdcd"
    property color pink: "#f5c2e7"
    property color mauve: "#cba6f7"
    property color red: "#f38ba8"
    property color maroon: "#eba0ac"
    property color peach: "#fab387"
    property color yellow: "#f9e2af"
    property color green: "#a6e3a1"
    property color teal: "#94e2d5"
    property color sky: "#89dceb"
    property color sapphire: "#74c7ec"
    property color blue: "#89b4fa"
    property color lavender: "#b4befe"
    // Core structural colors
    property color bgBase: base
    // Main bar background
    property color bgPanel: surface0
    // Widget backgrounds
    property color bgHover: surface1
    // Typography
    property color textPrimary: textMain
    property color textMuted: subtext0
    // Functional accents
    property color primary: blue
    // Main brand color
    property color secondary: mauve
    // Secondary accents
    property color success: green
    // Good battery, etc.
    property color warning: yellow
    // Medium battery, alerts
    property color danger: red
}
