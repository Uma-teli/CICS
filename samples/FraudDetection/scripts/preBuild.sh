#!/bin/env sh

MODEL_VERSION=$(python ${WORKSPACE}/scripts/json_extract.py model_version)

${WORKSPACE}/samples/FraudDetection/scripts/extract.sh $MODEL_VERSION ${WORKSPACE} /var/jenkins/workspaces/WMLzCobolPipeline

${WORKSPACE}/samples/FraudDetection/scripts/changeScoringEnd.sh ${WORKSPACE} /var/jenkins/workspaces/WMLzCobolPipeline

${WORKSPACE}/samples/FraudDetection/scripts/gitCommit.sh ${WORKSPACE}
