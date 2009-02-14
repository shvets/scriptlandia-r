# changeDefs.tcl
#
# Copyright (c) 1997 Sun Microsystems, Inc.
#
#   This file contains Tcl code which dynamically changes the
#   definitions of the "build" and "remove" Tcl commands.
#
# See the file "license.terms" for information on usage and
# redistribution of this file, and for a DISCLAIMER OF ALL
# WARRANTIES.
# 
# RCS: @(#) $Id: changeDefs.tcl,v 1.1.1.1 1998/10/14 21:09:23 cvsadmin Exp $

rename build buildOld

rename remove removeOld

# build --
#
#   From now on, "build" adds two blocks instead of one.
#   Notice that the build button retains the old behavior.

proc build {} {

    buildOld
    buildOld
}

# remove --
#
#   From now on, "remove" removes two blocks instead of one.
#   Notice that the remove button reflects this new behavior.

proc remove {} {

    removeOld
    removeOld
}
