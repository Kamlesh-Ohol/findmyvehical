import 'package:findmyvehical/auth/Forgotpasspage.dart';
import 'package:findmyvehical/home/homepage.dart';
import 'package:findmyvehical/login/signin.dart';
import 'package:flutter/material.dart';
import '../auth/auth_service.dart';
class getmail extends Signuppage{
  final S = Signuppage();
  String get _email => '';
}
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = AuthService();
  bool _isObscured = true;

  // Controllers
  final _email = TextEditingController();
  final _password = TextEditingController();

  // Error message variables
  String? _emailError;
  String? _passwordError;

  // Regular expression to validate email format
  final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  // Method to handle login
  Future<void> _login() async {
    setState(() {
      _validateFields();
    });

    // If there are no errors, proceed with login
    if (_emailError == null && _passwordError == null) {
      try {
        final user = await _auth.loginUserWithEmailAndPassword(
          _email.text.trim(),
          _password.text.trim(),
        );

        if (user != null) {
          gotohomepage(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Login failed. Please try again.')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  // Validate the fields
  void _validateFields() {
    setState(() {
      // Email validation
      _emailError = _email.text.isEmpty
          ? 'Email is required'
          : !emailRegex.hasMatch(_email.text)
          ? 'Enter a valid email address'
          : null;

      // Password validation
      _passwordError = _password.text.isEmpty ? 'Password is required' : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Email ID'),
                const SizedBox(height: 8.0),
                TextField(
                  controller: _email,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                    hintText: 'Enter Email ID',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorText: _emailError, // Show email error if any
                  ),
                ),
                const SizedBox(height: 16.0),

                const Text("Password"),
                const SizedBox(height: 8.0), // Add spacing before the password field
                Container(
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _password,
                          obscureText: _isObscured,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 8.0),
                            hintText: 'Enter password',
                            errorText: _passwordError, // Show password error if any
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _isObscured = !_isObscured;
                          });
                        },
                        icon: Icon(
                          _isObscured ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24.0),
                TextButton(onPressed: (){
                  gotoForgotpasspage(context);
                }, child: Text('Forgot Password',style: TextStyle(color: Colors.blue),)),
                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _login(); // Validate and login
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                    ),
                    child: const Text("Login"),
                  ),
                ),
                const SizedBox(height: 16.0),

                // Create Account Text Button
                Center(
                  child: TextButton(
                    onPressed: () {
                      gotosignuppage(context);
                    },
                    child: const Text("Create account"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Navigate to signup page
  gotosignuppage(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Signuppage()),
  );
  gotoForgotpasspage(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const Forgotpasspage(),
  ));
  // Navigate to home page
  gotohomepage(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const HomePage()),
  );
}
