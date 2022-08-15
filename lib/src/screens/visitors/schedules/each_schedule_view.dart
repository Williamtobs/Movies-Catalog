import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../movie_detail/movie_detail.dart';

class EachOptions extends StatelessWidget {
  final String option;
  final String keys;

  const EachOptions({Key? key, required this.option, required this.keys})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 20),
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
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
                              padding: const EdgeInsets.only(bottom: 10),
                              child: EachTile(
                                desc: snapshot.data!.docs[index]['desc'],
                                image: 'assets/logo.jpg',
                                details: snapshot.data!.docs[index]['details'],
                                time:
                                    "${snapshot.data!.docs[index]['period']} ${snapshot.data!.docs[index]['time']}",
                                title: snapshot.data!.docs[index]['title'],
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
  final String title, desc, image, time, details;

  const EachTile(
      {Key? key,
      required this.title,
      required this.desc,
      required this.image,
      required this.details,
      required this.time})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MoviesDetails(
              details: details,
              title: title,
              time: time,
              desc: desc,
              image: 'assets/logo.jpg');
        }));
      },
      child: Container(
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
                  Text(desc),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
