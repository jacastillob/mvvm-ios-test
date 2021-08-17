const AWS = require("aws-sdk");

const dynamo = new AWS.DynamoDB.DocumentClient();

exports.handler = async (event, context) => {
  let body;
  let statusCode = 200;
  const headers = {
    "Content-Type": "application/json"
  };

  try {
    switch (event.routeKey) {
      case "DELETE /savedhealines/{id}":
        await dynamo
          .delete({
            TableName: "SavedHeadline",
            Key: {
              id: event.pathParameters.id
            }
          })
          .promise();
        body = `Deleted Saved Headline ${event.pathParameters.id}`;
        break;
      case "GET /savedhealines/{id}":
        body = await dynamo
          .get({
            TableName: "SavedHeadline",
            Key: {
              id: event.pathParameters.id
            }
          })
          .promise();
        break;
      case "GET /savedhealines":
        body = await dynamo.scan({ TableName: "SavedHeadline" }).promise();
        break;
      case "PUT /savedhealines":
        let requestJSON = JSON.parse(event.body);
        await dynamo
          .put({
            TableName: "SavedHeadline",
            Item: {
              id: requestJSON.id,
              author: requestJSON.author,
              title: requestJSON.title,
              description: requestJSON.description,
              url: requestJSON.url,
              urlToImage: requestJSON.urlToImage,
              sourceId: requestJSON.sourceId,
              sourceName: requestJSON.sourceName, 
            }
          })
          .promise();
        body = `Put item ${requestJSON.id}`;
        break;
      default:
        throw new Error(`Unsupported route: "${event.routeKey}"`);
    }
  } catch (err) {
    statusCode = 400;
    body = err.message;
  } finally {
    body = JSON.stringify(body);
  }

  return {
    statusCode,
    body,
    headers
  };
};