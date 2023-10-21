import 'dart:io';
import 'package:http/http.dart' as http;


class ApiService{


  var serviceUrl = 'http://172.19.82.172:3000/';

  Future<http.Response> postData({required String apiUrl,required Object body, Map<String, String>? header})async{
    try{
      var url = Uri.parse(serviceUrl+apiUrl);
      var response = await http.post(url,body: body, headers: header);
      return response;
      // ignore: duplicate_ignore
    } on HttpException {
      rethrow;
    } on SocketException {
      rethrow;
    } on FormatException {
      rethrow;
    } catch (error){
      rethrow;
    }
  }

  Future<http.Response> getData({required String apiUrl})async{
    try{
      var url = Uri.parse(serviceUrl+apiUrl);
      var response = await http.get(url);
      return response;
    } on HttpException {
      rethrow;
    } on SocketException {
      rethrow;
    } on FormatException {
      rethrow;
    } catch (error){
      rethrow;
    }
  }

  Future<http.Response> customApiData({required String apiUrl})async{
    try{
      var url = Uri.parse(apiUrl);
      var response = await http.get(url);
      return response;
    } on HttpException {
      rethrow;
    } on SocketException {
      rethrow;
    } on FormatException {
      rethrow;
    } catch (error){
      rethrow;
    }
  }

}
