import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:laundry_management/models/order_model.dart';
import 'package:laundry_management/utils/constants.dart';
import 'package:laundry_management/utils/firebaseServices.dart';

class OrderAPIs {
  // Create or update user data in Firestore
  static Future<void> createOrder(
      {required String status,
      required double amount,
      required String address,
      required String name,
      required String phone,
      required String retur}) async {
    try {
      CollectionReference orders =
          FirebaseFirestore.instance.collection('orders');

      await orders.doc().set({
        'userId': auth!.currentUser!.uid,
        'name': name,
        'address': address,
        'phone': phone,
        'returnDate': retur,
        'amount': amount,
        'status': status,
        'timestamp': DateTime.now()
      });
      Constants.showToast("Order Created");
    } catch (e) {
      print("Error saving user data: $e");
    }
  }

  static Future<void> editStatus({String? status, String? id}) async {
    try {
      CollectionReference orders =
          FirebaseFirestore.instance.collection('orders');
      await orders.doc(id).update({'status': status});
      Constants.showToast("Order Edited");
    } catch (e) {
      print("Error saving user data: $e");
    }
  }

  // // Fetch admin data from Firestore
  // static Future<List<OrderModel?>> getAdminOrdersData({String? where}) async {
  //   try {
  //     final documentSnapshot =
  //         await FirebaseFirestore.instance.collection('orders').get();

  //     List<OrderModel> data =
  //         documentSnapshot.docs.map((DocumentSnapshot document) {
  //       var orderDetail = document.data() as Map<String, dynamic>;
  //       return OrderModel(
  //           userId: orderDetail['userId'],
  //           name: orderDetail['name'],
  //           address: orderDetail['address'],
  //           phone: orderDetail['phone'],
  //           retur: orderDetail['returnDate'],
  //           amount: double.parse(orderDetail['amount'] ?? 0),
  //           status: orderDetail['status']);
  //     }).toList();

  //     return data;
  //   } catch (e) {
  //     print("Error fetching user data: $e");
  //   }
  //   return [];
  // }

  // Fetch user data from Firestore
  static Future<List<OrderModel>> getOrdersData(
      {Map<String, dynamic>? where}) async {
    List<OrderModel> data = [];
    try {
      final tempData = FirebaseFirestore.instance.collection('orders');
      QuerySnapshot<Map<String, dynamic>>? documentSnapshot = null;
      if (auth!.currentUser!.email != "admin@gmail.com") {
        documentSnapshot = await tempData
            .where('userId', isEqualTo: auth!.currentUser!.uid)
            .get();
      }

      if (where != null) {
        documentSnapshot = await tempData
            .where(where.keys.first, isEqualTo: where.values.first)
            .get();
      }

      if (documentSnapshot != null) {
        data = documentSnapshot.docs.map((DocumentSnapshot document) {
          var orderDetail = document.data() as Map<String, dynamic>;
          return OrderModel(
              id: document.id,
              userId: orderDetail['userId'],
              name: orderDetail['name'],
              address: orderDetail['address'],
              phone: orderDetail['phone'],
              retur: orderDetail['returnDate'],
              amount: orderDetail['amount'] ?? 0,
              status: orderDetail['status']);
        }).toList();
      }

      return data;
    } catch (e) {
      print("Error fetching user data: $e");
    }
    return data;
  }
}
