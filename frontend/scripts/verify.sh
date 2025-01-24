#!/bin/bash

# Remove verify.cpp and verify
rm -f ./verify.cpp ./verify

# Create verify.cpp
cat <<EOF > ./verify.cpp
#include "dist/html.h"
#include <iostream>

int main() {
  std::cout.write(reinterpret_cast<const char*>(dist_index_html_br), dist_index_html_br_len);
  return 0;
}
EOF

# Compile and run verify.cpp
g++ ./verify.cpp -o ./verify && ./verify > ./index.html.br.verify

# Check if md5sum of dist/index.html.br equals md5sum of ./index.html.br.verify
checksum1=$(md5sum dist/index.html.br | awk '{print $1}')
checksum2=$(md5sum index.html.br.verify | awk '{print $1}')
if [ "$checksum1" == "$checksum2" ]; then
  rm -f ./index.html.br.verify ./verify.cpp ./verify
  echo "Verification successful"
else
  echo "Verification failed"
  exit 1
fi