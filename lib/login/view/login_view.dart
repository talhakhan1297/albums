import 'package:albums/login/cubit/login_cubit.dart';
import 'package:albums/login/view/login_form.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        authenticationRepository: GetIt.I<AuthenticationRepository>(),
      ),
      child: const LoginForm(),
    );
  }
}
