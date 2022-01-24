//todolist를 작성하는 페이지
import 'package:fastcampus_diary/data/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'data/todo.dart';

class TodoWritePage extends StatefulWidget{
  // 글변경 카테고리 등등 때문에 stateful
  final Todo todo;

  const TodoWritePage({Key key , this.todo}) : super(key : key);

  @override
  State<StatefulWidget> createState() {
    return _TodoWritePageState();
  }

}

class _TodoWritePageState extends State<TodoWritePage> {
  // 실제 페이지 위젯을 만들어줄 클래스

  TextEditingController nameController = TextEditingController();
  TextEditingController memoController = TextEditingController();
  final dbHelper = DatabaseHelper.instance;
  //텍스트 필드를 감지하는 컨트롤러
  int colorIndex = 0;
  int ctIndex = 0;

  @override
  void initState() {
    // 페이지가 실행될 때 처음 시작되는 함수
    super.initState();

    nameController.text = widget.todo.title;
    memoController.text = widget.todo.memo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          // 위젯을 리스트로 가지고 있는 친구
          TextButton(
            child: const Text("저장" , style: TextStyle(color : Colors.white),),
            onPressed: () async {
              // 페이지 저장 시 사용
              // 텍스트필드 컨트롤러의 .text저장
              widget.todo.title = nameController.text;
              widget.todo.memo = memoController.text;

              await dbHelper.insertTodo(widget.todo);
              // 데이터베이스에 기록하는데 시간이 좀 걸리기 때문에 async걸어줌.

              // 이 페이지가 꺼지면서 실행됫던 widget.todo를 넘김.
              Navigator.of(context).pop(widget.todo);
            },
          )
        ],
      ),

      body: // 휴대폰 환경이 다양하게 때문에 List가 스크롤이 되는 행을 제공하기 때문에 Column을 사용할 떄는 lsitviw를 쓰고 그 안에 Column을 쓰자
      ListView.builder(
        itemBuilder: (ctx , idx){
          if(idx == 0){
            return Container(
              child : const Text("제목" , style: TextStyle(fontSize: 20, ),),
              margin : const EdgeInsets.symmetric(vertical: 12 , horizontal: 16),

            );

            // 텍스트필드
          }else if(idx == 1){
            return Container(
              child: TextField(
                controller: nameController,
              ),
              margin : const EdgeInsets.symmetric(horizontal: 16),
            );
          }
          // 색상
          else if(idx == 2){
            return InkWell(child : Container(
              //InkWell은 해당 위젯을 선택가능하게 하기 위한 것 따라서 전체를 감싸줘야함 ()
              margin : const EdgeInsets.symmetric(vertical: 12 , horizontal: 16),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children : [
                    const Text("색상" , style: TextStyle(fontSize: 20),),
                    Container(
                      width: 15,
                      height: 15,
                      color: Color(widget.todo.color),
                      // 색상 접근 시 그냥 위에 클래스에서 선언한 todo.color로 접근하면 안된다.
                      // 왜냐면 상위 클래스에 접근하기 위해선 widget을 앞에 꼭 붙여줘야 하기 때문

                    )
                  ]
              ),
            ),
              onTap: (){
                List<Color> colors = [
                  Color(0xff80d3f4),
                  Color(0xffd180f4),
                  Color(0xff803175),
                  Color(0xffb4414f),
                  Color(0xfff4e580),
                  Color(0xff91f480),
                  Color(0xffd0e3ea),
                ];

                widget.todo.color = colors[colorIndex].value;
                colorIndex++;
                //7이 넘어가지 않게 하기 위해
                setState((){
                  colorIndex = colorIndex % colors.length;
                });
              },
            );

          }
          else if(idx == 3){
            return InkWell(child : Container(
              margin : const EdgeInsets.symmetric(vertical: 12 , horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("카테고리", style: TextStyle(fontSize: 20)),
                  Text(widget.todo.category)
                ],
              ),
            ),
              onTap: (){
                List<String> category = ["공부" , "운동" , "게임"];

                widget.todo.category = category[ctIndex];
                ctIndex++;
                setState(() {
                  ctIndex = ctIndex % category.length;
                });
              },
              
            );
          }
          else if(idx == 4){
            return Container(
              margin : const EdgeInsets.symmetric(vertical: 12 , horizontal: 16),
              child: const Text("메모", style: TextStyle(fontSize: 20)),
            );
          }
          else if(idx == 5){
            return Container(
              margin : const EdgeInsets.symmetric(vertical: 1 , horizontal: 16),
              child: TextField(
                controller: memoController,
                // 여러 줄 입력
                maxLines: 10,
                minLines: 10,
                decoration: const InputDecoration(
                    border : OutlineInputBorder(borderSide: BorderSide(color : Colors.black))
                ),
              ),
            );
          }
          // 아이템 6개 이외의 값이 오면 그냥컨테이너 리턴
          return Container();
        },
        itemCount: 6,
      ) ,
    );
  }

}