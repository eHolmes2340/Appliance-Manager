  import 'package:flutter/material.dart';
  import 'services/getRecalls.dart';
  import 'model/recall.dart';

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
        appBar: AppBar(title: Text('Recall List')),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: onSearch,
                decoration: InputDecoration(
                  labelText: 'Search recalls...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            
            // Pagination controls moved up
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: currentPage > 1 ? prevPage : null,
                  ),
                  Text('Page $currentPage', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: Icon(Icons.arrow_forward),
                    onPressed: nextPage,
                  ),
                ],
              ),
            ),

            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : recalls.isEmpty
                      ? Center(child: Text('No recalls found'))
                      : ListView.builder(
                          itemCount: recalls.length,
                          itemBuilder: (context, index) {
                            final recall = recalls[index];
                            return Card(
                              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              child: ListTile(
                                title: Text(recall.recall_heading, style: TextStyle(fontWeight: FontWeight.bold)),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Product: ${recall.product_name}'),
                                    Text('Hazard: ${recall.hazard_description}'),
                                    Text('Date: ${recall.recall_date}'),
                                  ],
                                ),
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