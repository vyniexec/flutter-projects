// ignore_for_file: file_names, unused_local_variable, prefer_typing_uninitialized_variables, unused_import, must_be_immutable, use_key_in_widget_constructors, no_logic_in_create_state, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:youtube/api.dart';
import 'package:youtube/model/Video.dart';
import 'package:youtube/telas/EmAlta.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'CustomSearch.dart';
import 'telas/Inicio.dart';

class PlayVideoTeste extends StatefulWidget {
  String id;
  PlayVideoTeste({required this.id});
  @override
  State<PlayVideoTeste> createState() => _PlayVideoTesteState(id: id);
}

class _PlayVideoTesteState extends State<PlayVideoTeste> {
  String id;
  _PlayVideoTesteState({required this.id});
  late YoutubePlayerController _controller;

  @override
  void initState() {
    final videoID = id;
    int seconds = 0;
    _controller = YoutubePlayerController(
        initialVideoId: videoID,
        flags: YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          isLive: false,
        ));
    super.initState();
  }

  String resultado = '';
  @override
  Widget build(BuildContext context) {
    List<Widget> telas = [
      Inicio(resultado),
    ];
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.red,
        progressColors: ProgressBarColors(
          playedColor: Colors.red,
          handleColor: Color.fromARGB(255, 97, 0, 0),
        ),
      ),
      builder: (context, player) => Scaffold(
        backgroundColor: Color.fromARGB(255, 12, 12, 12),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.grey),
          backgroundColor: Color.fromARGB(255, 12, 12, 12),
          title: GestureDetector(
            onTap: () {
              resultado = '';
            },
            child: Image.asset(
              "images/youtubeDark.png",
              width: 98,
              height: 22,
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                String res = await showSearch(
                    context: context,
                    delegate: CustomSearchDelegate()) as String;
                setState(() {
                  resultado = res;
                });
              },
            ),
          ],
        ),
        body: 
        ListView(
          children: [
            player,
            Text('${_controller.metadata.title}',
                style: TextStyle(color: Colors.white)),
            Text('${_controller.metadata.author}',
              style: TextStyle(color: Colors.white)),
            Text('${_controller.metadata.duration} seconds',
              style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
    );
  }
}