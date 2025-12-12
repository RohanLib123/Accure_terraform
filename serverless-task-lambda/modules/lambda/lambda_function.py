def lambda_handler(event, context):
    print("Lambda executed successfully!")
    return {
        "statusCode": 200,
        "body": "Hello from python Lambda!"
    }