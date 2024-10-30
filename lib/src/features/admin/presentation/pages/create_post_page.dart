import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gradus/src/core/colors/app_colors.dart';
import 'package:gradus/src/core/widgets/custom_appbar.dart';
import 'package:gradus/src/core/widgets/custom_button.dart';
import 'package:gradus/src/features/admin/widgets/admin_fields_widget.dart';
import 'package:gradus/src/features/admin/widgets/post_widget.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    titleController.dispose();
    imageUrlController.dispose();
    super.dispose();
  }

  void _publishPost() async {
    if (_formKey.currentState!.validate()) {
      await FirebaseFirestore.instance.collection('news').add({
        'desc': titleController.text,
        'images': [imageUrlController.text],
      });

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.sectionColor,
      appBar: CustomAppBar(
        title: 'Post',
        popAble: true,
        backgroundColor: AppColors.sectionColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(height: 10),
              PostWidget(
                hint: 'Link',
                title: 'Images',
                controller: imageUrlController,
              ),
              AdminFieldsWidget(
                title: 'Title',
                hint: 'Write something',
                controller: titleController,
              ),
              SizedBox(height: 20),
              CustomButton(
                onTap: _publishPost,
                btnText: 'Publish',
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
