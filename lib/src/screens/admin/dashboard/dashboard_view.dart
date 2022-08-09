import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../options/add_movie.dart';
import '../options/others.dart';
import '../options/periods/periods.dart';
import '../options/view_all_movies.dart';

class AdminDashboardView extends StatelessWidget {
  const AdminDashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 30),
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/admin.jpg'), fit: BoxFit.fill)),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 15.0, right: 15),
              child: Text(
                'View, and Edit the Movies Catalog for your users to '
                'keep in touch with their favourite movie playing',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 20),
            GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              children: grids
                  .map((grid) => Column(
                        children: [
                          InkWell(
                            onTap: () {
                              if (grid['title'] as String ==
                                  'View All Movies') {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const ViewALlMovies();
                                }));
                              } else if (grid['title'] as String ==
                                  'Add New Movie') {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return const AddMovie();
                                }));
                                //AddMovie
                              }
                              else if (grid['title'] as String == 'View Popular Movies'){
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return const OthersOptions(keys: 'popular', option: 'Popular Movies',);
                                    }));
                              }
                              else{
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return const Periods();
                                    }));
                                //Periods
                              }
                              //grid['title'] as String == ''
                              //ViewALlMovies
                            },
                            child: Container(
                              height: 140,
                              width: 140,
                              decoration: BoxDecoration(
                                  color: grid['color'] as Color,
                                  borderRadius: BorderRadius.circular(15)),
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(grid['title'] as String)
                        ],
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}

var grids = [
  {"title": "View All Movies", "color": const Color.fromRGBO(50, 31, 219, 1)},
  {
    "title": "View Popular Movies",
    "color": const Color.fromRGBO(51, 153, 255, 1)
  },
  {"title": "Add New Movie", "color": const Color.fromRGBO(249, 177, 22, 1)},
  {
    "title": "View Movies Schedule",
    "color": const Color.fromRGBO(229, 83, 82, 1)
  },
];
