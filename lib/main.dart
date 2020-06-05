import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learning_demo/CustomWidgetPage.dart';
import 'package:flutter_learning_demo/ImagePage.dart';
import 'package:flutter_learning_demo/NetTest.dart';
import 'package:flutter_learning_demo/PageData.dart';
import 'package:flutter_learning_demo/TextFieldPage.dart';
import 'package:flutter_learning_demo/bottomNaviagtionPage.dart';
import 'package:toast/toast.dart';

import 'CustomWidget/CustomDrawer.dart';


void main() => runApp(MyApp());

enum PagesName{ first , second , third , fourth, fifth}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  static final imagePageName = '/third';
  static final textFieldPageName = '/textField';
  static final netPageName = '/netPage';

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

      textFieldPageName: (context) => TextFieldPage() ,

      netPageName:(context) => NetTestPage(),
  },


    );
  }
}

class MyHomePage extends StatefulWidget {

  final pageTitle;
  //构造函数
  MyHomePage({Key key, this.pageTitle}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


    double _counter = 1;

    //接收返回的参数
    PageData receivedata;

    var _scaffoldkey = new GlobalKey<ScaffoldState>();



    ///菜单选择项名字
    // var _menuSelectionIndex;

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

  void enterPageByName(var pageName) async {
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
          //设置传入TextFieldPage的参数
          PageData textPageData = new PageData(contentString : 'come from HomePage');
          // var backReceiveResult = await Navigator.pushNamed(
          //             context,
          //             MyApp.textFieldPageName,
          //             arguments: textPageData
          //           );
          // if(backReceiveResult != null){
          //   setState(() {
          //     receivedata = backReceiveResult ;
          //   });
          // }
          Navigator.push(context, new MaterialPageRoute(
                                  builder: (BuildContext context){
            print("121  ${textPageData.contentString} ");
            return TextFieldPage(
                    pageData: textPageData,
                  );
                }
            )).then( (receiveBackData){
              print("接收到返回的数据了  ");
              setState(() {
                receivedata = receiveBackData;
              });
            } 
          );
          break;
        case PagesName.fifth:
          Navigator.pushNamed(context, MyApp.netPageName);
          break;                
        default: 
          break;
     }
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,

      appBar: AppBar(
          title: const Text('测试页'),
          ///automaticallyImplyLeading设为false会隐藏Leading的按钮
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon:  Image.asset(
            "asset/local_images/img1.webp",
            width: 30 ,
            height: 30, 
          ),
            onPressed: (){
              _handlerDrawerButton(context);
            },
          ),

          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_alert),
              onPressed: () {

              },
            ),
            //弹出菜单
            _popUpMenu,
          ],
      ),

      drawer: _drawer,

      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ///自定义StatefulWidget
            GoodJobWidget(),

            ///显示页面回参的内容
            Text(
              receivedata != null ? receivedata.contentString : '尚未接收页面回参内容' ,
              style: TextStyle(
                fontSize : 18,
                color : Colors.teal,
              ),
            ),
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

  ///弹出式菜单
  get _popUpMenu => PopupMenuButton<PagesName>(
              icon: Icon(Icons.navigate_next),
              onSelected: (PagesName result) {
                 setState(() { 
                   //更新菜单选中项
                  //  _menuSelectionIndex = result;
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
                const PopupMenuItem<PagesName>(
                  value: PagesName.fifth,
                  child: Text('第五页 网络测试页'),
                ),
              ],
  );

    ///抽屉Drawer
    get _drawer => CustomDrawer(
        callback: _handleDrawerStateCallback ,
        child: ListView(
            ///edit start
          padding: EdgeInsets.zero,
            ///edit end
          children: <Widget>[
            ///Drawer 头部控件
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
              ),
              child: Center(
                child: SizedBox(
                  width: 120.0,
                  height: 120.0,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Center(
                      child:FlutterLogo(
                              size: 100,
                            ),
                    )
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('设置'),
              onTap: drawerTileClick,
            ),
            ListTile(
              leading: Icon(Icons.book),
              title: Text('阅读2'),
              onTap: drawerTileClick,
            ),
            ListTile(
              leading: Icon(Icons.local_cafe),
              title: Text('阅读3'),
              onTap: drawerTileClick,
            ),
            ListTile(
              leading: Icon(Icons.hotel),
              title: Text('阅读4'),
              onTap: drawerTileClick,
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('阅读5'),
              onTap: drawerTileClick,
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('阅读6'),
              onTap: drawerTileClick,
            ),
            ListTile(
              leading: Icon(Icons.important_devices),
              title: Text('阅读7'),
              onTap: drawerTileClick,
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('阅读8'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('阅读9'),
            ),            
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('阅18'),
            ),            
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('阅读28'),
            ),           
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('阅读36'),
            ),            
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('阅读566'),
            ),
          ],
        ),
    );

    void drawerTileClick(){
      Toast.show("点击了Drawer条目", context);
    }

    ///当自定义Drawer的呼出按钮时给Leading的点击事件
    void _handlerDrawerButton(BuildContext context) {
      // Scaffold.of(context).openDrawer();
      _scaffoldkey.currentState.openDrawer();
    }

    ///监听Drawer的打开时刻和关闭时刻
    ///isOpen true代表 Drawer已经出现在屏幕里，false代表Drawer完全隐藏
    void _handleDrawerStateCallback(bool isOpen){
        if(isOpen){
          // Toast.show('Drawer 被打开', context);
          print('Drawer 被打开');
        }else {
          // Toast.show('Drawer 被关闭', context);
          print('Drawer 被关闭');
        }
    }
}
