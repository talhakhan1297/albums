import 'package:albums/onboarding/cubit/onboarding_cubit.dart';
import 'package:albums/onboarding/view/onboarding_form.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(
        authenticationRepository: GetIt.I<AuthenticationRepository>(),
      ),
      child: const OnboardingForm(),
    );
  }
}
