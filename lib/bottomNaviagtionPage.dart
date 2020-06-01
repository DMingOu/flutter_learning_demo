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
      return Scaffold(
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
          )
        ),
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
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
          selectedItemColor: Colors.red[400],
          onTap: _onItemTapped,
        ),
      );
    }


}