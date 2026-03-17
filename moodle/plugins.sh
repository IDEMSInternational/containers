#!/bin/sh

set -ex

MOODLE_ROOT=/opt/idems/moodle

git clone --depth 1 \
    https://github.com/dthies/moodle-quizaccess_addreview.git \
    ${MOODLE_ROOT}/mod/quiz/accessrule/addreview
chmod -R g+w ${MOODLE_ROOT}/mod/quiz/accessrule/addreview

cd /staging

archive_name=archive.tar.gz

while read -r url checksum install_dir
do
    curl -SsLf $url -o $archive_name
    echo $checksum $archive_name | sha256sum -c
    mkdir -p ${MOODLE_ROOT}/${install_dir}
    tar -C ${MOODLE_ROOT}/${install_dir} --strip-components=1 -xf $archive_name
done < plugins.txt

cd -
