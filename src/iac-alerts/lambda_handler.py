import json
import boto3
import requests

CHANNEL = 'iac-security-alerts'
SLACK_SECRET = 'slack_iac_alerts_webhook'


body = """
{{
	"blocks": [
		{{
			"type": "section",
			"text": {{
				"type": "mrkdwn",
				"text": "<https://github.com/{repo_url}|{repo_url}>"
			}}
		}},
		{{
			"type": "section",
			"text": {{
				"type": "mrkdwn",
				"text": "*Altas:* {high}\n*Medias:* {mid}\n*Bajas:* {low}\n*Informativas:* {inf}\n"
			}}
		}}
	]
}}
"""


def parse_bucket_object(bucket, key):
    s3 = boto3.resource('s3')
    object = s3.Object(bucket, key)
    body = object.get()['Body'].read()
    content = json.loads(body)
    return content['severity_counters']


def send_to_slack(slack_url, repo, content):
    headers = {
        'Content-type': 'application/json'
    }

    requests.post(slack_url, headers=headers, data=body.format(
        repo_url=repo,
        high=content['HIGH'],
        mid=content['MEDIUM'],
        low=content['LOW'],
        inf=content['INFO']
    ))


def lambda_handler(event, context):
    bucket = event["Records"][0]["s3"]["bucket"]["name"]
    key = event["Records"][0]["s3"]["object"]["key"]
    content = parse_bucket_object(bucket, key)
    slack_url = get_slack_url(SLACK_SECRET)
    send_to_slack(slack_url, key, content)


def get_slack_url(name):
    AWS_REGION = "us-east-1"
    ssm_client = boto3.client("ssm", region_name=AWS_REGION)
    get_response = ssm_client.get_parameter(Name=name,
                                            WithDecryption=True)
    return get_response['Parameter']['Value']
