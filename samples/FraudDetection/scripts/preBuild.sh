#!/bin/env sh

MODEL_VERSION=$(python /u/wml/jenkinsPipeline/json_extract.py model_version)

/u/wml/jenkinsPipeline/WMLzAppBuild/samples/FraudDetection/scripts/extract.sh $MODEL_VERSION

/u/wml/jenkinsPipeline/WMLzAppBuild/samples/FraudDetection/scripts/changeScoringEnd.sh

/u/wml/jenkinsPipeline/WMLzAppBuild/samples/FraudDetection/scripts/gitCommit.sh
