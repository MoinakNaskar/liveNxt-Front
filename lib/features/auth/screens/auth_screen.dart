import 'package:flutter/material.dart';
import 'package:livenxt_front/common/widgets/common_textfield.dart';
import 'package:livenxt_front/common/widgets/custom_buttom.dart';
import 'package:livenxt_front/constants/global_variable.dart';
import 'package:livenxt_front/features/auth/services/auth_service.dart';

enum Auth { signIn, signUp }

class AuthScreen extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signUp;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService authService = AuthService();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text);
  }

  void signInUser() {
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariable.greyBackgroundCOlor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text(
                "Welcome To LiveNxt",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              tileColor: _auth == Auth.signUp
                  ? GlobalVariable.backgroundColor
                  : GlobalVariable.greyBackgroundCOlor,
              title: const Text(
                "create Account",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Radio(
                  value: Auth.signUp,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  }),
            ),
            if (_auth == Auth.signUp)
              Container(
                padding: const EdgeInsets.all(8),
                color: GlobalVariable.backgroundColor,
                child: Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _nameController,
                        hintText: "Name",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: _emailController,
                        hintText: "Email",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: _passwordController,
                        hintText: "Password",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                          text: "Sign Up",
                          onTap: () {
                            if (_signUpFormKey.currentState!.validate()) {
                              signUpUser();
                            }
                          })
                    ],
                  ),
                ),
              ),
            ListTile(
              tileColor: _auth == Auth.signIn
                  ? GlobalVariable.backgroundColor
                  : GlobalVariable.greyBackgroundCOlor,
              title: const Text(
                "Sign-In.",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              leading: Radio(
                  value: Auth.signIn,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  }),
            ),
            if (_auth == Auth.signIn)
              Container(
                padding: const EdgeInsets.all(8),
                color: GlobalVariable.backgroundColor,
                child: Form(
                  key: _signInFormKey,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: _emailController,
                        hintText: "Email",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: _passwordController,
                        hintText: "Password",
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                        text: "Sign In",
                        onTap: () {
                          if (_signInFormKey.currentState!.validate()) {
                            signInUser();
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
          ],
        ),
      )),
    );
  }
}
