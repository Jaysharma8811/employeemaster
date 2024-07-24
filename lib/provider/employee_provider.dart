// import 'package:flutter/material.dart';
// import '../data_model/data_helper/database_helper.dart';
// import '../data_model/employee_data_model.dart';
//
//
// class EmployeeProvider with ChangeNotifier {
//   List<Employee> _employees = [];
//   List<Employee> get employees => _employees;
//
//   Future<void> fetchEmployees() async {
//     _employees = await FirestoreHelper().getEmployees();
//     print("Employee:${_employees.length}");
//     notifyListeners();
//   }
//
//   Future<void> addEmployee(Employee employee) async {
//     await FirestoreHelper().insertEmployee(employee);
//     await fetchEmployees();
//   }
//
//   Future<void> updateEmployee(Employee employee) async {
//     await FirestoreHelper().updateEmployee(employee);
//     await fetchEmployees();
//   }
//
//   Future<void> deleteEmployee(String empCode) async {
//     await FirestoreHelper().deleteEmployee(empCode);
//     await fetchEmployees();
//   }
//
//   Future<void> searchEmployees(String keyword) async {
//     _employees = await FirestoreHelper().searchEmployees(keyword);
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';
import '../data_model/data_helper/database_helper.dart';
import '../data_model/employee_data_model.dart';


class EmployeeProvider with ChangeNotifier {
  List<Employee> _employees = [];
  List<Employee> _searchResults = [];
  List<Employee> get employees => _employees;
  List<Employee> get searchResults => _searchResults;

  EmployeeProvider() {
    fetchEmployees();
  }

  Future<void> fetchEmployees() async {
    try {
      _employees = await FirestoreHelper().getEmployees();
      notifyListeners();
    } catch (e) {
      print('Error fetching employees: $e');
    }
  }

  Future<void> addEmployee(Employee employee) async {
    await FirestoreHelper().insertEmployee(employee);
    await fetchEmployees();
  }

  Future<void> updateEmployee(Employee employee) async {
    await FirestoreHelper().updateEmployee(employee);
    await fetchEmployees();
  }

  Future<void> deleteEmployee(String empCode) async {
    await FirestoreHelper().deleteEmployee(empCode);
    await fetchEmployees();
  }

  Future<void> searchEmployees(String keyword) async {
    _searchResults = await FirestoreHelper().searchEmployees(keyword);

    print('Employees found: ${_searchResults.length}');
    notifyListeners();
  }
}
