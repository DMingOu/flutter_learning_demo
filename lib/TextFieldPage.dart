import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learning_demo/PageData.dart';

class TextFieldPage extends StatefulWidget {

  //接收上一个页面的传进来的参数
  final PageData pageData;

    //构造函数
  TextFieldPage({Key key, this.pageData}) : super(key: key);

  @override
  TextFieldPageState createState() {
      return TextFieldPageState();
  }
}

class TextFieldPageState extends State<TextFieldPage> {


  //文本输入框的Controller
  var _controller = TextEditingController();

  String showPushData(){
    if(widget.pageData == null){
      return '未接收到上一页面传参';
    }else {
      return widget.pageData.toString();
    }
  }


  @override
  Widget build(BuildContext context) {
    ////获取接收的参数，转换并显示出来
    // PageData obj = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('文本输入测试页'),
      ),
      body: Column(
            children: <Widget>[
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                    labelText: "用户名",
                    hintText: "用户名或邮箱",
                    prefixIcon: Icon(Icons.person)
                ),
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: "密码",
                    hintText: "您的登录密码",
                    prefixIcon: Icon(Icons.lock)
                ),
                obscureText: true,
              ),
              TextField(
                controller: _controller,
                decoration: InputDecoration(
                    labelText: "回参",
                    hintText: "输入要返回上一页面的内容",
                    prefixIcon: Icon(Icons.work)
                ),
              ),
              CupertinoButton.filled(
                child: Text("点击返回上一个页面"),
                minSize: 15,
                onPressed: (){
                //返回上一个页面 pop ,设置回参
                String popData = _controller.text != '' ? _controller.text.toString() : 'Nothing back' ; 
                Navigator.pop(context, PageData(contentString: popData));
                },
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      showPushData()
                      ///显示接收的参数
                      // obj != null ?(obj as PageData).contentString : 'Nothing arguments received'
                    )
                  ]
                ),
              )
            
            ],
      ),
    );
  }
  @override
  void initState() {
    super.initState();
  }
  
  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  void didUpdateWidget(TextFieldPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}