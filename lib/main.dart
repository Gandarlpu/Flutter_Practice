import 'package:flutter/material.dart';

import 'data/todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
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
  const MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // 여러개를 담는 List를 통해 idx(할일)이 1이상일 때
  // 무엇을 담냐면 todo.dart의 여러 정보들을 담아줌
  List<Todo> todos = [];



  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(child : AppBar(),
        preferredSize: Size.fromHeight(0),
      ),
      body: ListView.builder(
          itemBuilder: (ctx , idx){
            if(idx == 0){
              return Container(
                child : const Text("오늘 하루" , style : TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
                margin : const EdgeInsets.symmetric(vertical: 12 , horizontal: 20),
              );
            }else if(idx == 1){
              return Container(
                child : Column(
                  children: List.generate(todos.length, (_idx){
                      // todos의 갯수 인덱스만큼 출력
                      Todo t = todos[_idx];

                      return Container(
                        decoration: BoxDecoration(
                          color : Color(t.color),
                          borderRadius: BorderRadius.circular(16)
                        ),
                        padding : const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                        margin : const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                        child : Column(
                          // 각 줄은 중앙 정렬로 기본 셋팅되어잇음
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //Column의 경우 행이 들어가는데 행에 대한 얼라이먼트가 아닌 행의 열이 시작으로 되던지 가운데인지를
                          // 크로스 얼라이언트를 통해 설정

                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(t.title , style: const TextStyle(fontSize: 18, color : Colors.white , fontWeight: FontWeight.bold),),
                                Text(t.done == 0 ? "미완료" : "완료" , style: const TextStyle(color : Colors.white),)
                              ],
                            ),
                            Container(height: 8), // 여백
                            Text(t.memo , style: const TextStyle(color : Colors.white),)
                          ],
                        )
                      );
                    }
                  )
                )
              );
            }

            return Container();
          },
        itemCount: 4,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.today_outlined),
              label: "오늘"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_outlined),
              label: "기록"
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              label: "더보기"
          ),
        ],
      ),

    );
  }
}
