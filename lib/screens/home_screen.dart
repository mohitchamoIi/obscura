import 'package:flutter/material.dart';
import 'dart:async';
import '../services/vpn_service.dart';
import '../widgets/vpn_button.dart';
import '../widgets/stats_card.dart';
import '../widgets/connection_status.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  final VPNService _vpnService = VPNService();
  bool isConnected = false;
  bool isConnecting = false;
  String selectedServer = 'United States';
  String connectionTime = '00:00:00';
  int downloadSpeed = 0;
  int uploadSpeed = 0;
  Timer? _statsTimer;
  Timer? _connectionTimer;
  int _connectionSeconds = 0;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _statsTimer?.cancel();
    _connectionTimer?.cancel();
    _pulseController.dispose();
    super.dispose();
  }

  void _toggleVPN() async {
    if (isConnecting) return;

    setState(() {
      isConnecting = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      isConnected = !isConnected;
      isConnecting = false;
    });

    if (isConnected) {
      _startMonitoring();
    } else {
      _stopMonitoring();
    }
  }

  void _startMonitoring() {
    _connectionSeconds = 0;
    _connectionTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _connectionSeconds++;
        connectionTime = _formatDuration(_connectionSeconds);
      });
    });

    _statsTimer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        downloadSpeed = 500 + (DateTime.now().millisecond % 1000);
        uploadSpeed = 200 + (DateTime.now().millisecond % 500);
      });
    });
  }

  void _stopMonitoring() {
    _statsTimer?.cancel();
    _connectionTimer?.cancel();
    setState(() {
      connectionTime = '00:00:00';
      downloadSpeed = 0;
      uploadSpeed = 0;
      _connectionSeconds = 0;
    });
  }

  String _formatDuration(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8EEF2),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF2C3E50),
        title: const Text(
          'Obscurra',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.2,
          ),
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white, size: 28),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/about'),
            icon: const Icon(Icons.info_outline, color: Colors.white),
          ),
        ],
      ),
      drawer: _buildDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 30),
            ConnectionStatus(
              isConnected: isConnected,
              isConnecting: isConnecting,
            ),
            const SizedBox(height: 40),
            VPNButton(
              isConnected: isConnected,
              isConnecting: isConnecting,
              onPressed: _toggleVPN,
              pulseController: _pulseController,
            ),
            const SizedBox(height: 40),
            _buildServerCard(),
            const SizedBox(height: 20),
            if (isConnected) ...[
              StatsCard(
                connectionTime: connectionTime,
                downloadSpeed: downloadSpeed,
                uploadSpeed: uploadSpeed,
              ),
            ],
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildServerCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(16),
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
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, '/servers'),
        borderRadius: BorderRadius.circular(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF34495E).withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.public,
                color: Color(0xFF34495E),
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Selected Server',
                    style: TextStyle(
                      color: Color(0xFF7F8C8D),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    selectedServer,
                    style: const TextStyle(
                      color: Color(0xFF2C3E50),
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(0xFF95A5A6),
              size: 18,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      backgroundColor: const Color(0xFFF8FAFB),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF2C3E50), Color(0xFF34495E)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.shield,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 12),
                const Text(
                  'Obscurra VPN',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'Secure & Private',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          _buildDrawerItem(Icons.home, 'Home', '/'),
          _buildDrawerItem(Icons.dns, 'Servers', '/servers'),
          _buildDrawerItem(Icons.settings, 'Settings', '/settings'),
          _buildDrawerItem(Icons.info, 'About', '/about'),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF34495E)),
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF2C3E50),
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        if (ModalRoute.of(context)?.settings.name != route) {
          Navigator.pushNamed(context, route);
        }
      },
    );
  }
}
