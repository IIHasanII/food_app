import 'package:flutter/material.dart';
import 'package:food_app/features/home/ui/home_screen.dart';


class Signup extends StatefulWidget {
  static const String id = "Signup";
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  late String email;
  late String password;
  bool textPrivacy = false;
  String fakeEmail = "wintersoldier0987@gmail.com";
  String fakePaswword = "123456";

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
                    onPressed: () {
                      setState(() {
                        if (email == fakeEmail && password == fakePaswword) {
                          Navigator.pushNamed(context, HomeScreen.id);
                        } else if (email != fakeEmail &&
                            password != fakePaswword) {
                          print("Nope");
                        }
                      });
                    },
                    child: const Text(
                      "SIGNUP",
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
