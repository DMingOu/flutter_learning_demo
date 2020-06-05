// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:flutter_learning_demo/models/Response.dart' as model;
import 'package:flutter_learning_demo/models/hot_word.dart';
import 'package:flutter_learning_demo/models/wan_android_user.dart';
import 'package:flutter_learning_demo/net/ApiManager.dart';
// import 'package:flutter_learning_demo/net/CustomInterceptors.dart';
import 'package:flutter_learning_demo/net/HttpUtil.dart';



class NetTestPage extends StatefulWidget {
  @override
  NetTestPageState createState() => NetTestPageState();
}



class NetTestPageState extends State<NetTestPage> {

  HttpClient httpClient = HttpClient();

  String responseString = 'Nothing yet';

  ///通过HttpClient获取请求的数据
  void getRequsetData() async{
      String url = 'wanandroid.com';
      String requestPath = '/hotkey/json' ;
      var uri = new Uri.http(url , requestPath);
      ///打开Http连接
      var request = await httpClient.getUrl(uri);
      ///等待连接服务器（会将请求信息发送给服务器），请求成功后会返回 HttpClientResponse
      var response = await request.close();

      // 判断 response 状态
      if (response.statusCode == HttpStatus.ok) {
        // 转换 response，获取结果
          var responseBody = await response.transform(utf8.decoder).join();

          Map<String, dynamic> decodeJson = json.decode(responseBody);  
          HotWord word1 = HotWord.fromJson(decodeJson);  
          print("Word1  ${word1.errorCode}");
          setState(() {
            responseString = responseBody;
          });

          model.Response responseData = model.Response.parse(responseBody, HotWord.fromMap);
          HotWord hw = responseData?.result?.content;
          print(hw?.data.toString());
      }

        String requestPath2 = '/user/login' ;
        var uri2 = new Uri.https(url , requestPath2 , {'username':'758502274@qq.com','password':'ytmz8901'});
        ///打开Http连接
        var request2 = await httpClient.postUrl(uri2);
        ///等待连接服务器（会将请求信息发送给服务器），请求成功后会返回 HttpClientResponse
        var response2 = await request2.close();
        if (response2.statusCode == HttpStatus.ok) {
        // 转换 response，获取结果
          var responseBody = await response2.transform(utf8.decoder).join();

          Map<String, dynamic> decodeJson = json.decode(responseBody);  
          WanAndroidUser user = WanAndroidUser.fromJson(decodeJson);  
          print("User  ${user.data.nickname}");
          setState(() {
            responseString = user.data.nickname;
          });
        } else {
          print('请求 失败 ');
        }


      httpClient.close();
  }

  void dioRequestData() async{

      WanAndroidUser user2 = await ApiManager.requestLogin('123456789@qq.com', '123456');
      setState(() {
            responseString = user2.data.nickname;
      });

      var response =  await HttpUtil.getInstance(baseUrl:'http://47.102:6666').get('/user/checkCode/123456789/123456');
      print(response.toString());

      WanAndroidUser user = await ApiManager.requestLogin('758502274@qq.com', 'ytmz8901');
      setState(() {
            responseString = user.data.id.toString();
      });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('网络请求测试页'),
        centerTitle: true,
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
             Text(
                responseString
             )
          ]
        ),
      );
  }



  @override
  void initState() {
    super.initState();
    ///获取网络数据
    // getRequsetData();
    dioRequestData();
  }
  
  @override
  void dispose() {
    super.dispose();
  }
  
  @override
  void didUpdateWidget(NetTestPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
}