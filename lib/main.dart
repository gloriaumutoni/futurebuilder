import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FutureBuilder Loading Scenarios',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoadingDemoScreen(),
    );
  }
}

class LoadingDemoScreen extends StatefulWidget {
  @override
  _LoadingDemoScreenState createState() => _LoadingDemoScreenState();
}

class _LoadingDemoScreenState extends State<LoadingDemoScreen> {
  Future<String>? _skeletonFuture;
  Future<List<String>>? _loaderFuture;
  Future<Map<String, dynamic>>? _spinnerFuture;

  @override
  void initState() {
    super.initState();
    _initializeFutures();
  }

  void _initializeFutures() {
    _skeletonFuture = _fetchUserProfile();
    _loaderFuture = _fetchProductList();
    _spinnerFuture = _fetchDashboardData();
  }

  // Scenario 1: User Profile with 2 second delay
  Future<String> _fetchUserProfile() async {
    await Future.delayed(Duration(seconds: 2));
    return "John Doe - Software Developer";
  }

  // Scenario 2: Product List with 3 second delay
  Future<List<String>> _fetchProductList() async {
    await Future.delayed(Duration(seconds: 3));
    return [
      "iPhone 15 Pro",
      "MacBook Air M2",
      "AirPods Pro",
      "iPad Air",
      "Apple Watch Series 9",
    ];
  }

  // Scenario 3: Dashboard Data with 4 second delay
  Future<Map<String, dynamic>> _fetchDashboardData() async {
    await Future.delayed(Duration(seconds: 4));
    return {
      "totalSales": "\$125,430",
      "orders": 1247,
      "customers": 892,
      "revenue": "\$89,234",
    };
  }

  void _refreshData() {
    setState(() {
      _initializeFutures();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FutureBuilder Loading Scenarios'),
        backgroundColor: Colors.blue[600],
        foregroundColor: Colors.white,
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: _refreshData),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Scenario 1: Skeleton Loader
            _buildSectionTitle("Scenario 1: Skeleton Loader (2s)"),
            SizedBox(height: 8),
            FutureBuilder<String>(
              future: _skeletonFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildSkeletonLoader();
                } else if (snapshot.hasError) {
                  return _buildErrorWidget("Error loading profile");
                } else if (snapshot.hasData) {
                  return _buildProfileCard(snapshot.data!);
                }
                return Container();
              },
            ),

            SizedBox(height: 32),

            // Scenario 2: Progress Loader
            _buildSectionTitle("Scenario 2: Progress Loader (3s)"),
            SizedBox(height: 8),
            FutureBuilder<List<String>>(
              future: _loaderFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildProgressLoader();
                } else if (snapshot.hasError) {
                  return _buildErrorWidget("Error loading products");
                } else if (snapshot.hasData) {
                  return _buildProductList(snapshot.data!);
                }
                return Container();
              },
            ),

            SizedBox(height: 32),

            // Scenario 3: Spinner Loader
            _buildSectionTitle("Scenario 3: Spinner Loader (4s)"),
            SizedBox(height: 8),
            FutureBuilder<Map<String, dynamic>>(
              future: _spinnerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return _buildSpinnerLoader();
                } else if (snapshot.hasError) {
                  return _buildErrorWidget("Error loading dashboard");
                } else if (snapshot.hasData) {
                  return _buildDashboard(snapshot.data!);
                }
                return Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.grey[700],
      ),
    );
  }

  // Skeleton Loader
  Widget _buildSkeletonLoader() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildShimmerBox(60, 60, isCircle: true),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildShimmerBox(120, 16),
                    SizedBox(height: 8),
                    _buildShimmerBox(80, 14),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          _buildShimmerBox(double.infinity, 12),
          SizedBox(height: 8),
          _buildShimmerBox(200, 12),
        ],
      ),
    );
  }

  Widget _buildShimmerBox(
    double width,
    double height, {
    bool isCircle = false,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius:
            isCircle
                ? BorderRadius.circular(height / 2)
                : BorderRadius.circular(8),
      ),
      child: _shimmerEffect(),
    );
  }

  Widget _shimmerEffect() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.3, end: 1.0),
      duration: Duration(milliseconds: 800),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.grey[300]!,
                  Colors.grey[100]!,
                  Colors.grey[300]!,
                ],
                stops: [0.0, 0.5, 1.0],
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      },
      onEnd: () {
        // Restart animation
        Future.delayed(Duration(milliseconds: 100), () {
          if (mounted) setState(() {});
        });
      },
    );
  }

  // Progress Loader
  Widget _buildProgressLoader() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            "Loading Products...",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 20),
          LinearProgressIndicator(
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
          SizedBox(height: 12),
          Text(
            "Please wait while we fetch the latest products",
            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  // Spinner Loader
  Widget _buildSpinnerLoader() {
    return Container(
      padding: EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          SizedBox(
            width: 50,
            height: 50,
            child: CircularProgressIndicator(
              strokeWidth: 4,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Loading Dashboard Data...",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 8),
          Text(
            "This might take a moment",
            style: TextStyle(fontSize: 12, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  // Content Widgets
  Widget _buildProfileCard(String profile) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue[100],
            child: Icon(Icons.person, size: 30, color: Colors.blue[600]),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  profile,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "Active since 2020",
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductList(List<String> products) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children:
            products.map((product) {
              return ListTile(
                leading: Icon(Icons.shopping_bag, color: Colors.blue[600]),
                title: Text(product),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              );
            }).toList(),
      ),
    );
  }

  Widget _buildDashboard(Map<String, dynamic> data) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Dashboard Overview",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 16),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            children: [
              _buildDashboardCard(
                "Total Sales",
                data["totalSales"],
                Icons.attach_money,
                Colors.green,
              ),
              _buildDashboardCard(
                "Orders",
                data["orders"].toString(),
                Icons.shopping_cart,
                Colors.blue,
              ),
              _buildDashboardCard(
                "Customers",
                data["customers"].toString(),
                Icons.people,
                Colors.orange,
              ),
              _buildDashboardCard(
                "Revenue",
                data["revenue"],
                Icons.trending_up,
                Colors.purple,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDashboardCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      margin: EdgeInsets.all(4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 30, color: color),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red[200]!),
      ),
      child: Row(
        children: [
          Icon(Icons.error, color: Colors.red[600]),
          SizedBox(width: 12),
          Expanded(
            child: Text(message, style: TextStyle(color: Colors.red[600])),
          ),
        ],
      ),
    );
  }
}
