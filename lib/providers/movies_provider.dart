

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../home/Movies/movies_controller.dart';

final moviesProvider = StateNotifierProvider<MoviesController, MoviesStates>(
      (ref) => MoviesController(),
);