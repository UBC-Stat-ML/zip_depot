#!/bin/bash

load_depot() {
  TEMP_DIR=$(mktemp -d)
  export JULIA_DEPOT_PATH="$TEMP_DIR/depot"
  echo "Setting up depot into $JULIA_DEPOT_PATH"

  if [ -f "$HOME/.depot.zip" ]; then
    cp "$HOME/.depot.zip" "$TEMP_DIR/"
    unzip -q "$TEMP_DIR/.depot.zip" -d "$TEMP_DIR/"
  fi
}
export -f load_depot

save_depot() {
  if [ ! -d "$JULIA_DEPOT_PATH" ]; then
    echo "Need to setup depot path first"
    return
  fi
  
  ZIP_FILE="$HOME/.depot.zip"
  [ -f "$ZIP_FILE" ] && rm "$ZIP_FILE" 
  PARENT_DIR="$(dirname "$JULIA_DEPOT_PATH")" 
  cd $PARENT_DIR
  zip -rq depot.zip depot
  mv depot.zip "$ZIP_FILE"
  cd - > /dev/null
}
export -f save_depot
