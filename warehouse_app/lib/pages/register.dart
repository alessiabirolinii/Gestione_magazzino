import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:warehouse_app/models/user.dart';
import 'package:warehouse_app/providers/auth.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key, required this.switchPage}) : super(key: key);
  final Function switchPage;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();

  bool formError = false;
  bool isLoading = false;

  Widget get formErrorWidget => Column(
        children: [
          const SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              setState(() => formError = false);
            },
            child: Container(
              color: Colors.red.shade400,
              height: 30,
              width: 180,
              child: const Center(
                child: Text("Email già esistente"),
              ),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 60),
              const Text(
                "Register",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              if (formError) formErrorWidget,
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
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: "Inserisci Nome",
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
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: surnameController,
                        decoration: InputDecoration(
                          labelText: "Inserisci Cognome",
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
                            child: const Text("Ho già un account?"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          if (mounted) {
                            setState(() {
                              isLoading = true;
                            });
                          }
                          if (formKey.currentState!.validate()) {
                            final AuthProvider authProvider =
                                Provider.of<AuthProvider>(
                              context,
                              listen: false,
                            );
                            try {
                              await authProvider.register(
                                UserRegisterDTO(
                                  password: passwordController.text,
                                  email: emailController.text,
                                  name: nameController.text,
                                  surname: surnameController.text,
                                ),
                              );
                            } catch (e) {
                              if ((e as dynamic).message ==
                                  "Email already taken") {
                                setState(() => formError = true);
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
                            ? const Text('Register')
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
              Center(
                child: TextButton(
                  onPressed: () async {
                    final AuthProvider authProvider = Provider.of<AuthProvider>(
                      context,
                      listen: false,
                    );
                    try {
                      await authProvider.register(
                        UserRegisterDTO(
                          password: "password",
                          email: "prova@prasdova.it",
                          name: "nome",
                          surname: "cognome1",
                        ),
                      );
                    } catch (e) {
                      if ((e as dynamic).message == "Email already taken") {
                        setState(() => formError = true);
                      }
                    }
                  },
                  child: const Text("prova register"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
