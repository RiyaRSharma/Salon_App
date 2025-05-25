import 'package:flutter/material.dart';

class BookSlotPage extends StatefulWidget {
  const BookSlotPage({super.key});

  @override
  BookSlotPageState createState() => BookSlotPageState();
}

class BookSlotPageState extends State<BookSlotPage> {
  String? selectedSlot;
  String? selectedStaff;

  final List<String> timeSlots = [
    "10:00 AM", "11:00 AM", "12:00 PM", "2:00 PM", "3:00 PM", "4:00 PM"
  ];

  final List<String> staffOptions = [
    "Any Available Staff", "Alice", "John", "Emma", "David"
  ];

  void proceedToPayment() {
    if (selectedSlot == null || selectedStaff == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select both slot and staff!")),
      );
      return;
    }
    Navigator.pushNamed(context, "/payment.dart", arguments: {
      "slot": selectedSlot,
      "staff": selectedStaff,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Book Your Slot")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Choose Time Slot:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            DropdownButtonFormField<String>(
              value: selectedSlot,
              hint: const Text("Select Slot"),
              items: timeSlots.map((slot) {
                return DropdownMenuItem(value: slot, child: Text(slot));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedSlot = value;
                });
              },
            ),
            const SizedBox(height: 20),

            const Text("Select Staff:", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            DropdownButtonFormField<String>(
              value: selectedStaff,
              hint: const Text("Any Available Staff"),
              items: staffOptions.map((staff) {
                return DropdownMenuItem(value: staff, child: Text(staff));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedStaff = value;
                });
              },
            ),
            const SizedBox(height: 30),

            ElevatedButton(
              onPressed: proceedToPayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              ),
              child: const Text("Proceed to Payment", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
