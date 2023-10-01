import 'package:flutter/material.dart';
import 'package:food_app/features/home/ui/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  static const String id = "Login";
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String email = '';
  String password = '';
  String emailErrorMessage = '';
  String passwordErrorMessage = '';
  bool _hasError = false;

  bool textPrivacy = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                  child: Text("Login",
                      style: TextStyle(
                          fontSize: 30.0, fontWeight: FontWeight.bold))),
              const SizedBox(
                height: 30.0,
              ),
              const Text("Email Address", style: TextStyle(fontSize: 20.0)),
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: _emailController,
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                  hintText: "Enter Email",
                  prefixIconColor: Colors.grey,
                  prefixIcon: Icon(Icons.mail),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  errorText: _hasError ? emailErrorMessage : null,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                "Password",
                style: TextStyle(fontSize: 20.0),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextField(
                controller: _passwordController,
                onChanged: (value) {
                  password = value;
                },
                obscureText: !textPrivacy,
                decoration: InputDecoration(
                    prefixIconColor: Colors.grey,
                    suffixIconColor: Colors.grey,
                    errorText: _hasError ? passwordErrorMessage : null,
                    suffixIcon: IconButton(
                      icon: Icon(
                        textPrivacy ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          textPrivacy = !textPrivacy;
                        });
                      },
                    ),
                    prefixIcon: const Icon(Icons.lock),
                    hintText: "Enter Password",
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)))),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Center(
                  child: SizedBox(
                height: 60,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                    onPressed: () async {
                      setState(() {
                        if (email.isEmpty ||
                            !email.contains('@') ||
                            password.isEmpty) {
                          emailErrorMessage = 'Invalid Email Address';
                          passwordErrorMessage = "Enter a password";
                          _hasError = true;
                        } else {
                          passwordErrorMessage = '';
                          emailErrorMessage = '';
                        }
                      });
                      try {
                        await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
                      } catch (error) {
                        if (error is FirebaseAuthException) {
                          String errorMessage =
                              error.message ?? 'An error occured';
                          if (errorMessage ==
                              "An internal error has occurred. [ INVALID_LOGIN_CREDENTIALS ]") {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                                behavior: SnackBarBehavior.floating,
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [Text('Invalid Email or Password')])));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                                behavior: SnackBarBehavior.floating,
                                content:Column(
                                  mainAxisSize: MainAxisSize.min,                                     
                                  children: [Text('$errorMessage')])));
                          }
                        } else {
                          print("An unexpected error occurred: $error");
                        }
                      }
                    },
                    child: const Text(
                      "LOGIN",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
              )),
              const SizedBox(
                height: 15.0,
              ),
              const Center(
                  child: Text(
                "Forgot Password?",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w800),
              ))
            ],
          ),
        ),
      ),
    );
  }
}
