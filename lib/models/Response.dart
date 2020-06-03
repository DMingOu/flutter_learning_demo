import 'dart:convert';

class Response{

  String errorMsg;
  int errorCode;
  Result result;

  // parseDataFunction data 数据类的解析函数
  static Response parse(String data, var parseDataFunction) {
    // 通过 dart:convert 提供的 jsonDecode() 函数将原始数据类转换为 Map<String, dynamic> map
    Map<String, dynamic> map = jsonDecode(data);
    Response response = Response();
    response.errorMsg = map['errorMsg'];
    response.errorCode = map['errorCode'];
    response.result = Result.fromMap(map, parseDataFunction);
    return response;
  }
}

class Result{
  // 真正需要的数据类
  var content;

  static Result fromMap(Map<String, dynamic> map, var parseDataFunction){
    Result result = Result();
    if(map != null){
        result.content = parseDataFunction(map);
    }
    return result;
  }
}