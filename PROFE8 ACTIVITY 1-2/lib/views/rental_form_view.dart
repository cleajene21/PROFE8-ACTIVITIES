import 'package:flutter/material.dart';
import '../models/camera.dart';
import '../services/camera_service.dart';
import '../services/rental_service.dart';

class RentalFormView extends StatefulWidget {
  const RentalFormView({required this.cameraId, super.key});

  final String cameraId;

  @override
  State<RentalFormView> createState() => _RentalFormViewState();
}

class _RentalFormViewState extends State<RentalFormView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  int _rentalDays = 1;
  Camera? _camera;
  bool _showCustomerSupport = false;
  final List<Map<String, String>> _supportMessages = [];
  final _supportController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCamera();
  }

  Future<void> _loadCamera() async {
    final cameraService = CameraService();
    setState(() {
      _camera = cameraService.getCameraById(widget.cameraId);
    });
  }

  Future<void> _selectStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked;
        if (_endDate != null && _endDate!.isBefore(_startDate!)) {
          _endDate = null;
        }
        _calculateDays();
      });
    }
  }

  Future<void> _selectEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate?.add(const Duration(days: 1)) ??
          DateTime.now().add(const Duration(days: 1)),
      firstDate: _startDate?.add(const Duration(days: 1)) ??
          DateTime.now().add(const Duration(days: 1)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _endDate = picked;
        _calculateDays();
      });
    }
  }

  void _calculateDays() {
    if (_startDate != null && _endDate != null) {
      setState(() {
        _rentalDays = _endDate!.difference(_startDate!).inDays + 1;
      });
    }
  }

  void _submitRental() {
    if (_formKey.currentState!.validate() &&
        _startDate != null &&
        _endDate != null) {
      final rentalService = RentalService();
      final totalPrice = _camera!.pricePerDay * _rentalDays;

      final rentalId = rentalService.addRental(
        cameraId: widget.cameraId,
        cameraName: _camera!.name,
        startDate: _startDate!,
        endDate: _endDate!,
        totalPrice: totalPrice,
        customerName: _nameController.text,
        customerEmail: _emailController.text,
        customerPhone: _phoneController.text,
      );

      setState(() {
        _showCustomerSupport = true;
      });

      showDialog<void>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Rental Confirmed!'),
          content: Text(
              'Your rental request has been submitted successfully.\nRental ID: $rentalId\n\nNeed help? Use the customer support chat below.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_camera == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Rental Form'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildCameraInfo(),
              const SizedBox(height: 16),
              _buildPersonalInfo(),
              const SizedBox(height: 16),
              _buildDateSelection(),
              const SizedBox(height: 16),
              _buildPricingSummary(),
              const SizedBox(height: 24),
              _buildActionButtons(),
              if (_showCustomerSupport) ...[
                const SizedBox(height: 24),
                _buildCustomerSupport(),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCameraInfo() => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Camera Details',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.camera_alt,
                        size: 40, color: Colors.grey),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _camera!.name,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Text(_camera!.brand),
                        Text(
                            '\$${_camera!.pricePerDay.toStringAsFixed(0)}/day'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget _buildPersonalInfo() => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Personal Information',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      );

  Widget _buildDateSelection() => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Rental Period',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: _selectStartDate,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Start Date',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                            Text(_startDate?.toString().split(' ')[0] ??
                                'Select Date'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: InkWell(
                      onTap: _selectEndDate,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('End Date',
                                style: TextStyle(
                                    fontSize: 12, color: Colors.grey)),
                            Text(_endDate?.toString().split(' ')[0] ??
                                'Select Date'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget _buildPricingSummary() {
    final totalPrice = _camera!.pricePerDay * _rentalDays;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pricing Summary',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Flexible(
                  flex: 2,
                  child: const Text('Daily Rate:'),
                ),
                Flexible(
                  flex: 1,
                  child: Text(
                    '\$${_camera!.pricePerDay.toStringAsFixed(2)}',
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  flex: 2,
                  child: const Text('Number of Days:'),
                ),
                Flexible(
                  flex: 1,
                  child: Text(
                    '$_rentalDays',
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
            const Divider(),
            Row(
              children: [
                Flexible(
                  flex: 2,
                  child: const Text('Total:',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ),
                Flexible(
                  flex: 1,
                  child: Text(
                    '\$${totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16),
                    textAlign: TextAlign.right,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed:
                (_startDate != null && _endDate != null) ? _submitRental : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[600],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Submit Rental Request',
                style: TextStyle(fontSize: 16)),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.blue[600],
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: BorderSide(color: Colors.blue[600]!),
            ),
            child: const Text('Cancel', style: TextStyle(fontSize: 16)),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomerSupport() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Customer Support',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Container(
              height: 200,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListView(
                children: [
                  _buildChatBubble(
                      'Hello! How can we help you with your rental?', true),
                  ..._supportMessages.map((msg) => _buildChatBubble(
                      msg['text']!, msg['isSupport'] == 'true')),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _supportController,
                    decoration: const InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: () {
                    if (_supportController.text.isNotEmpty) {
                      setState(() {
                        _supportMessages.add({
                          'text': _supportController.text,
                          'isSupport': 'false',
                        });
                        _supportController.clear();
                      });
                    }
                  },
                  icon: Icon(Icons.send, color: Colors.blue[600]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatBubble(String message, bool isSupport) {
    return Align(
      alignment: isSupport ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSupport ? Colors.blue[100] : Colors.green[100],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isSupport ? Colors.blue[900] : Colors.green[900],
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _supportController.dispose();
    super.dispose();
  }
}
