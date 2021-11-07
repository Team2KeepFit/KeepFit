import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audioplayers/src/audio_cache.dart';
import 'package:keepfit/timer/timer_widget_ui.dart';


class timer_home_page extends StatelessWidget {
  const timer_home_page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
      appBar: AppBar(
      centerTitle: true,
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
    body: extendibletimer(),
    ),
    debugShowCheckedModeBanner: false,
    );
  }
}

List timer_widgets_keys=[GlobalKey<timersState>()];
class extendibletimer extends StatefulWidget {
  const extendibletimer({Key? key}) : super(key: key);

  @override
  _extendibletimerState createState() => _extendibletimerState();
}


class _extendibletimerState extends State<extendibletimer> {

  List<Widget> timer_widgets=[timers(key: timer_widgets_keys[timer_widgets_keys.length-1])];
  bool _startedplay=false;
  bool _paused=false;
  int _timer_traverser=0;
  bool _isplaying=false;
  int _sets=1;
  Timer? _timer;
  void timeradder()
  {
    setState(() {
      timer_widgets_keys.add(GlobalKey<timersState>());
      timer_widgets.add(Container(
        height: 30,
      ));
      timer_widgets.add(timers(key: timer_widgets_keys[timer_widgets_keys.length-1]));
    });
  }
  void timerremover()
  {
    setState(() {
      if(timer_widgets.length>1) {
        timer_widgets_keys.removeLast();
        timer_widgets.removeLast();
        timer_widgets.removeLast();
      }
    });
  }
  void pauser()
  {
    setState(() {
      _isplaying=false;
      _paused=true;
      if(_timer!.isActive) {
        _timer!.cancel();
      }
    });
  }
  void resetter()
  {
    setState(() {
      _isplaying=false;
      _sets=1;
      _timer!.cancel();
      _startedplay=false;
      timer_widgets.clear();
      timer_widgets_keys.clear();
      timer_widgets_keys=[GlobalKey<timersState>()];
      timer_widgets=[timers(key: timer_widgets_keys[timer_widgets_keys.length-1])];
      _timer_traverser=0;
    });
  }
  void inc_sets()
  {
    setState(() {
      _sets++;
    });
  }
  void dec_sets()
  {
    setState(() {
      _sets--;
      if(_sets<1)
        _sets=1;
    });
  }
  void player()
  {
    List<List<int>> time_val_timers=[];
    for(int i=0;i<timer_widgets_keys.length;i++) {
      List<int> temp=[];
       temp.add(timer_widgets_keys[i].currentState.mins);
      temp.add(timer_widgets_keys[i].currentState.secs);
      time_val_timers.add(temp);
    }
    setState(() {
      _startedplay=true;
      _paused=false;
      _isplaying=true;
      for(int i=0;i<timer_widgets_keys.length;i++)
        timer_widgets_keys[i].currentState.allowedmodifier(false);
    });

    //while(_timer_traverser<timer_widgets.length)
      //{
        _timer=Timer.periodic(const Duration(seconds: 1), (timer) {
          if (timer_widgets_keys[_timer_traverser].currentState.mins*60+timer_widgets_keys[_timer_traverser].currentState.secs > 0) {
            setState(() {
              if ((timer_widgets_keys[_timer_traverser].currentState.mins*60+timer_widgets_keys[_timer_traverser].currentState.secs)%60== 0){
                timer_widgets_keys[_timer_traverser].currentState.timemodifier(timer_widgets_keys[_timer_traverser].currentState.mins-1,59);
              }
              else{
                timer_widgets_keys[_timer_traverser].currentState.timemodifier(timer_widgets_keys[_timer_traverser].currentState.mins,timer_widgets_keys[_timer_traverser].currentState.secs-1);
              }
            });
          } else {
              final player = AudioCache();
              player.play('finished.wav');
              setState(() {
                _timer_traverser++;
              });
              print("$_timer_traverser");
              if(_timer_traverser>=timer_widgets_keys.length) {
                if (_sets<=1) {
                  _timer!.cancel();
                  final player = AudioCache();
                  player.play('finished.wav');
                  for(int i=0;i<timer_widgets_keys.length;i++)
                    timer_widgets_keys[i].currentState.allowedmodifier(true);
                  _timer_traverser=0;
                  _isplaying=false;
                  _paused=true;
                  _sets=1;
                }
                else{
                  setState(() {
                    _sets--;
                    _timer_traverser=0;
                  });
                  for(int i=0;i<timer_widgets_keys.length;i++){
                    setState(() {
                      timer_widgets_keys[i].currentState.timemodifier(time_val_timers[i][0],time_val_timers[i][1]);
                    });
                  }

                }
              }
          }
        });
      //}
  }
  Widget get addremove{
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: timeradder,
            icon: Icon(
              Icons.add_circle_outline,
              color: Colors.blueAccent,
              size: 35,
            ),
        ),
        IconButton(onPressed: timerremover,
          icon: Icon(
            Icons.remove_circle_outline,
            size: 35,
            color: (timer_widgets.length>1)?Colors.blueAccent:Color(0x40448AFFFF),
          ),
        ),
      ],
    );
  }
  Widget get pausereset{
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: pauser,
          icon: Icon(
            Icons.pause,
            size: 35,
            color: (_paused==false)?Colors.blueAccent:Color(0x40448AFFFF),
          ),
        ),
        IconButton(onPressed:resetter,
          icon: Icon(
            Icons.refresh_rounded,
            size: 35,
            color: Colors.blueAccent,
          ),
        ),
      ],
    );
  }
  Widget get sets{
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(onPressed: (_isplaying==false)?dec_sets:(){},
          icon: Icon(
            Icons.arrow_left,
            size: 35,
            color: (_isplaying==false)?Colors.black45:Color(0x00448AFFFF),
          ),
        ),
        Text(
          "Sets: $_sets",
            style: TextStyle(
              color: Colors.black,
              fontSize: 40,
            )
        ),
        IconButton(onPressed:(_isplaying==false)?inc_sets:(){},
          icon: Icon(
            Icons.arrow_right,
            size: 35,
            color: (_isplaying==false)?Colors.black45:Color(0x00448AFFFF),
          ),
        ),
      ],
    );
  }
  IconButton get play_button{
    return IconButton(onPressed: (!_isplaying)?player:(){},
      icon: Icon(
        Icons.play_arrow_rounded,
        size: 35,
        color: (!_isplaying)?Colors.blueAccent:Color(0x40448AFFFF),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[sets]+ timer_widgets+[
            AnimatedCrossFade(firstChild: addremove, secondChild: pausereset, crossFadeState: (_startedplay==true)?CrossFadeState.showSecond:CrossFadeState.showFirst, duration: Duration(milliseconds: 250))
          ]+[play_button],
        ),
      ),
    );
  }
}
