import 'package:flutter/material.dart';
import 'package:keepfit/feedback/options/options.dart';
import 'package:keepfit/Planner/planner.dart';
import 'package:keepfit/search/search.dart';
import 'package:keepfit/timer/timer_ac.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'KeepFit',
          textAlign: TextAlign.center,
        ),
        //leading: new Container(),
        /*BackButton(
          color: Colors.white,
          onPressed: () => {},
        ),*/
        elevation: 2.0,
      ),
      body: _buildContent(context),
    );
  } 

void exsearch(BuildContext context) {
  Navigator.of(context).push (
    MaterialPageRoute(
      builder: (context) => Search(),
      )
  );
}

  void plan(BuildContext context) {
    Navigator.of(context).push (
        MaterialPageRoute(
          builder: (context) => Planner(),
        )
    );
  }

/*void exsug(BuildContext context) {
  Navigator.of(context).push (
    MaterialPageRoute(
      builder: (context) => Exercise(),
      )
  );
}*/

void fdbk(BuildContext context) {
  Navigator.of(context).push (
    MaterialPageRoute(
      builder: (context) => Options(),
      )
  );
}

void timer(BuildContext context) {
  Navigator.of(context).push (
    MaterialPageRoute(
      builder: (context) => timer_home_page(),
      )
  );
}

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          /*Text(
            'Select an Option',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
             ),
          ),*/
          //SizedBox(height: 30.0),
          /*Container(
            color: Colors.indigo[200],
            child: SizedBox(
              width: 200.0,
              height: 60.0,
            ),
          ),*/
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.indigo[300],
              onSurface: Colors.grey,
              padding: EdgeInsets.all(12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),

            ),
            child: Text(
              'Exercise Planner',
              style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
             ),
            ),
            onPressed: () => plan(context),
          ),
          SizedBox(height: 15.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.indigo[300],
              onSurface: Colors.grey,
              padding: EdgeInsets.all(12.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
            ),
            child: Text(
              'Exercise Search',
              style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
             ),
              ),
            onPressed: () => exsearch(context),

          ),
          SizedBox(height: 15.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.indigo[300],
              onSurface: Colors.grey,
              padding: EdgeInsets.all(14.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              )
            ),
            child: Text(
              'Timer',
              style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
             ),
              ),
            onPressed: ()  => timer(context),

          ),
          SizedBox(height: 15.0),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.indigo[300],
              onSurface: Colors.grey,
              padding: EdgeInsets.all(14.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15)),
              )
            ),
            child: Text(
              'Feedback',
              style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
             ),
              ),
            onPressed: () => fdbk(context),

          ),
        ]
    ));
  }
}
