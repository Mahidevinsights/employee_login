import 'package:flutter/material.dart';
import '../models/employee_model.dart';

class EmployeeDetailPage extends StatelessWidget {
  final Employee employee;

  const EmployeeDetailPage(this.employee, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Employee Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username: ${employee.username}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Email: ${employee.email}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Mobile: ${employee.mobile}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Employee ID: ${employee.employeeId}',
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Text('Designation: ${employee.designation}',
                style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
