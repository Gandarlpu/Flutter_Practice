import 'package:fastcampus_diary/data/utils.dart';
import 'package:fastcampus_diary/write.dart';
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
  List<Todo> todos = [
    Todo(
      title : "패스트캠퍼스 강의듣기",
      memo : "앱개발 입문 강의 듣기",
      color : Colors.redAccent.value,
      done : 0,
      category: "공부",
      date : 20210709
    ),
    Todo(
        title : "패스트캠퍼스 강의듣기2",
        memo : "앱개발 입문 강의 듣기",
        color : Colors.blue.value,
        done : 1,
        category: "공부",
        date : 20210709
    ),
  ];

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
      floatingActionButton: FloatingActionButton(
        child : Icon(Icons.add , color : Colors.white,),
        onPressed: () async {
          // 화면 이동을 해야 합니다.
          Todo todo = await Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => TodoWritePage(todo : Todo(
              title: "",
              color : 0,
              memo : "",
              done: 0,
              category: "",
              date: Utils.getFormatTime(DateTime.now())
            ))));

          setState(() {
            todos.add(todo);
          });

        },
      ),
      body: ListView.builder(
        itemBuilder: (ctx , idx){

          if(idx == 0){
            return Container(
              child : const Text("오늘 하루" , style : TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
              margin : const EdgeInsets.symmetric(vertical: 12 , horizontal: 20),
            );
          }else if(idx == 1){

            List<Todo> undone = todos.where((t){
              return t.done == 0;
            }).toList();

            return Container(
                child : Column(
                    children: List.generate(undone.length, (_idx){
                      Todo t = undone[_idx];

                      return Container(
                          decoration: BoxDecoration(
                              color : Color(t.color),
                              borderRadius: BorderRadius.circular(16)
                          ),
                          padding : const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                          margin : const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          child : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

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
          else if(idx == 2){
            return Container(
              child : const Text("완료된 하루" , style : TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
              margin : const EdgeInsets.symmetric(vertical: 12 , horizontal: 20),
            );
          }else if(idx == 3){

            List<Todo> done = todos.where((t){
              return t.done == 1;
            }).toList();

            return Container(
                child : Column(
                    children: List.generate(done.length, (_idx){
                      Todo t = done[_idx];

                      return Container(
                          decoration: BoxDecoration(
                              color : Color(t.color),
                              borderRadius: BorderRadius.circular(16)
                          ),
                          padding : const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                          margin : const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          child : Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

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