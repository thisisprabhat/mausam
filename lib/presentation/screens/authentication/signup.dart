import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/data/models/user_model.dart';
import '/domain/bloc/auth_bloc/auth_bloc.dart';
import '/presentation/screens/homescreen/homescreen.dart';
import '/core/utils/input_validation.dart';
import '/presentation/widgets/loader.dart';

part 'components/signup_text_fields.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp'),
        backgroundColor: colorScheme.background,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthStateCreatingUserSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthStateCreatingUser) {
            return const Loader();
          } else {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                SignupTextFields(
                  emailController: _emailController,
                  passwordController: _passwordController,
                  confirmPasswordController: _confirmPasswordController,
                  firstNameController: _firstNameController,
                  lastNameController: _lastNameController,
                  formKey: _formKey,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState?.validate() ?? false) {
                      final UserModel user = UserModel()
                        ..email = _emailController.text
                        ..password = _passwordController.text
                        ..firstName = _firstNameController.text
                        ..lastName = _lastNameController.text;
                      context
                          .read<AuthBloc>()
                          .add(AuthEventCreateNewUser(user));
                    }
                  },
                  child: const Text('SignUp'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account'),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Login'),
                    ),
                  ],
                )
              ],
            );
          }
        },
      ),
    );
  }
}
