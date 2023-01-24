import 'Post.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

// https://github.com/vyniexec

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String _urlBase = "https://jsonplaceholder.typicode.com";

  Future<List<Post>> _recuperarPostagens() async {
    http.Response response = await http.get("$_urlBase/posts");
    var dadosJson = json.decode(response.body);

    List<Post> postagens = [];
    for (var post in dadosJson) {
      Post p = Post(post["userId"], post["id"], post["title"], post["body"]);
      postagens.add(p);
    }
    return postagens;
    //print( postagens.toString() );
  }

  _post() async {
    var corpo = json.encode({
      "userId": 120,
      "id": null,
      "title": "Titulo",
      "body": "Corpo da postagem"
    });

    http.Response response = await http.post("$_urlBase/posts",
        headers: {"Content-type": "application/json; charset=UTF-8"},
        body: corpo);

    print("resposta: ${response.statusCode}");
    print("resposta: ${response.body}");
  }

// https://github.com/vyniexec

  _put() async {
    var corpo = json.encode({
      "userId": 120,
      "id": null,
      "title": "Titulo alterado",
      "body": "Corpo da postagem alterada"
    });

    http.Response response = await http.put("$_urlBase/posts/1",
        headers: {"Content-type": "application/json; charset=UTF-8"},
        body: corpo);

    print("resposta: ${response.statusCode}");
    print("resposta: ${response.body}");
  }

  _delete() async {
    http.Response response = await http.delete("$_urlBase/posts/1");
    print("resposta: ${response.statusCode}");
    print("resposta: ${response.body}");
  }

// https://github.com/vyniexec
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Consumo de serviço avançado"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: _post,
                  child: const Text("Salvar"),
                ),
                ElevatedButton(
                  onPressed: _put,
                  child: const Text("Atualizar"),
                ),
                ElevatedButton(
                  onPressed: _delete,
                  child: const Text("Remover"),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder<List<Post>>(
                future: _recuperarPostagens(),
                // ignore: missing_return
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                      break;
                    case ConnectionState.active:
                    case ConnectionState.done:
                      if (snapshot.hasError) {
                        print("lista: Erro ao carregar ");
                      } else {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, index) {
                              List<Post> lista = snapshot.data;
                              Post post = lista[index];

                              return ListTile(
                                title: Text(post.title),
                                subtitle: Text(post.id.toString()),
                              );
                            });
                      }
                      break;
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
// https://github.com/vyniexec