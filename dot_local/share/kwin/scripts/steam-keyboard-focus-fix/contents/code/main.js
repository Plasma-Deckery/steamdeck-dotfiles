// Steam Keyboard Focus Fix
// Restores focus to the previously active window when the Steam on-screen
// keyboard appears. Matches on locale-independent properties only:
// resourceClass "steam", resourceName "steamwebhelper", skipTaskbar true,
// and window type Utility (8) — avoids matching the main Steam window.

var previousWindow = null;

function isSteamKeyboard(window) {
    return window &&
           window.resourceClass === "steam" &&
           window.resourceName === "steamwebhelper" &&
           window.skipTaskbar &&
           window.windowType === 8;
}

workspace.windowActivated.connect(function(window) {
    if (!window) return;

    if (isSteamKeyboard(window)) {
        if (previousWindow) {
            workspace.activeWindow = previousWindow;
        }
    } else {
        previousWindow = window;
    }
});
