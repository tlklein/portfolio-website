import json
import boto3
import os
from datetime import datetime

# Initialize DynamoDB client
dynamodb = boto3.client('dynamodb')

TABLE_NAME = os.environ.get('TABLE_NAME', 'VisitorCounter')

def lambda_handler(event, context):
    print("Incoming event:", json.dumps(event, indent=2))

    # Extract IP
    ip_address = get_ip_address(event)
    print(f"IP address detected: {ip_address}")

    try:
        # Check if IP already exists
        response = dynamodb.get_item(
            TableName=TABLE_NAME,
            Key={
                'ip_address': {'S': ip_address}
            }
        )
        
        if 'Item' in response:
            # IP exists → update visit_count
            dynamodb.update_item(
                TableName=TABLE_NAME,
                Key={
                    'ip_address': {'S': ip_address}
                },
                UpdateExpression="SET visit_count = visit_count + :inc, last_visit = :now",
                ExpressionAttributeValues={
                    ":inc": {"N": "1"},
                    ":now": {"S": datetime.utcnow().isoformat()}
                }
            )
            is_new_visitor = False
        else:
            # IP is new → insert record
            dynamodb.put_item(
                TableName=TABLE_NAME,
                Item={
                    "ip_address": {"S": ip_address},
                    "visit_count": {"N": "1"},
                    "first_visit": {"S": datetime.utcnow().isoformat()},
                    "last_visit": {"S": datetime.utcnow().isoformat()}
                }
            )
            is_new_visitor = True

        # Scan to get total stats
        scan = dynamodb.scan(TableName=TABLE_NAME, AttributesToGet=["visit_count"])
        total_visits = sum(int(item["visit_count"]["N"]) for item in scan["Items"])
        unique_visitors = len(scan["Items"])

        return {
            "statusCode": 200,
            "headers": {
                "Access-Control-Allow-Origin": "*",
                "Content-Type": "application/json"
            },
            "body": json.dumps({
                "ip": ip_address,
                "unique_visitors": unique_visitors,
                "total_visits": total_visits,
                "is_new_visitor": is_new_visitor
            })
        }

    except Exception as e:
        print("Error:", str(e))
        return {
            "statusCode": 500,
            "body": json.dumps({"error": "Internal Server Error"})
        }

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
        if ip and ip != "":
            return ip
    return "0.0.0.0"

# Value: table_name, table: visitor_ips