import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:movie_catalog/src/screens/visitors/movie_detail/movie_detail.dart';

class OthersOptions extends StatelessWidget {
  final String option;
  final String keys;
  final bool? admin;

  const OthersOptions(
      {Key? key, required this.option, required this.keys, this.admin = true})
      : super(key: key);

  removeFromPopular(String title, BuildContext context) async {
    CollectionReference reference =
        FirebaseFirestore.instance.collection('movies');
    await reference
        .doc(title.replaceAll(' ', ''))
        .update({'popular': false}).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Movie removed from popular'),
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
        title: Text(
          option,
          style: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 20),
              StreamBuilder<QuerySnapshot>(
                  stream: keys == 'popular'
                      ? FirebaseFirestore.instance
                          .collection('movies')
                          .where('popular', isEqualTo: true)
                          .snapshots()
                      : FirebaseFirestore.instance
                          .collection('movies')
                          .where('period', isEqualTo: option)
                          .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color.fromRGBO(51, 51, 51, 1),
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.isNotEmpty) {
                        return ListView.builder(
                          padding: const EdgeInsets.all(0),
                          itemCount: snapshot.data!.docs.length,
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: EachTile(
                                desc: snapshot.data!.docs[index]['desc'],
                                date: snapshot.data!.docs[index]['date'],
                                image: 'assets/logo.jpg',
                                title: snapshot.data!.docs[index]['title'],
                                admin: admin!,
                                details: snapshot.data!.docs[index]['details'],
                                time:
                                    "${snapshot.data!.docs[index]['period']} ${snapshot.data!.docs[index]['time']}",
                                viewMore: keys == 'popular' ? true : false,
                                onPressed: () {
                                  removeFromPopular(
                                      snapshot.data!.docs[index]['title'],
                                      context);
                                },
                              ),
                            );
                          },
                        );
                      }
                      return const Center(child: Text('Collection Empty'));
                    }
                    return const Text('Something went wrong, retry later');
                  })
            ],
          ),
        ),
      ),
    );
  }
}

class EachTile extends StatelessWidget {
  final String title, desc, image, details, date;
  final String? time;
  final Function onPressed;
  final bool admin, viewMore;

  const EachTile(
      {Key? key,
      required this.title,
      required this.desc,
      required this.image,
      required this.onPressed,
      this.time,
      required this.date,
      required this.details,
      required this.admin,
      this.viewMore = false})
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
          GestureDetector(
            onTap: viewMore != true
                ? null
                : () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return MoviesDetails(
                          title: title,
                          time: time!,
                          desc: desc,
                          details: details,
                          date: date,
                          image: 'assets/logo.jpg');
                    }));
                  },
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.80,
              child: Row(
                children: [
                  Container(
                    height: 100,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage(image), fit: BoxFit.fill),
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
                        Text(desc.length > 95
                            ? "${desc.substring(0, 95)}..."
                            : desc),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          admin == true
              ? FocusedMenuHolder(
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
                      title: const Text('Remove from List'),
                      onPressed: onPressed,
                    ),
                  ],
                  menuItemExtent: 45,
                  child: const Icon(Icons.delete))
              : Container()
        ],
      ),
    );
  }
}
