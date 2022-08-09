import 'package:flutter/material.dart';

import '../others.dart';

class Periods extends StatelessWidget {
  const Periods({Key? key}) : super(key: key);

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
          'Choose Movie Period',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromRGBO(75, 78, 85, 1),
                ),
                child: TextButton(
                    onPressed: () {
                      Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                              return const OthersOptions(option: 'Morning', keys: 'Morning',);
                            }));
                    },
                    child: const Text(
                      'Morning',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ))),
            const SizedBox(height: 15),
            Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromRGBO(75, 78, 85, 1),
                ),
                child: TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return const OthersOptions(option: 'Afternoon', keys: 'Afternoon',);
                          }));
                    },
                    child: const Text(
                      'Afternoon',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ))),
            const SizedBox(height: 15),
            Container(
                height: 60,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: const Color.fromRGBO(75, 78, 85, 1),
                ),
                child: TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return const OthersOptions(option: 'Night', keys: 'Night',);
                          }));
                    },
                    child: const Text(
                      'Night',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ))),
          ],
        ),
      ),
    );
  }
}
