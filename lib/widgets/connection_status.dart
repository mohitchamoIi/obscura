import 'package:flutter/material.dart';

class ConnectionStatus extends StatelessWidget {
  final bool isConnected;
  final bool isConnecting;

  const ConnectionStatus({
    super.key,
    required this.isConnected,
    required this.isConnecting,
  });

  @override
  Widget build(BuildContext context) {
    String statusText;
    Color statusColor;

    if (isConnecting) {
      statusText = 'Connecting...';
      statusColor = const Color(0xFFF39C12);
    } else if (isConnected) {
      statusText = 'Connected';
      statusColor = const Color(0xFF27AE60);
    } else {
      statusText = 'Disconnected';
      statusColor = const Color(0xFF95A5A6);
    }

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: statusColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                statusText,
                style: TextStyle(
                  color: statusColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          isConnected ? 'Your connection is secure' : 'Tap to connect',
          style: TextStyle(
            color: const Color(0xFF7F8C8D),
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
