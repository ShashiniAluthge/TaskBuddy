import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset('assets/images/menu.png'),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: (Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  //color: Colors.red,
                  border: Border.all(color: Colors.grey, width: 1.0),
                ),
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/profile.webp',
                    fit: BoxFit.cover,
                  ),
                ),
              )))
        ],
      ),
    );
  }
}
