def lambda_handler(event, context):
    print("CloudWatch log entry: Lambda triggered successfully!")
    return {
        "statusCode": 200,
        "body": "Hello from Python Lambda via API Gateway!"
    }
