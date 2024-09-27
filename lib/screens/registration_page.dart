import 'package:employee_management/models/employee_model.dart';
import 'package:employee_management/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController employeeIdController = TextEditingController();
  String? designation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Employee Registration")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: "Username"),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              TextField(
                controller: mobileController,
                decoration: const InputDecoration(labelText: "Mobile Number"),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              TextField(
                controller: employeeIdController,
                decoration: const InputDecoration(labelText: "Employee ID"),
              ),
              DropdownButtonFormField<String>(
                value: designation,
                hint: const Text("Select Designation"),
                items: ["Developer", "Sr. Developer", "HR"]
                    .map((String value) => DropdownMenuItem(
                          value: value,
                          child: Text(value),
                        ))
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    designation = newValue;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (designation != null &&
                      usernameController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    final employee = Employee(
                      username: usernameController.text,
                      password: passwordController.text,
                      mobile: mobileController.text,
                      email: emailController.text,
                      employeeId: employeeIdController.text,
                      designation: designation!,
                    );

                    Provider.of<DBService>(context, listen: false)
                        .insertEmployee(employee);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Registration Successful!")));
                    Navigator.pop(context);
                  } else if (usernameController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Username & pasword shouldn't be empty"),
                    ));
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please select a designation")));
                  }
                },
                child: const Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
