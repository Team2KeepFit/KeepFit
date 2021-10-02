import 'package:flutter/material.dart';
import 'package:keepfit/feedback/feedbac/feedback.dart';
import 'package:keepfit/feedback/issue/issue.dart';
import 'package:keepfit/feedback/exercise/ex_sug.dart';

class Options extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'KeepFit',
          textAlign: TextAlign.center,
        ),
        elevation: 2.0,
      ),
      body: _buildContent(context),
    );
}  

void exsug(BuildContext context) {
  //Exercise();
  Navigator.of(context).push (
    MaterialPageRoute(
      builder: (context) => Exercise(),
      )
  );
}

void fdbk(BuildContext context) {
  //Exercise();
  Navigator.of(context).push (
    MaterialPageRoute(
      builder: (context) => Feedbac(),
      )
  );
}

void issue(BuildContext context) {
  //Exercise();
  Navigator.of(context).push (
    MaterialPageRoute(
      builder: (context) => Issue(),
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
          Text(
            'Select an Option',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
             ),
          ),
          SizedBox(height: 30.0),
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
              'Feedback',
              style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
             ),
            ),
            onPressed: () => fdbk(context),
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
              'Report Issue',
              style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
             ),
              ),
            onPressed: () => issue(context),

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
              'Exercise suggestion',
              style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
             ),
              ),
            onPressed: ()  => exsug(context),

          ),
        ]
    ));
  }
}