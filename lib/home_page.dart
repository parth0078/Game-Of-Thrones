import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gameofthronesapp/episode_page.dart';
import 'package:gameofthronesapp/models/game_of_thron_data.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url =
      "http://api.tvmaze.com/singlesearch/shows?q=game-of-thrones&embed=episodes";

  GameOfThronData _gameOfThronData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  fetchData() async {
    var response = await http.get(url);
    var jsonDecoded = jsonDecode(response.body);
    print(response.body);
    _gameOfThronData = GameOfThronData.fromJson(jsonDecoded);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Game Of Thrones"),
      ),
      drawer: Drawer(),
      body: _gameOfThronData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Hero(

                      tag:"g1",
                      child: CircleAvatar(
                        radius: 100,
                        backgroundImage:
                            NetworkImage(_gameOfThronData.image.original),
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      _gameOfThronData.name,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 22 ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "RunTime : " +
                          _gameOfThronData.runtime.toString() +
                          " minutes",
                      style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(_gameOfThronData.summary),
                    SizedBox(
                      height: 10.0,
                    ),
                    OutlineButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return EpisodePage(episode: _gameOfThronData.eEmbedded.episodes,
                          myImage: _gameOfThronData.image,);
                        }));
                      },
                      child: Text("All Episode"),
                    )
                  ],
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.refresh),
      ),
    );
  }
}
