import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cropsureconnect/seller/controller/farmer_profile_controller.dart';

class EditFarmerProfileView extends StatelessWidget {
  const EditFarmerProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final FarmerProfileController controller = Get.find();
    final profile = controller.farmerProfile.value!;

    final nameController = TextEditingController(text: profile.name);
    final phoneController = TextEditingController(text: profile.phoneNumber);
    final cropController = TextEditingController(text: profile.mainCrop);
    final fertilizerController = TextEditingController(text: profile.fertilizerUsed);
    var selectedFarmingType = profile.farmingType.obs;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              final updatedData = {
                'name': nameController.text,
                'phoneNumber': phoneController.text,
                'mainCrop': cropController.text,
                'farmingType': selectedFarmingType.value,
                'fertilizerUsed': fertilizerController.text,
              };
              controller.saveProfile(updatedData);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Picture Section
            Center(
              child: Obx(() {
                final imageFile = controller.farmerProfile.value?.localProfileImage;
                ImageProvider<Object> imageProvider;
                if (imageFile != null) {
                  imageProvider = FileImage(imageFile);
                } else if (profile.profileImageUrl != null && profile.profileImageUrl!.isNotEmpty) {
                  imageProvider = NetworkImage(profile.profileImageUrl!);
                } else {
                  imageProvider = const AssetImage('assets/placeholder.png');
                }
                return Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: imageProvider,
                      child: imageFile == null && (profile.profileImageUrl == null || profile.profileImageUrl!.isEmpty)
                          ? const Icon(Icons.person, size: 60)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: const CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Icon(Icons.camera_alt, color: Colors.white),
                        ),
                        onPressed: () => controller.pickImage(),
                      ),
                    ),
                  ],
                );
              }),
            ),
            const SizedBox(height: 24),

            // Personal & Farming Details
            const Text("Farmer Details", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            _buildTextField(nameController, 'Full Name'),
            _buildTextField(phoneController, 'Phone Number', keyboardType: TextInputType.phone),
            _buildTextField(cropController, 'Main Crop'),
            _buildFarmingTypeDropdown(selectedFarmingType),
            Obx(() => selectedFarmingType.value == 'Fertilizer'
                ? _buildTextField(fertilizerController, 'Fertilizers Used')
                : const SizedBox.shrink()),
            const SizedBox(height: 24),

            // *** NEW CERTIFICATES SECTION ***
            const Text("Certificates", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const Divider(),
            Obx(() => _buildCertificateUploadRow(
                controller: controller,
                docType: 'Organic',
                label: 'Organic Certificate')),
            Obx(() => _buildCertificateUploadRow(
                controller: controller,
                docType: 'GLOBALG.A.P.',
                label: 'GLOBALG.A.P. Certificate')),
            Obx(() => _buildCertificateUploadRow(
                controller: controller,
                docType: 'APEDA',
                label: 'APEDA License')),
          ],
        ),
      ),
    );
  }

  // Helper widget for a single certificate upload row
  Widget _buildCertificateUploadRow({required FarmerProfileController controller, required String docType, required String label}) {
    final profile = controller.farmerProfile.value!;
    final doc = profile.documents.firstWhereOrNull((d) => d.type == docType);

    String statusText = "Not Uploaded";
    Color statusColor = Colors.grey;
    String fileName = "";

    if (doc != null) {
      statusText = doc.isVerified ? "Verified" : "Pending Verification";
      statusColor = doc.isVerified ? Colors.green : Colors.orange;
      fileName = doc.name;
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(statusText, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold)),
                    if (fileName.isNotEmpty)
                      Text(fileName, style: const TextStyle(color: Colors.black54, fontSize: 12)),
                  ],
                ),
                ElevatedButton.icon(
                  icon: const Icon(Icons.upload_file),
                  label: Text(doc == null ? 'Upload' : 'Re-upload'),
                  onPressed: () => controller.pickDocumentForType(docType),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, {TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }

  Widget _buildFarmingTypeDropdown(RxString selectedType) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Obx(
            () => DropdownButtonFormField<String>(
          value: selectedType.value,
          decoration: InputDecoration(
            labelText: 'Farming Type',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
          items: ['Organic', 'Fertilizer']
              .map((label) => DropdownMenuItem(
            value: label,
            child: Text(label),
          ))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              selectedType.value = value;
            }
          },
        ),
      ),
    );
  }
}