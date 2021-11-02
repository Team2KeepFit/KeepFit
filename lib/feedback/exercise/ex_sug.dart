import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Exercise extends StatefulWidget {
  @override
  _ExerciseState createState() => _ExerciseState();
}

class _ExerciseState extends State<Exercise> {
  late String exer;
  String equip="None";
  String desc="NULL";

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

  ex_nam(String ex){
    exer=ex;
  }
  equipment(String eq) {
    equip=eq;
  }
  description(String des) {
    desc=des;
  }

  uupdate() {
    Map<String,dynamic> demo ={"exercise_name " : exer,"equipments_required" : equip,"Descripion" : desc};
    CollectionReference collectionReference = FirebaseFirestore.instance.collection('Feedback/feedback/ex_sug');
    collectionReference.add(demo);
  }

  showAlertDialog(BuildContext context){
    Widget okButton = TextButton(
      onPressed: () {Navigator.of(context,rootNavigator: true).pop(Dialog);}, 
      child: Text("OK"),
    );
    AlertDialog alert =AlertDialog(
      title: Text("Exercise Suggestion submitted"),
      content: Text("Thank for for the feedback.Exercise has been submitted and will be added(if verfied) as soon as possible."),
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
  final TextEditingController _controller3 = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Form (
        key: _formKey,
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
            SizedBox(height: 10.0), 
            Container(
              height: 20.0,
              child : TextFormField(
                onChanged: (String ex) { ex_nam(ex);},
                controller: _controller1,
                validator: (value) {
                    if(value!.isEmpty) {
                      return "Enter the name of the exercise to submit";
                    }
                    else {
                      return null;
                    }
                  },
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
            SizedBox(height: 10.0), 
            Container(
              height: 20.0,
              child : TextFormField(
                onChanged: (String eq) {equipment(eq);},
                controller: _controller2,
                decoration: InputDecoration(
                  hintText: "Eg : Dumbbells,Lifting rod",
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
              child : TextFormField(
                maxLines: 5,
                onChanged: (String des) {description(des);},
                controller: _controller3,
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
                        _controller3.clear();
                        equip="None";
                        desc="NULL";
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