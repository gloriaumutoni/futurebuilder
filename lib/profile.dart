import 'package:flutter/material.dart';

class LoadingWidgets {
  static Widget buildSkeletonLoader() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: _cardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _shimmerBox(60, 60, isCircle: true),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _shimmerBox(120, 16),
                    SizedBox(height: 8),
                    _shimmerBox(80, 14),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          _shimmerBox(double.infinity, 12),
          SizedBox(height: 8),
          _shimmerBox(200, 12),
        ],
      ),
    );
  }

  static Widget buildProgressLoader() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: _cardDecoration(),
      child: Column(
        children: [
          Text(
            "Loading Products...",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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

  static Widget buildSpinnerLoader() {
    return Container(
      padding: EdgeInsets.all(32),
      decoration: _cardDecoration(),
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
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
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

  static Widget _shimmerBox(
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
    );
  }

  static BoxDecoration _cardDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 5,
        ),
      ],
    );
  }
}
