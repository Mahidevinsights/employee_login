import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/db_service.dart';
import 'employee_detail_page.dart';
import '../models/employee_model.dart';

class EmployeeListPage extends StatelessWidget {
  const EmployeeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final dbService = Provider.of<DBService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Employee List',
          style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<Employee>>(
        future: dbService.getAllEmployees(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.red, fontSize: 18),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No employees found.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            );
          } else {
            final employees = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: employees.length,
              itemBuilder: (context, index) {
                final employee = employees[index];
                return _buildEmployeeCard(context, employee);
              },
            );
          }
        },
      ),
    );
  }

  // Build a Card widget for each employee
  Widget _buildEmployeeCard(BuildContext context, Employee employee) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.blueAccent,
          child: Icon(
            _getDesignationIcon(employee.designation),
            color: Colors.white,
          ),
        ),
        title: Text(
          employee.username,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          employee.designation,
          style: const TextStyle(
            color: Colors.grey,
          ),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EmployeeDetailPage(employee),
            ),
          );
        },
        trailing: const Icon(Icons.arrow_forward_ios),
      ),
    );
  }

  // Get an icon based on the employee's designation
  IconData _getDesignationIcon(String designation) {
    switch (designation) {
      case 'Developer':
        return Icons.code;
      case 'Sr. Developer':
        return Icons.developer_mode;
      case 'HR':
        return Icons.person_outline;
      default:
        return Icons.work_outline;
    }
  }
}
