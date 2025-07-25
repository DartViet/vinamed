import 'dart:io';
import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:webserver/views/codes_data_views/dhs_view.dart';
import 'package:webserver/views/codes_data_views/fda_drug_view.dart';
import 'package:webserver/views/codes_data_views/icd10cm_view.dart';
import 'package:webserver/views/codes_data_views/icd10pcs_view.dart';
import 'package:webserver/views/codes_data_views/loinc_view.dart';

class WebServer {
  late HttpServer _server;
  late Router _router;

  WebServer() {
    _setupRoutes();
  }

  void _setupRoutes() {
    _router = Router();

    DhsView(_router);
    Icd10CmView(_router);
    Icd10PcsView(_router);
    LoincView(_router);
    FdaDrugView(_router);

    // Basic GET route
    _router.get('/', _handleRoot);

    // Health check endpoint
    _router.get('/health', _handleHealth);

    // API endpoint example
    _router.get('/api/users', _handleUsers);

    // POST endpoint example
    _router.post('/api/users', _handleCreateUser);

    // Dynamic route example
    _router.get('/api/users/<id>', _handleUserById);

    _router.get('/api/v1/code', _handleUsers);
  }

  Response _handleRoot(Request request) {
    return Response.ok(
      '''
      <!DOCTYPE html>
      <html>
      <head>
        <title>Dart Shelf Server</title>
        <style>
          body { font-family: Arial, sans-serif; margin: 40px; }
          .container { max-width: 600px; }
          h1 { color: #333; }
          .endpoint { background: #f5f5f5; padding: 10px; margin: 10px 0; border-radius: 5px; }
        </style>
      </head>
      <body>
        <div class="container">
          <h1>🚀 Dart Shelf Server</h1>
          <p>Welcome to your Dart Shelf backend server!</p>
          
          <h2>Available Endpoints:</h2>
          <div class="endpoint"><strong>GET /</strong> - This welcome page</div>
          <div class="endpoint"><strong>GET /health</strong> - Health check</div>
          <div class="endpoint"><strong>GET /api/users</strong> - Get all users</div>
          <div class="endpoint"><strong>POST /api/users</strong> - Create a new user</div>
          <div class="endpoint"><strong>GET /api/users/:id</strong> - Get user by ID</div>
        </div>
      </body>
      </html>
      ''',
      headers: {'Content-Type': 'text/html'},
    );
  }

  Response _handleHealth(Request request) {
    final healthData = {'status': 'healthy', 'timestamp': DateTime.now().toIso8601String()};

    return Response.ok(jsonEncode(healthData), headers: {'Content-Type': 'application/json'});
  }

  Response _handleUsers(Request request) {
    final users = [
      {'id': 1, 'name': 'John Doe', 'email': 'john@example.com'},
      {'id': 2, 'name': 'Jane Smith', 'email': 'jane@example.com'},
      {'id': 3, 'name': 'Bob Johnson', 'email': 'bob@example.com'},
    ];

    final responseData = {'users': users};

    return Response.ok(jsonEncode(responseData), headers: {'Content-Type': 'application/json'});
  }

  Future<Response> _handleCreateUser(Request request) async {
    try {
      final body = await request.readAsString();
      print('Received user data: $body');

      // In a real app, you'd parse the JSON and save to a database
      final newUser = {
        'id': DateTime.now().millisecondsSinceEpoch,
        'name': 'New User',
        'email': 'newuser@example.com',
        'created_at': DateTime.now().toIso8601String(),
      };

      final responseData = {'message': 'User created successfully', 'user': newUser};

      return Response.ok(jsonEncode(responseData), headers: {'Content-Type': 'application/json'});
    } catch (e) {
      final errorData = {'error': 'Failed to create user: $e'};
      return Response.internalServerError(
        body: jsonEncode(errorData),
        headers: {'Content-Type': 'application/json'},
      );
    }
  }

  Response _handleUserById(Request request, String id) {
    final userId = int.tryParse(id);

    if (userId == null) {
      final errorData = {'error': 'Invalid user ID'};
      return Response.badRequest(
        body: jsonEncode(errorData),
        headers: {'Content-Type': 'application/json'},
      );
    }

    // Mock user data
    final user = {'id': userId, 'name': 'User $userId', 'email': 'user$userId@example.com'};

    final responseData = {'user': user};

    return Response.ok(jsonEncode(responseData), headers: {'Content-Type': 'application/json'});
  }

  Future<void> start({String host = 'localhost', int port = 8080}) async {
    // Create a pipeline with logging middleware
    final pipeline = Pipeline()
        .addMiddleware(logRequests())
        .addMiddleware(_corsMiddleware())
        .addHandler(_router.call);

    _server = await serve(pipeline, host, port);
    print('🚀 Server running on http://$host:$port');
    print('Press Ctrl+C to stop the server');
  }

  Future<void> stop() async {
    await _server.close();
    print('Server stopped');
  }

  // CORS middleware for web clients
  Middleware _corsMiddleware() {
    return createMiddleware(
      responseHandler: (Response response) {
        return response.change(
          headers: {
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
            'Access-Control-Allow-Headers': 'Content-Type, Authorization',
          },
        );
      },
      requestHandler: (Request request) {
        if (request.method == 'OPTIONS') {
          return Response.ok(
            '',
            headers: {
              'Access-Control-Allow-Origin': '*',
              'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
              'Access-Control-Allow-Headers': 'Content-Type, Authorization',
            },
          );
        }
        return null;
      },
    );
  }
}

// Utility function for easy server creation
Future<WebServer> createServer({String host = 'localhost', int port = 8080}) async {
  final server = WebServer();
  await server.start(host: host, port: port);
  return server;
}
