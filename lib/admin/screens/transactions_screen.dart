import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// --- Data Model ---
// In a real app, this would be in your /models folder.
enum TransactionStatus { completed, pending, failed }

class Transaction {
  final String id;
  final String fromUser;
  final String toUser;
  final double amount;
  final DateTime date;
  final TransactionStatus status;

  Transaction({
    required this.id,
    required this.fromUser,
    required this.toUser,
    required this.amount,
    required this.date,
    required this.status,
  });
}
// --- End of Data Model ---


class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  // --- Dummy Data ---
  // In a real app, this data would come from your controller/service.
  final List<Transaction> _allTransactions = [
    Transaction(id: 'BK-2025-0078', fromUser: 'Erode Farmers FPO', toUser: 'Al Dahra Agri. Co', amount: 360000, date: DateTime.now().subtract(const Duration(days: 2)), status: TransactionStatus.completed),
    Transaction(id: 'BK-2025-0077', fromUser: 'Salem Growers', toUser: 'Fresh Veggies Inc.', amount: 120000, date: DateTime.now().subtract(const Duration(days: 5)), status: TransactionStatus.pending),
    Transaction(id: 'BK-2025-0076', fromUser: 'Nilgiri Horticult.', toUser: 'Global Exports', amount: 550000, date: DateTime.now().subtract(const Duration(days: 10)), status: TransactionStatus.completed),
    Transaction(id: 'BK-2025-0075', fromUser: 'Delta Farmers', toUser: 'AgriCorp', amount: 75000, date: DateTime.now().subtract(const Duration(days: 12)), status: TransactionStatus.failed),
    Transaction(id: 'BK-2025-0074', fromUser: 'Erode Farmers FPO', toUser: 'Fresh Veggies Inc.', amount: 210000, date: DateTime.now().subtract(const Duration(days: 15)), status: TransactionStatus.completed),
  ];

  late List<Transaction> _filteredTransactions;
  TransactionStatus? _selectedStatus;

  @override
  void initState() {
    super.initState();
    _filteredTransactions = _allTransactions;
  }

  void _filterTransactions(String query) {
    List<Transaction> filtered = _allTransactions;

    if (query.isNotEmpty) {
      filtered = filtered.where((t) =>
      t.id.toLowerCase().contains(query.toLowerCase()) ||
          t.fromUser.toLowerCase().contains(query.toLowerCase()) ||
          t.toUser.toLowerCase().contains(query.toLowerCase())
      ).toList();
    }

    if (_selectedStatus != null) {
      filtered = filtered.where((t) => t.status == _selectedStatus).toList();
    }

    setState(() {
      _filteredTransactions = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Screen Header
          Text(
            'Transaction History',
            style: GoogleFonts.lato(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),

          // Search and Filter Bar
          _buildFilterBar(),
          const SizedBox(height: 24),

          // Transaction List Header
          const Row(
            children: [
              Expanded(flex: 3, child: Text('Details', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey))),
              Expanded(flex: 2, child: Text('Amount', textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey))),
            ],
          ),
          const Divider(),

          // Transaction List
          Expanded(
            child: ListView.builder(
              itemCount: _filteredTransactions.length,
              itemBuilder: (context, index) {
                return TransactionListItem(transaction: _filteredTransactions[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Column(
      children: [
        TextField(
          onChanged: _filterTransactions,
          decoration: InputDecoration(
            hintText: 'Search by ID, Farmer, or Importer...',
            prefixIcon: const Icon(Icons.search),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildFilterChip(null, 'All'),
              _buildFilterChip(TransactionStatus.completed, 'Completed'),
              _buildFilterChip(TransactionStatus.pending, 'Pending'),
              _buildFilterChip(TransactionStatus.failed, 'Failed'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(TransactionStatus? status, String label) {
    final bool isSelected = _selectedStatus == status;
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: ChoiceChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            _selectedStatus = selected ? status : null;
          });
          _filterTransactions(''); // Re-apply filter with the new status
        },
        selectedColor: Colors.green.shade100,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: isSelected ? Colors.green.shade700 : Colors.grey.shade300)
        ),
      ),
    );
  }
}

class TransactionListItem extends StatelessWidget {
  final Transaction transaction;

  const TransactionListItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    final statusData = _getStatusData(transaction.status);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Icon
            CircleAvatar(
              backgroundColor: statusData['color']!.withOpacity(0.1),
              child: Icon(statusData['icon'], color: statusData['color']),
            ),
            const SizedBox(width: 16),
            // Details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.id,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${transaction.fromUser} → ${transaction.toUser}',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${transaction.date.day}/${transaction.date.month}/${transaction.date.year}',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            // Amount and Status
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₹${transaction.amount.toStringAsFixed(0)}',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 4),
                _buildStatusBadge(statusData['text']!, statusData['color']!),
              ],
            )
          ],
        ),
      ),
    );
  }

  Map<String, dynamic> _getStatusData(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.completed:
        return {'text': 'Completed', 'color': Colors.green.shade700, 'icon': Icons.check_circle};
      case TransactionStatus.pending:
        return {'text': 'Pending', 'color': Colors.orange.shade800, 'icon': Icons.hourglass_top};
      case TransactionStatus.failed:
        return {'text': 'Failed', 'color': Colors.red.shade700, 'icon': Icons.cancel};
    }
  }

  Widget _buildStatusBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }
}