#!/bin/env python
import json

with open('/u/wml/jenkinsPipeline/scoringURL.json') as f:
    data = json.load(f)

SCORING_URL = data["scoring_url"]

with open('/u/wml/jenkinsPipeline/WMLzAppBuild/samples/FraudDetection/scripts/extracted_data_model.json') as f:
    data = json.load(f)

DEPLOY_ID = data["model_id"]
print(DEPLOY_ID)

filename = "/u/wml/jenkinsPipeline/WMLzAppBuild/samples/FraudDetection/cobol/FRAUDMOD.cbl"
new_value = SCORING_URL.split("/")[-1]
old_value = DEPLOY_ID

with open(filename, "r") as file:
    content = file.read()

new_value="this should be populated"
content = content.replace(old_value, new_value)
print(content)

with open(filename, "w") as file:
    file.write(content)

print(file)
