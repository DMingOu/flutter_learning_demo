import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'LogsInterceptors.dart';
import 'NetAddress.dart';

class HttpUtil {
  static HttpUtil instance = HttpUtil.internal();

  factory HttpUtil() => instance;

  BaseOptions options;

  Dio dio;

  CancelToken cancelToken = CancelToken();

  ///通用全局单例，第一次使用时初始化
  HttpUtil.internal() {
    if (null == dio) {
        //BaseOptions、Options、RequestOptions 都可以配置参数，优先级别依次递增，且可以根据优先级别覆盖参数
        options = BaseOptions(
        //请求基地址,可以包含子路径
        baseUrl: NetAddress.BASE_URL_RELEASE ,
        //连接服务器超时时间，单位是毫秒.
        connectTimeout: 10000,
        //响应流上前后两次接受到数据的间隔，单位为毫秒。
        receiveTimeout: 5000,
        //Http请求头.
        headers: {
          //do something
          "version": "1.0.0"
        },
        //请求的Content-Type，默认值是"application/json; charset=utf-8",Headers.formUrlEncodedContentType会自动编码请求体.
        contentType: Headers.formUrlEncodedContentType,
        //表示期望以那种格式(方式)接受响应数据。接受四种类型 `json`, `stream`, `plain`, `bytes`. 默认值是 `json`,
        responseType: ResponseType.plain,
        );

        dio = Dio(options);

        //Cookie管理
        dio.interceptors.add(CookieManager(CookieJar()));


      // _dio.interceptors.add(new ResponseInterceptors());
      dio.interceptors.add(InterceptorsWrapper(
          onRequest: (RequestOptions options) {
            // Do something before request is sent
            print("请求之前预处理");
          return options; //continue
        }, onResponse: (Response response) {
          print("响应之前预处理");
          // Do something with response data
          return response; // continue
        }, onError: (DioError e) {
          print("错误之前预处理");
          // Do something with response error
          return e; //continue
        })
      );

      dio.interceptors.add(new LogsInterceptors());
    }
  }


  
  static HttpUtil getInstance({String baseUrl}) {
    if (baseUrl == null) {
      return instance.normalUrl();
    } else {
      return instance.baseUrl(baseUrl);
    }
  }

    //用于本次请求需指定特定域名，比如cdn和kline首次的http请求
  HttpUtil baseUrl(String baseUrl) {
    if (dio != null) {
      dio.options.baseUrl = baseUrl;
    }
    return this;
  }

  //一般的请求，使用默认域名
  HttpUtil normalUrl() {
    if (dio != null) {
      if (dio.options.baseUrl != NetAddress.BASE_URL_RELEASE) {
        dio.options.baseUrl = NetAddress.BASE_URL_RELEASE;
      }
    }
    return this;
  }


  /*
   * get请求
   */
  get(url, {data, options, cancelToken}) async {
    Response response;
    try {
      response = await dio.get(url,
          queryParameters: data, options: options, cancelToken: cancelToken);
      // print('get success  \n${response.statusCode}');
      // print('get success  \n${response.data}');

//      response.data; 响应体
//      response.headers; 响应头
//      response.request; 请求体
//      response.statusCode; 状态码

    } on DioError catch (e) {
      print('get error\n$e');
      formatError(e);
    }
    return response;
  }

  /*
   * post请求
   */
  post(url, {data, options, cancelToken}) async {
    Response response;
    try {
      response = await dio.post(url,
          queryParameters: data, options: options, cancelToken: cancelToken);
      // print('post success\n${response.data}');
    } on DioError catch (e) {
      print('post error\n$e');
      formatError(e);
    }
    return response;
  }

  /*
   * 下载文件
   */
  downloadFile(urlPath, savePath) async {
    Response response;
    try {
      response = await dio.download(urlPath, savePath,
          onReceiveProgress: (int count, int total) {
        //进度
        print("$count $total");
      });
      print('downloadFile success\n${response.data}');
    } on DioError catch (e) {
      print('downloadFile error\n$e');
      formatError(e);
    }
    return response.data;
  }

  /*
   * error统一处理
   */
  void formatError(DioError e) {
    if (e.type == DioErrorType.CONNECT_TIMEOUT) {
      // It occurs when url is opened timeout.
      print("连接超时");
    } else if (e.type == DioErrorType.SEND_TIMEOUT) {
      // It occurs when url is sent timeout.
      print("请求超时");
    } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
      //It occurs when receiving timeout
      print("响应超时");
    } else if (e.type == DioErrorType.RESPONSE) {
      // When the server response, but with a incorrect status, such as 404, 503...
      print("出现异常");
    } else if (e.type == DioErrorType.CANCEL) {
      // When the request is cancelled, dio will throw a error with this type.
      print("请求取消");
    } else {
      //DEFAULT Default error type, Some other Error. In this case, you can read the DioError.error if it is not null.
      print("未知错误");
    }
  }

  /*
   * 取消请求
   *
   * 同一个cancel token 可以用于多个请求，当一个cancel token取消时，所有使用该cancel token的请求都会被取消。
   * 所以参数可选
   */
  void cancelRequests(CancelToken token) {
    token.cancel("cancelled");
  }
}