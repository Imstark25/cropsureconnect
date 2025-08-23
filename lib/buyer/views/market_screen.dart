import 'package:cropsureconnect/buyer/models/dummy_data.dart';
import 'package:cropsureconnect/buyer/widgets/market/available_crop_card.dart';
import 'package:flutter/material.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  // State for search and filtering can be added here
  final _searchController = TextEditingController();

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.6,
          maxChildSize: 0.9,
          builder: (_, controller) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: ListView(
                controller: controller,
                children: const [
                  Text(
                    'Filters',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Crop Category',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // Add filter options here (Checkboxes, Chips, etc.)
                  SizedBox(height: 16),
                  Text(
                    'Quality Standards',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // Add filter options here
                  SizedBox(height: 16),
                  Text(
                    'Origin Country',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  // Add filter options here
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Market')),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Search & Filter Bar
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search crops (e.g., "Rice", "Apples")',
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.filter_list),
                          onPressed: _showFilterModal,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.grey[200],
                      ),
                    ),
                  ),
                  // 2. Featured Crops Section
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Featured Crops',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // Placeholder for Horizontal Scroll
                  Container(
                    height: 100,
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    color: Colors.grey[100],
                    child: const Center(
                      child: Text('Featured Crops Horizontal Scroll Here'),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Available Crops',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ];
        },
        // 3. Available Crops Listing
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: dummyMarketCrops.length,
          itemBuilder: (context, index) {
            return AvailableCropCard(crop: dummyMarketCrops[index]);
          },
        ),
      ),
    );
  }
}
