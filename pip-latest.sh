#!/bin/bash
# Tue May 15 12:25:33 PDT 2018
# Author: John Cardarelli

PIP_PKG="$1"

#######################################
# Install prerequisite packages with apt-get
#######################################
install_apt_prereqs() {
  local APT_PREREQS=("curl" "jq")
  local APT_INSTALL_CMD="sudo apt-get install"
  local APT_NOT_INSTALLED=()
  for PACKAGE in "${APT_PREREQS[@]}"; do
    # check if package is installed by testing response code of dpkg-query
    dpkg-query -l $PACKAGE 2>&1 > /dev/null

    if [[ "$?" -ne 0 ]]; then
      echo "$PACKAGE not found, adding to install list."
      APT_NOT_INSTALLED+=$PACKAGE
    fi
  done

  if [[ "$APT_NOT_INSTALLED" -gt 0 ]]; then
    echo "Installing prerequisite packages..."
    "$APT_INSTALL_CMD" "${APT_NOT_INSTALLED[@]}"
  fi
}

#######################################
# Store the output of stderr to a variable, throw away stdout, translate each
# comma and space to a newline
#######################################
stupid_pip_check() {
  pip install ${PIP_PKG}== 2>&1 > /dev/null | tr ', ' '\r\n' | sed '/[a-z]/d' 
  \| sort -r | head -n 1
}

ok_pip_check() {
  curl -s https://pypi.org/pypi/${1}/json | jq --raw-output '.info.version'
}

# Exit if $PIP_PKG argument is not specified
if [[ -z "$PIP_PKG" ]]; then
  echo "ERROR: Please specify a pip package to find the latest version of."
else
  install_apt_prereqs
  ok_pip_check "$PIP_PKG"
fi
