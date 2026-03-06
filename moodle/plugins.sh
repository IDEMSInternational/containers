#!/bin/sh

set -ex

MOODLE_ROOT=/opt/idems/moodle

git clone --depth 1 \
    https://github.com/dthies/moodle-quizaccess_addreview.git \
    ${MOODLE_ROOT}/mod/quiz/accessrule/addreview
chmod -R g+w ${MOODLE_ROOT}/mod/quiz/accessrule/addreview

cd /staging

while read -r in out checksum install_dir; do
    curl -SsLf $in -o $out
    echo $checksum $out | sha256sum -c
    tar -xf $out
    mv $(basename -s .tar.gz $out) ${MOODLE_ROOT}/${install_dir}
done < plugins.txt

cd -
