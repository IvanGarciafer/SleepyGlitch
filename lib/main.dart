import 'package:flutter/material.dart';

import 'sections/about_section.dart';
import 'sections/contact_section.dart';
import 'sections/docs_section.dart';
import 'sections/events_section.dart';
import 'sections/footer.dart';
import 'sections/gallery_section.dart';
import 'sections/game_section.dart';
import 'sections/hero_section.dart';
import 'theme/app_theme.dart';
import 'widgets/nav_bar.dart';

void main() => runApp(const SleepyGlitchApp());

class SleepyGlitchApp extends StatelessWidget {
  const SleepyGlitchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sleepy Glitch · Estudio indie',
      debugShowCheckedModeBanner: false,
      theme: buildTheme(),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scroll = ScrollController();
  late final List<NavItem> _items = [
    NavItem('Inicio', GlobalKey()),
    NavItem('El juego', GlobalKey()),
    NavItem('Galería', GlobalKey()),
    NavItem('Desarrollo', GlobalKey()),
    NavItem('Estudio', GlobalKey()),
    NavItem('Eventos', GlobalKey()),
    NavItem('Contacto', GlobalKey()),
  ];
  int _active = 0;
  bool _scrolled = false;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _onScroll() {
    final scrolled = _scroll.offset > 24;
    var active = 0;
    for (var i = 0; i < _items.length; i++) {
      final ctx = _items[i].key.currentContext;
      if (ctx == null) continue;
      final box = ctx.findRenderObject() as RenderBox?;
      if (box == null || !box.attached) continue;
      final top = box.localToGlobal(Offset.zero).dy;
      if (top <= 160) active = i;
    }
    // Al llegar al final, marca la última sección.
    if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 4) {
      active = _items.length - 1;
    }
    if (active != _active || scrolled != _scrolled) {
      setState(() {
        _active = active;
        _scrolled = scrolled;
      });
    }
  }

  void _goTo(int i) {
    final ctx = _items[i].key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 650),
      curve: Curves.easeInOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final k = _items.map((e) => e.key).toList();
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: SGNavBar(
        items: _items,
        active: _active,
        onTap: _goTo,
        scrolled: _scrolled,
      ),
      endDrawer: SGDrawer(items: _items, active: _active, onTap: _goTo),
      body: SingleChildScrollView(
        controller: _scroll,
        child: Column(
          children: [
            HeroSection(
              key: k[0],
              onTrailer: () => _goTo(1),
              onDocs: () => _goTo(3),
            ),
            GameSection(key: k[1]),
            GallerySection(key: k[2]),
            DocsSection(key: k[3]),
            AboutSection(key: k[4]),
            EventsSection(key: k[5]),
            ContactSection(key: k[6]),
            Footer(onNavigate: _goTo, items: _items),
          ],
        ),
      ),
    );
  }
}
