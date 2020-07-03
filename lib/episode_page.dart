import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gameofthronesapp/models/game_of_thron_data.dart';

class EpisodePage extends StatelessWidget {
  final List<Episodes> episode;
  final Images myImage;

  EpisodePage({this.episode, this.myImage});

  showSummary(BuildContext context, String summary) {
    showDialog(
        context: context,
        builder: (context) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(summary),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Hero(
              tag: "g1",
              child: CircleAvatar(
                backgroundImage: NetworkImage(myImage.medium),
              ),
            ),
            SizedBox(
              width: 16.0,
            ),
            Text("All Episodes "),
          ],
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 5,
            mainAxisSpacing: 2
          ),
          itemCount: episode.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                showSummary(context, episode[index].summary);
              },
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(22.0),
                  ),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Image.network(
                      episode[index].image.original,
                      fit: BoxFit.cover,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          episode[index].name,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Positioned(
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blue,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(20))
                        ),

                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(episode[index].season.toString() +
                                " - " +
                                episode[index].number.toString()),
                          ),
                        ),
                      ),
                      left: 0,
                      top: 0,
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
