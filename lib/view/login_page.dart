import 'package:flutter/material.dart';
import 'package:tpmproject169/view/register_page.dart';
import '../../controller/hive_database.dart';

import 'menu.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController CurrentUsn = TextEditingController();
  TextEditingController CurrentPass = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(18),
            height: size.height,
            width: size.width,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Aplikasi List Game PC',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    width: size.width,
                    height: size.height * 0.37,
                    child: Image.asset('assets/landing.png'),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    height: size.height * .18,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                            child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.account_circle_outlined,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  width: 250,
                                  child: TextFormField(
                                    controller: CurrentUsn,
                                    decoration: const InputDecoration(
                                      hintText: 'Username',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                        SizedBox(
                            child: Column(
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.lock_outlined,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(left: 10),
                                  width: 250,
                                  child: TextFormField(
                                    controller: CurrentPass,
                                    obscureText: true,
                                    decoration: const InputDecoration(
                                      hintText: 'Password',
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      _buildLoginButton(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ),
                              );
                            },
                            child: const Text(' Sign up!'),
                          ),
                        ],
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

  Widget _commonSubmitButton({
    required String labelButton,
    required Function(String) submitCallback,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        child: Text(labelButton),
        onPressed: () {
          submitCallback(labelButton);
        },
      ),
    );
  }

  Widget _buildLoginButton() {
    return _commonSubmitButton(
      labelButton: "Login",
      submitCallback: (value) {
        String currentUsername = CurrentUsn.value.text;
        String currentPassword = CurrentPass.value.text;

        _processLogin(currentUsername, currentPassword);
      },
    );
  }

  void _processLogin(String username, String password) async {
    final HiveDatabase _hive = HiveDatabase();
    bool found = false;

    found = _hive.checkLogin(username, password);
    String? hashedPassword = _hive.getHashedPassword(username);

    if (hashedPassword != null) {
      bool isPasswordMatch =
          await _hive.comparePassword(password, hashedPassword);

      if (isPasswordMatch) {
        found = true;
      }
    }
    if (!found) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Username dan Password Anda Salah!'),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Berhasil!'),
          backgroundColor: Color.fromARGB(255, 54, 101, 244),
        ),
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => mainMenu(),
        ),
      );
    }
  }

  Widget _buildRegisterButton() {
    return _commonSubmitButton(
      labelButton: "Register",
      submitCallback: (value) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const RegisterPage(),
          ),
        );
      },
    );
  }
}
