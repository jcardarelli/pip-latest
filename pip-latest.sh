#!/bin/bash
# Tue May 15 12:25:33 PDT 2018
# Author: John Cardarelli

PIP_PKG="$1"

# Exit if $PIP_PKG argument is not specified
if [[ -z $PIP_PKG ]]; then
  echo "ERROR: Please specify a pip package to find the latest version of."
else
  # Store the output of stderr to a variable, throw away stdout, translate each comma and space to a newline
  PIP_CHECK_CMD="$(pip install ${PIP_PKG}== 2>&1 > /dev/null | tr ', ' '\r\n')"

  # Grep alphanumeric characters from output
  echo "$PIP_CHECK_CMD"
fi
