
class Order {
  final String orderId;
  final double totalAmount;
  final String paymentMethod;
  final DateTime timestamp;

  Order({
    required this.orderId,
    required this.totalAmount,
    required this.paymentMethod,
    required this.timestamp,
  });
}
