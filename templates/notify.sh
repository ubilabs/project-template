#!/bin/bash

# Configure these:
PATH="<http://storage.ubidev.net/MY-PROJECT-PATH/index.html>"
CHANNEL="#MY-CHANNEL"

# These should not change.
URL="https://hooks.slack.com/services/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"
NAME="Benachrichtigungsbiene"
ICON=":bee:"

case "$1" in
  "release")
    MESSAGE="New App Release! Version $2. :tada:"
    ;;
  "deploy")
    MESSAGE="Deployed a new version to $PATH. :confetti_ball:"
    ;;
  *)
    echo "Usage: ./notify.sh release 1.0.0|deploy"
    exit 1
    ;;
esac

curl -X POST --data-urlencode "payload={\"channel\": \"$CHANNEL\", \"username\": \"$NAME\", \"text\": \"$MESSAGE\", \"icon_emoji\": \"$ICON\"}" $URL

echo Done.
