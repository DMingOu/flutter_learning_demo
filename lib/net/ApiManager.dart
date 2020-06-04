import 'dart:convert';
import 'package:flutter_learning_demo/models/wan_android_user.dart';
import 'package:flutter_learning_demo/net/NetAddress.dart';
import 'HttpUtil.dart';

class ApiManager {
  ///示例请求
  // static request(String param) {
  //   var params = DataHelper.getBaseMap();
  //   params['param'] = param;
  //   return HttpManager.getInstance().get(NetAddress.TEST_API, params);
  // }

  ///返回请求对应的数据类
  static Future<WanAndroidUser> requestLogin(String userName ,String password) async {
      WanAndroidUser user;
      var queryParameters = {'username':userName,'password':password};
      // var params = DataHelper.getBaseMap();
      // params['param'] = queryParameters;
      var response =  await HttpUtil.getInstance().post(NetAddress.LOGIN , data: queryParameters);
      Map<String, dynamic> decodeJson = json.decode(response.toString() );  
      user = WanAndroidUser.fromJson(decodeJson);  
      return user;   
  }

}