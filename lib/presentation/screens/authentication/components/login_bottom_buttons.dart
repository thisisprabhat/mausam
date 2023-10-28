part of '../login.dart';

class LoginBottomButtons extends StatelessWidget {
  const LoginBottomButtons({
    super.key,
    required this.onLoginPressed,
    required this.onCreateNewAccountPressed,
  });
  final VoidCallback onLoginPressed;
  final VoidCallback onCreateNewAccountPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 40),
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 500),
          child: ElevatedButton(
            onPressed: onLoginPressed,
            child: const Text('Login'),
          ),
        ),
        const SizedBox(height: 10),
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 500),
          child: TextButton(
            onPressed: onCreateNewAccountPressed,
            child: const Text(
              'Create new account',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.11),
      ],
    );
  }
}
