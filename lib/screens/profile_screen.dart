import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          CircleAvatar(radius: 36, child: Icon(Icons.person, size: 36)),
          SizedBox(height: 12),
          Center(
              child: Text('Guest User',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600))),
          SizedBox(height: 24),
          ListTile(
              leading: Icon(Icons.location_on_outlined),
              title: Text('Saved Addresses')),
          ListTile(leading: Icon(Icons.support_agent), title: Text('Support')),
          ListTile(leading: Icon(Icons.info_outline), title: Text('About')),
        ],
      ),
    );
  }
}
