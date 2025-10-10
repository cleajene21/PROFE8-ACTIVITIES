import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../models/camera.dart';

class CameraCard extends StatelessWidget {
  final Camera camera;
  final VoidCallback? onTap;
  final VoidCallback? onRent;

  const CameraCard({
    super.key,
    required this.camera,
    this.onTap,
    this.onRent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCameraImage(),
            Flexible(child: _buildCameraInfo()),
            _buildActionButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildCameraImage() {
    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: camera.imageUrl.isNotEmpty
                ? Image.network(
                    camera.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 100,
                    headers: const {
                      'Access-Control-Allow-Origin': '*',
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return const Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      );
                    },
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              CupertinoIcons.camera,
                              size: 30,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Image unavailable',
                              style: TextStyle(
                                fontSize: 8,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : Container(
                    color: Colors.grey[300],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.camera,
                          size: 30,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'No image',
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.blue[600],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '\$${camera.pricePerDay.toStringAsFixed(0)}/day',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          if (!camera.isAvailable)
            Positioned(
              top: 8,
              left: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red[600],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Rented',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          Positioned(
            bottom: 8,
            right: 8,
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.blue[600],
              onPressed: camera.isAvailable ? onRent : null,
              child: const Icon(Icons.add_shopping_cart,
                  size: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCameraInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          camera.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 2),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              camera.brand,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 11,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(CupertinoIcons.star_fill,
                    size: 12, color: Colors.amber),
                const SizedBox(width: 2),
                Text(
                  camera.rating.toString(),
                  style: const TextStyle(
                      fontSize: 11, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionButton() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
      child: SizedBox(
        width: double.infinity,
        height: 32,
        child: ElevatedButton(
          onPressed: camera.isAvailable ? onRent : null,
          style: ElevatedButton.styleFrom(
            backgroundColor:
                camera.isAvailable ? Colors.blue[600] : Colors.grey,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            camera.isAvailable ? 'Rent Now' : 'Unavailable',
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
