import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../admin/options/others.dart';

class AllMovies extends ConsumerStatefulWidget {
  const AllMovies({Key? key}) : super(key: key);

  @override
  ConsumerState<AllMovies> createState() => _AllMovies();
}

class _AllMovies extends ConsumerState<AllMovies> {
  final TextEditingController title = TextEditingController();

  List<dynamic> searchList = [];
  List<dynamic> movieList = [];

  performSearch(String searchText) {
    searchText.trim();
    searchList.clear();
    if (searchText.isNotEmpty) {
      for (int i = 0; i < movieList.length; i++) {
        if (movieList[i]['title']
            .toLowerCase()
            .contains(searchText.toLowerCase())) {
          searchList.add(movieList[i]);
        }
      }
    }
  }

  addToPopular(
      String title, String desc, String period, BuildContext context) async {
    CollectionReference reference =
        FirebaseFirestore.instance.collection('popular');
    await reference
        .add({'title': title, 'desc': desc, 'period': period}).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Movie added Successfully'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Close',
          onPressed: () {},
        ),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'All Movies',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(197, 198, 200, 1.0),
                  borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                controller: title,
                onChanged: (text) {
                  setState(() {
                    performSearch(text);
                  });
                },
                style: const TextStyle(
                    color: Color.fromRGBO(75, 78, 85, 1),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                decoration: const InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.white),
                  isDense: true,
                  filled: true,
                  contentPadding: EdgeInsets.all(15),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
            ),
            const SizedBox(height: 10),
            title.text.isNotEmpty
                ? Expanded(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: ListView.builder(
                                  padding: const EdgeInsets.all(0),
                                  itemCount: searchList.length,
                                  physics: const BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 8.0),
                                      child: EachTile(
                                        desc: searchList[index]['desc'],
                                        image: 'assets/logo.jpg',
                                        title: searchList[index]['title'],
                                        time:
                                            "${searchList[index]['period']} ${searchList[index]['time']}",
                                        admin: false,
                                        details: searchList[index]['details'],
                                        viewMore: true,
                                        onPressed: () {
                                          // deleteMovie(index, snapshot);
                                        },
                                        //deleteMovie
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection("movies")
                            .orderBy(
                              'title',
                              descending: false,
                            )
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Color.fromRGBO(51, 51, 51, 1),
                              ),
                            );
                          }
                          if (snapshot.hasData) {
                            if (snapshot.data!.docs.isNotEmpty) {
                              movieList = snapshot.data!.docs;
                              //print(movieList[0]['title']);
                              return SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: ListView.builder(
                                            padding: const EdgeInsets.all(0),
                                            itemCount:
                                                snapshot.data!.docs.length,
                                            physics:
                                                const BouncingScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 8.0),
                                                child: EachTile(
                                                  desc: snapshot.data!
                                                      .docs[index]['desc'],
                                                  image: 'assets/logo.jpg',
                                                  title: snapshot.data!
                                                      .docs[index]['title'],
                                                  details: snapshot.data!
                                                      .docs[index]['details'],
                                                  admin: false,
                                                  time:
                                                      "${snapshot.data!.docs[index]['period']} ${snapshot.data!.docs[index]['time']}",
                                                  viewMore: true,
                                                  onPressed: () {
                                                    //deleteMovie(index, snapshot);
                                                  },
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return const Center(
                                child: Text('Collection Empty'));
                          }
                          return const Text(
                              'Something went wrong, retry later');
                        }),
                  ),
          ],
        ),
      ),
    );
  }
}
