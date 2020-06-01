import 'package:flutter/material.dart';

class BNVPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BNVPage();
  } 
}

class _BNVPage extends State<BNVPage>{

    ///底部导航栏选择的Index
    int _selectedIndex = 0;

    static const List<String> _tabs = ['新闻', '体育', '民生'];

    ///Text的统一Style
    static const TextStyle optionStyle = TextStyle(
      fontSize: 30, 
      fontWeight: FontWeight.bold,
      color: Colors.cyan
    );
    
    ///存储Text对象的List
    static const List<Widget> _widgetOptions = <Widget>[
      Text(
        'Index 0: Home',
        style: optionStyle,
      ),
      Text(
        'Index 1: Business',
        style: optionStyle,
      ),
      Text(
        'Index 2: School',
        style: optionStyle,
      ),
    ];

    ///更改选择的Index
    void _onItemTapped(int index) {
      setState(() {
        _selectedIndex = index;
      });
    }

    ///pop回上一页
    void popPage(){
        Navigator.pop(context);
    }


    @override
    Widget build(BuildContext context) {
      ///TabView 必须要有 TabController 否则报错，TabController可以包裹Widget
      return DefaultTabController(
        length: _tabs.length, 
        child: Scaffold(
          appBar: AppBar(
            title: const Text('底部导航栏测试页'),
            centerTitle: true,
            backgroundColor: Colors.red[400],
            //去掉AppBar自带的返回键
            automaticallyImplyLeading: false,
            //leading属性可以放一个Widget代表左侧按钮
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios), 
              onPressed: popPage
            ),
            bottom: TabBar(
            // 通过在AppBar的Bottom属性下放一个Tabbar，显示_tabs
              tabs: _tabs.map((String name) => Tab(text: name)).toList(),
              indicatorColor: Colors.white,
            ),
          ),
        // body: Center(
        //   child: _widgetOptions.elementAt(_selectedIndex),
        // ),
        body: TabBarView(
          // These are the contents of the tab views, below the tabs.
          children: _tabs.map((String name) {
            return SafeArea(
              top: false,
              bottom: false,
              child: Builder(
                // This Builder is needed to provide a BuildContext that is "inside"
                // the NestedScrollView, so that sliverOverlapAbsorberHandleFor() can
                // find the NestedScrollView.
                builder: (BuildContext context) {
                  return Center(
                   child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("选中 Page $name"),
                      _widgetOptions.elementAt(_selectedIndex),
                    ],
                  ),
                );
              },
              ),
            );
          }
          ).toList(),
        ),
        bottomNavigationBar: 
          ///自定义BottomNavigationBar的Theme，取消扩散水波纹
          Theme(
                data: ThemeData(
                  brightness: Brightness.light,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.grey,
                ) ,
          child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text('Home'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.business),
                  title: Text('Business'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.school),
                  title: Text('School'),
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.red[800],
              onTap: _onItemTapped,
            ),
          ),
        ),
      );
    }

}