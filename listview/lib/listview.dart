// ignore_for_file: camel_case_types
// https://github.com/vyniexec
import 'package:flutter/material.dart';

class listview extends StatefulWidget {
  const listview({super.key});

  @override
  State<listview> createState() => _listviewState();
}

// https://github.com/vyniexec
class _listviewState extends State<listview> {
  List _itens = [];

  void carregarItens() {
    _itens = [];
    for (int i = 0; i <= 10; i++) {
      Map<String, dynamic> item = {};
      item['titulo'] = 'Título $i';
      item['descricao'] = 'Esta descrição é referente ao número $i';
      _itens.add(item);
    }
  }

  @override
  Widget build(BuildContext context) {
    carregarItens();

    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
            itemCount: _itens.length,
            itemBuilder: (context, indice) {
// https://github.com/vyniexec
              return ListTile(
                title: Text(_itens[indice]['titulo']),
                onTap: (() {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(_itens[indice]['titulo']),
                          content: Text(_itens[indice]['descricao']),
                          actions: [
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.blue)),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'SIM',
                                  style: TextStyle(color: Colors.black),
                                )),
                            ElevatedButton(
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.blue)),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'NÃO',
                                  style: TextStyle(color: Colors.black),
                                ))
                          ],
                        );
                      });
                }),
                // onLongPress: (() {
                //   print('ONLONGPRESS');
                // }),
                subtitle: Text(_itens[indice]['descricao']),
              );
            }),
      ),
    );
  }
}
// https://github.com/vyniexec