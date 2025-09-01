import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/stat_card.dart';
import '../widgets/chart_placeholder.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dashboard',
            style: GoogleFonts.lato(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2,
            children: const [
              StatCard(title: 'Total Farmers', value: '1,250', icon: Icons.people, color: Colors.green),
              StatCard(title: 'Total Importers', value: '340', icon: Icons.business, color: Colors.blue),
              StatCard(title: 'Pending Approvals', value: '15', icon: Icons.hourglass_top, color: Colors.orange),
              StatCard(title: 'Active Orders', value: '82', icon: Icons.receipt_long, color: Colors.purple),
            ],
          ),
          const SizedBox(height: 24),
          const ChartPlaceholder(title: 'New User Registrations (Weekly)'),
          const SizedBox(height: 24),
          Text(
            'Recent Activity',
            style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          _buildActivityTile(
            icon: Icons.person_add,
            title: 'New Farmer Registration',
            subtitle: 'Erode Farmers FPO',
            time: '2m ago',
            color: Colors.green,
          ),
          _buildActivityTile(
            icon: Icons.document_scanner,
            title: 'New Document Uploaded',
            subtitle: 'Al Dahra Agri. Co - Import License',
            time: '1h ago',
            color: Colors.blue,
          ),
        ],
      ),
    );
  }

  Widget _buildActivityTile({required IconData icon, required String title, required String subtitle, required String time, required Color color}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ),
    );
  }
}