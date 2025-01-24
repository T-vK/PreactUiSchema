#!/bin/bash

# Define the output header file
HEADER_FILE="$1"

rm -f "$HEADER_FILE"

# Read the binary content of the file
C_ARRAY_CODE=$(xxd -i dist/index.html.br | sed 's/unsigned char/const uint8_t/' | sed 's/unsigned int/const uint32_t/')

# Create the header file and write the content
cat <<EOL > $HEADER_FILE
#ifndef GENERATED_HTML_H
#define GENERATED_HTML_H

#ifdef ARDUINO
#include <Arduino.h>
#else
#include <cstdint>
#endif

// Binary content of index.html.br as const uint8_t array
$C_ARRAY_CODE

#endif // GENERATED_HTML_H
EOL

echo "Header file created: $HEADER_FILE"
