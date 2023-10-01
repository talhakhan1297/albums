import 'package:album_repository/album_repository.dart';
import 'package:albums/home/home.dart';
import 'package:albums/home/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(
        albumRepository: GetIt.I<AlbumRepository>(),
      ),
      child: const HomePage(),
    );
  }
}
