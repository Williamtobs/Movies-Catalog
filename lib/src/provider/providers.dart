import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/movie_model.dart';

final fireBaseAuthProvider = Provider<FirebaseAuth>((ref) {
  return FirebaseAuth.instance;
});

final firebaseMovieProvider =
    StreamProvider.autoDispose<List<MovieModel>>((ref) {
  final stream = FirebaseFirestore.instance.collection('ideas').snapshots();
  return stream.map((snapshot) =>
      snapshot.docs.map((doc) => MovieModel.fromJson(doc.data())).toList());
});
