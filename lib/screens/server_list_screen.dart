import 'package:flutter/material.dart';
import '../models/server_model.dart';

class ServerListScreen extends StatefulWidget {
  const ServerListScreen({super.key});

  @override
  State<ServerListScreen> createState() => _ServerListScreenState();
}

class _ServerListScreenState extends State<ServerListScreen> {
  final List<ServerModel> servers = [
    ServerModel(name: 'United States', ping: 76, flag: '🇺🇸'),
    ServerModel(name: 'United Kingdom', ping: 45, flag: '🇬🇧'),
    ServerModel(name: 'Germany', ping: 38, flag: '🇩🇪'),
    ServerModel(name: 'Japan', ping: 120, flag: '🇯🇵'),
    ServerModel(name: 'Singapore', ping: 85, flag: '🇸🇬'),
    ServerModel(name: 'Canada', ping: 32, flag: '🇨🇦'),
    ServerModel(name: 'Australia', ping: 140, flag: '🇦🇺'),
    ServerModel(name: 'Netherlands', ping: 42, flag: '🇳🇱'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8EEF2),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF2C3E50),
        title: const Text(
          'Select Server',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: servers.length,
        itemBuilder: (context, index) {
          return _buildServerCard(servers[index]);
        },
      ),
    );
  }

  Widget _buildServerCard(ServerModel server) {
    Color pingColor = server.ping < 50
        ? const Color(0xFF27AE60)
        : server.ping < 100
            ? const Color(0xFFF39C12)
            : const Color(0xFFE74C3C);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Text(
          server.flag,
          style: const TextStyle(fontSize: 32),
        ),
        title: Text(
          server.name,
          style: const TextStyle(
            color: Color(0xFF2C3E50),
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: pingColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '${server.ping}ms',
            style: TextStyle(
              color: pingColor,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
