import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:isportapp/pages/accounttype_page.dart';

class OtpVerificationPage extends StatefulWidget {
  final String mobileNumber;

  OtpVerificationPage({required this.mobileNumber});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  TextEditingController otpController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Verify OTP"),
      ),
       backgroundColor: const Color.fromARGB(255, 244, 244, 247),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Enter OTP sent to ${widget.mobileNumber}",
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "OTP",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isLoading ? null : _verifyOtp,
              child: isLoading
                  ? const CircularProgressIndicator(color: Colors.blue)
                  : const Text("Verify OTP"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _verifyOtp() async {
    setState(() {
      isLoading = true;
    });
    final otp = otpController.text;
    final url = Uri.parse('http://10.0.2.2:8080/api/sms/verify-otp');

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'mobileNumber': widget.mobileNumber,
          'otp': otp,
        },
      );

      if (response.statusCode == 200) {
        debugPrint("OTP verified successfully: ${response.body}");
        // Proceed to the next screen or show a success message
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ChooseAccountTypePage(),
        ),
      );
      } else {
        debugPrint("Failed to verify OTP: ${response.body}");
      }
    } catch (e) {
      debugPrint("Error verifying OTP: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
