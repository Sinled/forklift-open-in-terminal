-- ForkLift.app/Contents/Resources/OpenInTerminal.applescript
-- ForkLift
-- Based on script by guivho

-- This script creates a new tab in the current iTerm window.

on splitPath(path)
	-- save delimiters to restore them later
	set _delimiters to AppleScript's text item delimiters
	set AppleScript's text item delimiters to "/"
	set _array to every text item of path
	set AppleScript's text item delimiters to _delimiters
	return _array
end splitPath

tell application "iTerm"
	activate
	-- split the specified path into its components
	set _array to my splitPath("_forklift_path_placeholder_")
	-- uncomment next line if you want to use the last component as tab name
	-- set _child to the last item of _array
	-- and then comment the next three lines
	set _nr to the count of _array
	set _lastButOne to _nr - 1
	set _child to the item _lastButOne of _array

	select first window

	tell current window
		set newTab to (create tab with default profile)
	end tell

	tell current session of first window
		-- name to the trailing component of the parent directory
		set name to _child
		write text "cd _forklift_path_placeholder_"
	end tell
end tell
