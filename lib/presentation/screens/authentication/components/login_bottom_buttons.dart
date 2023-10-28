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
        ElevatedButton(
          onPressed: onLoginPressed,
          child: const Text('Login'),
        ),
        const SizedBox(height: 10),
        TextButton(
          style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: onCreateNewAccountPressed,
          child: const Text(
            'Create new account',
            style: TextStyle(fontSize: 20),
          ),
        ),
        SizedBox(height: MediaQuery.sizeOf(context).height * 0.11),
      ],
    );
  }
}
