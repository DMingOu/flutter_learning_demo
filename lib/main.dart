import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learning_demo/bottomNaviagtionPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
            IconButton(
              icon: const Icon(Icons.navigate_next),
              tooltip: '前往下一页',
              onPressed: (){
                Navigator.push(
                    context,
                    new MaterialPageRoute(builder: (context) => new BNVPage()),
                );
              },
            ),
          ],
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '按下数字就翻倍',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display4,
            ),
            IconButton(
              icon: Icon(Icons.cake),
              onPressed: _reduceCounter
            ),
            CupertinoButton.filled(
              child: Text("跳转下一页"),
              minSize: 15,
              onPressed: enterNextPage,
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
