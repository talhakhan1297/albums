import 'package:albums/onboarding/cubit/onboarding_cubit.dart';
import 'package:albums/utils/constants/constants.dart';
import 'package:albums/utils/helpers/snackbar.dart';
import 'package:albums/utils/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

class OnboardingForm extends StatelessWidget {
  const OnboardingForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TitleWidget(text: Constants.onboardingTitle),
            SizedBox(height: 48),
            UsernameTextField(),
            SizedBox(height: 16),
            PasswordTextField(),
            SizedBox(height: 48),
            SaveButton(),
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
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return CustomTextField(
          label: Constants.usernameLabel,
          hintText: Constants.usernameHint,
          initialValue: state.username.value,
          inputFormatters: [LengthLimitingTextInputFormatter(50)],
          errorMessage: state.usernameError,
          onChanged: context.read<OnboardingCubit>().usernameChanged,
        );
      },
    );
  }
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingCubit, OnboardingState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return CustomTextField(
          label: Constants.passwordLabel,
          hintText: Constants.passswordHint,
          obscureText: true,
          textInputAction: TextInputAction.done,
          initialValue: state.password.value,
          inputFormatters: [LengthLimitingTextInputFormatter(50)],
          errorMessage: state.passwordError,
          onChanged: context.read<OnboardingCubit>().passwordChanged,
        );
      },
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnboardingCubit, OnboardingState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) async {
        if (state.status.isFailure) {
          context.errorSnackbar(state.errorMessage ?? Constants.generalError);
        }
      },
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.isValid != current.isValid,
      builder: (context, state) {
        return PrimaryButton(
          isLoading: state.status.isInProgress,
          text: Constants.saveButtonLabel,
          onPressed: state.isValid
              ? () => context.read<OnboardingCubit>().onboardingFormSubmitted()
              : null,
        );
      },
    );
  }
}
