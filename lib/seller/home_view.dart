import 'package:cropsureconnect/seller/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cropsureconnect/seller/home_controller.dart';

import 'package:cropsureconnect/seller/farmer_profile_view.dart';
import 'package:cropsureconnect/seller/payment_history_view.dart';


import 'grap/status_report_view.dart';
import 'home_model.dart';
import 'language/language_selection_view.dart';


class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('app_title'.tr, style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.bold)),
        actions: [
          TextButton(
            onPressed: () => Get.to(() => const LanguageSelectionView()),
            child: Text('language'.tr, style: const TextStyle(color: Colors.black54)),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none, color: Colors.black54),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              _buildSearchBar(controller),
              const SizedBox(height: 20),
              _buildTopFarmersSection(controller),
              const SizedBox(height: 20),
              _buildCategorySection(controller),
              const SizedBox(height: 10),
              _buildProductListHeader(),
              Obx(() => _buildProductList(controller.filteredProducts)),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // *** UPDATED WIDGET TO HANDLE ASSET AND NETWORK IMAGES ***
  Widget _buildCategoryItem(Category category) {
    // Check if the icon path is a local asset or a network URL
    final bool isAsset = !category.icon.startsWith('http');

    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          CircleAvatar(
            radius: 35,
            // Use AssetImage for local files and NetworkImage for URLs
            backgroundImage: isAsset ? AssetImage(category.icon) as ImageProvider : NetworkImage(category.icon),
          ),
          const SizedBox(height: 5),
          Text(
            category.name,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  // ... (rest of the HomeView class remains the same)

  Widget _buildTopFarmersSection(HomeController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('top_farmers_title'.tr,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        SizedBox(
          height: 100,
          child: Obx(() {
            if (controller.isLoading.value && controller.topFarmers.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.topFarmers.length,
              itemBuilder: (context, index) {
                final farmer = controller.topFarmers[index];
                return _buildTopFarmerCard(farmer);
              },
            );
          }),
        ),
      ],
    );
  }

  Widget _buildTopFarmerCard(TopFarmer farmer) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const FarmerProfileView());
      },
      child: Container(
        width: 80,
        margin: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(farmer.profileImageUrl),
            ),
            const SizedBox(height: 5),
            Text(
              farmer.name,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar(HomeController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: Colors.grey),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'search_by_location'.tr,
                border: InputBorder.none,
              ),
            ),
          ),
          const Icon(Icons.mic, color: Colors.grey),
          const VerticalDivider(thickness: 1, indent: 8, endIndent: 8),
          Obx(
                () => DropdownButton<String>(
              value: controller.selectedLocation.value,
              underline: const SizedBox(),
              icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  controller.selectedLocation.value = newValue;
                }
              },
              items: <String>['All', 'Salem', 'Yercaud', 'Sangli']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategorySection(HomeController controller) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('category_title'.tr,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextButton.icon(
              icon: const Icon(Icons.filter_list, size: 20),
              label: Text('filter'.tr),
              onPressed: () => _showFilterDialog(controller),
              style: TextButton.styleFrom(foregroundColor: Colors.green),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 100,
          child: Obx(() {
            if (controller.isLoading.value && controller.allCategories.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.allCategories.length,
              itemBuilder: (context, index) {
                final category = controller.allCategories[index];
                return _buildCategoryItem(category);
              },
            );
          }),
        ),
      ],
    );
  }

  void _showFilterDialog(HomeController controller) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Filter by Category", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Obx(() => Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: controller.allCategories.map((category) {
                final isSelected = controller.selectedCategories.contains(category.name);
                return FilterChip(
                  label: Text(category.name),
                  selected: isSelected,
                  onSelected: (selected) {
                    controller.toggleCategoryFilter(category.name);
                  },
                  selectedColor: Colors.green.withOpacity(0.3),
                  checkmarkColor: Colors.green,
                );
              }).toList(),
            )),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProductListHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.sort, color: Colors.black54),
          label: Text('sort'.tr, style: const TextStyle(color: Colors.black54)),
        ),
      ],
    );
  }

  Widget _buildProductList(List<Product> products) {
    if (products.isEmpty) {
      return const Center(child: Padding(
        padding: EdgeInsets.all(32.0),
        child: Text("No products match the filter."),
      ));
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return _buildProductCard(product);
      },
    );
  }

  Widget _buildProductCard(Product product) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      color: const Color(0xFFF5F5F0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                product.image,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey.shade300)),
                  child: Center(
                      child: Text(product.name.substring(0, 1),
                          style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.green))),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold)),
                  const Text('General', style: TextStyle(color: Colors.grey)),
                  Text(product.seller,
                      style: const TextStyle(color: Colors.grey)),
                  Text('Qty: ${product.quantity}',
                      style: const TextStyle(color: Colors.grey)),
                  Text(product.location,
                      style: const TextStyle(color: Colors.grey)),
                  Text('₹ ${product.price.toStringAsFixed(0)}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14)),
                ],
              ),
            ),
            Column(
              children: [
                _buildIconButton(Icons.favorite_border),
                const SizedBox(height: 4),
                _buildIconButton(Icons.phone_outlined),
                const SizedBox(height: 4),
                _buildIconButton(Icons.chat_bubble_outline),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade400),
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Icon(icon, size: 20, color: Colors.grey.shade600),
      ),
    );
  }

  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      onTap: (index) {
        if (index == 1) Get.to(() => const PaymentHistoryView());
        if (index == 2) Get.to(() => const FarmerProfileView());
        if (index == 3) Get.to(() => const StatusReportView());
        if (index == 4) Get.to(() => const SettingsView());
      },
      items: [
        BottomNavigationBarItem(icon: const Icon(Icons.home), label: 'home'.tr),
        BottomNavigationBarItem(icon: const Icon(Icons.history), label: 'payment_history'.tr),
        BottomNavigationBarItem(icon: const Icon(Icons.person_outline), label: 'profile'.tr),
        BottomNavigationBarItem(icon: const Icon(Icons.show_chart), label: 'status'.tr),
        BottomNavigationBarItem(icon: const Icon(Icons.settings), label: 'settings'.tr),
      ],
    );
  }
}