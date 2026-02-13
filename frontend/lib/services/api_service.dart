import 'dart:convert';
import 'package:http/http.dart' as http;
import '../config/api_constants.dart';

class ApiService {
  Future<http.Response> getData(String endpoint) async {
    final url = Uri.parse("${ApiConstants.baseUrl}/$endpoint");
    return await http.get(url);
  }

  Future<http.Response> postData(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse("${ApiConstants.baseUrl}/$endpoint");
    return await http.post(url, body: data);
  }

  Future<List<dynamic>> fetchClientes() async {
  final response = await getData("clientes");
  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    throw Exception("Error al cargar clientes");
  }
  }
  Future<http.Response> createData(String endpoint, Map<String, dynamic> data) async {
    return await http.post(Uri.parse("${ApiConstants.baseUrl}/$endpoint"),
        body: data);
  }
Future<http.Response> updateData(String endpoint, Map<String, dynamic> data, Map<String, String> map) async {
  final response = await http.put(
    Uri.parse("${ApiConstants.baseUrl}/$endpoint"),
    headers: {"Content-Type": "application/json"},
    body: json.encode(data),
  );
  return response;
}
  Future<http.Response> deleteData(String endpoint, int id) async {
    return await http.delete(Uri.parse("${ApiConstants.baseUrl}/$endpoint/$id"));
  }
}