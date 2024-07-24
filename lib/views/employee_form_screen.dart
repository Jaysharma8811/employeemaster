import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data_model/employee_data_model.dart';
import '../provider/employee_provider.dart';


class EmployeeFormScreen extends StatefulWidget {
  final Employee? employee;
  EmployeeFormScreen({this.employee});

  @override
  _EmployeeFormScreenState createState() => _EmployeeFormScreenState();
}

class _EmployeeFormScreenState extends State<EmployeeFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _empCodeController = TextEditingController();
  final _empNameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _dobController = TextEditingController();
  final _dateOfJoiningController = TextEditingController();
  final _salaryController = TextEditingController();
  final _addressController = TextEditingController();
  final _remarkController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.employee != null) {
      _empCodeController.text = widget.employee!.empCode;
      _empNameController.text = widget.employee!.empName;
      _mobileController.text = widget.employee!.mobile;
      _dobController.text = widget.employee!.dob;
      _dateOfJoiningController.text = widget.employee!.dateOfJoining;
      _salaryController.text = widget.employee!.salary.toString();
      _addressController.text = widget.employee!.address;
      _remarkController.text = widget.employee!.remark;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmployeeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.employee == null ? 'Add Employee' : 'Edit Employee'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _empCodeController,
                decoration: InputDecoration(labelText: 'Employee Code'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter employee code';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _empNameController,
                decoration: InputDecoration(labelText: 'Employee Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter employee name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _mobileController,
                decoration: InputDecoration(labelText: 'Mobile No.'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter mobile number';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dobController,
                decoration: InputDecoration(labelText: 'Date of Birth'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter date of birth';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateOfJoiningController,
                decoration: InputDecoration(labelText: 'Date of Joining'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter date of joining';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _salaryController,
                decoration: InputDecoration(labelText: 'Salary'),

                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter salary';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _addressController,
                decoration: InputDecoration(labelText: 'Address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter address';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _remarkController,
                decoration: InputDecoration(labelText: 'Remark'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter remark';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final employee = Employee(
                      empCode: _empCodeController.text,
                      empName: _empNameController.text,
                      mobile: _mobileController.text,
                      dob: _dobController.text,
                      dateOfJoining: _dateOfJoiningController.text,
                      salary: double.parse(_salaryController.text),
                      address: _addressController.text,
                      remark: _remarkController.text,
                    );

                    if (widget.employee == null) {
                      provider.addEmployee(employee);
                    } else {
                      provider.updateEmployee(employee);
                    }

                    Navigator.pop(context);
                  }
                },
                child: Text(widget.employee == null ? 'Save' : 'Update'),
              ),
              if (widget.employee != null)
                ElevatedButton(
                  onPressed: () {
                    provider.deleteEmployee(widget.employee!.empCode);
                    Navigator.pop(context);
                  },
                  child: Text('Delete'),
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
