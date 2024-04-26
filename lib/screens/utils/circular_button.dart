import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:guardiancare/screens/utils/shimmer_item.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerItem extends StatelessWidget {
  const ShimmerItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        color: Colors.grey[300],
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 2,
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
