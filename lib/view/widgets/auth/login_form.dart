import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:spendly_ui/view/util/validator.dart';
import 'package:spendly_ui/view/widgets/tile.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState>? formKey;

  final TextEditingController? emailController;
  final TextEditingController? passwordController;

  final VoidCallback? onLoginButtonPressed;
  final VoidCallback? onCreateAccountTextPressed;

  const LoginForm({
    this.formKey,
    this.emailController,
    this.passwordController,
    this.onLoginButtonPressed,
    this.onCreateAccountTextPressed,
    super.key,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    bool _hidePassword = true;

    return Form(
      key: widget.formKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Tile(
          maxWidth: 600,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'Spendly',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: widget.emailController,
                  validator: (value) =>
                      Validator.validateEmailOrUsername(value ?? ""),
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [
                    AutofillHints.username,
                    AutofillHints.email,
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email or username',
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: TextFormField(
                  controller: widget.passwordController,
                  validator: (value) => Validator.validatePassword(value ?? ""),
                  obscureText: _hidePassword,
                  keyboardType: TextInputType.visiblePassword,
                  autofillHints: const [
                    AutofillHints.password,
                  ],
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() => _hidePassword = !_hidePassword);
                      },
                      child: Icon(
                        _hidePassword ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                    ),
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                    isDense: true,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                height: 40,
                width: 175,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: ElevatedButton(
                  onPressed: widget.onLoginButtonPressed,
                  child: const Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    const TextSpan(
                      text: 'Don\'t have a Spendly account yet? ',
                      style: TextStyle(color: Colors.black),
                    ),
                    TextSpan(
                      text: 'Create account',
                      style: const TextStyle(
                        color: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onCreateAccountTextPressed,
                    )
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
