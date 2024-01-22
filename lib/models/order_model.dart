class OrderModel {
  String? id;
  String? status;
  double? amount;
  String? address;
  String? name;
  String? phone;
  String? retur;
  String? userId;

  OrderModel(
      {this.id,
      this.userId,
      this.status,
      this.name,
      this.address,
      this.phone,
      this.retur,
      this.amount});
}
