import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/Models/login_model.dart';
import 'package:frontend/Models/token.adapter.dart';
import 'package:frontend/Models/user.adapter.dart';
import 'package:frontend/Screens/home_screen.dart';
import 'package:frontend/Screens/register_screen.dart';
import 'package:frontend/Services/auth.hive.dart';
import 'package:frontend/Services/auth.services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController cellphoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final APIClient _apiClient = APIClient();

  late LoginModel loginModel;
  late UserDataAdapter userModel;

  @override
  void dispose() {
    cellphoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    loginModel = LoginModel();
    userModel = UserDataAdapter();
  }

  Future<void> _handleLogin(String cellphone, String password) async {
    loginModel.cellphone = cellphone;
    loginModel.password = password;

    _apiClient.login(loginModel).then(
          (value) async => {
            // ignore: unnecessary_null_comparison
            if (value != null)
              {
                // setState(() {
                //   isApiCallProcessing = false;
                // }),
                userModel.avatar = value.user?.avatar,
                userModel.isAvatar = value.user?.isAvatar,
                userModel.name = value.user?.name,
                userModel.cellphone = value.user?.cellphone,
                if (value.message!.isNotEmpty)
                  {
                    await AuthHiveClient().authHiveStoreToken(
                      TokenModel(
                        token: value.token.toString(),
                        isLoggedIn: true,
                      ),
                    ),
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(value.message!),
                      ),
                    ),
                    AuthHiveClient().storeUserData(userModel),
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    ),
                  }
                else
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(value.error!),
                      ),
                    ),
                  }
              },
          },
        );
  }

  int backButtonCounter = 0;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        backButtonCounter++;
        if (backButtonCounter >= 3) {
          // Terminate the app when back button is pressed 3 times
          exit(0);
        } else {
          // Show a toast or snackbar indicating how many more times to press back
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Press back ${3 - backButtonCounter} more times to exit',
              ),
            ),
          );

          // Return false to allow the back button press but prevent navigation
          return false;
        }
      },
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.grey[300],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.lock,
                      size: 80,
                      color: Color.fromARGB(255, 25, 55, 109),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Welcome to Metto"),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: cellphoneController,
                      decoration: const InputDecoration(
                        hintText: "Cellphone",
                        focusColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.phone,
                          color: Color.fromARGB(255, 25, 55, 109),
                        ),
                        filled: true,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10)
                      ],
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value.length < 10) {
                          return 'Please enter your cellphone number';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        hintText: "Password",
                        focusColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Color.fromARGB(255, 25, 55, 109),
                        ),
                        filled: true,
                      ),
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Text(
                          "Forgot Password?",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Navigate the user to the Home page
                          _handleLogin(cellphoneController.text,
                              passwordController.text);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please fill input')),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 11, 36, 71),
                        elevation: 50.0,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.done,
                              color: Colors.white,
                            ),
                            Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            " register",
                            style: TextStyle(
                              color: Color.fromARGB(255, 11, 36, 71),
                            ),
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
      ),
    );
  }
}
