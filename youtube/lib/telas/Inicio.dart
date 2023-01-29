// ignore_for_file: prefer_const_constructors, prefer_final_fields, file_names
import 'package:flutter/material.dart';
import 'package:youtube/Api.dart';
import 'package:youtube/model/Video.dart';

import '../playVideo.dart';

class Inicio extends StatefulWidget {
  String pesquisa;

  Inicio(this.pesquisa);

  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  _listarVideos(String pesquisa) {
    Api api = Api();
    return api.pesquisar(pesquisa);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Video>>(
      future: _listarVideos(widget.pesquisa),
      builder: (contex, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(
              child: CircularProgressIndicator(),
            );
            break;
          case ConnectionState.active:
          case ConnectionState.done:
            if (snapshot.hasData) {
              return ListView.separated(
                  itemBuilder: (context, index) {
                    List<Video>? videos = snapshot.data;
                    Video video = videos![index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PlayVideoTeste(id: '${video.id}')));
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage('${video.imagem}'),
                            )),
                          ),
                          ListTile(
                            title: Text('${video.titulo}'),
                            subtitle: Text('${video.canal}'),
                          )
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(
                        height: 2,
                        color: Colors.grey,
                      ),
                  itemCount: snapshot.data!.length);
            } else {
              return Center(
                child: Text("Nenhum dado a ser exibido!"),
              );
            }
            break;
        }
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import '../Api.dart';
// import '../playVideo.dart';
// import '../model/Video.dart';

// class Inicio extends StatefulWidget {
//   String pesquisa;
//   Inicio(this.pesquisa, {super.key});
//   @override
//   _InicioState createState() => _InicioState();
// }

// class _InicioState extends State<Inicio> {
//   _listarVideo(String p) {
//     Api api = Api();
//     return api.pesquisar(p);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<Video>>(
//       future: _listarVideo(widget.pesquisa),
//       builder: (contex, snapshot) {
//         switch (snapshot.connectionState) {
//           case ConnectionState.none:
//           case ConnectionState.waiting:
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           case ConnectionState.active:
//           case ConnectionState.done:
//             if (snapshot.hasData) {
//               return ListView.separated(
//                   itemBuilder: ((context, index) {
//                     List<Video>? videos = snapshot.data;
//                     Video video = videos![index];
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 PlayVideoTeste(id: '${video.id}'),
//                           ),
//                         );
//                       },
//                       child: Column(
//                         children: [
//                           Container(
//                             height: 200,
//                             decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                     fit: BoxFit.cover,
//                                     image: NetworkImage('${video.imagem}'))),
//                           ),
//                           ListTile(
//                             title: Text(
//                               '${video.titulo}',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                             subtitle: Text('${video.canal}',
//                                 style: TextStyle(color: Colors.white)),
//                           )
//                         ],
//                       ),
//                     );
//                   }),
//                   itemCount: snapshot.data!.length,
//                   separatorBuilder: ((context, index) => const Divider(
//                         height: 2,
//                         color: Colors.grey,
//                       )));
//             } else {
//               return Center(
//                 child: Text("Nenhum dado a ser exibido!"),
//               );
//             }
//         }
//       },
//     );
//   }
// }
