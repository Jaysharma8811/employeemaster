import 'package:cloud_firestore/cloud_firestore.dart';
import '../employee_data_model.dart';

class FirestoreHelper {
  static final FirestoreHelper _instance = FirestoreHelper._internal();
  factory FirestoreHelper() => _instance;
  final CollectionReference employeesCollection = FirebaseFirestore.instance.collection('employees');

  FirestoreHelper._internal();

  Future<void> insertEmployee(Employee employee) async {
    await employeesCollection.doc(employee.empCode).set(employee.toMap());
  }

  Future<List<Employee>> getEmployees() async {
    QuerySnapshot snapshot = await employeesCollection.get();
    return snapshot.docs.map((doc) => Employee.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }

  Future<void> updateEmployee(Employee employee) async {
    await employeesCollection.doc(employee.empCode).update(employee.toMap());
  }

  Future<void> deleteEmployee(String empCode) async {
    await employeesCollection.doc(empCode).delete();
  }

  Future<List<Employee>> searchEmployees(String keyword) async {
    QuerySnapshot snapshot = await employeesCollection
        .where('empName', isGreaterThanOrEqualTo: keyword)
        .where('empName', isLessThanOrEqualTo: keyword + '\uf8ff')
        .get();
    return snapshot.docs.map((doc) => Employee.fromMap(doc.data() as Map<String, dynamic>)).toList();
  }
}
