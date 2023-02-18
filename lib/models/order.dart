class Order {
  String order_id;
  int company_id;
  int amount;
  String status;
  String currency;

  Order(
      {required this.order_id,
      required this.amount,
      this.company_id = 0,
      this.currency = "INR",
      required this.status});

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
        order_id: json["order_id"],
        amount: json["amount"],
        status: json["status"],
        company_id: json['company_id']);
  }
}

class OrderList {
  final List<Order> orders;
  OrderList({
    required this.orders,
  });
  factory OrderList.fromJson(List<dynamic> parsedJson) {
    List<Order> orders = [];
    orders = parsedJson.map((i) => Order.fromJson(i)).toList();
    return new OrderList(orders: orders);
  }
}
