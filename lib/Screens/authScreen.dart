import 'dart:convert';

import 'package:capp/Screens/conversationScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../API/BaseUrl.dart';

class UserDetail {
  static String? userid;
}

String? UserID() {
  return UserDetail.userid;
}

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  static const routeName = '/auth-Screen';

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool _isLogin = true;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();

  Map? mapResponse;
  Map? dataResponse;

  void register(String email, String password, String userName) async {
    try {
      Response response =
          await post(Uri.parse('${BaseUrl.baseUrl}/api/auth/register'), body: {
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
      Response response =
          await post(Uri.parse('${BaseUrl.baseUrl}/api/auth/login'), body: {
        "email": email,
        "password": password,
      });
      mapResponse = json.decode(response.body);
      dataResponse = mapResponse?['data'];
      UserDetail.userid = (dataResponse?['userId']);

      if (response.statusCode == 200) {
        Navigator.of(context).pushNamed(ConversationList.routeName);
      } else {
        print('faild');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  static const routeName = '/auth-Screen';
  @override
  Widget build(BuildContext context) {
    print(UserDetail.userid);
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
                      // obscureText: true,
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
