import 'package:albums/login/cubit/login_cubit.dart';
import 'package:albums/routes/routes.dart';
import 'package:albums/utils/helpers/snackbar.dart';
import 'package:albums/utils/widgets/widgets.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TitleWidget(text: 'Login'),
            SizedBox(height: 48),
            UsernameTextField(),
            SizedBox(height: 16),
            PasswordTextField(),
            SizedBox(height: 48),
            LoginButton(),
          ],
        ),
      ),
    );
  }
}

class UsernameTextField extends StatelessWidget {
  const UsernameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) =>
          previous.username != current.username ||
          previous.errorMessage != current.errorMessage,
      builder: (context, state) {
        return CustomTextField(
          label: 'Username',
          hintText: 'e.g. awesomeUser',
          initialValue: state.username.value,
          inputFormatters: [LengthLimitingTextInputFormatter(50)],
          errorMessage: state.usernameError,
          onChanged: context.read<LoginCubit>().usernameChanged,
        );
      },
    );
  }
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return CustomTextField(
          label: 'Password',
          hintText: 'e.g. 12345678',
          obscureText: true,
          textInputAction: TextInputAction.done,
          initialValue: state.password.value,
          inputFormatters: [LengthLimitingTextInputFormatter(50)],
          errorMessage: state.passwordError,
          onChanged: context.read<LoginCubit>().passwordChanged,
        );
      },
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) async {
        if (state.status.isSuccess) {
          await context.router.pushAndPopUntil(
            const AlbumsRoute(),
            predicate: (_) => false,
          );
        } else if (state.status.isFailure) {
          context.errorSnackbar(state.errorMessage ?? 'Something went wrong!');
        }
      },
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.isValid != current.isValid,
      builder: (context, state) {
        return PrimaryButton(
          isLoading: state.status.isInProgress,
          text: 'Login',
          onPressed: state.isValid
              ? () => context.read<LoginCubit>().loginFormSubmitted()
              : null,
        );
      },
    );
  }
}
