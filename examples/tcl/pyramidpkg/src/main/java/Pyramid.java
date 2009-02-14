/*
 * Pyramid.java
 *
 * Copyright (c) 1997 Sun Microsystems, Inc.
 *
 *   This file implements the Pyramid class.
 *
 * See the file "license.terms" for information on usage and
 * redistribution of this file, and for a DISCLAIMER OF ALL
 * WARRANTIES.
 * 
 * RCS: @(#) $Id: Pyramid.java,v 1.3 2000/06/04 03:36:52 mo Exp $
 */

import tcl.lang.*;
import java.awt.*;
import java.awt.event.*;
import java.applet.*;

// This class implements an applet with three components:
// 1) a drawing of a partially built pyramid,
// 2) buttons which allow the user to complete or erase the drawing, and
// 3) a console which runs a Jacl interpreter.

public class Pyramid extends Applet {

    public static void main(String args[]) {
    	new Pyramid();
    }

    Button buildButton;
    Button removeButton;
    AppletConsole console;

    public int numBlocks;
    private int maxBlocks;

    // Initialize the applet.

    public void init() {
	numBlocks = 4;
	maxBlocks = 6;

	// Create buttons to manipulate the pyramid.

	buildButton = new Button(" build ");
	removeButton = new Button(" remove ");
	add(buildButton);
	add(removeButton);

	// Create an AppletConsole and add it to the applet.

	console = new AppletConsole(15, 50, this);
	console.start();

	// When the build button is pressed, run "build" cmd

	buildButton.addActionListener(new ActionListener() {
	    public void actionPerformed(ActionEvent event) {
                console.putLine("build");
		console.processCommand("build");
	    }
	});

	// When the remove button is pressed, run the "remove" cmd

	removeButton.addActionListener(new ActionListener() {
	    public void actionPerformed(ActionEvent event) {
                console.putLine("remove");
		console.processCommand("remove");
	    }
	});
    }


    // Update the pyramid as shown in the applet.

    public void paint(Graphics g) {

	int w       = 70;        // width of each block
	int dRow    = w + 30;    // dist btw base of two adjacent rows
	int h       = 35;        // height of each block
	int dColumn = h + 30;    // dist btw left side of two adjacent cols
	int dTop    = 300;       // dist from top of window

	int dLeft   = dRow / 2;  // dist from left side of window
	int tempBlocks = 0;

 	for (int column = 3; column >= 1; column--) { 
 	    for (int row = 1; row <= column; row++) {
		if (tempBlocks >= numBlocks) {
		    g.drawLine((row * dRow) + ((3 - column) * dLeft),  
			    (column * dColumn) + dTop + h, 
			    (row * dRow) + ((3 - column) * dLeft) + w, 
			    (column * dColumn) + dTop + h); 
		} else {
		    g.fillRect((row * dRow) + ((3 - column) * dLeft), 
			    (column * dColumn) + dTop, w, h);
		}
		++tempBlocks;
		g.drawString("" + tempBlocks, 
			(row * dRow) + ((3 - column) * dLeft) + h, 
			(column * dColumn) + dTop + dLeft);
	    }
	}
    }

    // Build 1 block in the pyramid.

    public boolean buildBlock() {
	if (numBlocks >= maxBlocks) {
	    return false;
	}
	++numBlocks;
	repaint();
	return true;
    }

    // Remove 1 block from the pyramid.

    public boolean removeBlock() {
	if (numBlocks == 0) {
	    return false;
	}
	--numBlocks;
	repaint();
	return true;
    }
}



