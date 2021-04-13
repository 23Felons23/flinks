import 'package:cloud_firestore/cloud_firestore.dart';

class Flink {
  //final String title;
  final String url;
  final String description;
  final Timestamp timestamp;

  Flink({/*this.title,*/ this.url, this.description, this.timestamp});

  factory Flink.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data();

    return Flink(
      //title: data['title'] ?? '',
      url: data['url'] ?? '',
      description: data['description'] ?? '',
      timestamp: data['timestamp'] ?? ''
    );
  }
}