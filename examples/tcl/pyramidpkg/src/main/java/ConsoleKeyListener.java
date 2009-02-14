/*
 * ConsoleKeyListener.java
 *
 * Copyright (c) 1997 Sun Microsystems, Inc.
 *
 *   This class implements the ConsoleKeyListener class.
 *
 * See the file "license.terms" for information on usage and
 * redistribution of this file, and for a DISCLAIMER OF ALL
 * WARRANTIES.
 * 
 * RCS: @(#) $Id: ConsoleKeyListener.java,v 1.2 2000/06/04 03:36:52 mo Exp $
 */

import java.awt.*;
import java.awt.event.*;

/*
 * The KeyListener object intercepts user keyboard inputs.
 * It stores the user's input in a buffer.
 * When the user presses return, the buffer is sent to the
 * AppletConsole object, which evaluates the user's input
 * in the main Tcl interpreter.
 */

public class ConsoleKeyListener implements KeyListener {
    public static final int DELETE = 177;
    public static final int BACK_SPACE = 8;
    private StringBuffer sbuf;
    AppletConsole console;

    public ConsoleKeyListener(AppletConsole c) {
	sbuf = new StringBuffer();
	console = c;
    }

    public void keyPressed(KeyEvent evt) {
    }

    public void keyReleased(KeyEvent evt) {
    }

    public void keyTyped(KeyEvent evt) {
 	char key = evt.getKeyChar();
	
	if ((key == '\r') || (key == '\n')) {
	    // Enter and return notify the console that there is a new
	    // line to process. If this line was a complete Tcl command
	    // then we can empty our cmd buffer.
	
	    sbuf.append(key);
	    if (console.processCommand(sbuf.toString())) {
		sbuf.setLength(0);
	    }
	} else if (((int) key == BACK_SPACE) || ((int) key ==  DELETE)) {
	    // Delete and backspace erase the last character from both
	    // the screen and the buffer.

	    int len = sbuf.length();
	    if (len > 0) {
		sbuf.setLength(len-1);
	    }
	} else {
	    // All other keys are appended to the buffer.

	    sbuf.append(key);
	}
    }
}

