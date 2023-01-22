import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sempre_va/model/user.dart';
import 'package:sempre_va/screens/trips_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    String email = "";
    String password = "";

    return Scaffold(
        body: Align(
            alignment: Alignment.center,
            child: SingleChildScrollView(
                child: Form(
              key: _formKey,
              child: Padding(
                  padding: EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(16),
                          child:
                              Image.asset("assets/app_icon.png", height: 230)),
                      TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Digite seu e-mail',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'por favor digite o e-mail';
                          }

                          email = value;
                          return null;
                        },
                      ),
                      TextFormField(
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Digite a senha',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return 'por favor digite a senha';
                          }

                          password = value;
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            // Validate will return true if the form is valid, or false if
                            // the form is invalid.
                            if (_formKey.currentState!.validate()) {
                              fetchUser(password, email);
                            }
                          },
                          child: const Text('Acessar'),
                        ),
                      ),
                      const Text(
                        "clique aqui para criar uma conta",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  )),
            ))));
  }

  Future<http.Response> fetchUser(String password, String email) async {
    final response =
        await http.get(Uri.parse('http://192.168.15.5:62112/users'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var user = User.fromJson(jsonDecode(response.body)['content'].first);

      if(user.password == password && user.email == email) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => TripsPage(),
                settings: RouteSettings(arguments: TripsPage())),
            ModalRoute.withName("/"));
      } else {
        var snackBar = SnackBar(content: Text('Usuario ou senha incorretos'));
        // Step 3
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }

      return response;
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}
