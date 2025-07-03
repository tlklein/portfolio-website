import json
import boto3
import os
from datetime import datetime, timedelta
import hashlib

# Initialize DynamoDB client
dynamodb = boto3.client('dynamodb')
TABLE_NAME = os.environ.get('TABLE_NAME', 'VisitorCounter')

UNIQUE_VISITOR_WINDOW_HOURS = 24  # 24-hour uniqueness window

def lambda_handler(event, context):
    print("Incoming event:", json.dumps(event, indent=2))

    # Extract and hash IP address
    ip_address = get_ip_address(event)
    if ip_address == "0.0.0.0":
        return error_response("Unable to determine IP address")
    
    hashed_ip = hash_ip(ip_address)
    now = datetime.utcnow()
    now_str = now.isoformat()

    try:
        response = dynamodb.get_item(
            TableName=TABLE_NAME,
            Key={'ip_address': {'S': hashed_ip}}
        )

        is_new_visitor = False

        if 'Item' in response:
            last_visit = response['Item'].get('last_visit', {}).get('S')
            last_visit_time = datetime.fromisoformat(last_visit)

            # Check if it's a unique visit (more than 24h since last)
            if now - last_visit_time >= timedelta(hours=UNIQUE_VISITOR_WINDOW_HOURS):
                is_new_visitor = True
                dynamodb.update_item(
                    TableName=TABLE_NAME,
                    Key={'ip_address': {'S': hashed_ip}},
                    UpdateExpression="SET visit_count = visit_count + :inc, last_visit = :now",
                    ExpressionAttributeValues={
                        ":inc": {"N": "1"},
                        ":now": {"S": now_str}
                    }
                )
        else:
            # First time seeing this IP
            is_new_visitor = True
            dynamodb.put_item(
                TableName=TABLE_NAME,
                Item={
                    "ip_address": {"S": hashed_ip},
                    "visit_count": {"N": "1"},
                    "first_visit": {"S": now_str},
                    "last_visit": {"S": now_str}
                }
            )

        # Scan to get all visits
        scan = dynamodb.scan(
            TableName=TABLE_NAME,
            AttributesToGet=["visit_count"]
        )
        total_visits = sum(int(item["visit_count"]["N"]) for item in scan["Items"])
        unique_visitors = len(scan["Items"])

        return {
            "statusCode": 200,
            "headers": {
                "Access-Control-Allow-Origin": "*",
                "Content-Type": "application/json"
            },
            "body": json.dumps({
                "unique_visitors": unique_visitors,
                "total_visits": total_visits,
                "is_new_visitor": is_new_visitor
            })
        }

    except Exception as e:
        print("Error:", str(e))
        return error_response("Internal server error")


def get_ip_address(event):
    headers = event.get("headers", {})
    ip_sources = [
        event.get("requestContext", {}).get("http", {}).get("sourceIp"),
        event.get("requestContext", {}).get("identity", {}).get("sourceIp"),
        headers.get("x-forwarded-for", "").split(",")[0].strip(),
        headers.get("X-Forwarded-For", "").split(",")[0].strip(),
        headers.get("x-real-ip"),
        headers.get("X-Real-IP"),
        headers.get("cf-connecting-ip"),
        headers.get("CF-Connecting-IP"),
    ]
    for ip in ip_sources:
        if ip:
            return ip
    return "0.0.0.0"


def hash_ip(ip):
    """One-way SHA256 hash to anonymize IP"""
    return hashlib.sha256(ip.encode()).hexdigest()


def error_response(message):
    return {
        "statusCode": 500,
        "body": json.dumps({"error": message})
    }
