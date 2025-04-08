import 'package:applianceCare/common/theme.dart';
import 'package:applianceCare/features/mainApp/navDrawer/recalls_page/widgets/recallDetailDialog.dart';
import 'package:flutter/material.dart';
import 'services/getRecalls.dart';
import 'model/recallClass.dart';

class RecallPage extends StatefulWidget {
  @override
  _RecallPageState createState() => _RecallPageState();
}

class _RecallPageState extends State<RecallPage> {
  List<Recall> recalls = [];
  bool isLoading = false;
  String searchQuery = '';
  int currentPage = 1;
  final int limit = 10;
  int totalItems = 0;

  @override
  void initState() {
    super.initState();
    fetchRecalls();
  }

  Future<void> fetchRecalls() async {
    setState(() => isLoading = true);

    try {
      List<Recall> fetchedRecalls = await getRecalls(
        search: searchQuery,
        page: currentPage,
        limit: limit,
      );

      setState(() {
        recalls = fetchedRecalls;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      print('Error fetching recalls: $e');
    }
  }

  void onSearch(String query) {
    setState(() {
      searchQuery = query;
      currentPage = 1;
    });
    fetchRecalls();
  }

  void nextPage() {
    setState(() => currentPage++);
    fetchRecalls();
  }

  void prevPage() {
    if (currentPage > 1) {
      setState(() => currentPage--);
      fetchRecalls();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recall List'),
        centerTitle: true,
        backgroundColor: AppTheme.main_colour, // Modern color scheme
        elevation: 0, // Remove appBar shadow for a clean look
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              onChanged: onSearch,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: 'Search recalls...',
                labelStyle: TextStyle(color: AppTheme.main_colour),
                prefixIcon: Icon(Icons.search, color: AppTheme.main_colour),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: AppTheme.main_colour),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: BorderSide(color: AppTheme.main_colour),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back, color: AppTheme.main_colour),
                  onPressed: currentPage > 1 ? prevPage : null,
                ),
                Text('Page $currentPage', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color:AppTheme.main_colour)),
                IconButton(
                  icon: Icon(Icons.arrow_forward, color: AppTheme.main_colour),
                  onPressed: nextPage,
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : recalls.isEmpty
                    ? Center(child: Text('No recalls found', style: TextStyle(fontSize: 18, color: Colors.grey)))
                    : ListView.builder(
                        itemCount: recalls.length,
                        itemBuilder: (context, index) {
                          final recall = recalls[index];
                          return Card(
                            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: BorderSide(color:AppTheme.main_colour.withOpacity(0.2), width: 1),
                            ),
                            elevation: 4, // Add slight shadow to the card for depth
                            child: ListTile(
                              contentPadding: EdgeInsets.all(16),
                              title: Text(recall.recall_heading, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 8),
                                  Text('Product: ${recall.product_name}', style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                                  Text('Hazard: ${recall.hazard_description}', style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                                  Text('Date: ${recall.recall_date}', style: TextStyle(fontSize: 14, color: Colors.grey[700])),
                                ],
                              ),
                              onTap: () => showRecallDetailsDialog(recall, context),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
