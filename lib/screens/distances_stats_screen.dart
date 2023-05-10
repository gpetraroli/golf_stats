import 'package:flutter/material.dart';
import 'package:golf_distances_stats/screens/distance_new_screen.dart';

class DistancesStatsScreen extends StatelessWidget {
  static const routeName = '/distances/stats';

  const DistancesStatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Distances Stats')),
      body: const Placeholder(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed(DistanceNewScreen.routeName);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
