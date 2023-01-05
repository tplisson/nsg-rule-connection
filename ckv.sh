#!/bin/sh

# Scanning the whole Directory
CMD="checkov -d . --external-checks-dir . -c test  --compact"

# Checkov Scan
echo "### Executing: $CMD"
$CMD
