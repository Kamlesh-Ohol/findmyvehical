import 'package:findmyvehical/auth/auth_service.dart';
import 'package:flutter/material.dart';

class Forgotpasspage extends StatefulWidget {
  const Forgotpasspage({super.key});
  @override
  State<Forgotpasspage> createState() => _ForgotpasspageState();
}

class _ForgotpasspageState extends State<Forgotpasspage> {
  final _auth = AuthService();
  final _email = TextEditingController();
  String? _emailError;
  final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  Future<void> _emailcheck() async {
    setState(() {
      _validateFields();
    });

    // If no error, proceed with the sending email
    if (_emailError == null) {
      try {
        await _auth.ForgotPass(_email.text.trim());
    } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text('Error: $e')), // Show the error message
    );
    }
  }
  }

  // Validate the fields
  void _validateFields() {
    setState(() {
      // Username validation
      // Email validation
      _emailError = _email.text.isEmpty
          ? 'Email is required'
          : !emailRegex.hasMatch(_email.text)
          ? 'Enter a valid email address'
          : null;

      // Password validatio
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: Column(
        children: [
          const Text("Enter email"),
      const SizedBox(height: 8.0),
      TextField(
        controller: _email,
        decoration: InputDecoration(
          hintText: "Enter Email",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          errorText: _emailError, // Show error if any
        ),
      ),
          ElevatedButton(
            onPressed: () => (
            _auth.ForgotPass(_email.text)
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50), // Full-width button
            ),
            child: const Text("Get email"),
          ),
        ],

      ),
    );
  }
}
