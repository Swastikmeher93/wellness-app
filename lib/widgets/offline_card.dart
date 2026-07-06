import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OfflineCard extends StatelessWidget {
  const OfflineCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFF9F9F9), // Light background color from the design
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE5E5E5), // Thin gray bottom border
            width: 1.0,
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Circular grey icon container
              Container(
                width: 24,
                height: 24,
                margin: const EdgeInsets.only(top: 2.0), // Align slightly with first line of text
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFD6D6D6), // Grey circle background
                ),
                child: const Icon(
                  Icons.lock_rounded,
                  size: 13,
                  color: Color(0xFF4A4A4A), // Dark grey padlock icon
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "You're offline.",
                      style: GoogleFonts.workSans(
                        color: const Color(0xFF1E1E1E),
                        fontWeight: FontWeight.w500,
                        fontSize: 14.5,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Showing what we already have. New things will appear when you're back.",
                      style: GoogleFonts.workSans(
                        color: const Color(0xFF6B6B6B),
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        height: 1.35,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
