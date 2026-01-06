import 'package:flutter/material.dart';

class StatsCard extends StatelessWidget {
  final String connectionTime;
  final int downloadSpeed;
  final int uploadSpeed;

  const StatsCard({
    super.key,
    required this.connectionTime,
    required this.downloadSpeed,
    required this.uploadSpeed,
  });

  String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B/s';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB/s';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB/s';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Connection Statistics',
            style: TextStyle(
              color: Color(0xFF2C3E50),
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                icon: Icons.access_time,
                label: 'Duration',
                value: connectionTime,
              ),
              Container(
                width: 1,
                height: 50,
                color: const Color(0xFFECF0F1),
              ),
              _buildStatItem(
                icon: Icons.download,
                label: 'Download',
                value: _formatBytes(downloadSpeed),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Color(0xFFECF0F1)),
          const SizedBox(height: 16),
          _buildStatItem(
            icon: Icons.upload,
            label: 'Upload',
            value: _formatBytes(uploadSpeed),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF34495E), size: 24),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF7F8C8D),
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Color(0xFF2C3E50),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
