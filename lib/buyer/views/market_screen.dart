
import 'package:cropsureconnect/buyer/models/market_crop_model.dart';
import 'package:cropsureconnect/buyer/widgets/market/available_crop_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/dummy_market_data.dart';

class MarketScreen extends StatefulWidget {
  const MarketScreen({super.key});

  @override
  State<MarketScreen> createState() => _MarketScreenState();
}

class _MarketScreenState extends State<MarketScreen> {
  final _searchController = TextEditingController();
  List<MarketCropModel> _filteredCrops = [];

  @override
  void initState() {
    super.initState();
    // This now works because the list is imported from the new file
    _filteredCrops = dummyMarketCrops;
    _searchController.addListener(_filterCrops);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterCrops);
    _searchController.dispose();
    super.dispose();
  }

  void _filterCrops() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        // This now works
        _filteredCrops = dummyMarketCrops;
      } else {
        // This now works
        _filteredCrops = dummyMarketCrops.where((crop) {
          final nameMatches = crop.name.toLowerCase().contains(query);
          final varietyMatches = crop.variety.toLowerCase().contains(query);
          return nameMatches || varietyMatches;
        }).toList();
      }
    });
  }

  void _showFilterModal() {
    // Placeholder for your advanced filter modal
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Market')),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Padding(
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
            ),
          ];
        },
        body: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: _filteredCrops.length,
          itemBuilder: (context, index) {
            return AvailableCropCard(crop: _filteredCrops[index]);
          },
        ),
      ),
    );
  }
}