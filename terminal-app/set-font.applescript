-- Sets JetBrainsMono Nerd Font on every Terminal.app profile.
-- Run with: osascript ~/dots/terminal-app/set-font.applescript

tell application "Terminal"
    set theFont to "JetBrainsMonoNF-Regular"
    set theSize to 14
    repeat with s in settings sets
        try
            set font name of s to theFont
            set font size of s to theSize
        end try
    end repeat
end tell
