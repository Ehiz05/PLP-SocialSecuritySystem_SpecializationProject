import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:social_security_app/BackendFiles/api_service.dart';

class PaymentScreen extends StatefulWidget {
  final int userId;

  const PaymentScreen({super.key, required this.userId});

  @override
  PaymentScreenState createState() => PaymentScreenState(); // Changed to public
}

class PaymentScreenState extends State<PaymentScreen> {
  final ApiService apiService = ApiService();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  bool isLoading = false;

  Future<void> makePayment() async {
    setState(() {
      isLoading = true;
    });

    try {
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        PaymentMethodParams.card(
          paymentMethodData: PaymentMethodData(),
        ),
      );
      final token = paymentMethod.id;

      final response = await apiService.makePayment(
        token,
        widget.userId,
        double.parse(amountController.text),
        descriptionController.text,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'])),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Payment failed: $e")),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Make Payment")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: amountController,
              decoration: const InputDecoration(labelText: "Amount"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: "Description"),
            ),
            const SizedBox(height: 20),
            isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: makePayment,
                    child: const Text("Pay Now"),
                  ),
          ],
        ),
      ),
    );
  }
}
