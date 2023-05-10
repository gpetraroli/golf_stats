import 'package:flutter/material.dart';
import 'package:golf_distances_stats/screens/distance_new_screen.dart';

import 'package:golf_distances_stats/screens/distances_stats_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const DistancesStatsScreen(),
        routes: {
          DistancesStatsScreen.routeName: (context) =>
              const DistancesStatsScreen(),
          DistanceNewScreen.routeName: (context) => const DistanceNewScreen(),
        });
  }
}
