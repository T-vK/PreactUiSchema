#!/bin/bash

# Define the output header file
HEADER_FILE="$1"

rm -f "$HEADER_FILE"

# Read the binary content of the file
C_ARRAY_CODE=$(xxd -i dist/index.html.br)

# Create the header file and write the content
cat <<EOL > $HEADER_FILE
#ifndef GENERATED_HTML_H
#define GENERATED_HTML_H

#include <cstdint>

// Binary content of index.html.br as char array
$C_ARRAY_CODE

#endif // GENERATED_HTML_H
EOL

echo "Header file created: $HEADER_FILE"
