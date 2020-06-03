import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class GoodJobWidget extends StatefulWidget {
  @override
  GoodJobWidgetState createState() => GoodJobWidgetState();
}

class GoodJobWidgetState extends State<GoodJobWidget> {

  bool _isGood = true;
  
  int _goodCount = 0;

  
  ///点击事件
  void _toggleFavorite() {
    // 通过 setState() 更新数据
    // 组件树就会自动刷新了
    setState(() {
      if (_isGood) {
        _goodCount -= 1;
        _isGood = false;
      } else {
        _goodCount += 1;
        _isGood = true;
      }
    });
  }

  ///刷新点赞数
  void getLikeCount(){
    Future.wait([
      Future.delayed(new Duration(milliseconds: 2000),(){
        print("加 50 -------${new DateTime.now()}  ");
          return 50;
      }),
      Future.delayed(new Duration(milliseconds: 4000),(){
        print("减 5 -------${new DateTime.now()}  ");
        return -5;
      })
    ]).then( (results){
      var timer;
      ///results这个List里面的内容是执行wait中返回的对象们,会根据返回的类型动态改变List<T>的T
      _goodCount = _goodCount + results[0] + results[1]  ;
      timer = Timer.periodic(
          const Duration(milliseconds: 4500), (Void) {
              // DateTime nowTime = new DateTime.now();
              // print("执行轮询-------$nowTime ");
            ///定时任务，每2000ms增加 1 
              Future.delayed(new Duration(milliseconds: 2000),(){
                // print("加 1 -------${new DateTime.now()}  ");
                _goodCount++;
              });             
              ///点赞数变化，调用setState会更新视图
              setState(() {
                // print('更新点赞数');
              });
              ///当点赞数目超过1000就停止轮询任务
              if(_goodCount >= pow(10, 3)){
                (timer as Timer).cancel();
              }
          });
    }).catchError((e){
      //执行失败会走到这里
      print(e);
    }).whenComplete((){
      //无论成功或失败都会走到这里  
      print("task complete");
    });
  }



 // 重写 build() 函数，构建视图树
  @override
  Widget build(BuildContext context) => Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(0),
            child: IconButton(
              icon: Icon(Icons.thumb_up) ,
              color: (_isGood ?  Colors.red[500]: Colors.grey[400]) ,
              onPressed: _toggleFavorite,
            ),
          ),
          SizedBox(
            width: 180,
            child: Container(
              child: Text('$_goodCount'),
            ),
          ),
        ],
      );
  @override
  void initState() {
    super.initState();
    //State准备好，会调用初始化
    getLikeCount();
  }
  
  @override
  void dispose() {
    super.dispose();
    print('CustomWidget dispose');
  }
  
  @override
  void didUpdateWidget(GoodJobWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('CustomWidget didUpdateWidget');
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('CustomWidget didChangeDependencies');  
  }
}