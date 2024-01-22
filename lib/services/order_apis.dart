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

      await orders.add({
        'userId': auth!.currentUser!.uid,
        'name': name,
        'address': address,
        'phone': phone,
        'returnDate': retur,
        'amount': amount,
        'status': status
      });
      Constants.showToast("Order Created");
    } catch (e) {
      print("Error saving user data: $e");
    }
  }

  // Fetch admin data from Firestore
  static Future<List<OrderModel?>> getAdminOrdersData() async {
    try {
      final documentSnapshot =
          await FirebaseFirestore.instance.collection('orders').get();

      List<OrderModel> data =
          documentSnapshot.docs.map((DocumentSnapshot document) {
        var orderDetail = document.data() as Map<String, dynamic>;
        return OrderModel(
            userId: orderDetail['userId'],
            name: orderDetail['name'],
            address: orderDetail['address'],
            phone: orderDetail['phone'],
            retur: orderDetail['returnDate'],
            amount: double.parse(orderDetail['amount'] ?? 0),
            status: orderDetail['status']);
      }).toList();

      return data;
    } catch (e) {
      print("Error fetching user data: $e");
    }
    return [];
  }

  // Fetch user data from Firestore
  static Future<List<OrderModel?>> getOrdersData() async {
    try {
      final documentSnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('userId', isEqualTo: auth!.currentUser!.uid)
          .get();

      List<OrderModel> data =
          documentSnapshot.docs.map((DocumentSnapshot document) {
        var orderDetail = document.data() as Map<String, dynamic>;
        return OrderModel(
            userId: orderDetail['userId'],
            name: orderDetail['name'],
            address: orderDetail['address'],
            phone: orderDetail['phone'],
            retur: orderDetail['returnDate'],
            amount: double.parse(orderDetail['amount'] ?? 0),
            status: orderDetail['status']);
      }).toList();

      return data;
    } catch (e) {
      print("Error fetching user data: $e");
    }
    return [];
  }
}
