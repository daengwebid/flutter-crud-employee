import 'package:dw_employee_crud/models/employee_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EmployeeProvider extends ChangeNotifier {
  List<EmployeeModel> _data = [];
  List<EmployeeModel> get dataEmployee => _data;

  Future<List<EmployeeModel>> getEmployee() async {
    final url = 'http://employee-crud-flutter.daengweb.id/index.php';
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final result = json.decode(response.body)['data'].cast<Map<String, dynamic>>();
      _data = result.map<EmployeeModel>((json) => EmployeeModel.fromJson(json)).toList();
      return _data;
    } else {
      throw Exception();
    }
  }

  //ADD DATA
  Future<bool> storeEmployee(String name, String salary, String age) async {
    final url = 'http://employee-crud-flutter.daengweb.id/add.php';
    final response = await http.post(url, body: {
      'employee_name': name,
      'employee_salary': salary,
      'employee_age': age
    });

    final result = json.decode(response.body);
    if (response.statusCode == 200 && result['status'] == 'success') {
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<EmployeeModel> findEmployee(String id) async {
    return _data.firstWhere((i) => i.id == id);
  }

  Future<bool> updateEmployee(id, name, salary, age) async {
    final url = 'http://employee-crud-flutter.daengweb.id/update.php';
    final response = await http.post(url, body: {
      'id': id,
      'employee_name': name,
      'employee_salary': salary,
      'employee_age': age
    });

    final result = json.decode(response.body);
    if (response.statusCode == 200 && result['status'] == 'success') {
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<void> deleteEmployee(String id) async {
    final url = 'http://employee-crud-flutter.daengweb.id/delete.php';
    await http.get(url + '?id=$id');
  }
}