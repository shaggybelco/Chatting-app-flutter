import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/Screens/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
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
                const TextField(
                  decoration: InputDecoration(
                    hintText: "Username",
                    focusColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.person_sharp,
                      color: Color.fromARGB(255, 25, 55, 109),
                    ),
                    filled: true,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextField(
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
                ),
                const SizedBox(
                  height: 20,
                ),
                const TextField(
                  decoration: InputDecoration(
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
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 11, 36, 71),
                    elevation: 0,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                    const Text("Have an account?"),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        " login",
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
    );
  }
}
