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
  List<Table> tobescrolled=[];
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
    final List<String> summa=["name","Previous Progression","Next Progression","Sets","Reps"];
    List<TableRow> p=[];
    List<Widget> texts=[];
    texts.add(
        const Text(
          "Name",
          style: TextStyle(color: Colors.white70,fontStyle: FontStyle.italic,fontWeight: FontWeight.w500,fontSize: 13.65),
        ));
    for (var i in summa)
      {
        if(i!="name") {
          print("Header ${i}");
          texts.add(
              Text(
                i,
                style: const TextStyle(color: Colors.white70,fontStyle: FontStyle.italic,fontWeight: FontWeight.w500,fontSize: 13.65),
              ));
        }
      }
    p.add(TableRow(
        children: texts
    ));
    texts=[];
    for(int j=0;j<plans[x]!.length;j++)
    {
      texts=[];
      texts.add(
          Text(
            plans[x]![j]["name"],
            style: const TextStyle(color: Colors.white70,fontStyle: FontStyle.italic,fontWeight: FontWeight.w400,fontSize: 12),
          ));
      print(plans[x]![j]["name"]);
      for (var i in summa)
      {
        if(i!="name")
        {
          print("Data ${plans[x]![j][i]}");
          texts.add(
              Text(
                (i != "Sets") ? (plans[x]![j][i]) : ("${plans[x]![j][i]}"),
                style: const TextStyle(color: Colors.white70,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w400,
                    fontSize: 12),
              ));
        }
      }
      p.add(TableRow(
          children: texts
      ));
    }
    print("This is the no. of children inside each row: ${p.first.children!.length}");
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
              print(tobescrolled.first.children.length);
              return ListView.separated(
                scrollDirection: Axis.vertical,
                itemCount: tobescrolled.length,
                itemBuilder: (BuildContext context, int index) {
                 return Container(
                   alignment: Alignment.center,
                   height: 500,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                       Text(
                         names[index],
                         textAlign: TextAlign.center,
                         style: const TextStyle(color: Colors.white70,fontWeight: FontWeight.w900,fontSize: 20),
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
