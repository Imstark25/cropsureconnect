import 'package:cropsureconnect/buyer/widgets/documents/document_card.dart';
import 'package:cropsureconnect/buyer/widgets/documents/verification_progress_indicator.dart';
import 'package:cropsureconnect/buyer/widgets/documents/verification_status_banner.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cropsureconnect/buyer/models/importer_profile_model.dart';
import 'package:cropsureconnect/buyer/services/buyer_service.dart';


class DocumentsScreen extends StatelessWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final BuyerService buyerService = Get.find<BuyerService>();
    final User? currentUser = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: const Text('Documents & Verification')),
      body: FutureBuilder<ImporterProfileModel>(
        future: buyerService.getBuyerProfile(currentUser!.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            final profile = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // 1. Status Banner
                  VerificationStatusBanner(status: profile.overallVerificationStatus),
                  
                  // 2. Progress Indicator
                  VerificationProgressIndicator(documents: profile.requiredDocuments),
                  const SizedBox(height: 24),
                  
                  // 3. Document List
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: profile.requiredDocuments.length,
                    itemBuilder: (context, index) {
                      return DocumentCard(document: profile.requiredDocuments[index]);
                    },
                  ),
                  
                  const SizedBox(height: 24),
                  // 4. Help Section
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Need help with verification?'),
                          OutlinedButton(
                            onPressed: () {},
                            child: const Text('Contact Support'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(child: Text('Profile not found.'));
        },
      ),
    );
  }
}