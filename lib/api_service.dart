class ApiService {
  Future<String> fetchUserProfile() async {
    await Future.delayed(Duration(seconds: 2));
    return "John Doe - Software Developer";
  }

  Future<List<String>> fetchProducts() async {
    await Future.delayed(Duration(seconds: 3));
    return [
      "iPhone 15 Pro",
      "MacBook Air M2",
      "AirPods Pro",
      "iPad Air",
      "Apple Watch Series 9",
    ];
  }

  Future<Map<String, dynamic>> fetchDashboardData() async {
    await Future.delayed(Duration(seconds: 4));
    return {
      "totalSales": "\$125,430",
      "orders": 1247,
      "customers": 892,
      "revenue": "\$89,234",
    };
  }
}
