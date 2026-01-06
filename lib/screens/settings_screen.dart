import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool autoConnect = false;
  bool killSwitch = true;
  bool splitTunneling = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE8EEF2),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFF2C3E50),
        title: const Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSection(
            title: 'Connection',
            children: [
              _buildSwitchTile(
                title: 'Auto-Connect',
                subtitle: 'Connect automatically on app launch',
                value: autoConnect,
                onChanged: (val) => setState(() => autoConnect = val),
              ),
              _buildSwitchTile(
                title: 'Kill Switch',
                subtitle: 'Block internet if VPN disconnects',
                value: killSwitch,
                onChanged: (val) => setState(() => killSwitch = val),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSection(
            title: 'Advanced',
            children: [
              _buildSwitchTile(
                title: 'Split Tunneling',
                subtitle: 'Choose apps to bypass VPN',
                value: splitTunneling,
                onChanged: (val) => setState(() => splitTunneling = val),
              ),
              _buildListTile(
                title: 'Protocol',
                subtitle: 'WireGuard',
                trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSection({required String title, required List<Widget> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            title,
            style: const TextStyle(
              color: Color(0xFF7F8C8D),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Container(
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
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return SwitchListTile(
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF2C3E50),
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: Color(0xFF7F8C8D),
          fontSize: 12,
        ),
      ),
      value: value,
      onChanged: onChanged,
      activeColor: const Color(0xFF27AE60),
    );
  }

  Widget _buildListTile({
    required String title,
    required String subtitle,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF2C3E50),
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: Color(0xFF7F8C8D),
          fontSize: 12,
        ),
      ),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
