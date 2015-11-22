-- ForkLift.app/Contents/Resources/OpenInTerminal.applescript
-- ForkLift
-- Created by guivho
-- This script creates a new tab in the current iTerm window.
-- I never use several windows,so it is imperative that the
-- new terminal is launched in that current window. The script
-- will create a first window if none did exist at invocation time.
-- The iTerm app will be launched if it was not running
-- at invocation time.
-- Usually the actve selection rests on a subdirectory name
-- when I launch a terminal. ForkLift passes the name of the
-- subdirectory as path. IMHO this is wrong. It should pass 
-- the current directory of the active pane.
-- In this script I cd to the passed subdirectory, and than I
-- cd to its parent (cd ..). In the rare case where I did need
-- the subdirectory, I can quickly 'cd -' to it.
-- This script also sets the tab name to the last path component
-- of the parent directory, i.e. the trailing path component
-- of the current directory after issuing the 'cd ..' 
-- Function to split the path into its components
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
	-- I only use one single window (terminal)
	-- but we must ensure that such a window does exist
	try
		-- we want to talk to the first window
		set _term to the first terminal
	on error
		-- create a window if there is none yet
		set _term to (make new terminal)
	end try
	-- talk to the first terminal window
	tell _term
		-- launch default shell in a new tab in the same terminal
		launch session "Default Session"
		tell the last session
			-- name to the trailing component of the parent directory
			set name to _child
			-- cd to the specified subdirectory
			write text "cd _forklift_path_placeholder_"
			-- cd to the parent (usually the active pane directory)
			-- write text "cd .."
		end tell
	end tell
end tell
