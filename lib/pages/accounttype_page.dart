import 'package:flutter/material.dart';
import 'package:isportapp/pages/createaccount_page.dart';


class ChooseAccountTypePage extends StatefulWidget {
  @override
  State<ChooseAccountTypePage> createState() => _ChooseAccountTypePageState();
}

class _ChooseAccountTypePageState extends State<ChooseAccountTypePage> {
  String selectedAccountType = 'Individual';

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
              'Set up profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Personalize your profile to unlock a tailored sports experience!',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 32),
            Text('Choose Account Type', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16),
            ToggleButtons(
              isSelected: [
                selectedAccountType == 'Individual',
                selectedAccountType == 'Team Account',
              ],
              onPressed: (index) {
                setState(() {
                  selectedAccountType = index == 0 ? 'Individual' : 'Team Account';
                });
              },
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Individual'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Team Account'),
                ),
              ],
              borderRadius: BorderRadius.circular(8),
              selectedColor: Colors.white,
              fillColor: Colors.blue,
              color: Colors.black,
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Navigate to Create Account screen based on the selected account type
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateAccountPage(
                      accountType: selectedAccountType,
                    ),
                  ),
                );
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
                  'Next',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
