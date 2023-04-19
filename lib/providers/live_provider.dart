
import 'package:bestiptv/home/LiveTv/liveTv_controller.dart';
import 'package:riverpod/riverpod.dart';



final liveProvider = StateNotifierProvider<LiveTvController, LiveTvStates>(
      (ref) => LiveTvController(),
);