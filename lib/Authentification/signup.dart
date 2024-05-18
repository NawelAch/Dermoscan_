import 'package:flutter/material.dart';
import 'login.dart';
import 'package:dermoscan/JsonModels/users.dart';
import 'package:dermoscan/sqlite/login_db.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final username = TextEditingController();
  final email = TextEditingController(); // Controller for email input
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  final age = TextEditingController(); // Controller for age input
  String selectedGender = '';

  final formKey = GlobalKey<FormState>();

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ListTile(
                    title: Text(
                      "Register New Account",
                      style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
                    ),
                  ),

                  // Username field
                  Container(
                    margin: EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFFC7D9FD),
                    ),
                    child: TextFormField(
                      controller: username,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Username is required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        border: InputBorder.none,
                        hintText: "Username",
                      ),
                    ),
                  ),

                  // Email field
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFFC7D9FD),
                    ),
                    child: TextFormField(
                      controller: email,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Email is required";
                        } else if (!value.contains('@')) {
                          return "Invalid email";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.email),
                        border: InputBorder.none,
                        hintText: "Email",
                      ),
                    ),
                  ),

                  // Age field
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFFC7D9FD),
                    ),
                    child: TextFormField(
                      controller: age,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Age is required";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today),
                        border: InputBorder.none,
                        hintText: "Age",
                      ),
                    ),
                  ),

                  // Gender field
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFFC7D9FD),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Gender:'),
                        Row(
                          children: [
                            Radio(
                              value: 'Male',
                              groupValue: selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  selectedGender = value.toString();
                                });
                              },
                            ),
                            const Text('Male'),
                            Radio(
                              value: 'Female',
                              groupValue: selectedGender,
                              onChanged: (value) {
                                setState(() {
                                  selectedGender = value.toString();
                                });
                              },
                            ),
                            const Text('Female'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Password field
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFFC7D9FD),
                    ),
                    child: TextFormField(
                      controller: password,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is required";
                        }
                        return null;
                      },
                      obscureText: !isVisible,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.lock),
                        border: InputBorder.none,
                        hintText: "Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
                        ),
                      ),
                    ),
                  ),

                  // Confirm Password field
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0xFFC7D9FD),
                    ),
                    child: TextFormField(
                      controller: confirmPassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Confirm Password is required";
                        } else if (password.text != confirmPassword.text) {
                          return "Passwords don't match";
                        }
                        return null;
                      },
                      obscureText: !isVisible,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.lock),
                        border: InputBorder.none,
                        hintText: "Confirm Password",
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isVisible = !isVisible;
                            });
                          },
                          icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off),
                        ),
                      ),
                    ),
                  ),

                  //sign up button
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xFF387ADF)),
                    child: TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          //Login method will be here

                          // Call signup function from DatabaseHelper
                          final db = DatabaseHelper();
                          db.signup(
                            Users(
                              usrName: username.text,
                              usrPassword: password.text,
                              usrEmail: email.text, // Pass the email text from the email field
                            ),
                            age.text, // Pass the age text from the age field
                            selectedGender, // Pass the selected gender
                          ).then((_) {//After success user creation go to login screen
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    const LoginScreen()));
                          });
                        }
                      },
                      child: const Text(
                        "SIGN UP",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),

                  // Already have an account? Login button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginScreen()),
                          );
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(color: Color(0xFF387ADF)),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}