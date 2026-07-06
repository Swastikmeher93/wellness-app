import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Section label ─────────────────────────────────────────────
        Text(
          'FROM YOUR COMMUNITY',
          style: GoogleFonts.newsreader(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Colors.black45,
            letterSpacing: 1.2,
            height: 1.0,
          ),
        ),
        const SizedBox(height: 10),

        // ── Card ──────────────────────────────────────────────────────
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F5F5),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar
              Container(
                width: 36,
                height: 36,
                decoration: const BoxDecoration(color: Colors.black),
                child: const Center(
                  child: Text(
                    'M',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      'Marcus asked a question.',
                      style: GoogleFonts.newsreader(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // Quote
                    Text(
                      '"Slept through tonight\'s feed. Felt like winning."',
                      style: GoogleFonts.newsreader(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 8),

                    // Meta
                    Text(
                      '2 dads · 35 minutes ago',
                      style: GoogleFonts.newsreader(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: Colors.black45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
