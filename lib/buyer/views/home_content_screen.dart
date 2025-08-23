import 'package:cropsureconnect/buyer/widgets/home/home_header_widget.dart';
import 'package:cropsureconnect/buyer/widgets/home/quick_stats_grid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cropsureconnect/buyer/models/importer_profile_model.dart';
import 'package:cropsureconnect/buyer/services/buyer_service.dart';

class HomeContentScreen extends StatefulWidget {
  const HomeContentScreen({super.key});

  @override
  State<HomeContentScreen> createState() => _HomeContentScreenState();
}

class _HomeContentScreenState extends State<HomeContentScreen> {
  Future<ImporterProfileModel>? _profileFuture;
  
  final BuyerService buyerService = Get.find<BuyerService>();
  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    if (currentUser != null) {
      _profileFuture = buyerService.getBuyerProfile(currentUser!.uid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<ImporterProfileModel>(
        future: _profileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.hasData) {
            final profile = snapshot.data!;
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Header
                    HomeHeader(profile: profile),

                    // 2. Quick Stats Grid
                    QuickStatsGrid(profile: profile),
                    const SizedBox(height: 16),
                    
                    // 3. Seasonal Demand Banner
                    _buildSeasonalDemandBanner(profile.seasonalDemand),
                    const SizedBox(height: 24),
                    
                    // 4. Crops Interested
                    _buildInterestedCrops(profile.cropsInterestedIn),
                    const SizedBox(height: 24),

                    // 5. Recent Activity
                    _buildRecentActivity(profile.recentActivity),
                    const SizedBox(height: 24),
                    
                    // 6. Call-to-Action Buttons
                    _buildActionButtons(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            );
          }
          return const Center(child: Text('Profile not found.'));
        },
      ),
    );
  }

  // --- Helper Widgets specific to this screen ---
  
  Widget _buildSeasonalDemandBanner(String demand) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.teal.shade300, Colors.green.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          demand,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildInterestedCrops(List<String> crops) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text('Crops Interested In', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: crops.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              return Chip(label: Text(crops[index]));
            },
            separatorBuilder: (context, index) => const SizedBox(width: 8),
          ),
        ),
      ],
    );
  }

  Widget _buildRecentActivity(List<Map<String, String>> activities) {
     return Padding(
       padding: const EdgeInsets.symmetric(horizontal: 16.0),
       child: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           const Text('Recent Activity', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
           const SizedBox(height: 12),
           Card(
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
             elevation: 2,
             child: ListView.separated(
               shrinkWrap: true,
               physics: const NeverScrollableScrollPhysics(),
               itemCount: activities.length,
               itemBuilder: (context, index) {
                 return ListTile(
                   leading: const Icon(Icons.history, color: Colors.grey),
                   title: Text(activities[index]['title']!),
                 );
               },
               separatorBuilder: (context, index) => const Divider(height: 1, indent: 16, endIndent: 16),
             ),
           ),
         ],
       ),
     );
  }
  
  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton.icon(
              icon: const Icon(Icons.store),
              label: const Text('Browse Market'),
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: OutlinedButton.icon(
              icon: const Icon(Icons.upload_file),
              label: const Text('Upload Documents'),
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}