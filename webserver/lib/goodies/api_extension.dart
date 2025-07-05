class NetWorkConfig {
  // Private constructor
  NetWorkConfig._();

  // Static instance variable
  static final NetWorkConfig _instance = NetWorkConfig._();

  // Public accessor for the singleton instance
  static NetWorkConfig get instance => _instance;

  String host = 'localhost';
  int port = 8080;
  String apiVersion = 'v1';
  String get baseApiUrl => 'http://$host:$port/api/$apiVersion';
}
