import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube/CustomSearch.dart';
import 'package:youtube/telas/library.dart';
import 'package:youtube/telas/EmAlta.dart';
import 'package:youtube/telas/Inicio.dart';
import 'package:youtube/telas/Inscricao.dart';

class youtube extends StatefulWidget {
  @override
  _youtubeState createState() => _youtubeState();
}

class _youtubeState extends State<youtube> {
  String resultado = '';
  int _indiceAtual = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> telas = [
      Inicio(resultado),
      EmAlta(),
      Inscricao(),
      Biblioteca()
    ];
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Color.fromARGB(255, 12, 12, 12)));
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey),
        backgroundColor: Color.fromARGB(255, 12, 12, 12),
        title: Image.asset(
          "images/youtubeDark.png",
          width: 98,
          height: 22,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () async {
              String res = await showSearch(
                  context: context, delegate: CustomSearchDelegate()) as String;
              setState(() {
                resultado = res;
              });
            },
          ),
        ],
      ),
      body: Container(
        color: Color.fromARGB(255, 12, 12, 12),
        padding: const EdgeInsets.all(16),
        child: telas[_indiceAtual],
      ),
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Color.fromARGB(155, 255, 255, 255),
          currentIndex: _indiceAtual,
          onTap: (indice) {
            setState(() {
              _indiceAtual = indice;
            });
          },
          type: BottomNavigationBarType.fixed,
          backgroundColor: Color.fromARGB(255, 12, 12, 12),
          fixedColor: Colors.white,
          items: const [
            BottomNavigationBarItem(
                label: 'Início',
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                )),
            BottomNavigationBarItem(
                label: 'Em alta',
                icon: Icon(
                  Icons.whatshot,
                  color: Colors.white,
                )),
            BottomNavigationBarItem(
                label: 'Inscrições',
                icon: Icon(
                  Icons.subscriptions,
                  color: Colors.white,
                )),
            BottomNavigationBarItem(
                label: 'Biblioteca',
                icon: Icon(
                  Icons.folder,
                  color: Colors.white,
                )),
          ]),
    );
  }
}
