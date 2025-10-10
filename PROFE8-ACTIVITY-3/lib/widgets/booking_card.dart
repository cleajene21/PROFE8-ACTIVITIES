import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/booking_model.dart';

class BookingCard extends StatelessWidget {
  final BookingModel booking;
  final int index;
  final VoidCallback? onDelete;

  const BookingCard({
    Key? key,
    required this.booking,
    required this.index,
    this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Booking #${index + 1}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.blue,
                  ),
                ),
                if (onDelete != null)
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: onDelete,
                  ),
              ],
            ),
            const Divider(),
            _buildInfoRow(Icons.person, 'Name', booking.customerName),
            _buildInfoRow(Icons.content_cut, 'Service', booking.service),
            _buildInfoRow(Icons.person_outline, 'Barber', booking.barber),
            _buildInfoRow(Icons.payment, 'Payment', booking.paymentMethod),
            _buildInfoRow(Icons.calendar_today, 'Date',
                DateFormat('MMM dd, yyyy').format(booking.date)),
            _buildInfoRow(
                Icons.access_time, 'Time', booking.time.format(context)),
            if (booking.washIncluded || booking.stylingIncluded)
              _buildInfoRow(
                Icons.star,
                'Extras',
                '${booking.washIncluded ? "Hair Wash " : ""}${booking.stylingIncluded ? "Styling" : ""}',
              ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total Price:',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(
                    '\$${booking.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey[600]),
          const SizedBox(width: 8),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.w500)),
          Expanded(
            child: Text(value, style: TextStyle(color: Colors.grey[700])),
          ),
        ],
      ),
    );
  }
}
