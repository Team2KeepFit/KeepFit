import 'package:flutter/material.dart';

class DisplaySchedule extends StatelessWidget {
  final Map<String,dynamic> para;
  const DisplaySchedule({required this.para, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
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

  List<TableRow> Workout_Type()
  {
    List<TableRow> x=[];
    List p=["Monday","Tuesday","Wednesday","Thursday","Friday","Saturday","Sunday"];
    for (var i in p)
    {
      List<Widget> y=[];
      y.add(
          Container(
            padding: const EdgeInsets.all(15.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.purple,
                border: Border.all(
                  color: Colors.black,
                ),
            ),
            child: Text(
              i,
              style: const TextStyle(color: Colors.white70,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 20),
            ),
          )
      );
      y.add(
          Container(
            padding: const EdgeInsets.all(15.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: const Color(0xFF786a36),
                border: Border.all(
                  color: Colors.white,
                ),
            ),
            child: Text(
              para[i],
              style: const TextStyle(color: Colors.white70,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold,fontSize: 20),
            ),
          )
      );
      x.add(TableRow(
        children: y,
      ));
    }
    return x;
  }
  Widget _buildContent()
  {
    return Center(
      child: Table(
        border: TableBorder.all(),
        children: Workout_Type(),
      ),
    );
  }
}
