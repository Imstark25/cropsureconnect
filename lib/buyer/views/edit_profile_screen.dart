import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/edit_profile_controller.dart';
import '../models/importer_profile_model.dart';

class EditProfileScreen extends StatelessWidget {
  final ImporterProfileModel profile;

  const EditProfileScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    final EditProfileController controller = Get.put(EditProfileController(profile: profile));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          Obx(() => controller.isLoading.value
              ? const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white)),
                )
              : IconButton(
                  icon: const Icon(Icons.save),
                  onPressed: controller.saveProfile,
                )),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              _buildTextFormField(
                controller: controller.companyNameController,
                label: 'Company Name',
                icon: Icons.business,
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                controller: controller.addressController,
                label: 'Business Address',
                icon: Icons.location_on,
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                controller: controller.countryController,
                label: 'Country',
                icon: Icons.public,
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                controller: controller.contactPersonController,
                label: 'Contact Person',
                icon: Icons.person,
              ),
              const SizedBox(height: 16),
              _buildTextFormField(
                controller: controller.mobileController,
                label: 'Mobile Number',
                icon: Icons.phone,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 32),
              Obx(() => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.save),
                      label: Text(controller.isLoading.value ? 'Saving...' : 'Save Changes'),
                      onPressed: controller.isLoading.value ? null : controller.saveProfile,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field cannot be empty';
        }
        return null;
      },
    );
  }
}