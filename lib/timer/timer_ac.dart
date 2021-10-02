import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keepfit/homepage.dart';

// ignore: camel_case_types
class timer_home_page extends StatefulWidget {
  const timer_home_page({Key? key}) : super(key: key);
  

  @override
  _timer_home_pageState createState() => _timer_home_pageState();
}

// ignore: camel_case_types
class _timer_home_pageState extends State<timer_home_page> {
  TextEditingController myController=TextEditingController();
  // ignore: non_constant_identifier_names
  int _Counter=0;
  int _c = 0;
  late Timer _timer;

  void startTimer() {
    // _Counter = 30;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_Counter > 0) {
        setState(() {
          _Counter--;
        });
      } else {
        _timer.cancel();
      }
    });
  }

  void bb (BuildContext context) {
    Navigator.of(context).push (
      MaterialPageRoute(
        builder: (context) => HomePage(),
        )
    );
  }

  void setset() {
    _Counter=int.parse(myController.text);
    _c=_Counter;
    setState(() {});
}

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body:
      Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // AppBar(
            //   title: Text("Timer"),
            // ),

            Container(
            height: 40.0,
            width: 230.0,
            child: TextField( 
              controller: myController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                hintText: "Enter the number of seconds",
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
              onChanged: (text) {
                _timer.cancel();
            },
            ),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
              onPressed: () {
                setset();
                _timer.cancel();
              },
              child: const Text(
                'Set',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.indigo,
                fixedSize: Size(300, 50),
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: BorderSide(color: Colors.indigo)
                ),
              ),
            ),
           SizedBox(height: 30.0), 
            Text(
              'Timer for $_c seconds',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Text(
              '$_Counter',
              style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                //setset();
                startTimer();
              },
              child: const Text(
                'Start',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.indigo,
                fixedSize: Size(300, 50),
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: BorderSide(color: Colors.indigo)
                ),
              ),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                _timer.cancel();
              },
              child: const Text(
                'Pause',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.indigo,
                fixedSize: Size(300, 50),
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: BorderSide(color: Colors.indigo),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _timer.cancel();
                  _Counter = _c;
                });
              },
              child: const Text(
                'Reset',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.indigo,
                fixedSize: Size(300, 50),
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  side: BorderSide(color: Colors.indigo),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'KeepFit',
          textAlign: TextAlign.center,
        ),
        elevation: 2.0,
        leading: BackButton(
          color: Colors.white,
          onPressed: () => bb(context),
        ),
      ),

    );
  }
}