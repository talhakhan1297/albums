import 'package:albums/app/cubit/app_cubit.dart';
import 'package:albums/routes/routes.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class App extends StatelessWidget {
  App({super.key});

  static final _appCubit = AppCubit(
    authenticationRepository: GetIt.I<AuthenticationRepository>(),
  );

  final appRouter = AppRouter(_appCubit);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _appCubit,
      child: AppView(appRouter: appRouter),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({required this.appRouter, super.key});

  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        colorSchemeSeed: Colors.green[900],
        useMaterial3: true,
      ),
      routerConfig: appRouter.config(),
      debugShowCheckedModeBanner: false,
    );
  }
}
