import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/employee_provider.dart';
import 'employee_form_screen.dart';

class EmployeeListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EmployeeProvider>(context);
    int empcd(){
      if(provider.employees.isEmpty){
        return 1;
      }
      else{
        return int.parse(provider.employees[provider.employees.length-1].empCode)+1;
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List'),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: EmployeeSearchDelegate());
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: provider.fetchEmployees(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.separated(
              itemCount: provider.employees.length,
              itemBuilder: (context, index) {
                final employee = provider.employees[index];
                return ListTile(
                  title: Text(employee.empName),
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Text(employee.empCode.toString()),
                  ),
                  subtitle: Text(employee.mobile),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Theme.of(context).primaryColor,
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            EmployeeFormScreen(employee: employee),
                      ),
                    );
                  },
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return Divider();
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EmployeeFormScreen(
                      empcode:empcd()  ,
                    )),
          );
        },
      ),
    );
  }
}

class EmployeeSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final provider = Provider.of<EmployeeProvider>(context, listen: false);
    provider.searchEmployees(query);
    return Consumer<EmployeeProvider>(
      builder: (context, provider, child) {
        return ListView.separated(
          itemCount: provider.searchResults.length,
          itemBuilder: (context, index) {
            final employee = provider.searchResults[index];
            return ListTile(
              title: Text(employee.empName),
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child:Text(employee.empCode.toString()),
              ),
              subtitle: Text(employee.mobile),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EmployeeFormScreen(employee: employee),
                  ),
                );
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final provider = Provider.of<EmployeeProvider>(context, listen: false);
    provider.searchEmployees(query);
    return Consumer<EmployeeProvider>(
      builder: (context, provider, child) {
        return ListView.separated(
          itemCount: provider.searchResults.length,
          itemBuilder: (context, index) {
            final employee = provider.searchResults[index];
            return ListTile(
              title: Text(employee.empName),
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).primaryColor,
                child: Text(employee.empCode.toString()),
              ),
              subtitle: Text(employee.mobile),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EmployeeFormScreen(employee: employee),
                  ),
                );
              },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider();
          },
        );
      },
    );
  }
}
