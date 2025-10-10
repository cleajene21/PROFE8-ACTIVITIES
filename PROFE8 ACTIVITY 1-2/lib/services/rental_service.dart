import '../models/rental.dart';

class RentalService {
  static final RentalService _instance = RentalService._internal();
  factory RentalService() => _instance;
  RentalService._internal();

  final List<Rental> _rentals = [
    Rental(
      id: '1',
      cameraId: '1',
      cameraName: 'Canon EOS R5',
      startDate: DateTime.now().subtract(const Duration(days: 2)),
      endDate: DateTime.now().add(const Duration(days: 3)),
      totalPrice: 375.0,
      status: RentalStatus.active,
    ),
    Rental(
      id: '2',
      cameraId: '2',
      cameraName: 'Sony A7 IV',
      startDate: DateTime.now().subtract(const Duration(days: 10)),
      endDate: DateTime.now().subtract(const Duration(days: 7)),
      totalPrice: 195.0,
      status: RentalStatus.completed,
    ),
  ];

  List<Rental> getUserRentals() {
    return List.from(_rentals);
  }

  String addRental({
    required String cameraId,
    required String cameraName,
    required DateTime startDate,
    required DateTime endDate,
    required double totalPrice,
    required String customerName,
    required String customerEmail,
    required String customerPhone,
  }) {
    final String newId = DateTime.now().millisecondsSinceEpoch.toString();
    final rental = Rental(
      id: newId,
      cameraId: cameraId,
      cameraName: cameraName,
      startDate: startDate,
      endDate: endDate,
      totalPrice: totalPrice,
      status: RentalStatus.active,
    );

    _rentals.insert(0, rental); // Add to beginning of list
    return newId;
  }

  bool createRental(String cameraId, DateTime startDate, DateTime endDate) {
    // Mock rental creation logic
    return true;
  }
}
