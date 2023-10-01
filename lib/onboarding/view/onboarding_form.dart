import 'package:albums/onboarding/cubit/onboarding_cubit.dart';
import 'package:albums/routes/routes.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingForm extends StatelessWidget {
  const OnboardingForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Onboarding'),
          TextButton(
            onPressed: () async {
              final router = context.router;
              final cubit = context.read<OnboardingCubit>()
                ..usernameChanged('test123')
                ..passwordChanged('12345678');
              await Future<void>.delayed(const Duration(seconds: 1));
              await cubit.onboardingFormSubmitted();
              await Future<void>.delayed(const Duration(seconds: 1));
              await router.push(const LoginRoute());
            },
            child: const Text('Tap to Onboard'),
          ),
        ],
      ),
    );
  }
}
