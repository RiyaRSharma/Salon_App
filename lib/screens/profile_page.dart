import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dio/dio.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final User? user = FirebaseAuth.instance.currentUser;
  Map<String, dynamic>? profileData;
  List<dynamic> pastBookings = [];
  List<dynamic> savedSalons = [];

  @override
  void initState() {
    super.initState();
    fetchProfileData();
  }

  Future<void> fetchProfileData() async {
    try {
      final String email = user?.email ?? "";
      if (email.isEmpty) return;

      // Web/Chrome should use localhost
      final String baseUrl = 'http://localhost:5000';

      final response = await Dio().get(
        '$baseUrl/api/users/profile',
        queryParameters: {'email': email},
      );

      if (response.statusCode == 200) {
        final data = response.data;

        print("🎯 Received data: $data"); // ✅ Added debug log

        setState(() {
          profileData = data; // ✅ Fixed assignment here
          pastBookings = data['pastBookings'] ?? [];
          savedSalons = data['savedSalons'] ?? [];
        });
      } else {
        print('Failed to load profile: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error fetching profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = profileData?['name'] ?? '';
    final email = profileData?['email'] ?? user?.email ?? '';
    final phone = profileData?['phone'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Profile',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: profileData == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.blue,
                child: Icon(Icons.person, size: 50, color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            _buildProfileInfo('Name', name),
            _buildProfileInfo('Email', email),
            _buildProfileInfo('Phone', phone),
            const SizedBox(height: 20),
            const Text(
              'Past Bookings',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildDynamicList(pastBookings, 'service', 'date'),
            const SizedBox(height: 20),
            const Text(
              'Saved Salons',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            _buildDynamicList(savedSalons, 'salonName', null),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final BuildContext currentContext = context;
                  await FirebaseAuth.instance.signOut();
                  if (!currentContext.mounted) return;
                  Navigator.of(currentContext)
                      .pushReplacementNamed('/login');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text('Logout',
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildDynamicList(List<dynamic> items, String mainKey, String? subKey) {
    return items.isEmpty
        ? const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text("No data found."),
    )
        : Column(
      children: items.map((item) {
        final title = item[mainKey] ?? '';
        final subtitle = subKey != null ? item[subKey] ?? '' : '';
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
          leading: const Icon(Icons.check_circle, color: Colors.blue),
          title: Text(title),
          subtitle: subKey != null ? Text(subtitle) : null,
        );
      }).toList(),
    );
  }
}
