import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ComingSoonScreen extends StatefulWidget {
  const ComingSoonScreen({super.key});

  @override
  State<ComingSoonScreen> createState() => _ComingSoonScreenState();
}

class _ComingSoonScreenState extends State<ComingSoonScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: _fade,
        child: SlideTransition(
          position: _slide,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'coming soon.',
                style: GoogleFonts.newsreader(
                  fontSize: 36,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'something good is on the way.',
                style: GoogleFonts.caveat(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black45,
                  height: 1.1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
