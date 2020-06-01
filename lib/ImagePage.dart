import 'package:flutter/material.dart';

class ImagePage extends StatefulWidget {
  @override
  ImagePageState createState() => ImagePageState();
}

class ImagePageState extends State<ImagePage> {


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('图片测试页面'),
        centerTitle: true ,
      ),
      body: Column(
        children: <Widget>[
          //Image组件甚至可直接加载gif
          Image.network(
            "http://picbed-dmingou.oss-cn-shenzhen.aliyuncs.com/img/20200601221758.gif",
            width: 400 ,
            height: 350, 
          ),
          Image.asset(
            "asset/local_images/img1.webp",
            width: 100 ,
            height: 80, 
          ),
          Image.asset(
            "asset/local_images/fun.gif",
            width: 400 ,
            height: 200, 
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
  void didUpdateWidget(ImagePage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}