/*
 * AppletConsole.java
 *
 * Copyright (c) 1997 Sun Microsystems, Inc.
 *
 *   This file implements the Appletconsole class.
 *
 * See the file "license.terms" for information on usage and
 * redistribution of this file, and for a DISCLAIMER OF ALL
 * WARRANTIES.
 * 
 * RCS: @(#) $Id: AppletConsole.java,v 1.3 2000/06/04 03:36:52 mo Exp $
 */

import java.awt.*;
import java.awt.event.*;
import tcl.lang.*;

// The AppletConsole object is essentially a thread and a text box.
// This thread allows the user to alternate between interacting with other 
// features of the applet and the embedded tcl console.

public class AppletConsole extends Thread {
    Interp interp;
    StringBuffer sbuf = new StringBuffer();
    TextArea text;
    Pyramid pyramid;
    boolean complete;

    public AppletConsole(int rows, int columns, Pyramid p) {
	setName("AppletConsole thread");
	pyramid = p;

	StringBuffer sbuf = new StringBuffer();
	
	// Create a text box and capture the key and mouse events via
	// the ConsoleKeyListener and ConsoleMouseListener interfaces.

	text = new TextArea(rows, columns);
	p.add(text);
	text.addKeyListener(new ConsoleKeyListener(this));
	text.addMouseListener(new ConsoleMouseListener());

	// The console thread runs as a daemon so that it gets terminated 
	// automatically when all other user threads are terminated.

	setDaemon(true);
    }

    // These next two methods can not be synchronized or we could
    // deadlock during the event callback inside processCommand().

    protected void putLine(String s) {
	text.insert(s + "\n", 100000);
    }

    protected void put(String s) {
	text.insert(s, 100000);
    }

    // The AppletConsole thread loops while processing events from
    // the Tcl event queue. This method can not be synchronized
    // otherwise we would deadlock when processCommand() is called.

    public void run() {

	// Create the new interp in the new thread! It is critical
	// that the interp even loop must be run in the thread
	// where the interp was created.
	interp = new Interp();
	
	// Add a couple of Tcl commands to this new Interp
	interp.createCommand("build", new BuildCmd(pyramid));
	interp.createCommand("remove", new RemoveCmd(pyramid));

	putLine("\n  This widget is a tcl console with two added commands,");
	putLine("  \"build\" and \"remove\", by which you can manipulate the");
	putLine("  pyramid below.");
	putLine("\n  To use the console, click your mouse to the right of the");
	putLine("  prompt.");
	put("\n% ");

	Notifier notifier = interp.getNotifier();

	while (true) {
	    // process events until "exit" is called.

	    notifier.doOneEvent(TCL.ALL_EVENTS);
	}
    }

    // The ConsoleKeyListener object tells the console thread that a 
    // line of input is available and run() can proceed. If the
    // command was processed then we return true. If the line
    // was not a complete Tcl command we reutrn false.

    public synchronized boolean processCommand(final String command) {
        // Will be set to true in processEvent() if a complete event
	complete = false;

	// Wrap up an event and send it off to the
	// Interp's event queue. This method is
	// called from an AWT thread but it is
	// thread safe because the Interp's Notifier
	// provides a thread safe way to queue up events.

	TclEvent event = new TclEvent() {
	    public int processEvent(int flags) {
		
		// See if the command is a complete Tcl command
		// If it is not, just return false

		if (! Interp.commandComplete(command)) {
		    return 1;
		} else {
		    TclObject commandObj = TclString.newInstance(command);

		    try {
			commandObj.preserve();
			interp.recordAndEval(commandObj, 0);

			String result = interp.getResult().toString();
			if (result.length() > 0) {
			    putLine(result);
			}
		    } catch (TclException e) {
			int code = e.getCompletionCode();

			switch (code) {
			case TCL.ERROR:
				// This really sucks. The getMessage() call on
				// a TclException will not always return a msg.
				// See TclException for super() problem.
			    putLine(interp.getResult().toString());
			    break;
			case TCL.BREAK:
			    putLine("invoked \"break\" outside of a loop");
			    break;
			case TCL.CONTINUE:
			    putLine("invoked \"continue\" outside of a loop");
			    break;
			default:
			    putLine("command returned bad code: " + code);
			}
		    }
		}

		put("% "); // Prompt for next cmd
		complete = true; // A complete event was processed
		return 1;
	    }
	}; // End of TclEvent inner class

	interp.getNotifier().queueEvent(event, TCL.QUEUE_TAIL);

	// Current thread to wait until the event has been processed.
	event.sync();

	return complete;
    }

}


// This class implements the "build" command in PyramidPackage.

class BuildCmd implements Command {
    
    Pyramid pyr;

    BuildCmd(Pyramid p) {
	pyr = p;
    }

    // This procedure is invoked to process the "build" Tcl command.
    // We simply call the pyramid's buildBlock method.

    public void cmdProc(Interp interp, TclObject argv[])
	    throws TclException {

	if (argv.length != 1) {
	    throw new TclNumArgsException(interp, 1, argv, "");
	}
	if (!pyr.buildBlock()) {
	    throw new TclException(interp, 
		    "error in build:  pyramid is already full");
	}
	return;
    }
}

// This class implements the "remove" command in PyramidPackage.

class RemoveCmd implements Command {
    
    Pyramid pyr;

    RemoveCmd(Pyramid p) {
	pyr = p;
    }

    // This procedure is invoked to process the "remove" Tcl command.
    // We simply call the pyramid's removeBlock method.

    public void cmdProc(Interp interp, TclObject argv[])
	    throws TclException {

	if (argv.length != 1) {
	    throw new TclNumArgsException(interp, 1, argv, "");
	}
	if (!pyr.removeBlock()) {
	    throw new TclException(interp, 
		    "error in remove: pyramid is already empty");
	}
	return;
    }
}
