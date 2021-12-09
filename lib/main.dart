import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _idx = 0;

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("패스트캠퍼스"),
            Icon(Icons.add),
            Container(child: Text("난 컨테이너 안이에요"),
                      color : Colors.redAccent,),
            TextButton(
              onPressed: () {
                print("텍스트 버튼 눌림!!");
              },
              child : Text("난 텍스트 버튼입니다.")
            )
          ],
        ),
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
        },

        currentIndex: _idx,
      ),
    );
  }
}
