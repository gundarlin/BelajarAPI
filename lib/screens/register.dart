import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Register extends StatelessWidget {
  const Register({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController email = TextEditingController();
    final TextEditingController password = TextEditingController();
    final TextEditingController name = TextEditingController();
    final TextEditingController password2 = TextEditingController();
    var baseUrl = 'http://10.0.2.2:8000/api';
    register() async {
      var headers = {'Accept': 'application/json'};
      var body = {
        'name': name.text,
        'email': email.text,
        'password': password.text,
        'c_password': password2.text
      };
      var response = await http.post(
        Uri.parse('$baseUrl/register'),
        body: body,
        headers: headers,
      );
      var data = jsonDecode(response.body);
      if (response.statusCode == 201) {
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
      } else {
        print(data);
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

    Widget formNama() {
      return Container(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          controller: name,
          decoration: InputDecoration(
              hintText: 'Nama',
              icon: const Icon(Icons.people),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              )),
        ),
      );
    }

    Widget formPassword2() {
      return Container(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
          controller: password2,
          obscureText: true,
          decoration: InputDecoration(
              hintText: 'Masukkan Password Ulang',
              icon: const Icon(Icons.lock),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              )),
        ),
      );
    }

    Widget button() {
      return ElevatedButton(
        onPressed: register,
        child: const Text('Register'),
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            formNama(),
            formEmail(),
            formPassword(),
            formPassword2(),
            button(),
          ],
        ),
      ),
    );
  }
}
