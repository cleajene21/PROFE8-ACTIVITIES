import '../models/booking_model.dart';

class BookingService {
  // Singleton pattern
  static final BookingService _instance = BookingService._internal();
  factory BookingService() => _instance;
  BookingService._internal();

  // Requirement 10: Local list to store bookings
  final List<BookingModel> _bookings = [];

  // Available services
  final List<String> services = [
    'Regular Haircut',
    'Premium Haircut',
    'Beard Trim',
    'Hair Coloring',
    'Kids Haircut',
  ];

  // Available barbers
  final List<String> barbers = [
    'John Lee',
    'Jane Marie',
    'Mike Johnson',
    'Sarah Williams',
  ];

  // Add booking
  Future<bool> addBooking(BookingModel booking) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 500));
      _bookings.add(booking);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Get all bookings
  List<BookingModel> getAllBookings() {
    return List.unmodifiable(_bookings);
  }

  // Get booking by ID
  BookingModel? getBookingById(String id) {
    try {
      return _bookings.firstWhere((booking) => booking.id == id);
    } catch (e) {
      return null;
    }
  }

  // Delete booking
  bool deleteBooking(String id) {
    try {
      _bookings.removeWhere((booking) => booking.id == id);
      return true;
    } catch (e) {
      return false;
    }
  }

  // Get bookings count
  int get bookingsCount => _bookings.length;

  // Clear all bookings
  void clearAllBookings() {
    _bookings.clear();
  }
}

final List<String> paymentMethods = ['Cash', 'GCash', 'Credit Card'];
