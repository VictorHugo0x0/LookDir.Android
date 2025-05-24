import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;

class Requests {
  String _url = "";

  Requests({required String url}) {
    this.url = url; // usa o setter para validar
  }

  String get url => _url;

  set url(String value) {
    if (isValidUrl(value)) {
      _url = value;
    } else {
      print("Url inválida: $value");
      _url = ""; // define vazio para evitar crashes
    }
  }

  static bool isValidUrl(String urlvalue) {
    try {
      final uri = Uri.parse(urlvalue);
      return (uri.scheme == 'http' || uri.scheme == 'https') &&
          uri.host.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<List<String>> readPayloads() async {
    try {
      final contents = await rootBundle.loadString(
        'assets/wordlist/wordlist.txt',
      );
      final lines =
          contents
              .split('\n')
              .map((line) => line.trim())
              .where((line) => line.isNotEmpty)
              .toList();
      return lines;
    } catch (e) {
      print("Erro ao ler o arquivo do assets: $e");
      return [];
    }
  }

  Future<List<String>> testPayloads() async {
    final payloads = await readPayloads();
    final List<String> validUrls = [];

    print('Base URL: $url');

    if (_url.isEmpty) {
      print('URL base inválida ou não definida.');
      return [];
    }

    for (final payload in payloads) {
      try {
        final baseUri = Uri.parse(url);
        final fullUri = Uri(
          scheme: baseUri.scheme,
          host: baseUri.host,
          port: baseUri.hasPort ? baseUri.port : null,
          pathSegments: [...baseUri.pathSegments, payload],
          queryParameters: null,
        );

        print('[Test] $fullUri');

        final response = await http.get(fullUri);
        print('[${response.statusCode}] $fullUri');

        if (response.statusCode == 200) {
          validUrls.add(fullUri.toString());
        }
      } catch (e) {
        print('Erro ao requisitar payload "$payload": $e');
      }
    }

    return validUrls;
  }
}
