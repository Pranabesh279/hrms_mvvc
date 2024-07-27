import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/setup_profile.controller.dart';

class SetupProfileScreen extends GetView<SetupProfileController> {
  const SetupProfileScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SetupProfileScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SetupProfileScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
