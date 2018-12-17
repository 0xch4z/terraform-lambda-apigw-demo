import {
  APIGatewayProxyCallback,
  APIGatewayEvent,
  APIGatewayEventRequestContext
} from 'aws-lambda';

const wait = (durration: number): Promise<void> =>
  new Promise(resolve => setTimeout(resolve, durration));

export const handler = async (
  event: APIGatewayEvent,
  context: APIGatewayEventRequestContext,
  callback: APIGatewayProxyCallback
): Promise<void> => {
  // simulate asynchronous task
  await wait(500);

  callback(null, {
    statusCode: 200,
    headers: {
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      message: 'Hello, World!',
      path: event.path,
      requestTimeEpoch: context.requestTimeEpoch,
    })
  });
};
