//! Repositório que vai pegar os dados da internet

import '../model/joke_model.dart';
import 'package:http/http.dart' as http;

class JokeRepository {
  final String _url = "https://v2.jokeapi.dev/joke/Any";

  Future<JokeModel> getJoke() async {
    final response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      return jokeModelFromJson(response.body);
    } else {
      throw Exception("Failed to load joke");
    }
  }
}
