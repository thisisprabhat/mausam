import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/domain/bloc/auth_bloc/auth_bloc.dart';
import '/presentation/widgets/loader.dart';
import '/presentation/screens/today/today.dart';
import '/presentation/screens/authentication/signup.dart';
import '/core/utils/input_validation.dart';

part 'components/login_icon_texts.dart';
part 'components/login_bottom_buttons.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthStateLoginSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const TodayWeather(),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Login"),
            backgroundColor: colorScheme.background,
          ),
          body: state is AuthStateLoggingIn
              ? const Loader()
              : GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        const LoginIconAndTexts(),
                        TextFormField(
                          controller: _emailController,
                          validator: InputValidator.email,
                          decoration: const InputDecoration(
                            label: Text('Email'),
                            hintText: 'Enter your Email',
                          ),
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: _isPasswordVisible,
                          validator: InputValidator.password,
                          decoration: InputDecoration(
                            suffix: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                              onPressed: () => setState(
                                () => _isPasswordVisible = !_isPasswordVisible,
                              ),
                            ),
                            label: const Text('Password'),
                            hintText: 'Enter your password',
                          ),
                        ),
                        LoginBottomButtons(
                          onLoginPressed: () {
                            FocusScope.of(context).unfocus();
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    AuthEventLoginWithEmailAndPassword(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                    ),
                                  );
                              _emailController.clear();
                              _passwordController.clear();
                            }
                          },
                          onCreateNewAccountPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const Signup(),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 20)
                      ],
                    ),
                  ),
                ),
        );
      },
    );
  }
}
