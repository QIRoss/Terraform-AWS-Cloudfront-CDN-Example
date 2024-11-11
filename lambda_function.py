def lambda_handler(event, context):
    request = event['Records'][0]['cf']['request']
    headers = request['headers']

    headers['x-custom-header'] = [{'key': 'X-Custom-Header', 'value': 'Hello from Lambda@Edge'}]

    return request
