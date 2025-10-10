import 'package:flutter/material.dart';

class BookingModel {
  final String id;
  final String customerName;
  final String service;
  final String barber;
  final DateTime date;
  final TimeOfDay time;
  final bool washIncluded;
  final bool stylingIncluded;
  final String paymentMethod; // 🆕 Added
  final DateTime createdAt;

  BookingModel({
    required this.id,
    required this.customerName,
    required this.service,
    required this.barber,
    required this.date,
    required this.time,
    required this.washIncluded,
    required this.stylingIncluded,
    required this.paymentMethod, // 🆕 Added
    required this.createdAt,
  });

  // Calculate total price
  double get totalPrice {
    double basePrice = 0;

    switch (service) {
      case 'Regular Haircut':
        basePrice = 20;
        break;
      case 'Premium Haircut':
        basePrice = 35;
        break;
      case 'Beard Trim':
        basePrice = 15;
        break;
      case 'Hair Coloring':
        basePrice = 50;
        break;
      case 'Kids Haircut':
        basePrice = 15;
        break;
    }

    if (washIncluded) basePrice += 5;
    if (stylingIncluded) basePrice += 10;

    return basePrice;
  }

  // Convert to Map for storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'customerName': customerName,
      'service': service,
      'barber': barber,
      'date': date.toIso8601String(),
      'time': '${time.hour}:${time.minute}',
      'washIncluded': washIncluded,
      'stylingIncluded': stylingIncluded,
      'paymentMethod': paymentMethod, // 🆕 Added
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Create from Map
  factory BookingModel.fromMap(Map<String, dynamic> map) {
    final timeParts = map['time'].split(':');
    return BookingModel(
      id: map['id'],
      customerName: map['customerName'],
      service: map['service'],
      barber: map['barber'],
      date: DateTime.parse(map['date']),
      time: TimeOfDay(
        hour: int.parse(timeParts[0]),
        minute: int.parse(timeParts[1]),
      ),
      washIncluded: map['washIncluded'],
      stylingIncluded: map['stylingIncluded'],
      paymentMethod: map['paymentMethod'], // 🆕 Added
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}
