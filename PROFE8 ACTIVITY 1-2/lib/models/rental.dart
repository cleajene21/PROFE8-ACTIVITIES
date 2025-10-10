class Rental {
  final String id;
  final String cameraId;
  final String cameraName;
  final DateTime startDate;
  final DateTime endDate;
  final double totalPrice;
  final RentalStatus status;

  Rental({
    required this.id,
    required this.cameraId,
    required this.cameraName,
    required this.startDate,
    required this.endDate,
    required this.totalPrice,
    required this.status,
  });
}

enum RentalStatus {
  active,
  completed,
  cancelled,
}
