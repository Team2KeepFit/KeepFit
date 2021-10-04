import 'package:flutter/material.dart';

class Issue extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KeepFit',
          textAlign: TextAlign.center,
        ),
        elevation: 2.0,
        leading: BackButton(
          color: Colors.white,
          onPressed: () => Navigator.pop(context),
        ),
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
            'Report Issue',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
             ),
          ),
          SizedBox(height: 30.0),
          Container(
            height: 150.0,
            child : TextField(
              //s
              maxLines: 15,
              decoration: InputDecoration(
                hintText: "Please briefly describe the issue",
                hintStyle: TextStyle(
                  fontSize: 13.0,
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
                  onPressed: () { Issue(); },
              ),
              ]
            )
          )
        ]
      )
    );
  }
}