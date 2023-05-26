import 'package:flutter/material.dart';

import '../../../common/entities/exercise.dart';

class ExerciseTile extends StatelessWidget {
  final Exercise exercise;
  const ExerciseTile(this.exercise);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(exercise.name),
      ),
    );
  }
}
