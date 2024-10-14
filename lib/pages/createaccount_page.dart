import 'package:flutter/material.dart';

class CreateAccountPage extends StatefulWidget {
  final String accountType;

  CreateAccountPage({required this.accountType});

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set up profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Set up profile for ${widget.accountType}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Personalize your profile to unlock a tailored sports experience!',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 32),
            Center(
              child: CircleAvatar(
                radius: 40,
                child: Icon(Icons.person, size: 40),
              ),
            ),
            SizedBox(height: 32),
            _inputField('Full Name', fullNameController),
            SizedBox(height: 16),
            _inputField('Email', emailController),
            SizedBox(height: 16),
            _inputField('Mobile Number', mobileNumberController),
            SizedBox(height: 16),
            _inputField('DOB', dobController, isDate: true),
            SizedBox(height: 16),
            _genderDropdown(),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Submit the form data
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: Center(
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField(String hint, TextEditingController controller, {bool isDate = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      keyboardType: isDate ? TextInputType.datetime : TextInputType.text,
    );
  }

  Widget _genderDropdown() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        hintText: "Select Gender",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
        ),
      ),
      value: selectedGender,
      onChanged: (value) {
        setState(() {
          selectedGender = value;
        });
      },
      items: ['Male', 'Female', 'Other'].map((gender) {
        return DropdownMenuItem(
          value: gender,
          child: Text(gender),
        );
      }).toList(),
    );
  }
}
