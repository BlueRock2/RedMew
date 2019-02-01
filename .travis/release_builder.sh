#!/bin/bash

#Copy the repo, clean it, and write the version for the release
cd ~/build || exit
echo "Changing dir to :"
pwd
echo "Copying RedMew folder to work on"
cp -rf Refactorio/RedMew working_copy
echo "Removing git files"
rm -rf working_copy/.??*
echo "Writing the version file"
echo "global.redmew_version=$DATE_FORMATTED-$COMMIT_SHA" > working_copy/resources/version.lua
echo "Contents of the version file:"
cat working_copy/resources/version.lua

#Create zips for each of the major maps/scenarios
function process_map (){
    #Show us which file is being worked on
    echo "-----$1-----"
    #Rename the directory per map
    mv "$3" "$1"
    # Write the contents to map_selection.lua
    echo "return require 'map_gen.maps.$2'" > "$1/map_selection.lua"
    echo "Contents of map_selection:"
    #Display the contents of map_selection.lua for verification
    cat "$1/map_selection.lua"
    if [ "$4" != true ]; then #Base RedMew can't be deflated
        echo "Remove binary files (images)"
        #Remove the binary files that don't compress well
        rm "$1"/redmew_git_banner.png -f
        rm "$1"/map_gen/data/.source_images -rf
        rm "$1"/map_gen/data/.map_previews -rf
    fi
    echo "Creating zip..."
    #Create the actual zip file with recursion, quiet, and max compression
    zip -r9q "$1.zip" "$1"
    echo "Stats on the zip:"
    ls -al "$1.zip"
    cp "$1.zip" "$HOME/build/Refactorio/RedMew/$1.zip"
    PREVIOUS_NAME=$1
    export PREVIOUS_NAME
    return 0
}

#Each map after the default redmew release repeats the pattern of $1=The regular name of the map (proper casing), $2=The name of the map file (lower case), $3 "$PREVIOUS_NAME"
process_map "RedMew" "default" "working_copy" true
process_map "Diggy" "diggy" "$PREVIOUS_NAME"
process_map "Crashsite" "crash_site" "$PREVIOUS_NAME"
process_map "Tetris" "tetris" "$PREVIOUS_NAME"
