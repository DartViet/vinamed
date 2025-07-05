import 'dart:convert';
import 'dart:io';
import 'package:webserver/webserver.dart';
import 'package:test/test.dart';

void main() {
  group('WebServer Tests', () {
    late WebServer server;
    late HttpClient client;
    const host = 'localhost';
    const port = 8081; // Use different port for testing

    setUp(() async {
      server = WebServer();
      await server.start(host: host, port: port);
      client = HttpClient();
    });

    tearDown(() async {
      await server.stop();
      client.close();
    });

    test('health endpoint returns healthy status', () async {
      final request = await client.get(host, port, '/health');
      final response = await request.close();
      final body = await response.transform(utf8.decoder).join();

      expect(response.statusCode, equals(200));
      expect(response.headers.contentType?.mimeType, equals('application/json'));

      final data = jsonDecode(body);
      expect(data['status'], equals('healthy'));
      expect(data['timestamp'], isNotNull);
    });

    test('users endpoint returns list of users', () async {
      final request = await client.get(host, port, '/api/users');
      final response = await request.close();
      final body = await response.transform(utf8.decoder).join();

      expect(response.statusCode, equals(200));
      expect(response.headers.contentType?.mimeType, equals('application/json'));

      final data = jsonDecode(body);
      expect(data['users'], isList);
      expect(data['users'].length, greaterThan(0));
    });

    test('user by id endpoint returns specific user', () async {
      final request = await client.get(host, port, '/api/users/123');
      final response = await request.close();
      final body = await response.transform(utf8.decoder).join();

      expect(response.statusCode, equals(200));
      expect(response.headers.contentType?.mimeType, equals('application/json'));

      final data = jsonDecode(body);
      expect(data['user']['id'], equals(123));
      expect(data['user']['name'], isNotNull);
    });

    test('invalid user id returns bad request', () async {
      final request = await client.get(host, port, '/api/users/invalid');
      final response = await request.close();
      final body = await response.transform(utf8.decoder).join();

      expect(response.statusCode, equals(400));

      final data = jsonDecode(body);
      expect(data['error'], equals('Invalid user ID'));
    });

    test('create user endpoint accepts POST requests', () async {
      final request = await client.post(host, port, '/api/users');
      request.headers.set('content-type', 'application/json');
      request.write('{"name": "Test User", "email": "test@example.com"}');

      final response = await request.close();
      final body = await response.transform(utf8.decoder).join();

      expect(response.statusCode, equals(200));
      expect(response.headers.contentType?.mimeType, equals('application/json'));

      final data = jsonDecode(body);
      expect(data['message'], equals('User created successfully'));
      expect(data['user'], isNotNull);
    });
  });
}
