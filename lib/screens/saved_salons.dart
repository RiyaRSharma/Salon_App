import 'package:flutter/material.dart';

class SavedSalonsPage extends StatefulWidget {
  const SavedSalonsPage({super.key});

  @override
  SavedSalonsPageState createState() => SavedSalonsPageState();
}

class SavedSalonsPageState extends State<SavedSalonsPage> {
  List<Map<String, String>> savedSalons = [
    {"name": "Luxury Salon", "location": "Mumbai"},
    {"name": "Elite Spa & Salon", "location": "Pune"},
  ];

  void removeSalon(int index) {
    setState(() {
      savedSalons.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Saved Salons")),
      body: savedSalons.isEmpty
          ? const Center(child: Text("No saved salons."))
          : ListView.builder(
        itemCount: savedSalons.length,
        itemBuilder: (context, index) {
          final salon = savedSalons[index];
          return Card(
            child: ListTile(
              title: Text(salon["name"]!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(salon["location"]!),
              trailing: IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => removeSalon(index),
              ),
              onTap: () {
                // Salon details page pe navigate
                Navigator.pushNamed(context, "/salon_details", arguments: salon);
              },
            ),
          );
        },
      ),
    );
  }
}
