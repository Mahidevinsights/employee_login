// ignore_for_file: use_build_context_synchronously

import 'package:employee_management/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'registration_page.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Employee Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final dbService =
                    Provider.of<DBService>(context, listen: false);
                var employee = await dbService.login(
                    usernameController.text, passwordController.text);

                if (employee != null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Welcome, ${employee.username}!")));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Invalid credentials")));
                }
              },
              child: const Text("Login"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationPage()),
                );
              },
              child: const Text("Registration"),
            ),
          ],
        ),
      ),
    );
  }
}
