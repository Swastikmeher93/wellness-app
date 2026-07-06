import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellness_app/model/guide_model.dart';

class GuideCard extends StatelessWidget {
  final GuideModel guide;

  const GuideCard({super.key, required this.guide});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: navigate to guide detail
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: SizedBox(
          width: double.infinity,
          height: 240,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // ── Background image ──────────────────────────────────────
              CachedNetworkImage(
                imageUrl: guide.imageUrl,
                fit: BoxFit.cover,
                placeholder: (_, _) => const ColoredBox(color: Color(0xFFE0E0E0)),
                errorWidget: (_, _, _) =>
                    const ColoredBox(color: Color(0xFFBDBDBD)),
              ),

              // ── Bottom gradient scrim ─────────────────────────────────
              Positioned.fill(
                child: DecoratedBox(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.3, 1.0],
                      colors: [Colors.transparent, Color(0xCC000000)],
                    ),
                  ),
                ),
              ),

              // ── Badge (always shown) ──────────────────────────────
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: Text(
                    guide.isPaid ? 'Paid Guide' : 'Free',
                    style: GoogleFonts.newsreader(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),

              // ── Title at bottom ───────────────────────────────────────
              Positioned(
                left: 14,
                right: 14,
                bottom: 16,
                child: Text(
                  guide.title,
                  style: GoogleFonts.newsreader(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                    height: 1.25,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
