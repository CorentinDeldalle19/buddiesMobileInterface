import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final Color titleBackgroundColor;

  const ImageCard({
    Key? key,
    required this.imageUrl,
    required this.title,
    this.titleBackgroundColor = Colors.black87,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      height: 200,
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl,
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              color: titleBackgroundColor.withOpacity(0.7),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EventMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(71, 18, 89, 1),
              Color.fromRGBO(20, 20, 20, 1)
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView( // Permet le défilement si nécessaire
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageCard(
                  imageUrl: "https://i.pinimg.com/736x/43/55/ab/4355abcdbf9787ab38612f48466e79b2.jpg",
                  title: "ASAP ROCKY à Paris",
                ),
                SizedBox(height: 10),
                ImageCard(
                  imageUrl: "https://i.pinimg.com/736x/71/b0/e4/71b0e4efbe3feebbfa23cd07ce6edfa5.jpg",
                  title: "LIL BABY à Paris",
                ),
                SizedBox(height: 10),
                ImageCard(
                  imageUrl: "https://i.pinimg.com/736x/6b/b3/7f/6bb37f7fd7a39b524c2ccd71289e2c46.jpg",
                  title: "DRAKE à Paris",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}