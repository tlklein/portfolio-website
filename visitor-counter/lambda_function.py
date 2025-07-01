# Lambda function for a simple hit counter using dynamodb

import json
import boto3
import os

# Initialize dynamodb boto3 object
dynamodb = boto3.resource('dynamodb')
# Set dynamodb table name variable from env
ddbTableName = os.environ['databaseName']
table = dynamodb.Table(ddbTableName)


def lambda_handler(event, context):
    try:
        # Try to update the item
        ddbResponse = table.update_item(
            Key={
                'id': 'visitor_count'
            },
            UpdateExpression='SET visitor_count = visitor_count + :value',
            ExpressionAttributeValues={
                ':value':1
            },
            ReturnValues="UPDATED_NEW"
        )
    except:
        # If the item doesn't exist, create it
        table.put_item(
            Item={
                'id': 'visitor_count',
                'visitor_count': 1
            }
        )
        ddbResponse = table.get_item(
            Key={
                'id': 'visitor_count'
            }
        )


    # Format dynamodb response into variable
    responseBody = json.dumps({"count": int(ddbResponse["Attributes"]["visitor_count"])})

    # Create api response object
    apiResponse = {
        "isBase64Encoded": False,
        "statusCode": 200,
        'headers': {
            'Access-Control-Allow-Headers': 'Content-Type',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'OPTIONS,POST,GET'
        },
        "body": responseBody
    }



    # Return api response object

    return apiResponse

# Value: databaseName, Table: VisitorCount