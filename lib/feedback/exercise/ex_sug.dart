import 'package:flutter/material.dart';

class Exercise extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KeepFit',
          textAlign: TextAlign.center,
        ),
        elevation: 2.0,
      ),
      body: _buildContent(),
    );
}  

 Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            'Exercise Suggestion',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
             ),
          ),
          SizedBox(height: 30.0),
          
          Text(
            '1. Enter the Name of the exercise',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 16.0,
             ),
          ),
          SizedBox(height: 5.0), 
          Container(
            height: 20.0,
            child : TextField(
              decoration: InputDecoration(
                hintText: "Eg : Pushups",
                hintStyle: TextStyle(
                  fontSize: 15.0,
                  color: Colors.indigo,
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
           SizedBox(height: 20.0), 

           Text(
            '1. Equipments Required (comma seperated)',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 16.0,
             ),
          ),
          SizedBox(height: 5.0), 
          Container(
            height: 20.0,
            child : TextField(
              decoration: InputDecoration(
                hintText: "Eg : Dumbbells,Lifting rod or none",
                hintStyle: TextStyle(
                  fontSize: 15.0,
                  color: Colors.indigo,
                ),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
           SizedBox(height: 20.0), 


          Text(
            '2. Description',
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 16.0,
             ),
          ),
          SizedBox(height: 5.0), 
          Container(
            height: 150.0,
            child : TextField(
              maxLines: 5,
              decoration: InputDecoration(
                hintText: "Please give the description of the exercise",
                hintStyle: TextStyle(
                  fontSize: 15.0,
                  color: Colors.indigo,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          
          SizedBox(height: 15.0),
          //@override
          Container(
            child: Row (
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget> [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigo[300],
                    onSurface: Colors.grey,
                    //padding: EdgeInsets.all(2.0),
                    alignment: Alignment.center,
                    fixedSize: Size(80.0,30.0),
                    //shape
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () { Exercise(); },
              ),
              ]
            )
          )
        ]
      )
    );
  }
}