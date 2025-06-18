import 'package:flutter/material.dart';
import 'profile.dart';
import 'dashboard.dart';
import 'list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FutureBuilder Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoadingDemoScreen(),
    );
  }
}

class LoadingDemoScreen extends StatefulWidget {
  const LoadingDemoScreen({super.key});

  @override
  _LoadingDemoScreenState createState() => _LoadingDemoScreenState();
}

class _LoadingDemoScreenState extends State<LoadingDemoScreen> {
  final ApiService _apiService = ApiService();
  Future<String>? _profileFuture;
  Future<List<String>>? _productsFuture;
  Future<Map<String, dynamic>>? _dashboardFuture;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    setState(() {
      _profileFuture = _apiService.fetchUserProfile();
      _productsFuture = _apiService.fetchProducts();
      _dashboardFuture = _apiService.fetchDashboardData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('FutureBuilder'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        actions: [IconButton(icon: Icon(Icons.refresh), onPressed: _loadData)],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection("Profile", _buildSkeletonScenario()),
            SizedBox(height: 32),
            _buildSection("List items", _buildProgressScenario()),
            SizedBox(height: 32),
            _buildSection("Dashboard", _buildSpinnerScenario()),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        ),
        SizedBox(height: 8),
        content,
      ],
    );
  }

  Widget _buildSkeletonScenario() {
    return FutureBuilder<String>(
      future: _profileFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingWidgets.buildSkeletonLoader();
        }
        if (snapshot.hasData) {
          return ContentWidgets.buildProfileCard(snapshot.data!);
        }
        return Container();
      },
    );
  }

  Widget _buildProgressScenario() {
    return FutureBuilder<List<String>>(
      future: _productsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingWidgets.buildProgressLoader();
        }
        if (snapshot.hasData) {
          return ContentWidgets.buildProductList(snapshot.data!);
        }
        return Container();
      },
    );
  }

  Widget _buildSpinnerScenario() {
    return FutureBuilder<Map<String, dynamic>>(
      future: _dashboardFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingWidgets.buildSpinnerLoader();
        }
        if (snapshot.hasData) {
          return ContentWidgets.buildDashboard(snapshot.data!);
        }
        return Container();
      },
    );
  }
}
