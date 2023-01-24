import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();
    var baseUrl = 'http://10.0.2.2:8000/api';

    login() async {
      var headers = {'Accept': 'application/json'};
      var body = {
        'email': email.text,
        'password': password.text,
      };
      var response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: headers,
        body: body,
      );
      if (response.statusCode == 201) {
        var data = jsonDecode(response.body);
        Navigator.pushNamed(context, 'home', arguments: data);
      }
    }

    Widget formEmail() {
      return Container(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          controller: email,
          decoration: InputDecoration(
              hintText: 'Email',
              icon: const Icon(Icons.email),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              )),
        ),
      );
    }

    Widget formPassword() {
      return Container(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          controller: password,
          obscureText: true,
          decoration: InputDecoration(
              hintText: 'Password',
              icon: const Icon(Icons.lock),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              )),
        ),
      );
    }

    Widget button() {
      return ElevatedButton(
        onPressed: login,
        child: const Text('Login'),
      );
    }

    Widget goToRegister() {
      return TextButton(
        onPressed: () {
          Navigator.pushNamed(context, '/register');
        },
        child: const Text('Register'),
      );
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Login'),
      ),
      backgroundColor: const Color(0xffeaeaea),
      bottomNavigationBar: goToRegister(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                formEmail(),
                formPassword(),
                button(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
