import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model/Video.dart';

const chaveApi = 'AIzaSyDrG6MGFu1cuJFg2jUlgECi7L6yTtcR0pQ';
const urlBase = 'https://www.googleapis.com/youtube/v3/';
const urlPesquisa = '$urlBase'
    'search'
    '?part=snippet'
    '&type=video'
    '&maxResults=20'
    '&order=date'
    '&key=$chaveApi';

class Api {
  Future<List<Video>> pesquisar(String pesquisa) async {
    final Uri urlPesquisa1 = Uri.parse('$urlPesquisa&q=$pesquisa');
    http.Response response = await http.get(urlPesquisa1);

    Map<String, dynamic> dadosJson = json.decode(response.body);

    List<Video> videos = dadosJson["items"].map<Video>((map) {
      return Video.fromJson(map);
    }).toList();

    return videos;
  }
}
