import 'package:flutter/cupertino.dart';

class PageData {
  
    String contentString;
    Object object;

    ///错误的构造参数，导致实例可以构建出来，但参数值永远是null
    // PageData({@required String contentString  , 
    //           Object object = 'null object'}
    //         );

    
    ///构造函数，描述必填,object是可选的
    // PageData({@required this.contentString,
    //                     this.object});

      ///构造函数，描述必填,object是可选的    
      PageData({@required contentString  , object}){
          this.contentString = contentString;
          if(object == null){
            object = 'null object';
          }else {
            this.object = object;
          }
      }

    @override
    String toString() {
      return "PageData = [contentString : $contentString , object : ${object.toString()}]";
    }
}