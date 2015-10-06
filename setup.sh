#!/usr/bin/env bash

config_loglevel="error"
if [ "x$npm_debug" = "x" ]; then
  (exit 0)
else
  echo "Running in debug mode."
  echo "Note that this requires bash or zsh."
  set -o xtrace # print commands before executing them
  set -o pipefail # outputs error on failing part of a pipe chain.
  config_loglevel="verbose"
fi
export config_loglevel

TEMPLATES_BASE_URL="http://ubilabs.github.io/project-template/templates/"

NPM_MODULES=(
  autoprefixer-stylus
  babel-core
  babelify
  browserify
  bumpery
  conventional-changelog-generator
  eslint
  gcloud-storage-upload
  jade
  light-server
  mocha
  pre-commit
  stylus
  uglifyjs
)

fetch() {
  local BASENAME=${1}
  local OUT_FILE_PATH=${2}

  if [ -z "$OUT_FILE_PATH" ]; then
    OUT_FILE_PATH=$BASENAME
  fi

  echo "Load ${BASENAME} from ${TEMPLATES_BASE_URL}${BASENAME#.}"
  curl -SsL "${TEMPLATES_BASE_URL}${BASENAME#.}" -o ${OUT_FILE_PATH}
  echo "Saved ${BASENAME} to ${OUT_FILE_PATH}"
}

#
# Load the README and fill out some defaults.
#

fetch "README.md"
fetch ".editorconfig"
fetch "CONVENTIONS.md"

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
  fetch "package.json"

  echo "update package.json"
  sed -i '' -e "s/{{project-name}}/${PROJECT_NAME}/g" package.json

  fetch ".eslintrc"

  fetch "gitignore"
  mv gitignore .gitignore

  echo "install npm modules ${NPM_MODULES[@]}"
  npm i ${NPM_MODULES[@]} --save-dev
fi

read -p "Use default folder structure? [y, N]: " DEFAULT_FOLDER_STRUCTURE </dev/tty

if [[ ${DEFAULT_FOLDER_STRUCTURE} == 'y' ]]; then

  mkdir -p app/{jade/layouts,styles,scripts}

  echo "Created folder structure:"
  find app -type d -print

  fetch "jade-default" "app/jade/layouts/default.jade"
  fetch "jade-index" "app/jade/index.jade"
  fetch "main-css" "app/styles/main.styl"
  fetch "main-js" "app/scripts/main.js"

  echo "update default.jade"
  sed -i '' -e "s/{{project-name}}/${PROJECT_NAME}/g" app/jade/layouts/default.jade

  echo "update index.jade"
  sed -i '' -e "s/{{project-name}}/${PROJECT_NAME}/g" app/jade/index.jade
  sed -i '' -e "s/{{project-description}}/${PROJECT_DESCRIPTION}/g" app/jade/index.jade
fi

echo "Setup finished, good to go!"
