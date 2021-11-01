import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class DisplayPlan extends StatefulWidget
{
  final List<Map<String,dynamic>>? para;
  const DisplayPlan({Key? key,this.para}) : super(key: key);

  @override
  _DisplayPlanState createState() => _DisplayPlanState();
}

class _DisplayPlanState extends State<DisplayPlan>
{
  List<Map<String,dynamic>>? get para{
    return widget.para;
  }
  late List<Table> tobescrolled;
  Future<Map<String,List<Map<String,dynamic>>>> fetchdata() async
  {
    Map<String,List<Map<String,dynamic>>> p={};
    for (int i=0;i<para!.length;i++)
      {
        List<Map<String,dynamic>> eachexercise=[];
        for(var x in para![i].keys)
          {
            if(x!="name")
              {
                DocumentReference<Map<String,dynamic>> t=para![i][x];
                await t.get().then((value){
                  if(value.exists) {
                    var temp = value.data() as Map<String, dynamic>;
                    eachexercise.add(temp);
                  }
                  else
                    {
                      print("Data missing!!");
                    }
                });
              }
            print("$eachexercise");
          }
        p[para![i]["name"]]=eachexercise;
        print("$p");
      }
      return p;
  }
  List<Table> tablevalgiver(Map<String,List<Map<String,dynamic>>> plans)
  {
    List<Table> temp=[];
    for(var x in plans.keys)
      {
        temp.add(
          Table(
            border: TableBorder.all(color: Colors.white),
            children: tuplegiver(x,plans),
          )
        );
      }
      return temp;
  }
  List<TableRow> tuplegiver(String x,Map<String,List<Map<String,dynamic>>> plans)
  {
    List<TableRow> p=[];
    List<Widget> texts=[];
    texts.add(
        const Text(
          "Name",
          style: TextStyle(color: Colors.white70,fontStyle: FontStyle.italic,fontWeight: FontWeight.w500,fontSize: 20),
        ));
    for (var i in plans[x]![0].keys)
      {
        if(i!="name") {
          texts.add(
              Text(
                i,
                style: const TextStyle(color: Colors.white70,fontStyle: FontStyle.italic,fontWeight: FontWeight.w500,fontSize: 20),
              ));
        }
      }
    p.add(TableRow(
        children: texts
    ));
    texts.clear();
    for(int j=0;j<plans[x]!.length;j++)
    {
      texts.add(
          Text(
            plans[x]![j]["name"],
            style: const TextStyle(color: Colors.white70,fontStyle: FontStyle.italic,fontWeight: FontWeight.w500,fontSize: 16),
          ));
      for (var i in plans[x]![j].keys)
      {
        if(i!="name")
        {
          texts.add(
              Text(
                (i != "Sets") ? (plans[x]![j][i]) : ("${plans[x]![j][i]}"),
                style: const TextStyle(color: Colors.white70,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w300,
                    fontSize: 12),
              ));
        }
      }
      p.add(TableRow(
          children: texts
      ));
      texts.clear();
    }
    return p;
  }
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            centerTitle: true,
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
          body: FutureBuilder<Map<String,List<Map<String,dynamic>>>>(
            future: fetchdata(),
            builder: (BuildContext context,AsyncSnapshot<Map<String,List<Map<String,dynamic>>>> plans) {
              if (plans.hasError) {
                return const Center(
                  child: Text("Error in fetching Data!!",
                      style: TextStyle(height: 5, fontSize: 10)),
                );
              } else if (plans.connectionState == ConnectionState.waiting) {
                return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ));
              }
              tobescrolled=tablevalgiver(plans.data!);
              List<String> names = [];
              for(var x in plans.data!.keys)
                {
                  names.add(x);
                }
              return ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: tobescrolled.length,
                padding: const EdgeInsets.all(20.0),
                itemBuilder: (BuildContext context, int index) {
                 return Center(
                   child: Column(
                     children: [
                       Text(
                         names[index],
                         textAlign: TextAlign.center,
                         style: const TextStyle(color: Colors.white70,fontWeight: FontWeight.w800,fontSize: 20),
                       ),
                       tobescrolled[index],
                     ],
                   ),
                 );
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(),
              );
            }
          ),
        backgroundColor: Colors.black,
      ), //Scaffold
      debugShowCheckedModeBanner: false,
    );
  }
}
