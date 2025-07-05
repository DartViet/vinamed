# Dart Shelf Backend Server

A basic HTTP server built with Dart and the dart Shelf framework.

## Features

- RESTful API endpoints
- JSON responses
- CORS support
- Request logging
- Health check endpoint
- Comprehensive test coverage

## Getting Started

### Prerequisites

- Dart SDK 3.8.1 or later

### Installation

1. Install dependencies:
```bash
dart pub get
```

### Running the Server

Start the server with default settings (localhost:8080):
```bash
dart run
```

Or specify custom host and port:
```bash
dart run bin/webserver.dart --host 0.0.0.0 --port 3000
```

### Available Endpoints

#### GET /
Welcome page with endpoint documentation

#### GET /health
Health check endpoint
```json
{
  "status": "healthy",
  "timestamp": "2025-06-29T15:35:42.164Z"
}
```

#### GET /api/users
Get all users
```json
{
  "users": [
    {
      "id": 1,
      "name": "John Doe",
      "email": "john@example.com"
    },
    ...
  ]
}
```

#### POST /api/users
Create a new user
- Content-Type: application/json
- Body: User data (any JSON object)

Response:
```json
{
  "message": "User created successfully",
  "user": {
    "id": 1735892142258,
    "name": "New User",
    "email": "newuser@example.com",
    "created_at": "2025-06-29T15:35:42.258Z"
  }
}
```

#### GET /api/users/:id
Get user by ID
```json
{
  "user": {
    "id": 123,
    "name": "User 123",
    "email": "user123@example.com"
  }
}
```

### Testing

Run tests:
```bash
dart test
```

### Development

The server includes:

- **CORS middleware** - Allows cross-origin requests
- **Logging middleware** - Logs all incoming requests  
- **Error handling** - Proper HTTP status codes and error responses
- **Graceful shutdown** - Handles Ctrl+C to stop server cleanly

### Project Structure

```
lib/
  webserver.dart      # Main server implementation
bin/
  webserver.dart      # Entry point
test/
  webserver_test.dart # Test suite
```

### Customization

You can extend the server by:

1. Adding new routes to the `_setupRoutes()` method
2. Implementing additional middleware
3. Adding database integration
4. Implementing authentication
5. Adding validation for request bodies

### Example Usage

Test the API with curl:

```bash
# Health check
curl http://localhost:8080/health

# Get users
curl http://localhost:8080/api/users

# Get specific user
curl http://localhost:8080/api/users/123

# Create user
curl -X POST http://localhost:8080/api/users \
  -H "Content-Type: application/json" \
  -d '{"name": "Alice", "email": "alice@example.com"}'
```
