import 'package:flutter/material.dart';
import './services/get_user_api.dart';
import 'EventMain.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final userData _apiService = userData();
  String _userName = '';
  String _userLastName = '';
  String _image = '';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      final userData = await _apiService.fetchUserData();
      setState(() {
        _userName = userData['prenom'];
        _userLastName = userData['nom'];
        _image = userData['image'];
        _isLoading = false;
      });
    } catch (e) {
      print('Erreur lors de la récupération des données utilisateur: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = MediaQuery.of(context).size.width * 0.08;
    final topPadding = MediaQuery.of(context).size.height * 0.02;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(
        title: 'Account',
        isAccountPage: true,
      ),
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
        child: Container(
          margin: EdgeInsets.fromLTRB(
            horizontalPadding,
            topPadding + kToolbarHeight + MediaQuery.of(context).padding.top,
            horizontalPadding,
            6.0,
          ),
          child: _isLoading
              ? Center(child: CircularProgressIndicator(color: Colors.white))
              : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(_image),
                  ),
                  SizedBox(width: 12),
                  Text(
                    '$_userName $_userLastName',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Événements futurs : 5',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Événements passés : 10',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              Spacer(),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => BlackScreenPage()),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(246, 117, 117, 0.5),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Color.fromRGBO(246, 62, 62, 0.8),
                        width: 3.0,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(255, 0, 0, 0.3),
                          blurRadius: 40,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      'Déconnexion',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

class BlackScreenPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'Vous êtes déconnecté.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}