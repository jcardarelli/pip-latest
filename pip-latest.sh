#!/bin/bash
# Tue May 15 12:25:33 PDT 2018
# Author: John Cardarelli

PIP_PKG="$1"
APT_PREREQS=("curl" "jq")
APT_INSTALL_CMD="sudo apt-get install"
APT_NOT_INSTALLED=()

install_apt_prereqs() {
  for PACKAGE in "${APT_PREREQS[@]}"; do
    # check if package is installed by testing response code of dpkg-query
    dpkg-query -l $PACKAGE 2>&1 > /dev/null

    if [[ $? -eq 0 ]]; then
      echo "$PACKAGE is already installed."
    else
      echo "$PACKAGE not found, adding to install list."
      # append package to install list
      APT_NOT_INSTALLED+=$PACKAGE
    fi
  done

  if [[ $APT_NOT_INSTALLED -gt 0 ]]; then
    echo "Installing prerequisite packages..."
    $APT_INSTALL_CMD "${APT_NOT_INSTALLED[@]}"
  else
    echo "Prerequisite check passed."
  fi
}

# Exit if $PIP_PKG argument is not specified
if [[ -z $PIP_PKG ]]; then
  echo "ERROR: Please specify a pip package to find the latest version of."
else
  install_apt_prereqs

  # Store the output of stderr to a variable, throw away stdout, translate each comma and space to a newline
  PIP_CHECK_CMD="$(pip install ${PIP_PKG}== 2>&1 > /dev/null | tr ', ' '\r\n' | sed '/[a-z]/d' | sort -r | head -n 1)"

  echo "$PIP_CHECK_CMD"
fi
