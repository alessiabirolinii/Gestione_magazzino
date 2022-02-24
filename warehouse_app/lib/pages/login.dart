import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:warehouse_app/models/user.dart';
import 'package:warehouse_app/providers/auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.switchPage}) : super(key: key);
  final Function switchPage;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Widget get formErrorWidget => Column(
        children: [
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              setState(() => formError = null);
            },
            child: Container(
              color: Colors.red.shade400,
              height: 30,
              width: 180,
              child: Center(
                child: Text(formError!),
              ),
            ),
          ),
        ],
      );

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String? formError;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60),
              const Text(
                "Login",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              if (formError != null) formErrorWidget,
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "Inserisci Email",
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Inserisci qualcosa";
                          }

                          final checkEmailRegExp = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                          );

                          if (!checkEmailRegExp.hasMatch(value)) {
                            return "Inserisci una email valida";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Inserisci Password",
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Inserisci qualcosa";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => widget.switchPage(),
                            child: const Text("Non ho ancora un account?"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            if (mounted) {
                              setState(() {
                                isLoading = true;
                              });
                            }
                            final AuthProvider authProvider =
                                Provider.of<AuthProvider>(
                              context,
                              listen: false,
                            );
                            try {
                              await authProvider.login(
                                UserLoginDTO(
                                  password: passwordController.text,
                                  email: emailController.text,
                                ),
                              );
                            } catch (e) {
                              if (mounted) {
                                if ((e as dynamic).message ==
                                    "Invalid credentials") {
                                  setState(() {
                                    formError = "Credenziali non valide";
                                  });
                                } else {
                                  setState(() {
                                    formError = "Utente non trovato";
                                  });
                                }
                              }
                            }
                            if (mounted) {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          }
                        },
                        child: !isLoading
                            ? const Text('Login')
                            : const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              // Expanded(child: Container()),
              // Center(
              //   child: TextButton(
              //     onPressed: () async {
              //       final AuthProvider authProvider = Provider.of<AuthProvider>(
              //         context,
              //         listen: false,
              //       );

              //       await authProvider.login(
              //         UserLoginDTO(
              //           password: "password",
              //           email: "prova@prova.it",
              //         ),
              //       );
              //     },
              //     child: const Text("prova login"),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
