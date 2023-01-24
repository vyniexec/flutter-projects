import 'package:flutter/material.dart';
import 'package:youtube/Api.dart';
import 'package:youtube/interface.dart';
import 'YoutubePlay.dart';

import '../model/Video.dart';

class Inicio extends StatefulWidget {
  String pesquisa;
  Inicio(this.pesquisa);
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  _listarVideo(String p) {
    Api api = Api();
    return api.pesquisar(p);
  }

  @override
  void initState() {
    super.initState();
    print("chamado 1 - initState");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("chamado 2 - didChangeDependencies");
  }

  void _abrirTelaVideo(Video video) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => YoutubePlay(video: video)));
  }

  @override
  void didUpdateWidget(covariant Inicio oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("chamado 2 - didUpdateWidget");
  }

  @override
  void dispose() {
    super.dispose();
    //descarrega a tela ou quando finaliza a execução da mesma
    print("chamado 4 - dispose");
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Video>>(
      future: _listarVideo(widget.pesquisa),
      builder: (contex, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: ((context, index) {
                    List<Video>? videos = snapshot.data;
                    Video video = videos![index];
                    return GestureDetector(
                      onTap: () {
                        _abrirTelaVideo(video);
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage('${video.imagem}'))),
                          ),
                          ListTile(
                            title: Text(
                              '${video.titulo}',
                              style: TextStyle(color: Colors.white),
                            ),
                            subtitle: Text('${video.canal}',
                                style: TextStyle(color: Colors.white)),
                          )
                        ],
                      ),
                    );
                  }),
                  itemCount: snapshot.data!.length,
                  separatorBuilder: ((context, index) => const Divider(
                        height: 2,
                        color: Colors.grey,
                      )));
            } else {
              return const Center(
                child: Text('Nenhum dado a ser exebido!'),
              );
            }
            break;
        }
      },
    );
  }
}
