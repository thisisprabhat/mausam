part of '../login.dart';

class LoginIconAndTexts extends StatelessWidget {
  const LoginIconAndTexts({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 60,
        right: 60,
        top: 20,
        bottom: 30,
      ),
      child: Column(
        children: [
          Image.asset(
            'assets/images/app_icon.png',
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black87
                : null,
            height: 100,
            width: 100,
          ),
          const SizedBox(height: 12),
          const Text(
            'Weather App',
            style: TextStyle(fontSize: 26),
          ),
          const SizedBox(height: 8),
          const Text(
            'Login to get latest weather info',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
