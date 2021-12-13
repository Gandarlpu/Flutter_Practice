import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);



  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  var count1 = 0;
  var count2 = 0;
  var vicTeam = "";

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(height: 50),
          Text("tingtong" , style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("fase univ"),
              Text("campus univ"),
            ],
          ),
          Container(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("score : $count1" , style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
              Text("score : $count2" , style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ],
          ),
          Container(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  IconButton(icon: Icon(Icons.add),
                    onPressed: (){
                      setState(() {
                        count1 = count1 + 1;

                        if(count1 > 10){
                          vicTeam = "fast univ win";
                        }
                      });
                    },
                  ),
                  IconButton(icon : Icon(Icons.remove),
                    onPressed: (){
                      setState(() {
                        count1 = count1 - 1;
                      });
                    },
                  )
                ],
              ),
              Row(
                children: [
                  IconButton(icon: Icon(Icons.add),
                    onPressed: (){
                      setState(() {
                        count2 = count2 + 1;
                        if(count2 > 10){
                          vicTeam = "campus univ win";
                        }
                      });
                    },
                  ),
                  IconButton(icon : Icon(Icons.remove),
                    onPressed: (){
                      setState(() {
                        count2 = count2 - 1;
                      });
                    },
                  )
                ],
              ),
            ],
          ),

          Container(height: 20),
              Text("$vicTeam" , style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold))
          ],
      ),
    );
  }
}
