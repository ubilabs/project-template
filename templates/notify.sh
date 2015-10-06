#!/bin/bash

# Configure these:
DEPLOYMENTPATH="<http://storage.ubidev.net/MY-PROJECT-PATH/index.html>"
CHANNEL="#MY-CHANNEL"
URL="https://hooks.slack.com/services/MY-HOOK"

# These should not change.
NAME="Benachrichtigungsbiene"
ICON=":bee:"

case "$1" in
  "release")
    MESSAGE="New App Release! Version $2. :tada:"
    ;;
  "deploy")
    MESSAGE="Deployed a new version to $DEPLOYMENTPATH. :confetti_ball:"
    ;;
  *)
    echo "Usage: ./notify.sh release 1.0.0|deploy"
    exit 1
    ;;
esac

curl -X POST --data-urlencode "payload={\"channel\": \"$CHANNEL\", \"username\": \"$NAME\", \"text\": \"$MESSAGE\", \"icon_emoji\": \"$ICON\"}" $URL

echo Done.
