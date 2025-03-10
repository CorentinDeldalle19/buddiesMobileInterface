import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: EventMain(),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 16.0); // Ajoutez la hauteur du padding

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0), // Padding horizontal et bas
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/rechercher-modified.png',
              height: 30,
              width: 30,
            ),
            Text(
              'Events',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Image.asset(
              'assets/user-modified.png',
              height: 30,
              width: 30,
            ),
          ],
        ),
      ),
    );
  }
}

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
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).padding.top + MediaQuery.of(context).size.height * 0.025),
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
          Positioned(
            top: MediaQuery.of(context).size.height * 0.015,
            left: 0,
            right: 0,
            child: CustomAppBar(),
          ),
        ],
      ),
    );
  }
}