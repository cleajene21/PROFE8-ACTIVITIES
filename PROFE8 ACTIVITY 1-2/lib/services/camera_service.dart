import '../models/camera.dart';

class CameraService {
  List<Camera> getAllCameras() {
    return [
      Camera(
        id: '1',
        name: 'Canon EOS R5',
        brand: 'Canon',
        imageUrl:
            'https://ph.canon/media/image/2020/07/07/1ca31541100945f89f12def69b85aeda_R5_FrontSlantLeft_RF24-105mmF4LISUSM.png',
        pricePerDay: 75.0,
        features: ['45MP', '8K Video', 'Image Stabilization'],
        isAvailable: true,
        rating: 4.8,
        category: 'Mirrorless',
      ),
      Camera(
        id: '2',
        name: 'Sony A7 IV',
        brand: 'Sony',
        imageUrl:
            'https://images.unsplash.com/photo-1502920917128-1aa500764cbd?w=400&h=300&fit=crop&auto=format',
        pricePerDay: 65.0,
        features: ['33MP', '4K Video', 'Dual Card Slots'],
        isAvailable: true,
        rating: 4.7,
        category: 'Mirrorless',
      ),
      Camera(
        id: '3',
        name: 'Nikon D850',
        brand: 'Nikon',
        imageUrl:
            'https://images.unsplash.com/photo-1516035069371-29a1b244cc32?w=400&h=300&fit=crop&auto=format',
        pricePerDay: 55.0,
        features: ['45.7MP', 'Weather Sealed', 'Dual XQD/CF'],
        isAvailable: false,
        rating: 4.6,
        category: 'DSLR',
      ),
      Camera(
        id: '4',
        name: 'Fujifilm X-T4',
        brand: 'Fujifilm',
        imageUrl:
            'https://images.unsplash.com/photo-1495121553079-4c61bcce1894?w=400&h=300&fit=crop&auto=format',
        pricePerDay: 50.0,
        features: ['26.1MP', 'Film Simulations', 'IBIS'],
        isAvailable: true,
        rating: 4.5,
        category: 'Mirrorless',
      ),
      Camera(
        id: '5',
        name: 'Leica Q2',
        brand: 'Leica',
        imageUrl:
            'https://www.adaminsights.com/wp-content/uploads/2022/11/leica-q2-ghost-hodinkee.jpg',
        pricePerDay: 120.0,
        features: ['47.3MP', 'Fixed 28mm f/1.7', 'Weather Sealed'],
        isAvailable: true,
        rating: 4.9,
        category: 'Compact',
      ),
      Camera(
        id: '6',
        name: 'Canon EOS R6 Mark II',
        brand: 'Canon',
        imageUrl:
            'https://images.unsplash.com/photo-1617005082133-548c4dd27f35?w=400&h=300&fit=crop&auto=format',
        pricePerDay: 70.0,
        features: ['24.2MP', '6K Video', 'Dual Pixel CMOS AF'],
        isAvailable: true,
        rating: 4.7,
        category: 'Mirrorless',
      ),
      Camera(
        id: '7',
        name: 'Sony A7R V',
        brand: 'Sony',
        imageUrl:
            'https://4.img-dpreview.com/files/p/TS320x180~products/sony_a7rv/shots/110c41978306446ebcdc223a57b4b1cd.png?v=5755',
        pricePerDay: 85.0,
        features: ['61MP', '8K Video', 'AI-Based AF'],
        isAvailable: false,
        rating: 4.8,
        category: 'Mirrorless',
      ),
      Camera(
        id: '8',
        name: 'Nikon Z9',
        brand: 'Nikon',
        imageUrl:
            'https://f8photo.ph/cdn/shop/files/4_159e351c-b110-4623-8f87-36b44dea52a6.png?v=1729239608&width=1946',
        pricePerDay: 90.0,
        features: ['45.7MP', '8K Video', 'No Mechanical Shutter'],
        isAvailable: true,
        rating: 4.8,
        category: 'Mirrorless',
      ),
    ];
  }

  Camera? getCameraById(String id) {
    try {
      return getAllCameras().firstWhere((camera) => camera.id == id);
    } catch (e) {
      return null;
    }
  }
}
