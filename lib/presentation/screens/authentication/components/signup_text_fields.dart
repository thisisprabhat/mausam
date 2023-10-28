part of '../signup.dart';

class SignupTextFields extends StatefulWidget {
  const SignupTextFields({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.firstNameController,
    required this.lastNameController,
    required this.formKey,
  });
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final GlobalKey<FormState> formKey;

  @override
  State<SignupTextFields> createState() => _SignupTextFieldsState();
}

class _SignupTextFieldsState extends State<SignupTextFields> {
  bool _isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          TextFormField(
            controller: widget.firstNameController,
            keyboardType: TextInputType.name,
            validator: InputValidator.name,
            decoration: const InputDecoration(
              label: Text('FirstName'),
              hintText: 'Enter your first name',
            ),
          ),
          TextFormField(
            controller: widget.lastNameController,
            keyboardType: TextInputType.name,
            validator: InputValidator.name,
            decoration: const InputDecoration(
              label: Text('Last Name'),
              hintText: 'Enter your last name',
            ),
          ),
          TextFormField(
            controller: widget.emailController,
            keyboardType: TextInputType.emailAddress,
            validator: InputValidator.email,
            decoration: const InputDecoration(
              label: Text('Email'),
              hintText: 'Enter your email id',
            ),
          ),
          TextFormField(
            controller: widget.passwordController,
            obscureText: _isPasswordVisible,
            keyboardType: TextInputType.visiblePassword,
            validator: InputValidator.password,
            decoration: InputDecoration(
              suffix: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () => setState(
                  () => _isPasswordVisible = !_isPasswordVisible,
                ),
              ),
              label: const Text('Password'),
              hintText: 'Enter your password',
            ),
          ),
          TextFormField(
            controller: widget.confirmPasswordController,
            obscureText: _isPasswordVisible,
            keyboardType: TextInputType.visiblePassword,
            validator: (value) => InputValidator.confirmPassword(
                value, widget.passwordController.text),
            decoration: InputDecoration(
              suffix: IconButton(
                icon: Icon(
                  _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () => setState(
                  () => _isPasswordVisible = !_isPasswordVisible,
                ),
              ),
              label: const Text('Confirm Passward'),
              hintText: 'Confirm your password',
            ),
          ),
        ],
      ),
    );
  }
}
