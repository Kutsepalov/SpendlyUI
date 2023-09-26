import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:spendly_ui/core/clients/auth_client.dart';
import 'package:spendly_ui/core/clients/response.dart';
import 'package:spendly_ui/core/clients/url_constants.dart';
import 'package:spendly_ui/view/pages/home/home_page.dart';
import 'package:spendly_ui/view/util/validator.dart';
import 'package:spendly_ui/view/widgets/auth/login_form.dart';
import 'package:spendly_ui/view/widgets/auth/registration_form.dart';
import 'package:spendly_ui/view/widgets/snack_bar.dart';
import 'package:spendly_ui/view/widgets/tile.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _registrationFormKey = GlobalKey<FormState>();

  late final Widget loginFormWidget;
  late final Widget registrationFormWidget;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthClient _authClient = AuthClient();

  String? _token;
  late Widget _currentFormWidget;

  @override
  void initState() {
    super.initState();
    autoLogin();
    loginFormWidget = LoginForm(
      formKey: _loginFormKey,
      emailController: emailController,
      passwordController: passwordController,
      onLoginButtonPressed: loginAction,
      onCreateAccountTextPressed: () => setState(() {
        _currentFormWidget = registrationFormWidget;
      }),
    );

    registrationFormWidget = RegistrationForm(
      formKey: _registrationFormKey,
      onRegisterButtonPressed: loginAction,
      onLoginTextPressed: () => setState(() {
        _currentFormWidget = loginFormWidget;
      }),
    );
    _currentFormWidget = loginFormWidget;
  }

  void autoLogin() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final String? token = preferences.getString(jwtKey);

    if (token != null) {
      setState(() {
        _token = token;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      });
    }
  }

  Future<void> loginRequest() async {
    SpendlyResponse<String> response = await _authClient.login(
      emailController.text,
      passwordController.text,
    );
    if (!response.hasError) {
      setState(() {
        _token = response.data;
      });
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString(jwtKey, response.data!);
    }
  }

  void loginAction() async {
    if (_loginFormKey.currentState!.validate()) {
      showLoadingSnackBar(context, 'Processing Data...');

      await loginRequest();

      WidgetsBinding.instance.addPostFrameCallback((_) {
        hideCurrentSnackBar(context);

        if (_token != null) {
          showSuccessSnackBar(context, 'Logged in');
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomePage()));
        } else {
          showFailSnackBar(context, 'Not logged in');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(167, 199, 231, 1),
      body: Center(
        child: SingleChildScrollView(
            child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: _currentFormWidget,
        )),
      ),
    );
  }
}
