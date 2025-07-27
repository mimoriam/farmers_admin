import 'package:farmers_admin/common/app_header.dart';
import 'package:farmers_admin/main.dart';
import 'package:flutter/material.dart';

class EditPostScreen extends StatefulWidget {
  const EditPostScreen({super.key});

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
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
              // AppHeader(),
              _Header(),
              const SizedBox(height: 20),
              // Re-introduced the Card for the main content area
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
                            Expanded(flex: 2, child: _PostForm()),
                            SizedBox(width: 24),
                            Expanded(flex: 1, child: _ImageGallery()),
                          ],
                        );
                      } else {
                        return const Column(
                          children: [_PostForm(), SizedBox(height: 24), _ImageGallery()],
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
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.of(context).pop(),
            ),
            const SizedBox(width: 8),
            Text(
              'Post Title',
              style: Theme.of(
                context,
              ).textTheme.headlineLarge?.copyWith(color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 8),
        const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Text('Dashboard / Post / Post Details', style: TextStyle(color: Colors.grey)),
        ),
      ],
    );
  }
}

class _PostForm extends StatelessWidget {
  const _PostForm();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _FormInput(
          label: 'Post Title*',
          child: CustomTextField(initialValue: 'Andrew'),
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _FormInput(
                label: 'City',
                child: CustomTextField(initialValue: 'Lahore'),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: _FormInput(
                label: 'Village',
                child: CustomTextField(initialValue: 'Bhandgran'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _FormInput(
                label: 'Category',
                child: CustomDropdown(
                  hint: 'Select Category',
                  items: const ['Goat', 'Sheep', 'Cow'],
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _FormInput(
                label: 'Gender',
                child: CustomDropdown(value: 'Male', items: const ['Male', 'Female']),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _FormInput(
                label: 'Weight (KG)',
                child: CustomTextField(initialValue: '50'),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: _FormInput(
                label: 'Quantity',
                child: CustomDropdown(value: '20', items: ['10', '20', '30', '40', '50']),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: _FormInput(
                label: 'Age',
                child: CustomDropdown(value: '20', items: ['10', '15', '20', '25']),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: _FormInput(
                label: 'Price',
                child: CustomTextField(initialValue: '50,000'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        _FormInput(
          label: 'Location',
          child: CustomTextField(
            hintText: 'Location....',
            suffixIcon: Icon(Icons.location_on_outlined),
          ),
        ),
        const SizedBox(height: 20),
        _FormInput(
          label: 'Status',
          child: CustomDropdown(value: 'Approve', items: const ['Approve', 'Pending', 'Rejected']),
        ),

        SizedBox(
          height: 10,
        ),
        const _ActionButtons(),
      ],
    );
  }
}

class _ImageGallery extends StatelessWidget {
  const _ImageGallery();

  @override
  Widget build(BuildContext context) {
    final imageUrls = [
      'https://i.imgur.com/efP5x5A.jpeg',
      'https://i.imgur.com/efP5x5A.jpeg',
      'https://i.imgur.com/efP5x5A.jpeg',
      'https://i.imgur.com/efP5x5A.jpeg',
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 4,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            imageUrls[index],
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              color: Colors.grey[200],
              child: Icon(Icons.image_not_supported_outlined, color: Colors.grey[400]),
            ),
          ),
        );
      },
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
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('CANCEL', style: TextStyle(color: Colors.grey)),
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
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: appColors.applyFilterButtonColor,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            elevation: 0,
          ),
          child: const Text('SAVE CHANGES', style: TextStyle(color: Colors.white)),
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
        suffixIcon: suffixIcon, // Restored border
        border: _inputBorder,
        enabledBorder: _inputBorder,
        focusedBorder: _focusedInputBorder,
        errorBorder: _errorInputBorder,
        focusedErrorBorder: _focusedInputBorder,
        contentPadding: _contentPadding
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
        // border: UnderlineInputBorder(), // Restored border
          border: _inputBorder,
          enabledBorder: _inputBorder,
          focusedBorder: _focusedInputBorder,
          errorBorder: _errorInputBorder,
          focusedErrorBorder: _focusedInputBorder,
          contentPadding: _contentPadding
      ),
      items: items.map((String value) {
        return DropdownMenuItem<String>(value: value, child: Text(value));
      }).toList(),
      onChanged: (_) {},
    );
  }
}
