import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

import 'add_movie.dart';
import 'edit_movies/edit_movie.dart';

class ViewALlMovies extends ConsumerStatefulWidget {
  const ViewALlMovies({Key? key}) : super(key: key);

  @override
  ConsumerState<ViewALlMovies> createState() => _ViewALlMovies();
}

class _ViewALlMovies extends ConsumerState<ViewALlMovies> {
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
        FirebaseFirestore.instance.collection('movies');
    await reference
        .doc(title.replaceAll(' ', ''))
        .update({'popular': true}).then((value) {
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

  deleteMovie(int index, AsyncSnapshot snapshot) async {
    await FirebaseFirestore.instance
        .runTransaction((Transaction myTransaction) async {
      await myTransaction.delete(snapshot.data.docs[index].reference);
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
            InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AddMovie();
                }));
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                padding: const EdgeInsets.only(left: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(51, 51, 51, 1),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.add_circle, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Add new movie',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
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
                                        //deleteMovie
                                        onPressed: () {
                                          addToPopular(
                                              searchList[index]['title'],
                                              searchList[index]['desc'],
                                              searchList[index]['period'],
                                              context);
                                        },
                                        onPressed2: () {},
                                        onPressed3: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return EditMovie(
                                              date: searchList[index]['date'],
                                              title: searchList[index]['title'],
                                              desc: searchList[index]['desc'],
                                              selectedText: searchList[index]
                                                  ['period'],
                                              details: searchList[index]
                                                  ['details'],
                                              time: searchList[index]
                                              ['time'],
                                            );
                                          }));
                                        },
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
                                                  //deleteMovie
                                                  onPressed: () {
                                                    addToPopular(
                                                        snapshot.data!
                                                                .docs[index]
                                                            ['title'],
                                                        snapshot.data!
                                                                .docs[index]
                                                            ['desc'],
                                                        snapshot.data!
                                                                .docs[index]
                                                            ['period'],
                                                        context);
                                                  },
                                                  onPressed2: () {
                                                    deleteMovie(
                                                        index, snapshot);
                                                  },
                                                  onPressed3: () {
                                                    Navigator.push(context,
                                                        MaterialPageRoute(
                                                            builder: (context) {
                                                      return EditMovie(
                                                        date: snapshot.data!
                                                            .docs[index]
                                                        ['date'],
                                                        title: snapshot.data!
                                                                .docs[index]
                                                            ['title'],
                                                        desc: snapshot.data!
                                                                .docs[index]
                                                            ['desc'],
                                                        details: snapshot.data!
                                                                .docs[index]
                                                            ['details'],
                                                        time: snapshot.data!
                                                            .docs[index]
                                                        ['time'],
                                                        selectedText: snapshot
                                                                .data!
                                                                .docs[index]
                                                            ['period'],
                                                      );
                                                    }));
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

class EachTile extends StatelessWidget {
  final String title, desc, image;
  final Function onPressed, onPressed2, onPressed3;

  const EachTile(
      {Key? key,
      required this.title,
      required this.desc,
      required this.image,
      required this.onPressed,
      required this.onPressed2,
      required this.onPressed3})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 120,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color.fromRGBO(51, 51, 51, 1),
          )),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                Text(desc.length > 95 ? "${desc.substring(0, 95)}..." : desc),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FocusedMenuHolder(
                  menuWidth: MediaQuery.of(context).size.width * 0.50,
                  blurSize: 5.0,
                  duration: const Duration(milliseconds: 100),
                  animateMenuItems: true,
                  openWithTap: true,
                  // Open Focused-Menu on Tap rather than Long Press
                  menuOffset: 10.0,
                  // Offset value to show menuItem from the selected item
                  bottomOffsetHeight: 80.0,
                  onPressed: () {},
                  menuItems: <FocusedMenuItem>[
                    FocusedMenuItem(
                      title: const Text('Add to Popular Movies'),
                      onPressed: onPressed,
                    ),
                    FocusedMenuItem(
                      title: const Text('Edit Movie'),
                      onPressed: onPressed3,
                    ),
                    FocusedMenuItem(
                      title: const Text('Remove from Movies'),
                      onPressed: onPressed2,
                    ),
                  ],
                  menuItemExtent: 45,
                  child: const Icon(Icons.more_vert)),
            ],
          )
        ],
      ),
    );
  }
}
