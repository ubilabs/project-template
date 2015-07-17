#!/bin/sh

npm_config_loglevel="error"
if [ "x$npm_debug" = "x" ]; then
  (exit 0)
else
  echo "Running in debug mode."
  echo "Note that this requires bash or zsh."
  set -o xtrace # print commands before executing them
  set -o pipefail # outputs error on failing part of a pipe chain.
  npm_config_loglevel="verbose"
fi
export npm_config_loglevel

TMP=".tmp"

rm -rf "$TMP" || true
mkdir "$TMP"
if [ $? -ne 0 ]; then
  echo "failed to mkdir $TMP" >&2
  exit 1
fi

fetch() {
  local BASENAME=`basename ${1}`

  if [[ ${#@} == 2 ]]; then
    BASENAME=${2}
  fi

  echo "Load ${BASENAME}"
  curl -SsL "${1}" -o $BASENAME
}

#
# Load the README and fill out some defaults.
#

cd "$TMP" \
  && fetch "https://raw.githubusercontent.com/ubilabs/ubilabs-project-template/master/README_TEMPLATE.md" "README.md"

read -p "The name of the project " PROJECT_NAME </dev/tty
read -p "Please add a short description " PROJECT_DESCRIPTION </dev/tty

echo "update README.md"
sed -i '' -e "s/{{project-name}}/${PROJECT_NAME}/g" README.md
sed -i '' -e "s/{{project-description}}/${PROJECT_DESCRIPTION}/g" README.md

echo
read -p "Don't forget to update the staging links and setup instructions when you are ready!" NOOP </dev/tty
echo

#
# Define some project type stuff
#

read -p "What is the type of the project [nodejs, other]: " PROJECT_TYPE </dev/tty

if [[ ${PROJECT_TYPE} == 'nodejs' ]]; then
  fetch "https://raw.githubusercontent.com/ubilabs/ubilabs-project-template/master/package.json"

  echo "update package.json"
  sed -i '' -e "s/{{project-name}}/${PROJECT_NAME}/g" package.json

  fetch "https://raw.githubusercontent.com/ubilabs/ubilabs-project-template/master/.eslintrc"

  npm i
fi

fetch "https://raw.githubusercontent.com/ubilabs/ubilabs-project-template/master/.editorconfig"
fetch "https://raw.githubusercontent.com/ubilabs/ubilabs-project-template/master/CONVENTIONS.md"
