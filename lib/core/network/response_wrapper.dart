class ResponseWrapper<T> {
  final int? statusCode;
  final String? message;
  final T? data;

  ResponseWrapper({this.statusCode, this.message, this.data});

  factory ResponseWrapper.success(T data, {int? statusCode}) {
    return ResponseWrapper(statusCode: statusCode ?? 200, data: data);
  }

  factory ResponseWrapper.error(String message, {int? statusCode}) {
    return ResponseWrapper(statusCode: statusCode ?? 500, message: message);
  }
}
