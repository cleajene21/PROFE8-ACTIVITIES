import 'package:flutter/material.dart';
import '../services/camera_service.dart';
import '../models/camera.dart';
import '../widgets/camera_card.dart';

class HomeView extends StatefulWidget {
  final VoidCallback onCameraViewed;
  final Function(String)? onRentCamera;

  const HomeView({
    super.key,
    required this.onCameraViewed,
    this.onRentCamera,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final CameraService _cameraService = CameraService();
  List<Camera> _cameras = [];
  String _selectedCategory = 'All';

  @override
  void initState() {
    super.initState();
    _loadCameras();
  }

  void _loadCameras() {
    setState(() {
      _cameras = _cameraService.getAllCameras();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'Featured Cameras',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900],
                  ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('Premium',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue[700])),
              Text('Quality',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue[700])),
              Text('Affordable',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue[700])),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildCategoryIcon(Icons.camera_alt, 'All'),
              _buildCategoryIcon(Icons.camera, 'DSLR'),
              _buildCategoryIcon(Icons.photo_camera, 'Mirrorless'),
              _buildCategoryIcon(Icons.camera_roll, 'Film'),
            ],
          ),
          const SizedBox(height: 16),
          _buildManualGrid(),
        ],
      ),
    );
  }

  Widget _buildCategoryIcon(IconData icon, String category) {
    final isSelected = _selectedCategory == category;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedCategory = category;
        });
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected ? Colors.blue[600] : Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey[700],
              size: 24,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            category,
            style: TextStyle(
              fontSize: 12,
              color: isSelected ? Colors.blue[800] : Colors.grey[700],
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManualGrid() {
    final cameras = _cameras;
    final rows = <Widget>[];

    for (int i = 0; i < cameras.length; i += 2) {
      final row = Row(
        children: [
          Expanded(
            child: CameraCard(
              camera: cameras[i],
              onTap: () {
                widget.onCameraViewed();
              },
              onRent: () {
                if (widget.onRentCamera != null) {
                  widget.onRentCamera!(cameras[i].id);
                }
              },
            ),
          ),
          const SizedBox(width: 12),
          if (i + 1 < cameras.length)
            Expanded(
              child: CameraCard(
                camera: cameras[i + 1],
                onTap: () {
                  widget.onCameraViewed();
                },
                onRent: () {
                  if (widget.onRentCamera != null) {
                    widget.onRentCamera!(cameras[i + 1].id);
                  }
                },
              ),
            )
          else
            const Expanded(child: SizedBox()),
        ],
      );

      rows.add(row);
      if (i + 2 < cameras.length) {
        rows.add(const SizedBox(height: 12));
      }
    }

    return Column(children: rows);
  }
}
