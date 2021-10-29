#!/bin/bash

#get script path
SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`
cd $SCRIPTPATH

#set constants
NONE='\033[00m'
CYAN='\033[36m'
FUSCHIA='\033[35m'
UNDERLINE='\033[4m'

echo
echo "Updating Dependencies..."
echo
git pull

echo ""
echo "--------------------------------------------------"
echo "Retropie Overlay update complete!"
echo "--------------------------------------------------"