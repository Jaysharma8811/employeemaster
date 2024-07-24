class Employee {
  String empCode;
  String empName;
  String mobile;
  String dob;
  String dateOfJoining;
  double salary;
  String address;
  String remark;

  Employee({
    required this.empCode,
    required this.empName,
    required this.mobile,
    required this.dob,
    required this.dateOfJoining,
    required this.salary,
    required this.address,
    required this.remark,
  });

  Map<String, dynamic> toMap() {
    return {
      'empCode': empCode,
      'empName': empName,
      'mobile': mobile,
      'dob': dob,
      'dateOfJoining': dateOfJoining,
      'salary': salary,
      'address': address,
      'remark': remark,
    };
  }

  factory Employee.fromMap(Map<String, dynamic> map) {
    return Employee(
      empCode: map['empCode'],
      empName: map['empName'],
      mobile: map['mobile'],
      dob: map['dob'],
      dateOfJoining: map['dateOfJoining'],
      salary: map['salary'],
      address: map['address'],
      remark: map['remark'],
    );
  }
}
