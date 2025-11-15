import 'package:flutter/material.dart';
import 'package:tugas6/model.dart';
import 'package:tugas6/detail_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KATALOG WISATA',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('List Wisata di Masa Depan'),
          backgroundColor: Colors.pinkAccent,
          centerTitle: true,
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.list), text: 'List View'),
              Tab(icon: Icon(Icons.grid_on), text: 'Grid View'),
            ],
          ),
        ),
        body: TabBarView(children: [buildListView(), buildGridView()]),
      ),
    );
  }
}

Widget buildListView() {
  Wisata wisata = Wisata();
  return Container(
    color: const Color.fromARGB(
      255,
      235,
      189,
      204,
    ), // 👉 Ganti warna background di sini
    child: ListView.builder(
      itemCount: wisata.data.length,
      itemBuilder: (context, index) {
        final item = wisata.data[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: ListTile(
            leading: Image.network(
              item['image']!,
              width: 100,
              fit: BoxFit.cover,
            ),
            title: Text(item['title']!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailPage(
                    title: item['title']!,
                    image: item['image']!,
                    deskripsi: item['deskripsi']!,
                  ),
                ),
              );
            },
          ),
        );
      },
    ),
  );
}

Widget buildGridView() {
  Wisata w = Wisata();
  return Container(
    color: const Color.fromARGB(
      255,
      235,
      189,
      204,
    ), // 👉 warna background GridView
    child: GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: w.data.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        final item = w.data[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(
                  title: item['title']!,
                  image: item['image']!,
                  deskripsi: item['deskripsi']!,
                ),
              ),
            );
          },
          child: Card(
            color: Colors.white,
            shadowColor: Colors.pinkAccent.withOpacity(0.3),
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.network(item['image']!, fit: BoxFit.cover),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    item['title']!,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
