import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewALlMovies extends ConsumerWidget {
  const ViewALlMovies({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("movies").snapshots(),
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
                return Padding(
                  padding:
                      const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
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
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 15.0, right: 15.0),
                          child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              physics: const BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return EachTile(
                                    desc: snapshot.data!.docs[0]['title'],
                                    image: 'assets/survive_2022.jpg',
                                    title: snapshot.data!.docs[0]['title']);
                              }),
                        ),
                      ),
                      /*EachTile(
                        desc:
                            'When their plane crashes on a remote snow-covered mountain, '
                            'Jane and Paul have to fight for their lives as the only '
                            'remaining survivors.',
                        image: 'assets/survive_2022.jpg',
                        title: snapshot.data!.docs[0]['title'],
                      )*/
                    ],
                  ),
                );
              }
              return const Center(child: Text('Collection Empty'));
            }
            return const Text('Something went wrong, retry later');
          }),
    );
  }
}

class EachTile extends StatelessWidget {
  final String title, desc, image;

  const EachTile(
      {Key? key, required this.title, required this.desc, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 120,
      padding: const EdgeInsets.all(5),
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
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Icon(Icons.more_vert),
              Icon(
                Icons.delete,
                color: Color.fromRGBO(51, 51, 51, 1),
              )
            ],
          )
        ],
      ),
    );
  }
}
