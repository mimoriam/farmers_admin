import 'package:farmers_admin/models/post_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class EditPostScreen extends StatefulWidget {
  final Post post;
  const EditPostScreen({super.key, required this.post});

  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  late TextEditingController _titleController;
  late TextEditingController _avgWeightController;
  late TextEditingController _weightCategoryController;
  late TextEditingController _quantityController;
  late TextEditingController _genderController;
  late TextEditingController _cityController;
  late TextEditingController _villageController;
  late bool _isVerified;

  late DatabaseReference _dbRef;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.post.postTitle);
    _avgWeightController = TextEditingController(text: widget.post.postAverageWeight?.toString() ?? '');
    _weightCategoryController = TextEditingController(text: widget.post.postWeightCategory ?? '');
    _quantityController = TextEditingController(text: widget.post.postQuantity?.toString() ?? '');
    _genderController = TextEditingController(text: widget.post.postGender);
    _cityController = TextEditingController(text: widget.post.postCity);
    _villageController = TextEditingController(text: widget.post.postVillage);
    _isVerified = widget.post.postUserVerified;

    _dbRef = FirebaseDatabase.instance.ref().child('productPostsData').child(widget.post.postId);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _avgWeightController.dispose();
    _weightCategoryController.dispose();
    _quantityController.dispose();
    _genderController.dispose();
    _cityController.dispose();
    _villageController.dispose();
    super.dispose();
  }

  void _updatePost() {
    final updatedData = {
      'postTitle': _titleController.text,
      'postGender': _genderController.text,
      'postCity': _cityController.text,
      'postVillage': _villageController.text,
      'postUserVerified': _isVerified,
      'postAverageWeight': num.tryParse(_avgWeightController.text),
      'postWeightCategory': _weightCategoryController.text,
      'postQuantity': int.tryParse(_quantityController.text),
    };

    // Remove null values to avoid overwriting existing data with nulls in Firebase
    updatedData.removeWhere((key, value) => value == null);

    _dbRef.update(updatedData).then((_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Post updated successfully!')),
      );
      Navigator.pop(context);
    }).catchError((error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update post: $error')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _avgWeightController,
                decoration: const InputDecoration(labelText: 'Average Weight', border: OutlineInputBorder()),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _weightCategoryController,
                decoration: const InputDecoration(labelText: 'Weight Category (e.g., kg, byBox)', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'Quantity', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _genderController,
                decoration: const InputDecoration(labelText: 'Gender', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _cityController,
                decoration: const InputDecoration(labelText: 'City', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _villageController,
                decoration: const InputDecoration(labelText: 'Village', border: OutlineInputBorder()),
              ),
              const SizedBox(height: 10),
              SwitchListTile(
                title: const Text('Verified'),
                value: _isVerified,
                onChanged: (bool value) {
                  setState(() {
                    _isVerified = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _updatePost,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text('Update Post'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

