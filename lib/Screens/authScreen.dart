import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = false;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  Map? mapResponse;
  Map? dataResponse;
  String? userid;

  void register(String email, String password, String userName) async {
    try {
      Response response = await post(
          Uri.parse('https://3c3b-112-196-166-7.in.ngrok.io/api/auth/register'),
          body: {
            "email": email,
            "password": password,
            "username": userName,
          });

      if (response.statusCode == 201) {
        print('worked successfully');
      } else {
        print('faild');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void login(String email, String password) async {
    try {
      Response response = await post(
          Uri.parse('https://68f3-112-196-188-56.in.ngrok.io/api/auth/login'),
          body: {
            "email": email,
            "password": password,
          });
      mapResponse = json.decode(response.body);
      dataResponse = mapResponse?['data'];
      userid = dataResponse?['userId'];

      if (response.statusCode == 200) {
        print('worked successfully');
      } else {
        print('faild');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    print(userid);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(60),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(60),
                        ),
                        color: Colors.grey[500],
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            _isLogin ? 'Login' : 'Signup',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text("Email Address:"),
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      // decoration: InputDecoration(labelText: 'Email Address'),
                    ),
                    if (!_isLogin)
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Text("UserName:"),
                      ),
                    if (!_isLogin)
                      TextFormField(
                        controller: userNameController,
                        // decoration: InputDecoration(labelText: 'UserName'),
                      ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: Text("Password:"),
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      // decoration: InputDecoration(labelText: 'Password'),
                      validator: (value) {
                        if (value!.isEmpty || value.length < 6) {
                          return 'Password Must be atleast 7 characters long.';
                        }
                        return null;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 35),
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if (_isLogin) {
                              login(
                                emailController.text.toString(),
                                passwordController.text.toString(),
                              );
                            } else {
                              register(
                                emailController.text.toString(),
                                passwordController.text.toString(),
                                userNameController.text.toString(),
                              );
                            }
                          },
                          child: Text(_isLogin ? 'Login' : 'Sign Up'),
                        ),
                      ),
                    ),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(_isLogin
                            ? 'Create new Account'
                            : 'Already have an account'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
