import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learning_demo/ImagePage.dart';
import 'package:flutter_learning_demo/TextFieldPage.dart';
import 'package:flutter_learning_demo/bottomNaviagtionPage.dart';
import 'package:toast/toast.dart';


void main() => runApp(MyApp());

enum PagesName{ first , second , third , fourth, fifth}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  static final imagePageName = '/third';
  static final textFieldPageName = '/textField';


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      ///全局设置扩散效果
      theme: ThemeData(
        primarySwatch: Colors.blue,
        splashColor: Color.fromRGBO(0, 0, 0, 0)
      ),
      // home: MyHomePage(title: '首页'),
      
      // 设置第一个页面，即启动页
      initialRoute: '/home',
      routes: {
      // 注册一个页面
      '/home': (context) => MyHomePage(),
      // 注册第二个页面
      '/second': (context) => BNVPage(),
      imagePageName:(context) => ImagePage(),

      textFieldPageName: (context) => TextFieldPage()
  },


    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    double _counter = 1;

    ///菜单选择项名字
    var _menuSelectionIndex;

  ///增加数字的一半
  void _incrementCounter() {
    setState(() {
      _counter = _counter * 4 ;
    });
  }

    ///数字减少一半
  void _reduceCounter() {
    setState(() {
      _counter = _counter / 2 ;
    });
  }

  void enterNextPage(){
    ///第一种方式，通过Navigator.push
      // Navigator.push(
      //   context,
      //   new MaterialPageRoute(builder: (context) => new BNVPage()),
      // );
    ///第二种方式：通过命名路由
      Navigator.pushNamed(context, '/second');
  }

  void enterThirdPage(){

      Navigator.pushNamed(context, MyApp.imagePageName);
  }

  void enterPageByName(var pageName){
     switch(pageName){
        case PagesName.first:
          Navigator.pushNamed(context,  '/home');
          break;
        case PagesName.second:
          Navigator.pushNamed(context, '/second');
          break;        
        case PagesName.third:
          Navigator.pushNamed(context, MyApp.imagePageName);
          break;        
        case PagesName.fourth:
          Navigator.pushNamed(context, MyApp.textFieldPageName);   
          break;
        default: 
          break;
     }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('测试页'),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_alert),
              onPressed: () {

              },
            ),
            // IconButton(
            //   icon: const Icon(Icons.navigate_next),
            //   tooltip: '前往下一页',
            //   onPressed: (){
            //     Navigator.push(
            //         context,
            //         new MaterialPageRoute(builder: (context) => new BNVPage()),
            //     );
            //   },
            // ),
            PopupMenuButton<PagesName>(
              icon: Icon(Icons.navigate_next),
              onSelected: (PagesName result) {
                 setState(() { 
                   //更新菜单选中项
                   _menuSelectionIndex = result;
                  enterPageByName(result);
                }); 
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<PagesName>>[
                const PopupMenuItem<PagesName>(
                  value: PagesName.first,
                  child: Text('第一页 首页'),
                ),
                const PopupMenuItem<PagesName>(
                  value: PagesName.second,
                  child: Text('第二页 导航页'),
                ),
                const PopupMenuItem<PagesName>(
                  value: PagesName.third,
                  child: Text('第三页 图片页'),
                ),
                const PopupMenuItem<PagesName>(
                  value: PagesName.fourth,
                  child: Text('第四页 文本输入页 '),

                ),
              ],
            )           
          ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '按下右下角按钮，数字就翻倍',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display4,
            ),
            IconButton(
              icon: Icon(Icons.thumb_down),
              onPressed: _reduceCounter
            ),
            CupertinoButton.filled(
              child: Text("ios风格的按钮"),
              minSize: 15,
              onPressed: (){
                //弹出一个Toast
                Toast.show("Toast 弹出", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
