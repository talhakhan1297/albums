import 'package:albums/login/cubit/login_cubit.dart';
import 'package:albums/routes/routes.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Login'),
          TextButton(
            onPressed: () async {
              final router = context.router;
              final cubit = context.read<LoginCubit>()
                ..usernameChanged('test123')
                ..passwordChanged('12345678');
              await Future<void>.delayed(const Duration(seconds: 1));
              await cubit.loginFormSubmitted();
              await router.push(const AlbumsRoute());
            },
            child: const Text('Tap to login'),
          ),
        ],
      ),
    );
  }
}
