

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../home/Series/series_controller.dart';

final seriesProvider = StateNotifierProvider<SeriesController, SeriesStates>(
      (ref) => SeriesController(),
);