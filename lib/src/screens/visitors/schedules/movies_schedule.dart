import 'package:flutter/material.dart';

import 'each_schedule_view.dart';

class MoviesSchedule extends StatelessWidget {
  const MoviesSchedule({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
            automaticallyImplyLeading: false,
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            title: const Text(
              'Movies Schedule',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w700),
            ),
            bottom: const TabBar(
              labelColor: Colors.black,
              tabs: [
                Tab(text: 'Morning'),
                Tab(text: 'Afternoon'),
                Tab(text: 'Night'),
              ],
            ),
          ),
          body: const TabBarView(children: [
            EachSchedule(),
            Center(
              child: Text('Afternoon'),
            ),
            Center(
              child: Text('Night'),
            )
          ])),
    );
  }
}
