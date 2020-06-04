///请求响应的数据基类
class ResultData {
  var data;
  bool isSuccess;
  int code;
  var headers;

  ResultData(this.data, this.isSuccess, this.code, {this.headers});

  

}

