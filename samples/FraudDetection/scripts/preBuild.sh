#!/bin/env sh

for file in *.json; do
    if [ -f "$file" ]; then
        source_encoding="IBM-1047"
        target_encoding="UTF-8"

        iconv -f "$source_encoding" -t "$target_encoding" "$file" > "converted_$file"
    fi
done

MODEL_VERSION=$(python /u/wml/jenkinsPipeline/WMLzAppBuild/samples/FraudDetection/scripts/json_extract.py model_version ${WORKSPACE})

/u/wml/jenkinsPipeline/WMLzAppBuild/samples/FraudDetection/scripts/extract.sh $MODEL_VERSION /u/wml/jenkinsPipeline/WMLzAppBuild ${WORKSPACE}

/u/wml/jenkinsPipeline/WMLzAppBuild/samples/FraudDetection/scripts/changeScoringEnd.sh /u/wml/jenkinsPipeline/WMLzAppBuild ${WORKSPACE}

/u/wml/jenkinsPipeline/WMLzAppBuild/samples/FraudDetection/scripts/gitCommit.sh /u/wml/jenkinsPipeline/WMLzAppBuild
