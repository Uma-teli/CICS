#!/bin/env python
import json
import sys

WORKSPACE = sys.argv[1]
PREV_WORKSPACE = sys.argv[2]

with open(PREV_WORKSPACE + '/scoringURL.json') as f:
    data = json.load(f)

SCORING_URL = data["scoring_url"]
print("new:",SCORING_URL)

with open(WORKSPACE + '/samples/FraudDetection/scripts/oldScoringURL.json') as f:
    oldData = json.load(f)
print(oldData)
DEPLOY_ID = oldData["scoring_url"]
print(DEPLOY_ID)

filename = WORKSPACE + "/samples/FraudDetection/cobol/FRAUDMOD.cbl"
new_value = SCORING_URL.split("/")[-1]
old_value = DEPLOY_ID

with open(filename, "r") as file:
    content = file.read()

content = content.replace(old_value, new_value)
print(content)

with open(filename, "w") as file:
    file.write(content)

print(file)

with open(WORKSPACE + '/samples/FraudDetection/scripts/oldScoringURL.json','w') as f:
    json.dump(data,f)

