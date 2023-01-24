import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, query);
    return Text('');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> listSuggest = ["Android", "Android navegação", "IOS", "Jogos"];
    List<String> lista = [];
    if (query.isNotEmpty) {
      lista.addAll(
          listSuggest.where((texto) => texto.toLowerCase().startsWith(query)));
      return ListView.builder(
          itemCount: lista.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {
                close(context, lista[index]);
              },
              title: Text(lista[index]),
            );
          });
    } else {
      return Center(
        child: Text("Nenhum resultado para a pesquisa!"),
      );
    }
  }
}
