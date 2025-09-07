import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class EditUserScreen extends StatefulWidget {
  // Accept a map of user data
  final Map<dynamic, dynamic> user;

  const EditUserScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _dobController;
  late final TextEditingController _phoneController;
  String? _currentStatus;
  String? _currentGender;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with the user data passed to the widget
    _fullNameController = TextEditingController(text: widget.user['userName'] ?? '');
    _emailController = TextEditingController(text: widget.user['userMail'] ?? '');
    _dobController = TextEditingController(text: widget.user['dob'] ?? '');
    _phoneController = TextEditingController(text: widget.user['userContact'] ?? '');
  }

  @override
  void dispose() {
    // Dispose controllers to free up resources
    _fullNameController.dispose();
    _emailController.dispose();
    _dobController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  // Handles saving the updated data back to Firebase
  void _handleSaveChanges() async {
    if (widget.user['uid'] == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error: User ID is missing. Cannot save.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final String uid = widget.user['uid'];
    final DatabaseReference userRef = FirebaseDatabase.instance.ref('UsersAuthData/$uid');

    try {
      final Map<String, dynamic> updatedData = {
        'userName': _fullNameController.text,
        'userMail': _emailController.text,
        'dob': _dobController.text,
        'userContact': _phoneController.text,
      };

      await userRef.update(updatedData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('User details updated successfully!'),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update user: $error'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final String initialTitleName = widget.user['fullName'] ?? 'User';

    return Scaffold(
      appBar: AppBar(title: Text('Edit Details for $initialTitleName')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          // Use a Form widget for validation and submission
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: _fullNameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email_outlined),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _dobController,
                  decoration: const InputDecoration(
                    labelText: 'Date of Birth',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.calendar_today_outlined),
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.phone_outlined),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 16),
                // DropdownButtonFormField<String>(
                //   value: _currentStatus,
                //   decoration: const InputDecoration(
                //     labelText: 'Status',
                //     border: OutlineInputBorder(),
                //     prefixIcon: Icon(Icons.toggle_on_outlined),
                //   ),
                //   items: [
                //     'active',
                //     'inactive',
                //   ].map((status) => DropdownMenuItem(value: status, child: Text(status))).toList(),
                //   onChanged: (value) {
                //     setState(() {
                //       _currentStatus = value;
                //     });
                //   },
                // ),
                const SizedBox(height: 16),
                // DropdownButtonFormField<String>(
                //   value: _currentGender,
                //   decoration: const InputDecoration(
                //     labelText: 'Gender',
                //     border: OutlineInputBorder(),
                //     prefixIcon: Icon(Icons.wc_outlined),
                //   ),
                //   items: [
                //     'Male',
                //     'Female',
                //     'Other',
                //   ].map((gender) => DropdownMenuItem(value: gender, child: Text(gender))).toList(),
                //   onChanged: (value) {
                //     setState(() {
                //       _currentGender = value;
                //     });
                //   },
                // ),
                // const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isLoading ? null : _handleSaveChanges,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : const Text('Save Changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
