import 'dart:convert';
import 'package:http/http.dart';
import '../model/employees.dart';
import 'log_service.dart';

class Network {
  static String BASE = "dummy.restapiexample.com";
  static Map<String, String> headers = {
    'Content-Type': 'application/json; charset=UTF-8'
  };

/* Http Apis*/

  static String API_LIST = "/api/v1/employees";
  static String API_CREATE = "/api/v1/create";
  static String API_UPDATE = "/api/v1/update/21"; //{id}
  static String API_DELETE = "/api/v1/delete/2"; //{id}


/* Http Requests*/

  static Future<String?> GET(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api, params); // http or https
    var response = await get(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> POST(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api);
    var response = await post(uri, headers: headers, body: jsonEncode(params));
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }

  static Future<String?> PUT(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api); // http or https
    var response = await put(uri, headers: headers, body: jsonEncode(params));
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  static Future<String?> DEL(String api, Map<String, String> params) async {
    var uri = Uri.https(BASE, api, params);
    var response = await delete(uri, headers: headers);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }

  /* Http Params */

  static Map<String, String> paramsEmpty() {
    Map<String, String> params = Map();
    return params;
  }

  static Map<String, String> paramsCreate(Employee post) {
    Map<String, String> params = Map();
    params.addAll({
      'employee_name': post.employeeName!,
      'employee_salary': post.employeeSalary.toString()!,
      'employee_age': post.employeeName.toString(),
    });
    return params;
  }

  static Map<String, String> paramsUpdate(Employee post) {
    Map<String, String> params = Map();
    params.addAll({
      'id': post.id.toString(),
      'employee_name': post.employeeName!,
      'employee_salary': post.employeeSalary.toString()!,
      'employee_age': post.employeeName.toString(),
    });
    LogService.w(params.toString());
    return params;
  }

  /* Http Parsing */

  static EmpResponse parsePostList(String response) {
    dynamic json = jsonDecode(response);
    var data = EmpResponse.fromJson(json);
    return data;
  }
}
