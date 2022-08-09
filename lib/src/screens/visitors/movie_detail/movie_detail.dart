import 'package:flutter/material.dart';

class MoviesDetails extends StatelessWidget {
  final String title, image, desc, time;

  const MoviesDetails({Key? key, required this.title, required this.image, required this.desc, required this.time})
      : super(key: key);

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
          title,
          style: const TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 300,
              width: MediaQuery.of(context).size.width * 0.60,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  image: DecorationImage(
                      image: AssetImage(image), fit: BoxFit.fill)),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Text(
              'Screen Time: ',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          const SizedBox(height: 4),
          Padding(
            padding:const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Text(
              time,
              style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(left: 15.0, right: 15.0),
            child: Text(
              'Description',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
            ),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 15.0),
            child: Text(
              desc,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }
}
