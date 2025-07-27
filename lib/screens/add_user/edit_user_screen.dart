import 'package:farmers_admin/common/app_header.dart';
import 'package:farmers_admin/main.dart';
import 'package:flutter/material.dart';

class EditUserScreen extends StatefulWidget {
  const EditUserScreen({super.key});

  @override
  State<EditUserScreen> createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const AppHeader(),
              const _Header(),
              const SizedBox(height: 20),
              Card(
                elevation: 0,
                color: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      bool isWide = constraints.maxWidth > 800;
                      if (isWide) {
                        return const Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(flex: 2, child: _UserForm()),
                            SizedBox(width: 24),
                            Expanded(flex: 1, child: _ImageUploader()),
                          ],
                        );
                      } else {
                        return const Column(
                          children: [_UserForm(), SizedBox(height: 24), _ImageUploader()],
                        );
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            const SizedBox(width: 8),
            Text(
              'New Customer',
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text(
            'Dashboard / Customers\' List / New Customer',
            style: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}

class _UserForm extends StatelessWidget {
  const _UserForm();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _FormInput(
          label: 'Enter Name*',
          child: CustomTextField(initialValue: 'Andrew'),
        ),
        const SizedBox(height: 20),
        _FormInput(
          label: 'Phone Number',
          child: CustomTextField(initialValue: '+44 20 7123 4567'),
        ),
        const SizedBox(height: 20),
        _FormInput(
          label: 'Email*',
          child: CustomTextField(initialValue: 'example@site.com'),
        ),
        const SizedBox(height: 20),
        _FormInput(
          label: 'Address*',
          child: CustomTextField(
            initialValue: 'e.g 123 Elmwood Avenue Springfield, IL 62704, United States',
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'Date of Birth',
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _FormInput(
                label: 'Month*',
                child: CustomDropdown(
                  value: 'September',
                  items: const ['September', 'October', 'November'],
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _FormInput(
                label: 'Day*',
                child: CustomDropdown(value: '20', items: const ['20', '21', '22']),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _FormInput(
                label: 'Year*',
                child: CustomDropdown(value: '1997', items: const ['1997', '1998', '1999']),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _FormInput(
          label: 'Status*',
          child: CustomDropdown(value: 'Active', items: const ['Active', 'Inactive']),
        ),
        const SizedBox(height: 20),
        const _ActionButtons(),
      ],
    );
  }
}

class _ImageUploader extends StatelessWidget {
  const _ImageUploader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: const DecorationImage(
              image: NetworkImage('https://i.imgur.com/efP5x5A.jpeg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 16),
        // SizedBox(
        //   width: double.infinity,
        //   child: OutlinedButton.icon(
        //     onPressed: () {},
        //     icon: const Icon(Icons.file_upload_outlined, color: Colors.black),
        //     label: const Text('UPLOAD PHOTO', style: TextStyle(color: Colors.black)),
        //     style: OutlinedButton.styleFrom(
        //       padding: const EdgeInsets.symmetric(vertical: 16),
        //       backgroundColor: Colors.white,
        //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        //       side: BorderSide(color: Colors.grey[300]!),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class _ActionButtons extends StatelessWidget {
  const _ActionButtons();

  @override
  Widget build(BuildContext context) {
    final appColors = Theme.of(context).extension<AppColors>()!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: appColors.applyFilterButtonColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            elevation: 0,
          ),
          child: const Text('CREATE', style: TextStyle(color: Colors.white)),
        ),
        const SizedBox(width: 12),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.grey[700],
            side: BorderSide(color: Colors.grey[300]!),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
          child: const Text('DISCARD CHANGES'),
        ),
        const SizedBox(width: 12),
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('CANCEL', style: TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }
}

// --- Reusable Form Widgets ---

class _FormInput extends StatelessWidget {
  final String label;
  final Widget child;

  const _FormInput({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black54),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String? initialValue;
  final String? hintText;
  final Widget? suffixIcon;

  CustomTextField({super.key, this.initialValue, this.hintText, this.suffixIcon});

  final OutlineInputBorder _inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: BorderSide(color: Colors.grey.shade400),
  );
  final OutlineInputBorder _focusedInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(color: Colors.grey, width: 2.0),
  );
  final OutlineInputBorder _errorInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(color: Colors.red, width: 1.0),
  );

  final EdgeInsets _contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        border: _inputBorder,
        enabledBorder: _inputBorder,
        focusedBorder: _focusedInputBorder,
        errorBorder: _errorInputBorder,
        focusedErrorBorder: _focusedInputBorder,
        contentPadding: _contentPadding,
      ),
    );
  }
}

class CustomDropdown extends StatelessWidget {
  final String? value;
  final String? hint;
  final List<String> items;

  CustomDropdown({super.key, this.value, this.hint, required this.items});

  final OutlineInputBorder _inputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: BorderSide(color: Colors.grey.shade400),
  );
  final OutlineInputBorder _focusedInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(color: Colors.grey, width: 2.0),
  );
  final OutlineInputBorder _errorInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8.0),
    borderSide: const BorderSide(color: Colors.red, width: 1.0),
  );

  final EdgeInsets _contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      hint: hint != null ? Text(hint!) : null,
      decoration: InputDecoration(
        border: _inputBorder,
        enabledBorder: _inputBorder,
        focusedBorder: _focusedInputBorder,
        errorBorder: _errorInputBorder,
        focusedErrorBorder: _focusedInputBorder,
        contentPadding: _contentPadding,
      ),
      items: items.map((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      onChanged: (_) {},
    );
  }
}
