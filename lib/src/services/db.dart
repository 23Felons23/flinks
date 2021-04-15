import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import '../models/flink.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final User user = FirebaseAuth.instance.currentUser;

  Future<List<Flink>> getUserFlinks() async {
    final snap = await _db.collection('users').doc(user.uid).collection('flinks').get();
    return snap.docs.map((doc) => Flink.fromFirestore(doc)).toList();
  }

  //Stream for the user's flinks
  Stream<List<Flink>> streamUserFlinks() {
    final ref = _db.collection('users').doc(user.uid).collection('flinks').orderBy('timestamp', descending: true);
    return ref
        .snapshots()
        .map((list) => list.docs.map((doc) => Flink.fromFirestore(doc)).toList());
  }

  Future<DocumentReference> addFlink(String url, String description) {
    return _db.collection('users').doc(user.uid).collection('flinks').add({
      'url': url,
      'description': description,
      'timestamp': FieldValue.serverTimestamp()
    });
  }

  Future<DocumentReference> updateFlink(String flinkId, String url, String description) {
    return _db.collection('users').doc(user.uid).collection('flinks').doc(flinkId).update({
      'url': url,
      'description': description,
    });
  }

  deleteFlink(String flinkId) {
    return _db.collection('users').doc(user.uid).collection('flinks').doc(flinkId).delete();
  }
}
