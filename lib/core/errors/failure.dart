import 'package:dio/dio.dart';

abstract class Failure{
  final String message;
  Failure(this.message);
}
class ServerFailure extends Failure{
  ServerFailure(super.message);
  factory ServerFailure.fromDioException(DioException e){
    switch(e.type){
      case DioExceptionType.connectionTimeout:
        return ServerFailure("Connection Timeout With Api Server");
      case DioExceptionType.sendTimeout:
        return ServerFailure("Send Timeout With Api Server");
      case DioExceptionType.receiveTimeout:
        return ServerFailure("Receive Timeout With Api Server");
      case DioExceptionType.badCertificate:
        return ServerFailure("Bad Certificate With Api Server");
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(e.response!.statusCode, e.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure("Request To Api Server Was Canceled");
      case DioExceptionType.connectionError:
        return ServerFailure("No Internet Connection");
      case DioExceptionType.unknown:
        return ServerFailure("It Seems There Was An Error, Please Try Again");
    }
  }
  factory ServerFailure.fromResponse(int? statusCode,dynamic response){
    if(statusCode==404){
      return ServerFailure("Your Request Was Not Found, Please Try Again Later");
    } else if(statusCode==500){
      return ServerFailure("There Is A Problem With Server, Please Try Again Later");
    }else if(statusCode==400 || statusCode==401 ){
      return ServerFailure(response['error']['message']);
    }else if(statusCode==403){
      return ServerFailure("Forbidden Request");
    }else{
      return ServerFailure("It Seems There Was A Response Error, Please Try Again");
    }
  }

}