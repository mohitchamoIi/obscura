import 'package:flutter/material.dart';

class VPNButton extends StatelessWidget {
  final bool isConnected;
  final bool isConnecting;
  final VoidCallback onPressed;
  final AnimationController pulseController;

  const VPNButton({
    super.key,
    required this.isConnected,
    required this.isConnecting,
    required this.onPressed,
    required this.pulseController,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (isConnected)
            AnimatedBuilder(
              animation: pulseController,
              builder: (context, child) {
                return Container(
                  width: 200 + (pulseController.value * 20),
                  height: 200 + (pulseController.value * 20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF27AE60).withOpacity(0.1 - (pulseController.value * 0.1)),
                  ),
                );
              },
            ),
          Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: isConnected
                    ? [const Color(0xFF27AE60), const Color(0xFF2ECC71)]
                    : [const Color(0xFF34495E), const Color(0xFF2C3E50)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: (isConnected ? const Color(0xFF27AE60) : const Color(0xFF34495E))
                      .withOpacity(0.4),
                  blurRadius: 20,
                  spreadRadius: 5,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: isConnecting
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  )
                : Icon(
                    isConnected ? Icons.power_settings_new : Icons.power_settings_new,
                    size: 80,
                    color: Colors.white,
                  ),
          ),
        ],
      ),
    );
  }
}
