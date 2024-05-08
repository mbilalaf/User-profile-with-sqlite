// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profile_app/models/user_model.dart';
import 'package:profile_app/pages/login/login_page.dart';
import 'package:profile_app/pages/widgets/custom_button.dart';
import 'package:profile_app/services/database_helper.dart';

class ProfilePage extends StatefulWidget {
  final Users? profile;

  const ProfilePage({Key? key, this.profile}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? _fullName;
  String? _email;
  String? _userName;
  File? _image;

  final ImagePicker _picker = ImagePicker();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final userNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Initialize the text controllers with the initial values
    nameController.text = widget.profile?.fullName ?? '';
    emailController.text = widget.profile?.email ?? '';
    userNameController.text = widget.profile?.usrName ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 45.0, horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: _getImage,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 77,
                    child: _image != null
                        ? CircleAvatar(
                            radius: 75,
                            backgroundImage: FileImage(_image!),
                          )
                        : const CircleAvatar(
                            radius: 75,
                            // You can set a default image here
                            // backgroundImage: AssetImage("assets/no_user.jpg"),
                          ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  onChanged: (value) => _fullName = value,
                  controller: nameController,
                  decoration: const InputDecoration(hintText: 'Full Name'),
                ),
                TextField(
                  onChanged: (value) => _email = value,
                  controller: emailController,
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
                TextField(
                  onChanged: (value) => _userName = value,
                  controller: userNameController,
                  decoration: const InputDecoration(hintText: 'User Name'),
                ),
                const SizedBox(height: 24),
                CustomButton(
                    btnText: "Update Profile",
                    onTap: () {
                      _updateProfile;
                      final snackBar = SnackBar(
                        content: Text('Profile is Updated'),
                        duration: Duration(milliseconds: 600),
                      );

                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }),
                const SizedBox(height: 16),
                CustomButton(
                  btnText: "LOG OUT",
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _updateProfile() async {
    if (_fullName == null && _email == null && _userName == null) {
      // No updates to be saved
      return;
    }

    final DatabaseHelper db = DatabaseHelper();

    final Users updatedUser = Users(
      usrId: widget.profile!.usrId,
      fullName: _fullName ?? widget.profile!.fullName,
      email: _email ?? widget.profile!.email,
      usrName: _userName ?? widget.profile!.usrName,
      password: widget.profile!.password,
    );

    // Update user profile info
    await db.updateUser(updatedUser);

    // Save profile image
    if (_image != null) {
      await db.insertProfileImage(_image!);
    }
  }
}
