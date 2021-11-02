import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Issue extends StatefulWidget {
  @override
  _IssueState createState() => _IssueState();
}

class _IssueState extends State<Issue> {
  late String iss;

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
      body: _buildContent(context),
    );
}  

change(String issue){
  iss=issue;
}

uupdate() {
  Map<String,dynamic> demo ={"issue " : iss};
  CollectionReference collectionReference = FirebaseFirestore.instance.collection('Feedback/feedback/issues');
  collectionReference.add(demo);
}

showAlertDialog(BuildContext context){
  Widget okButton = TextButton(
    onPressed: () {Navigator.of(context,rootNavigator: true).pop(Dialog);}, 
    child: Text("OK"),
  );
  AlertDialog alert =AlertDialog(
    title: Text("Issue submitted"),
    content: Text("Thank for for the feedback.Issue has been submitted and will be solved as soon as possible."),
    actions: [okButton,],
  );
  showDialog(
    context: context, 
    builder: (BuildContext context) {
      return alert;
    }
  );
}
final TextEditingController _controller = TextEditingController();
final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
 Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Form(
        key: _formKey,
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
              child : TextFormField(
                maxLines: 7,
                onChanged: (String issue) {change(issue);},
                controller: _controller,
                validator: (value) {
                  if(value!.isEmpty) {
                    return "Describe the issue to submit";
                  }
                  else {
                    return null;
                  }
                },
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
                        //Navigator.of(context). => _formKey.currentState.reset());
                        _controller.clear();
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