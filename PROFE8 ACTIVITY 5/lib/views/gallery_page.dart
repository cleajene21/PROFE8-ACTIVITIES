import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> gridImages = [
      'https://www.barberstake.com/wp-content/uploads/2025/03/Haircut-Designs.jpg',
      'https://www.southernliving.com/thmb/Deu04ZuiLAL-3r_BkHo8AgRqrnI=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/Screenshot2024-02-02at1.35.11PM-5e651e05e7e34546ab7c6e554e959acf.png',
      'https://ladyandthehair.com.au/wp-content/uploads/2025/04/Butterfly-Cut-.jpg',
      'https://content.latest-hairstyles.com/wp-content/uploads/skin-fade-with-a-textured-short-top-for-boys.jpg',
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gallery'),
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Image.asset('assets/images/logo.jpg', height: 150),
            const SizedBox(height: 20),
            const Text(
              '',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Image.network(
              'https://i.pinimg.com/736x/86/68/86/86688627f1cc08b87345128bf71cf32d.jpg',
              height: 150,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            const Text(
              '',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.pinkAccent, width: 4),
                  image: const DecorationImage(
                    image: NetworkImage(
                      'https://t3.ftcdn.net/jpg/03/30/45/76/360_F_330457670_QdJI6oxOJLJ2WKtM1tFwBRFmqjs7UW2k.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
              itemCount: gridImages.length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(gridImages[index], fit: BoxFit.cover),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
