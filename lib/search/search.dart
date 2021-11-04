import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keepfit/search/search_result.dart';

class Search extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
        body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection("Search").get(),
          builder: (context,snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Error in fetching Data!!",
                    style: TextStyle(height: 5, fontSize: 10)),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ));
            }
            var documentlist = snapshot.data!.docs;
            return MyHomePage(documentlist);
          }
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  var documentlist;
  MyHomePage(this.documentlist,{Key? key}) : super(key: key);
  @override
  _MyHomepageState createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomePage> {
  List<DocumentSnapshot> get documentlist{
    return widget.documentlist;
}
  bool _flag = false;
  Column noresult = Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'No results Found!',
        textAlign: TextAlign.center,
        style: GoogleFonts.arimo(
            textStyle: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w200, fontSize: 30)
        ),
      ),
    ],
  );
  Column result=Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        'No results Found!',
        textAlign: TextAlign.center,
        style: GoogleFonts.arimo(
            textStyle: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.w200, fontSize: 30)
        ),
      ),
    ],
  );
  void detailer(BuildContext context, Map<String,dynamic> details, String name)
  {
    setState(() {
      _flag=false;
      result=noresult;
    });
    nextPage(context,details,name);
  }
  void documentexpander(BuildContext context,DocumentSnapshot docx)
  {
    List<TextButton> exercise_buttons=[];
    Map<String,dynamic> exercises=docx.data() as Map<String,dynamic>;
    for(String name in exercises.keys)
      {
        exercise_buttons.add(
          TextButton(
            onPressed: ()=>detailer(context,exercises[name],name),
            child: Text(
              name,
              textAlign: TextAlign.center,
              style: GoogleFonts.arimo(
                  textStyle: const TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w300,)
              ),
            ),
          )
        );
      }
    setState(() {
      result=Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: exercise_buttons,
      );
    });
  }
  void search_data(BuildContext context, String value) {
    setState(() {
      _flag=false;
      result=noresult;
    });
    if (value == "") {
      setState(() {
        _flag=false;
      });
      return;
    }
    List<Widget> textbuttons = [];
    for (int i = 0; i < documentlist.length; i++) {
      if (documentlist[i].id.toLowerCase().startsWith(value)) {
        if(_flag==false)
          {
            setState(() {
              _flag=true;
            });
          }
        textbuttons.add(
          TextButton(
            onPressed: ()=>documentexpander(context,documentlist[i]),
            child: Text(documentlist[i].id,
              textAlign: TextAlign.center,
              style: GoogleFonts.arimo(
                  textStyle: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w300,),
              ),
            ), //Text
          ),
        );
      }
      for(int i=0;i< documentlist.length;i++)
        {
          Map<String,dynamic> exercises=documentlist[i].data() as Map<String,dynamic>;
          for(String name in exercises.keys)
            {
              if(_flag==false)
                {
                  setState(() {
                    _flag=true;
                  });
                }
              if(name.toLowerCase().startsWith(value))
                {
                  textbuttons.add(
                      TextButton(
                        onPressed: ()=>detailer(context,exercises[name],name),
                        child: Text(
                          name,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.arimo(
                              textStyle: const TextStyle(
                                color: Colors.black, fontWeight: FontWeight.w300,)
                          ),
                        ),
                      )
                  );
                }
            }
        }
    }
    if(_flag==false) {
      setState(() {
        result=noresult;
      });
    }
    setState(() {
      result=Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: textbuttons,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          child: TextFormField(
            onChanged: (value) {
              search_data(context,value);
            },
            decoration: const InputDecoration(
                hintText: "Search", suffixIcon: Icon(Icons.search)),
          ),
        ),
        (_flag==false)?(
            Container(
              height: 500.0,
              alignment: Alignment.center,
              child: result,
            )):(result),
      ],
    );
  }

  void nextPage(context, Map<String, dynamic> details, String name)
  {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => SearchResult(details:details,name:name),
    ));
  }
}
