import 'package:flutter/material.dart';

class timers extends StatefulWidget {
  timers({Key? key}) : super(key: key);
  @override
  timersState createState() => timersState();
}

class timersState extends State<timers> {
  int mins=0;
  int secs=0;
  bool allowed=true;
  void allowedmodifier(bool x){
    setState(() {
      allowed=x;
    });
  }
  void timemodifier(int m,int s){
    setState(() {
      mins=m;
      secs=s;
    });
  }
  void inc_mins(){
    setState(() {
      mins+=1;
      mins%=60;
    });
  }
  void dec_mins(){
    setState(() {
      mins-=1;
      if(mins<0)
        mins=59;
    });
  }
  void inc_secs(){
    setState(() {
      secs+=1;
      secs%=60;
    });
  }
  void dec_secs(){
    setState(() {
      secs-=1;
      if(secs<0)
        secs=59;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed:(allowed==true)?inc_mins:(){},
              icon: Icon(
                Icons.arrow_drop_up,
                size: 40,
                color: (allowed==true)?Colors.black45:(Color(0x00000000)),
              ),
            ),
            IconButton(onPressed:(allowed==true)?dec_mins:(){},
              icon: Icon(
                Icons.arrow_drop_down,
                size: 40,
                color: (allowed==true)?Colors.black45:(Color(0x00000000)),
              ),
            ),
          ],
        ),
        Container(
          width: 250,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.black45,
              border: Border.all(
                color: Colors.black,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onVerticalDragStart: (DragStartDetails){
                },
                onVerticalDragUpdate: (DragUpdateDetails){
                  if(allowed==true){
                    setState(() {
                      mins-=(DragUpdateDetails.primaryDelta! * 0.65).toInt();
                      if(mins<0){
                        mins=0;
                      }
                      mins%=60;
                    });
                  }
                },
                child: Text(
                    (mins<10)?"0$mins":"$mins",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    )
                ),
              ),
              Text(
                ":",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                ),
              ),
              GestureDetector(
                onVerticalDragStart: (DragStartDetails){
                },
                onVerticalDragUpdate: (DragUpdateDetails){
                  if(allowed==true){
                    setState(() {
                      secs-=(DragUpdateDetails.primaryDelta! * 0.65).toInt();
                      if(secs<0){
                        secs=0;
                      }
                      secs%=60;
                    });
                  }
                },
                child: Text(
                    (secs<10)?"0$secs":"$secs",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    )
                ),
              ),
            ],
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed:(allowed==true)?inc_secs:(){},
              icon: Icon(
                Icons.arrow_drop_up,
                size: 40,
                color: (allowed==true)?Colors.black45:(Color(0x00000000)),
              ),
            ),
            IconButton(onPressed:(allowed==true)?dec_secs:(){},
              icon: Icon(
                Icons.arrow_drop_down,
                size: 40,
                color: (allowed==true)?Colors.black45:(Color(0x00000000)),
              ),
            ),
          ],
        ),
      ],
    );
  }
}