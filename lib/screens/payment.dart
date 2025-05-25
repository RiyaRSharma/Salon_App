import 'package:flutter/material.dart';
import '../services/api_service.dart';
import 'review_page.dart';

class PaymentPage extends StatefulWidget {
  final Map<String, String> bookingDetails;

  const PaymentPage({super.key, required this.bookingDetails});

  @override
  PaymentPageState createState() => PaymentPageState();
}

class PaymentPageState extends State<PaymentPage> {
  String? selectedPaymentMethod;
  final ApiService apiService = ApiService();

  final List<String> paymentMethods = [
    "UPI",
    "Credit/Debit Card",
    "Wallet",
    "Cash"
  ];

  void confirmPayment() async {
    if (selectedPaymentMethod == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a payment method!")),
      );
      return;
    }

    try {
      final bookingData = {
        "userId": int.tryParse(widget.bookingDetails["userId"] ?? "0") ?? 0,
        "userName": widget.bookingDetails["userName"] ?? "",
        "salonId": int.tryParse(widget.bookingDetails["salonId"] ?? "0") ?? 0,
        "salonName": widget.bookingDetails["salonName"] ?? "",
        "phoneNumber": widget.bookingDetails["phoneNumber"] ?? "",
        "bookingDate": widget.bookingDetails["bookingDate"] ?? DateTime.now().toIso8601String(),
        "status": "pending",
        "created_at": DateTime.now().toIso8601String(),
      };

      final response = await apiService.saveBooking(bookingData);

      if (response.statusCode == 201) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Booking Confirmed! 🎉"),
            content: Text(
              "Your booking for ${widget.bookingDetails["service"]} with ${widget.bookingDetails["staff"]} at ${widget.bookingDetails["slot"]} is confirmed.\nPayment via $selectedPaymentMethod was successful!",
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReviewPage(
                        bookingDetails: widget.bookingDetails,
                      ),
                    ),
                  );
                },
                child: const Text("Add Review"),
              ),
            ],
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Booking failed: ${response.statusMessage}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Payment Method")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Booking for ${widget.bookingDetails["service"]} at ${widget.bookingDetails["slot"]} with ${widget.bookingDetails["staff"]}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedPaymentMethod,
              hint: const Text("Select Payment Method"),
              items: paymentMethods.map((method) {
                return DropdownMenuItem(value: method, child: Text(method));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedPaymentMethod = value;
                });
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: confirmPayment,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              ),
              child: const Text("Pay Now", style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
