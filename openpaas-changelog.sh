#!/bin/bash

modules=(
  'esn'
  'linagora.esn.emoticon'
  'linagora.esn.calendar'
  'linagora.esn.unifiedinbox.twitter'
  'linagora.esn.unifiedinbox'
  'linagora.esn.unifiedinbox.github'
  'linagora.esn.lemonldap'
  'linagora.esn.admin'
  'linagora.esn.chat'
  'linagora.esn.calendar.collect.email'
  'linagora.esn.group'
  'linagora.esn.resource'
  'linagora.esn.james'
  'linagora.esn.contact.collect'
  'linagora.esn.dav.import'
  'esn-sabre'
  'linagora.esn.sync'
  'linagora.esn.unifiedinbox.james'
  'linagora.esn.linshare'
  'linagora.esn.unifiedinbox.linshare'
  'linagora.esn.unifiedinbox.social'
  'linagora.esn.oidc'
  'linagora.esn.videoconference'
  'linagora.esn.community'
)
BASE_PATH='/home/tlcong/workspace/linagora/'
RESULT_FILE_NAME=`pwd`/'CHANGELOG.txt'

read -p "Enter your taget tag 1: " TAG1
read -p "Enter your taget tag 2: " TAG2

rm -f $RESULT_FILE_NAME

echo "Total modules: ${#modules[*]}"

echo "Processing..."
echo 'CHANGE LOGS:' >> $RESULT_FILE_NAME 2>&1
for item in ${modules[*]}
do
    echo ">> Module "$item
    modulePath=$BASE_PATH$item
    cd $modulePath
    git fetch vanilla >> /dev/null 2>&1
    echo '------------------------------------------------------' >> $RESULT_FILE_NAME 2>&1
    echo '### Module: '$item >> $RESULT_FILE_NAME 2>&1
    git log --oneline --author='^(?!gitlab-ci|CI Bot).*$' --perl-regexp --no-merges $TAG1...$TAG2 >> $RESULT_FILE_NAME 2>&1
    echo '------------------------------------------------------' >> $RESULT_FILE_NAME 2>&1
    printf '\n' >> $RESULT_FILE_NAME 2>&1
done