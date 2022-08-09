import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';

class OthersOptions extends StatelessWidget {
  final String option;
  final String keys;

  const OthersOptions({Key? key, required this.option, required this.keys})
      : super(key: key);

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
        title: Text(
          option,
          style: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5),
        child: Column(
          children: [
            const SizedBox(height: 20),
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection(keys).snapshots(),
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
                              image: 'assets/nollywood.jpg',
                              title: snapshot.data!.docs[index]['title'],
                              onPressed: (){
                                deleteMovie(index, snapshot);
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
    );
  }
}

class EachTile extends StatelessWidget {
  final String title, desc, image;
  final Function onPressed;

  const EachTile(
      {Key? key,
      required this.title,
      required this.desc,
      required this.image,
      required this.onPressed})
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
                Text(desc),
              ],
            ),
          ),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                    title: const Text('Remove from List'),
                    onPressed: onPressed,
                  ),
                ],
                menuItemExtent: 45,
                child: const Icon(Icons.delete)),
          ])
        ],
      ),
    );
  }
}
