import 'package:flutter/material.dart';

class ViewDeletedItemsPage extends StatelessWidget {
  final List<Map<String, dynamic>> deletedItems;

  const ViewDeletedItemsPage({Key? key, required this.deletedItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Deleted Items'),
        backgroundColor: Colors.black,
      ),
      body: ListView.builder(
        itemCount: deletedItems.length,
        itemBuilder: (context, index) {
          final item = deletedItems[index];
          return ListTile(
            title: Text(
              '${item['name']} (${item['count']})',
              style: const TextStyle(color: Colors.white),
            ),
            subtitle: Text(
              'Item Placed at: ${item['place']}, Deleted at: ${item['timeDeleted']}',
              style: const TextStyle(color: Colors.white54),
            ),
          );
        },
      ),
    );
  }
}
