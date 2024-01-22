import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laundry_management/utils/constants.dart';

FirebaseAuth? auth = FirebaseAuth.instance;

class FirebaseServices {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // static Future<List<Map<String, dynamic>>> getCollectionDocuments(
  //     String collectionName) async {
  //   try {
  //     // Reference to the collection
  //     CollectionReference collectionRef = _firestore.collection(collectionName);

  //     // Get all documents in the collection
  //     QuerySnapshot querySnapshot = await collectionRef.get();

  //     // Extract data from documents
  //     List<Map<String, dynamic>> data =
  //         querySnapshot.docs.map((DocumentSnapshot document) {
  //       return document.data() as Map<String, dynamic>;
  //     }).toList();

  //     return data;
  //   } catch (e) {
  //     return [];
  //   }
  // }

  static Future<UserCredential?> login(String username, String password) async {
    try {
      return await auth!
          .signInWithEmailAndPassword(email: username, password: password);
    } on FirebaseException catch (e) {
      Constants.showToast(e.message!);
    }
  }

  static Future<void> logout() async {
    await auth!.signOut();
  }

  static Future<UserCredential?> signup(
      String username, String password) async {
    try {
      return await auth!
          .createUserWithEmailAndPassword(email: username, password: password);
    } on FirebaseException catch (e) {
      Constants.showToast(e.message!);
    }
  }
}
