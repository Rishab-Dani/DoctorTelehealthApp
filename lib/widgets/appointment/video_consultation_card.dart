import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class VideoConsultationCard extends StatelessWidget {
  final VoidCallback onStartCall;

  const VideoConsultationCard({
    super.key,
    required this.onStartCall,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha:.05),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [

          Container(
            height: 74,
            width: 74,
            decoration: BoxDecoration(
              color: Colors.green.withValues(alpha:.12),
              borderRadius: BorderRadius.circular(22),
            ),
            child: const Icon(
              Icons.video_camera_front_rounded,
              size: 40,
              color: Colors.green,
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            "Video Consultation",
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            "Connect securely with your patient using an HD video consultation.",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton.icon(
              onPressed: onStartCall,
              icon: const Icon(Icons.videocam_rounded),
              label: const Text(
                "Start Video Call",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),

          const SizedBox(height: 14),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [

              Icon(
                Icons.lock_outline,
                size: 16,
                color: Colors.grey,
              ),

              SizedBox(width: 6),

              Text(
                "Secure End-to-End Connection",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),

            ],
          ),
        ],
      ),
    );
  }
}