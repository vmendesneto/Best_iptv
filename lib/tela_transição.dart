import 'package:bestiptv/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'home/home.dart';

  class Transition extends ConsumerWidget {
    const Transition

    ({super.key});

    @override
    Widget build(BuildContext context, WidgetRef ref) {
      final home = ref.watch(homeProvider.notifier);

      return FutureBuilder(
        future: home.getAllProjects(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Colors.red,));
          }
         return const HomePage();
        },
      );
    }
  }