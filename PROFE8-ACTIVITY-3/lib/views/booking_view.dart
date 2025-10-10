import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/booking_model.dart';
import '../services/booking_service.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/booking_card.dart';

class BookingView extends StatefulWidget {
  const BookingView({Key? key}) : super(key: key);

  @override
  State<BookingView> createState() => _BookingViewState();
}

class _BookingViewState extends State<BookingView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _displayController = TextEditingController();
  final _bookingService = BookingService();

  String _selectedService = 'Regular Haircut';
  String _selectedBarber = 'John Lee';
  String _selectedPayment = 'Cash';
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool _washIncluded = false;
  bool _stylingIncluded = false;

  @override
  void dispose() {
    _nameController.dispose();
    _displayController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) setState(() => _selectedTime = picked);
  }

  void _displayName() {
    setState(() {
      _displayController.text = 'Hello, ${_nameController.text}!';
    });
  }

  Future<void> _submitBooking() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null || _selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select both date and time.')),
        );
        return;
      }

      final booking = BookingModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        customerName: _nameController.text,
        service: _selectedService,
        barber: _selectedBarber,
        date: _selectedDate!,
        time: _selectedTime!,
        washIncluded: _washIncluded,
        stylingIncluded: _stylingIncluded,
        paymentMethod: _selectedPayment,
        createdAt: DateTime.now(),
      );

      final success = await _bookingService.addBooking(booking);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Booking submitted successfully!')),
        );

        _nameController.clear();
        _displayController.clear();
        setState(() {
          _washIncluded = false;
          _stylingIncluded = false;
          _selectedDate = null;
          _selectedTime = null;
        });
      }
    }
  }

  void _deleteBooking(String id) {
    setState(() => _bookingService.deleteBooking(id));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Booking deleted')),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color pinkAccent = Color(0xFFE91E63);
    const Color lightPink = Color(0xFFF8BBD0);
    const Color white = Colors.white;

    final bookings = _bookingService.getAllBookings();

    double totalPrice = BookingModel(
      id: '',
      customerName: '',
      service: _selectedService,
      barber: _selectedBarber,
      date: _selectedDate ?? DateTime.now(),
      time: _selectedTime ?? TimeOfDay.now(),
      washIncluded: _washIncluded,
      stylingIncluded: _stylingIncluded,
      paymentMethod: _selectedPayment,
      createdAt: DateTime.now(),
    ).totalPrice;

    return Scaffold(
      backgroundColor: lightPink,
      appBar: AppBar(
        title: const Text(
          'Haircut Booking',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 3,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFF06292), Color(0xFFE91E63)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: white,
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shadowColor: pinkAccent.withOpacity(0.3),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _nameController,
                        labelText: 'Your Name',
                        prefixIcon: Icons.person,
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter your name'
                            : null,
                      ),
                      const SizedBox(height: 16),

                      // Display Name Section
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _displayController,
                              decoration: InputDecoration(
                                labelText: 'Display Name',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                filled: true,
                                fillColor: Colors.pink[50],
                              ),
                              readOnly: true,
                            ),
                          ),
                          const SizedBox(width: 10),
                          ElevatedButton.icon(
                            onPressed: _displayName,
                            icon: const Icon(Icons.visibility, color: white),
                            label: const Text('Show'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: pinkAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),

                      // Service
                      DropdownButtonFormField<String>(
                        value: _selectedService,
                        decoration: const InputDecoration(
                          labelText: 'Select Service',
                          prefixIcon:
                              Icon(Icons.content_cut, color: pinkAccent),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: white,
                        ),
                        items: _bookingService.services.map((service) {
                          return DropdownMenuItem(
                              value: service, child: Text(service));
                        }).toList(),
                        onChanged: (value) =>
                            setState(() => _selectedService = value!),
                      ),
                      const SizedBox(height: 16),

                      // Barber
                      DropdownButtonFormField<String>(
                        value: _selectedBarber,
                        decoration: const InputDecoration(
                          labelText: 'Select Barber',
                          prefixIcon:
                              Icon(Icons.person_outline, color: pinkAccent),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: white,
                        ),
                        items: _bookingService.barbers.map((barber) {
                          return DropdownMenuItem(
                              value: barber, child: Text(barber));
                        }).toList(),
                        onChanged: (value) =>
                            setState(() => _selectedBarber = value!),
                      ),
                      const SizedBox(height: 16),

                      // Date and Time
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.pink[50],
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.pink.shade100,
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            )
                          ],
                        ),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                _selectedDate == null
                                    ? 'Select Date'
                                    : 'Date: ${DateFormat('MMM dd, yyyy').format(_selectedDate!)}',
                              ),
                              leading: const Icon(Icons.calendar_today,
                                  color: pinkAccent),
                              onTap: () => _selectDate(context),
                            ),
                            const Divider(height: 1),
                            ListTile(
                              title: Text(
                                _selectedTime == null
                                    ? 'Select Time'
                                    : 'Time: ${_selectedTime!.format(context)}',
                              ),
                              leading: const Icon(Icons.access_time,
                                  color: pinkAccent),
                              onTap: () => _selectTime(context),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Add-ons
                      CheckboxListTile(
                        title: const Text('Include Hair Wash (+₱5)'),
                        value: _washIncluded,
                        onChanged: (val) =>
                            setState(() => _washIncluded = val!),
                        secondary:
                            const Icon(Icons.water_drop, color: pinkAccent),
                      ),
                      SwitchListTile(
                        title: const Text('Include Styling (+₱10)'),
                        value: _stylingIncluded,
                        onChanged: (val) =>
                            setState(() => _stylingIncluded = val),
                        secondary:
                            const Icon(Icons.style, color: Colors.pinkAccent),
                      ),
                      const SizedBox(height: 16),

                      // Payment Method
                      DropdownButtonFormField<String>(
                        value: _selectedPayment,
                        decoration: const InputDecoration(
                          labelText: 'Payment Method',
                          prefixIcon: Icon(Icons.payment, color: pinkAccent),
                          border: OutlineInputBorder(),
                          filled: true,
                          fillColor: white,
                        ),
                        items: ['Cash', 'GCash', 'Credit Card']
                            .map((method) => DropdownMenuItem(
                                  value: method,
                                  child: Text(method),
                                ))
                            .toList(),
                        onChanged: (value) =>
                            setState(() => _selectedPayment = value!),
                      ),
                      const SizedBox(height: 24),

                      // Total Price Section
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFFF8BBD0), Color(0xFFE91E63)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Amount:',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: white,
                              ),
                            ),
                            Text(
                              NumberFormat.currency(
                                      locale: 'en_PH', symbol: '₱')
                                  .format(totalPrice),
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 25),

                      ElevatedButton(
                        onPressed: _submitBooking,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: pinkAccent,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        child: const Text(
                          'Submit Booking',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (bookings.isNotEmpty) ...[
              const SizedBox(height: 30),
              const Divider(thickness: 2, color: pinkAccent),
              const Text(
                'Your Booking History',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: pinkAccent),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: bookings.length,
                itemBuilder: (context, index) {
                  final booking = bookings[index];
                  return BookingCard(
                    booking: booking,
                    index: index,
                    onDelete: () => _deleteBooking(booking.id),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
