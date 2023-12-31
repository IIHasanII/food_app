import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_app/features/login/ui/login.dart';

class Signup extends StatefulWidget {
  static const String id = "Signup";
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _auth = FirebaseAuth.instance;
  late String email;
  late String password;
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
                  child: Text("Signup",
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
                onChanged: (value) {
                  email = value;
                },
                decoration: const InputDecoration(
                    prefixIconColor: Colors.grey,
                    prefixIcon: Icon(Icons.mail),
                    hintText: "Enter Email",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)))),
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
                onChanged: (value) {
                  password = value;
                },
                obscureText: !textPrivacy,
                decoration: InputDecoration(
                    suffixIconColor: Colors.grey,
                    prefixIconColor: Colors.grey,
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
                      try {
                        await _auth.createUserWithEmailAndPassword(
                            email: email, password: password);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> Login()));
                      } catch (error) {
                        if (error is FirebaseAuthException) {
                          String errorMessage = error.message??"an error occured";
                          
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                                behavior: SnackBarBehavior.floating,
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [Text('$errorMessage')])));
                           
                          
                        } else {
                          print("An unexpected error occurred: $error");
                        }
                      }
                    },
                    child: const Text(
                      "SIGNUP",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )),
              )),
              const SizedBox(
                height: 5.0,
              ),
              Center(child: TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: ((context) => Login())));
              }, child: Text("Already Signup? Go to Login", style: TextStyle(fontSize: 18.0,fontWeight: FontWeight.bold, color: Colors.black),)))
            ],
          ),
        ),
      ),
    );
  }
}
