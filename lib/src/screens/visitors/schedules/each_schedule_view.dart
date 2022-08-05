import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../dashboard/dashboard.dart';

class EachSchedule extends StatelessWidget {
  const EachSchedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(15),
        itemCount: movies2.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
      return AvailableMovie(
        movieCover: movies2[index].movieCover,
        movieName: movies2[index].movieName,
      );
    });
  }
}
