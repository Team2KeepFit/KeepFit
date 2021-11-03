import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';



class SearchResult extends StatelessWidget {
  final Map<String,dynamic> details;
  final String name;
  const SearchResult({Key? key,required this.details,required this.name}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'KeepFit',
          textAlign: TextAlign.center,
        ),
        elevation: 2.0,
        leading: BackButton(
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ExerciseContent(details: details,name: name),
    );
  }
}

class ExerciseContent extends StatefulWidget {
  final Map<String,dynamic> details;
  final String name;
  const ExerciseContent({Key? key,required this.details,required this.name}) : super(key: key);

  @override
  _ExerciseContentState createState() => _ExerciseContentState();
}

class _ExerciseContentState extends State<ExerciseContent> {
  Map<String,dynamic> get details{
    return widget.details;
  }
  String get name{
    return widget.name;
  }
  String get url{
    return details["Tutorial Link"];
  }
  List<Widget> get shows{
    List<Widget> de_vid=[];
    de_vid.add(
        Text(
          name,
          style: const TextStyle(
            decoration: TextDecoration.underline,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        )
    );
    for(var field in details.keys)
    {
      if(field!="Tutorial Link")
      {
        de_vid.add(
            Container(
              alignment: Alignment.centerLeft,
              child: Text(
                "$field : ${details[field]}",
              ),
            )
        );
      }
    }
    return de_vid;
  }
  List<Widget> result_column(List<Widget> x,Widget player)
  {
   x.add(player);
   return x;
  }
  late YoutubePlayerController _controller;
  void runYoutubePlayer()
  {
    _controller=YoutubePlayerController(initialVideoId: YoutubePlayer.convertUrlToId(url)!,
      flags: const YoutubePlayerFlags(
        autoPlay: false
      ),
    );
  }

  @override
  void initState()
  {
    runYoutubePlayer();
    super.initState();
  }

  @override
  void dispose()
  {
    _controller.dispose();
    super.dispose();
  }
  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }
  @override
  Widget build(BuildContext context)
  {
    return YoutubePlayerBuilder(player: YoutubePlayer(controller: _controller,),
        builder: (context,player)
        {
          return Center(
              child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: result_column(shows,player),
              )
          );
        }
    );
  }
}



