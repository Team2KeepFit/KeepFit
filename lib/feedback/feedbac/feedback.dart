import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Feedbac extends StatefulWidget {
  @override
  _FeedbacState createState() => _FeedbacState();
}

class _FeedbacState extends State<Feedbac> {
  late String rat;
  String fk="NULL";

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

rating(String rate) {
  rat=rate;
}

feed(String ds){
  fk=ds;
}
uupdate() {
    Map<String,dynamic> demo ={"rating " : rat,"suggestion" : fk};
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('Feedback/feedback/gen_sug');
    collectionReference.add(demo);
  }

showAlertDialog(BuildContext context){
    Widget okButton = TextButton(
      onPressed: () {Navigator.of(context,rootNavigator: true).pop(Dialog);}, 
      child: Text("OK"),
    );
    AlertDialog alert =AlertDialog(
      title: Text("Feedback submitted"),
      content: Text("Thank for for the feedback."),
      actions: [okButton,],
    );
    showDialog(
      context: context, 
      builder: (BuildContext context) {
        return alert;
      }
    );
  }
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Feedback',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30.0),
            
            Text(
              '1. Enter the Rating for this app',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 10.0), 
            
            
            Container(
              height: 20.0,
              child : TextFormField(
                onChanged: (String rate) { rating(rate);},
                controller: _controller1,
                validator: (value) {
                    if(value!.isEmpty || !RegExp(r'^([1-9]|10)$').hasMatch(value)) {
                      return "Enter the number between 1 and 10";
                    }
                    else {
                      return null;
                    }
                  },
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly
                ],
                decoration: InputDecoration(
                  hintText: "Please rate the app between 0 to 10",
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
              '2. Suggestions (if any)',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 16.0,
              ),
            ),
            SizedBox(height: 5.0), 
            Container(
              height: 150.0,
              child : TextFormField(
                maxLines: 5,
                onChanged: (String ds) {feed(ds);},
                controller: _controller2,
                decoration: InputDecoration(
                  hintText: "Please enter the suggestions if any",
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
                      fixedSize: Size(110.0,30.0),
                      //shape
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () { 
                      if(_formKey.currentState!.validate()) {
                        uupdate();
                        showAlertDialog(context);
                        _controller1.clear();
                        _controller2.clear();
                        fk="NULL";
                      }  
                    },
                  ),
                ]
              )
            )
          ]
        )
      )
    );
  }
}