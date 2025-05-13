import 'package:flutter/material.dart';
import 'ChatPage.dart';

/// ---------- CustomAppBar intégré ici ----------
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Color arrowColor;
  final bool isAccountPage;

  CustomAppBar({
    this.title = 'Events',
    this.arrowColor = Colors.white,
    this.isAccountPage = false,
  });

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 16.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
      child: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () {
                // Remplace ça par ta page de compte si besoin
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
            }
          },
        ),
      ),
    );
  }
}
/// ---------- Fin de CustomAppBar ----------

class MessagesPage extends StatefulWidget {
  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  final List<Map<String, String>> conversations = [
    {"name": "Sarah", "message": "Hey ! Tu vas au concert ce soir ?", "image": "https://randomuser.me/api/portraits/women/2.jpg"},
    {"name": "Mehdi", "message": "T'es chaud pour ce week-end ?", "image": "https://randomuser.me/api/portraits/men/3.jpg"},
    {"name": "Leïla", "message": "Trop hâte de te voir !", "image": "https://randomuser.me/api/portraits/women/5.jpg"},
    {"name": "Yassine", "message": "On se capte demain ?", "image": "https://randomuser.me/api/portraits/men/8.jpg"},
    {"name": "Camille", "message": "Trop cool ton dernier post Insta !", "image": "https://randomuser.me/api/portraits/women/10.jpg"},
    {"name": "Lucas", "message": "Dispo pour un call ?", "image": "https://randomuser.me/api/portraits/men/12.jpg"},
    {"name": "Emma", "message": "Je passe chez toi vers 18h", "image": "https://randomuser.me/api/portraits/women/14.jpg"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 16.0),
        child: CustomAppBar(title: "Messages"),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(71, 18, 89, 1),
                  Color.fromRGBO(20, 20, 20, 1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Positioned(
            top: kToolbarHeight + 70,
            left: 20,
            right: 20,
            child: TextField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.white.withOpacity(0.2),
                prefixIcon: Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Positioned.fill(
            top: kToolbarHeight + 120,
            child: ListView.builder(
              padding: EdgeInsets.only(top: 20),
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                final convo = conversations[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(convo["image"]!),
                  ),
                  title: Text(
                    convo["name"]!,
                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  subtitle: Text(
                    convo["message"]!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white70),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChatPage(
                          userName: convo["name"]!,
                          userImage: convo["image"]!,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}