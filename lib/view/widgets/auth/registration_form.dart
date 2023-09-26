import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:spendly_ui/view/util/validator.dart';
import 'package:spendly_ui/view/widgets/dropdowns/currency_dropdown.dart';
import 'package:spendly_ui/view/widgets/tile.dart';

class RegistrationForm extends StatefulWidget {
  final GlobalKey<FormState>? formKey;

  final TextEditingController? emailController;
  final TextEditingController? passwordController;

  final VoidCallback? onRegisterButtonPressed;
  final VoidCallback? onLoginTextPressed;

  const RegistrationForm({
    this.formKey,
    this.emailController,
    this.passwordController,
    this.onRegisterButtonPressed,
    this.onLoginTextPressed,
    super.key,
  });

  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Tile(
          maxWidth: 600,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: TextFormField(
                  controller: widget.emailController,
                  validator: (value) => Validator.validateEmail(value ?? ""),
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [
                    AutofillHints.email,
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: TextFormField(
                  validator: (value) => Validator.validateUsername(value ?? ""),
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [
                    AutofillHints.username,
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Username',
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: TextFormField(
                  validator: (value) => Validator.validateUsername(value ?? ""),
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [
                    AutofillHints.username,
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: TextFormField(
                  validator: (value) => Validator.validateUsername(value ?? ""),
                  keyboardType: TextInputType.emailAddress,
                  autofillHints: const [
                    AutofillHints.username,
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Surname',
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 20),
                child: CurrencyDropdown(),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: TextFormField(
                  controller: widget.passwordController,
                  validator: (value) => Validator.validatePassword(value ?? ""),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  autofillHints: const [
                    AutofillHints.password,
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: TextFormField(
                  controller: widget.passwordController,
                  validator: (value) => Validator.validatePassword(value ?? ""),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  autofillHints: const [
                    AutofillHints.password,
                  ],
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Repeat password',
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
                  onPressed: widget.onRegisterButtonPressed,
                  child: const Text(
                    'Registration',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: [
                    const TextSpan(
                      text: 'Already have an account? ',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: 'Login',
                      style: const TextStyle(
                        color: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.onLoginTextPressed,
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
