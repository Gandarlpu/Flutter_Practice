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
  int _idx = 0;
  Color color = Colors.blue;

  @override
  void initState() {
    super.initState();
    color = Colors.green;
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 2,
          childAspectRatio: 1,
          children: <Widget>[
            InkWell(child : Container(child : Text("이름"),
              margin: EdgeInsets.all(16),
              padding : EdgeInsets.all(16),
              color: color,
            ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx){
              return MyHomePage(title: "새로운 페이지에요!!");
            })
          );
        },
        tooltip: "Increment",
        child : Icon(Icons.add),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon : Icon(Icons.home),
              label: "홈"
          ),
          BottomNavigationBarItem(
              icon : Icon(Icons.more),
              label: "더보기탭"
          ),
          BottomNavigationBarItem(
              icon : Icon(Icons.home)
          )
        ],

        onTap: (index){
          //상태 변경 시 알려줘야함 = setState
          setState(() {
            print(index);
            _idx = index;
          });
          Navigator.of(context).pop();
        },

        currentIndex: _idx,
      ),
    );
  }
}
