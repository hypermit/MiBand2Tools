#!/bin/bash
#
# Extract Mi Band 2 data from SQLite DB generated by GadgetBridge app.
#
# Parameter: SQLLite database file
# Output: tab separated output sent to stdout
#
# Tested with GadgetBridge version 0.19.2 (May 2017). The GadgetBridge
# source code GitHub repository is here:
# https://github.com/Freeyourgadget/Gadgetbridge
# but is currently (July 2017) offline due to a DMCA takedown notice.
#
# Source tarball can be downloaded from here:
# https://f-droid.org/packages/nodomain.freeyourgadget.gadgetbridge/
#
#
# Output is a tab separated file with columns:
#
# Column 1: time (unix epoch)
# Column 2: device id
# Column 3: user id
# Column 4: raw intensity
# Column 5: steps
# Column 6: raw kind (activity flags: bit field, bit5=sleep?)
# Column 7: heart rate (bpm) or 255 if no measurement
#
#
# Raw Kind (col 6):
# value   6 : charging?
# value 112 : sleeping
# value 115 : not worn
# 
# Joe Desbonnet
# 2 July 2017

DB=$1
DEVICE_ID=$2


sqlite3 $DB <<EOF
.separator " "
SELECT * FROM MI_BAND_ACTIVITY_SAMPLE WHERE DEVICE_ID=${DEVICE_ID} ORDER BY TIMESTAMP;
EOF
