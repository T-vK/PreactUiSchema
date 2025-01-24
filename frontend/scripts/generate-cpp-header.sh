#!/bin/bash

# Define the output header file
HEADER_FILE="$1"

# Read the binary content of the file
BINARY_CONTENT=$(xxd -i dist/index.html.br)

# Create the header file and write the content
cat <<EOL > $HEADER_FILE
#ifndef HTML_H
#define HTML_H

#include <cstdint>

// Binary content of index.html.br
static const uint8_t index_html_br[] = {
    $BINARY_CONTENT
};

static const size_t index_html_br_len = sizeof(index_html_br);

#endif // HTML_H
EOL

echo "Header file created: $HEADER_FILE"
