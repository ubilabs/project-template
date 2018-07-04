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
  autoprefixer
  babel-core
  babel-eslint
  babel-loader
  babel-plugin-transform-object-rest-spread
  babel-preset-env
  conventional-changelog-cli
  css-loader
  eslint
  extract-text-webpack-plugin
  gcloud-storage-upload
  html-webpack-plugin
  postcss-loader
  pre-commit
  prettier
  stylus
  stylus-loader
  sync-files
  webpack
  webpack-dev-server
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
  fetch "webpack.config.js"

  echo "update package.json"
  sed -i '' -e "s/{{project-name}}/${PROJECT_NAME}/g" package.json

  fetch ".eslintrc"
  fetch ".prettierrc"

  fetch "gitignore"
  mv gitignore .gitignore

  echo "install npm modules ${NPM_MODULES[@]}"
  npm i ${NPM_MODULES[@]} --save-dev
fi

read -p "Use default folder structure? [y, N]: " DEFAULT_FOLDER_STRUCTURE </dev/tty

if [[ ${DEFAULT_FOLDER_STRUCTURE} == 'y' ]]; then

  mkdir -p src/{templates,styles,scripts,static}

  echo "Created folder structure:"
  find src -type d -print

  fetch "index-html" "src/templates/index.html"
  fetch "index-css" "src/styles/index.styl"
  fetch "index-js" "src/scripts/index.js"
  fetch "Bug_report.md" ".github/ISSUE_TEMPLATE/Bug_report.md"
  fetch "Feature_request.md" ".github/ISSUE_TEMPLATE/Feature_request.md"
  fetch "PULL_REQUEST_TEMPLATE.md" ".github/PULL_REQUEST_TEMPLATE.md"

  echo "update index.html"
  sed -i '' -e "s/{{project-name}}/${PROJECT_NAME}/g" src/templates/index.html
  sed -i '' -e "s/{{project-description}}/${PROJECT_DESCRIPTION}/g" src/templates/index.html
fi

echo "Setup finished, good to go!"
