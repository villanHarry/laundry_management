import 'package:flutter/foundation.dart';
import 'package:laundry_management/models/order_model.dart';
import 'package:laundry_management/services/order_apis.dart';

class OrdersProvider extends ChangeNotifier {
  OrdersProvider();

  List<OrderModel> orders = [];
  String lastFiltered = "";

  Future<bool> getOrder({Map<String, dynamic>? where}) async {
    orders.clear();
    orders = await OrderAPIs.getOrdersData(where: where);
    if (where != null) {
      lastFiltered = where.values.first;
    }
    notifyListeners();
    return false;
  }

  Future<bool> editStatus({String? id, String? status}) async {
    await OrderAPIs.editStatus(id: id, status: status);
    orders.clear();
    orders = await OrderAPIs.getOrdersData(where: {'status': lastFiltered});
    notifyListeners();
    return false;
  }

  List<OrderModel> getOrdersfilter(String filter) {
    final temp = orders;
    return temp.where((element) => element.status == filter).toList();
  }
}
