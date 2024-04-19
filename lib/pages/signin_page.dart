import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pocketbase/pocketbase.dart';



class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      // ),
      body: Center(
          child:
              SigninForm()), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class SigninForm extends StatefulWidget {
  const SigninForm({super.key});

  @override
  State<SigninForm> createState() => _SigninFormState();
}

class _SigninFormState extends State<SigninForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final pb = PocketBase('http://127.0.0.1:8090');
  final _emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const FaIcon(
            FontAwesomeIcons.twitter,
            color: Colors.blue,
            size: 70,
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'Signin',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                hintText: "Provide your email",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                border: InputBorder.none,
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a email';
                } else if (!_emailRegex.hasMatch(value)) {
                  return 'Please enter a valid email!';
                }
                return null;
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextFormField(
              controller: _passwordController,
              obscureText: true,
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                } else if (value.length < 8) {
                  return 'Password must be atleast 8 characters!';
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: "Password",
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            width: 250,
            // padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: Colors.blue, borderRadius: BorderRadius.circular(30)),
            child: TextButton(
              onPressed: () async {
                // Validate will return true if the form is valid, or false if
                // the form is invalid.
                if (_formKey.currentState!.validate()) {
                  debugPrint("Email: ${_emailController.text}");
                  debugPrint("Password: ${_passwordController.text}");
                  try {
                  final body = <String, dynamic>{
                    "username": "Sakib013",
                    "email": _emailController.text,
                    "emailVisibility": true,
                    "password": _passwordController.text,
                    "passwordConfirm": _passwordController.text,
                    "name": _emailController.text
                  };

                  await pb.collection('users').create(body: body);
                  Navigator.of(context).pop();
                } catch (e) {
                  debugPrint(e.toString());
                }
                }
              },
              child: const Text(
                'Signup',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                  Navigator.of(context).pop();
              },
              child: const Text(
                "Already have an account? Login",
                style: TextStyle(color: Colors.blue),
              ))
        ],
      ),
    );
  }
}
