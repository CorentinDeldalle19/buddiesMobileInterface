import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'AccountPage.dart';
import 'main.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color arrowColor;
  final bool isAccountPage;

  const CustomAppBar({
    this.title = 'Events',
    this.arrowColor = Colors.white,
    this.isAccountPage = false,
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 16.0); // Hauteur fixe

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (!isAccountPage)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AccountPage()),
                  );
                },
                child: Image.asset(
                  'assets/user-modified.png',
                  height: 30,
                  width: 30,
                ),
              ),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: arrowColor),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            } else {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyHomePage()),
              );
            }
          },
        ),
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  final String image;
  final String title;
  final Color titleBackgroundColor;

  const ImageCard({
    Key? key,
    required this.image,
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
        shadowColor: const Color.fromRGBO(224, 130, 251, 0.1),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color.fromRGBO(224, 130, 251, 0.1),
                blurRadius: 15,
                spreadRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  image,
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (context, error, stackTrace) =>
                  const Center(child: Icon(Icons.error, color: Colors.red)),
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
      ),
    );
  }
}

class EventMain extends StatefulWidget {
  const EventMain({Key? key}) : super(key: key);

  @override
  State<EventMain> createState() => _EventMainState();
}

class _EventMainState extends State<EventMain> {
  List<dynamic> participations = [];
  bool isLoading = true;

  // Dictionnaire pour mapper event_id à l'image et au nom
  final Map<int, Map<String, String>> eventDetails = {
    1: {'image': 'https://i.pinimg.com/736x/a5/3f/5e/a53f5e1e4e84979d712899df01c98b39.jpg', 'name': 'GAZO'},
    2: {'image': 'https://i.pinimg.com/736x/92/52/76/9252764b5c3b35791d17ba0f721a352c.jpg', 'name': '50 CENT'},
    4: {'image': 'https://i.pinimg.com/736x/a8/b3/65/a8b3657ff3f9ec9748456847b64d5dd3.jpg', 'name': 'LIL BABY'},
    5: {'image': 'https://i.pinimg.com/736x/1d/eb/03/1deb03b98213d59dbd61a98c8a6365f0.jpg', 'name': 'SCH'},
    6: {'image': 'https://i.pinimg.com/736x/d1/36/9f/d1369fd74517bddc4f5fe4e4e81122d9.jpg', 'name': 'TIAKOLA'},
    7: {'image': 'https://i.pinimg.com/736x/29/20/a8/2920a875fca578721daa8cc9d7c3f49a.jpg', 'name': 'KENDRICK LAMAR'},
  };

  @override
  void initState() {
    super.initState();
    fetchParticipations();
  }

  Future<void> fetchParticipations() async {
    try {
      var response = await Dio().get('https://backendbuddies-production.up.railway.app/api/participations');
      setState(() {
        participations = response.data;
        isLoading = false;
      });
    } catch (e) {
      print("Erreur lors du fetch : $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(title: "Shows"),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromRGBO(71, 18, 89, 1), Color.fromRGBO(20, 20, 20, 1)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : participations.isEmpty
              ? const Center(
            child: Text(
              'No events available.',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          )
              : SingleChildScrollView(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: participations.take(3).map((event) {
                var eventId = event['event_id'];
                var eventInfo = eventDetails[eventId] ?? {'image': 'https://via.placeholder.com/350x200', 'name': 'Unknown Event'};
                return Column(
                  children: [
                    ImageCard(
                      image: eventInfo['image']!,
                      title: eventInfo['name']!,
                    ),
                    const SizedBox(height: 10),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
