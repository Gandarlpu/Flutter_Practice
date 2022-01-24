import 'package:fastcampus_diary/data/database.dart';
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

  //DB가져오기
  final dbHelper = DatabaseHelper.instance;
  int selectIndex = 0;

  // 여러개를 담는 List를 통해 idx(할일)이 1이상일 때
  // 무엇을 담냐면 todo.dart의 여러 정보들을 담아줌
  List<Todo> todos = [
    // Todo(
    //   title : "패스트캠퍼스 강의듣기",
    //   memo : "앱개발 입문 강의 듣기",
    //   color : Colors.redAccent.value,
    //   done : 0,
    //   category: "공부",
    //   date : 20210709
    // ),
    // Todo(
    //     title : "패스트캠퍼스 강의듣기2",
    //     memo : "앱개발 입문 강의 듣기",
    //     color : Colors.blue.value,
    //     done : 1,
    //     category: "공부",
    //     date : 20210709
    // ),
  ];

  void getTodayTodo() async {
    // 오늘의 Todo추가 함수
    todos = await dbHelper.getTodoByDate(Utils.getFormatTime(DateTime.now()));
    setState(() {});
  }
  void getAllTodo() async {
    // 오늘의 Todo추가 함수
    todos = await dbHelper.getAllTodo();
    setState(() {});
  }

  @override
  void initState(){
    getTodayTodo();
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

          getTodayTodo();

        },
      ),
      body: getPage(),

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
        currentIndex: selectIndex,
        onTap:(idx){
          if(idx == 1){
            getAllTodo();
          }
          setState(() {
            selectIndex = idx;
          });
        },
      ),
    );
  }

  Widget getPage(){
    if(selectIndex == 0){
      return getMain();
    }else{
      return getHistory();
    }
  }

  Widget getMain(){
    return ListView.builder(
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

                return InkWell(
                  child : TodoCardWidget(t : t),
                  onTap: (){
                    // 미완료일 떄는 완료로 변경
                    // 완료면 미완료로 변경
                    setState(() {
                      if(t.done == 0){
                        t.done = 1;
                      }else{
                        t.done = 0;
                      }
                    });
                  },
                  onLongPress: () async {

                    getTodayTodo();
                  },
                );
              }),
            ),
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
              children: List.generate(done.length, (_idx) {
                Todo t = done[_idx];
                return InkWell(
                  child: TodoCardWidget(t: t),
                  onTap: () {
                    // 미완료일 떄는 완료로 변경
                    // 완료면 미완료로 변경
                    setState(() {
                      if (t.done == 0) {
                        t.done = 1;
                      } else {
                        t.done = 0;
                      }
                    });
                  },
                  onLongPress: () async {
                    // 길게 누르면 수정할 수 있도록
                    Todo todo = await Navigator.of(context).push(
                        MaterialPageRoute(builder: (ctx) => TodoWritePage(todo : t)));
                    setState(() {

                    });
                  },
                );
              }),
            ),
          );
        }

        return Container();
      },
      itemCount: 4,
    );
  }

  List<Todo> allTodo = [];

  Widget getHistory(){
    return ListView.builder(
      itemBuilder: (ctx , idx){
        return TodoCardWidget(t : allTodo[idx]);
      },
      itemCount : allTodo.length,
    );
  }
}

// 각각의 카드들은 todo의 데이터만 출력해주는 것이기 때문에 less
class TodoCardWidget extends StatelessWidget {
  int now = Utils.getFormatTime(DateTime.now());
  DateTime time = Utils.nowToDateTime(t.date);

  final Todo t;

  TodoCardWidget({Key key, this.t}) : super(key : key);

  @override
  Widget build(BuildContext context) {

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
          Text(t.memo , style: const TextStyle(color : Colors.white),),
          now == t.date ? Container() : Text("${time.month}월 ${time.day}일", style: const TextStyle(color : Colors.white))
        ],
      ),
    );
  }

}