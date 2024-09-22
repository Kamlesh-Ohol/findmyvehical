import 'package:findmyvehical/auth/auth_service.dart';
import 'package:findmyvehical/home/homepage.dart';
import 'package:flutter/material.dart';
import 'login.dart';
class getmail extends Signuppage{
  final S = Signuppage();
  String get _email => '';
}
class Signuppage extends StatefulWidget {

  const Signuppage({super.key});

  @override
  State<Signuppage> createState() => _SignupageState();
}

class _SignupageState extends State<Signuppage> {
  var isObscured = true;
  final _auth = AuthService();
  // Controllers
  final _email = TextEditingController();
  final _username = TextEditingController();
  final _password = TextEditingController();

  // Error message variables
  String? _emailError;
  String? _usernameError;
  String? _passwordError;

  // Regular expression to validate email format
  final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  // Method to handle signup
  Future<void> _signup() async {
    setState(() {
      _validateFields();
    });

    // If no error, proceed with the signup
    if (_emailError == null && _usernameError == null && _passwordError == null) {
      try {
        await _auth.createUserWithEmailAndPassword(
          _email.text.trim(),
          _password.text.trim(),
        );
        gotohome(context);
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
      _usernameError = _username.text.isEmpty ? 'Username is required' : null;

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
              children: [
                const Text("Enter username"),
                const SizedBox(height: 8.0),
                TextField(
                  controller: _username,
                  decoration: InputDecoration(
                    hintText: "Enter Username",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    errorText: _usernameError, // Show error if any
                  ),
                ),
                const SizedBox(height: 16.0),

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
                const SizedBox(height: 16.0),

                const Text("Enter password"),
                const SizedBox(height: 8.0),
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
                          obscureText: isObscured,
                          decoration: InputDecoration(
                            hintText: "Enter password",
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                            errorText: _passwordError, // Show error if any
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isObscured = !isObscured;
                          });
                        },
                        icon: Icon(
                          isObscured ? Icons.visibility : Icons.visibility_off,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16.0),

                ElevatedButton(
                  onPressed: () => _signup(),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50), // Full-width button
                  ),
                  child: const Text("Sign Up"),
                ),
                const SizedBox(height: 16.0),

                Center(
                  child: TextButton(
                    onPressed: () {
                      gotologin(context);
                    },
                    child: const Text("Already have an account?"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  width: double.infinity,
                  height: 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Text("Continue with",style: TextStyle(fontSize: 15,color:Colors.deepPurple ),),
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(

                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: (){
                            //TODO: google login without password
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.transparent,
                            radius: 20,
                            child: Image(image: AssetImage('assets/images/google.png'))
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(

                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: (){
                            //TODO: google login without password
                          },
                          child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 20,
                              child: Image(image: AssetImage('assets/images/facebook.png'))
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(

                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: (){
                            //TODO: google login without password
                          },
                          child: CircleAvatar(
                              backgroundColor: Colors.transparent,
                              radius: 20,
                              child: Image(image: AssetImage('assets/images/apple-logo.png'))
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Navigate to login
  gotologin(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const LoginPage()),
  );

  // Navigate to home page
  gotohome(BuildContext context) => Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const HomePage()),
  );
}
