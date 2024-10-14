import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:isportapp/pages/verify_page.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController mobileNumberController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 92, 177, 233),
            Color.fromARGB(85, 85, 123, 238),
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: _page(),
      ),
    );
  }

  Widget _page() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _icon(),
            const SizedBox(height: 50),
            _inputField("Mobile Number", mobileNumberController),
            const SizedBox(height: 50),
            _sendOtpBtn(),
          ],
        ),
      ),
    );
  }

 Widget _icon() {
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white, width: 2),
      shape: BoxShape.circle,
    ),
    child: ClipOval(
      child: Image.asset(
        'assets/ksrlogo.png', // Replace with your image path
        fit: BoxFit.cover, // Adjusts the image to cover the circle
        width: 120, // Width of the circle
        height: 120, // Height of the circle
      ),
    ),
  );
}


  Widget _inputField(String hintText, TextEditingController controller) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(color: Colors.white),
    );

    return TextField(
      style: const TextStyle(color: Colors.white),
      controller: controller,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white),
        enabledBorder: border,
        focusedBorder: border,
      ),
    );
  }

  Widget _sendOtpBtn() {
    return ElevatedButton(
      onPressed: isLoading ? null : _sendOtp,
      child: isLoading
          ? const CircularProgressIndicator(color: Color.fromARGB(255, 0, 7, 12))
          : const SizedBox(
              width: double.infinity,
              child: Text(
                "Send OTP",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color.fromARGB(255, 0, 2, 4),
        shape: const StadiumBorder(),
        backgroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
    );
  }

  Future<void> _sendOtp() async {
    setState(() {
      isLoading = true;
    });
    final mobileNumber = mobileNumberController.text;
    final url = Uri.parse('http://10.0.2.2:8080/api/sms/sendOtp'); // Replace <your_machine_ip> with your actual IP

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'mobileNumber': mobileNumber,
        },
      );

      if (response.statusCode == 200) {
        debugPrint("OTP sent successfully: ${response.body}");
        // Navigate to the OTP verification screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpVerificationPage(mobileNumber: mobileNumber),
          ),
        );
      } else {
        debugPrint("Failed to send OTP: ${response.body}");
      }
    } catch (e) {
      debugPrint("Error sending OTP: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
