import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '/domain/bloc/auth_bloc/auth_bloc.dart';
import '/presentation/screens/splash/splash.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.read<AuthBloc>().user;
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return SimpleDialog(
              alignment: Alignment.topLeft,
              children: [
                const Center(
                  child: CircleAvatar(
                    radius: 50,
                    child: Icon(
                      Icons.person_rounded,
                      size: 56,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _profileInfo(user?.name),
                _profileInfo(user?.email),
                const SizedBox(height: 20),
                BlocListener<AuthBloc, AuthState>(
                  listener: (context, state) {
                    if (state is AuthStateLogout) {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SplashScreen(),
                        ),
                      );
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          context.read<AuthBloc>().add(AuthEventLogout());
                        },
                        child: const Text("Logout")),
                  ),
                ),
              ],
            );
          },
        );
      },
      icon: const Icon(Icons.person_rounded),
    );
  }

  Card _profileInfo(String? title) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title ?? ''),
          ),
        ],
      ),
    );
  }
}
