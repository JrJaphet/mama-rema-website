import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MamaRemaApp());
}

const whatsappNumber = '+27774443166';
const whatsappUrl = 'https://wa.me/27774443166';
const facebookUrl = 'https://www.facebook.com/';
const tiktokUrl = 'https://www.tiktok.com/';

class MamaRemaApp extends StatelessWidget {
  const MamaRemaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mama Rema | Traditional Healer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF120C08),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD29B55),
          brightness: Brightness.dark,
        ),
        fontFamily: 'Georgia',
      ),
      initialRoute: '/',
      routes: {
        '/': (_) => const HomePage(),
        '/about': (_) => const AboutPage(),
        '/services': (_) => const ServicesPage(),
        '/contact': (_) => const ContactPage(),
      },
    );
  }
}

Future<void> openUrl(String value) async {
  final uri = Uri.parse(value);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class SiteShell extends StatelessWidget {
  final Widget child;
  final String current;

  const SiteShell({
    super.key,
    required this.child,
    required this.current,
  });

  void navigate(BuildContext context, String route) {
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const SpiritualBackdrop(),
          SafeArea(
            child: Column(
              children: [
                _Header(current: current, navigate: navigate),
                Expanded(
                  child: SingleChildScrollView(
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: const Color(0xFF25D366),
        foregroundColor: Colors.white,
        onPressed: () => openUrl(whatsappUrl),
        icon: const Icon(Icons.chat_rounded),
        label: const Text('WhatsApp Mama Rema'),
      ),
    );
  }
}

class SpiritualBackdrop extends StatelessWidget {
  const SpiritualBackdrop({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF0D0805),
                Color(0xFF25150D),
                Color(0xFF3A2112),
                Color(0xFF120B07),
              ],
            ),
          ),
        ),
        Positioned(
          top: -120,
          right: -80,
          child: _Glow(size: 330, color: const Color(0xFF9D6B32)),
        ),
        Positioned(
          top: 300,
          left: -160,
          child: _Glow(size: 380, color: const Color(0xFF6B4021)),
        ),
        Positioned(
          bottom: -180,
          right: 20,
          child: _Glow(size: 420, color: const Color(0xFF4A2A16)),
        ),
      ],
    );
  }
}

class _Glow extends StatelessWidget {
  final double size;
  final Color color;

  const _Glow({required this.size, required this.color});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color.withOpacity(.12),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(.18),
              blurRadius: 100,
              spreadRadius: 30,
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String current;
  final void Function(BuildContext, String) navigate;

  const _Header({required this.current, required this.navigate});

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width >= 800;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: wide ? 48 : 20,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.32),
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(.08)),
        ),
      ),
      child: Row(
        children: [
          const _Brand(),
          const Spacer(),
          if (wide)
            Row(
              children: [
                _NavItem('Home', '/', current, navigate),
                _NavItem('About Us', '/about', current, navigate),
                _NavItem('Services', '/services', current, navigate),
                _NavItem('Contact', '/contact', current, navigate),
                const SizedBox(width: 12),
                _SocialIcon(Icons.facebook, facebookUrl),
                _SocialIcon(Icons.music_note_rounded, tiktokUrl),
              ],
            )
          else
            PopupMenuButton<String>(
              icon: const Icon(Icons.menu_rounded),
              onSelected: (route) => navigate(context, route),
              itemBuilder: (_) => const [
                PopupMenuItem(value: '/', child: Text('Home')),
                PopupMenuItem(value: '/about', child: Text('About Us')),
                PopupMenuItem(value: '/services', child: Text('Services')),
                PopupMenuItem(value: '/contact', child: Text('Contact')),
              ],
            ),
        ],
      ),
    );
  }
}

class _Brand extends StatelessWidget {
  const _Brand();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushReplacementNamed(context, '/'),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFFE0AE68), Color(0xFF805020)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFD29B55).withOpacity(.25),
                  blurRadius: 18,
                ),
              ],
            ),
            child: const Icon(Icons.auto_awesome, color: Colors.white),
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MAMA REMA',
                style: TextStyle(
                  letterSpacing: 2.3,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Traditional Healer',
                style: TextStyle(
                  color: Color(0xFFD7B27A),
                  fontSize: 11,
                  letterSpacing: 1.1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String label;
  final String route;
  final String current;
  final void Function(BuildContext, String) navigate;

  const _NavItem(this.label, this.route, this.current, this.navigate);

  @override
  Widget build(BuildContext context) {
    final active = current == route;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: TextButton(
        onPressed: () => navigate(context, route),
        child: Text(
          label,
          style: TextStyle(
            color: active ? const Color(0xFFE2B775) : Colors.white70,
            fontWeight: active ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }
}

class _SocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;

  const _SocialIcon(this.icon, this.url);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => openUrl(url),
      icon: Icon(icon, size: 20),
      tooltip: 'Social media',
    );
  }
}

class PageIntro extends StatelessWidget {
  final String eyebrow;
  final String title;
  final String description;

  const PageIntro({
    super.key,
    required this.eyebrow,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 54, 20, 38),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 920),
          child: Column(
            children: [
              Text(
                eyebrow.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFFD9A866),
                  fontSize: 12,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width >= 700 ? 48 : 34,
                  fontWeight: FontWeight.w700,
                  height: 1.05,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                  height: 1.7,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(24),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(.055),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(.10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.22),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: child,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final wide = MediaQuery.of(context).size.width >= 850;

    return SiteShell(
      current: '/',
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: wide ? 70 : 20,
              vertical: wide ? 80 : 50,
            ),
            child: wide
                ? Row(
                    children: const [
                      Expanded(flex: 6, child: _HeroText()),
                      SizedBox(width: 50),
                      Expanded(flex: 4, child: _SpiritualVisual()),
                    ],
                  )
                : const Column(
                    children: [
                      _HeroText(),
                      SizedBox(height: 40),
                      _SpiritualVisual(),
                    ],
                  ),
          ),
          const _TrustStrip(),
          const SizedBox(height: 55),
          const _HomeServicesPreview(),
          const SizedBox(height: 55),
          const _LocationSection(),
          const SizedBox(height: 45),
          const _Footer(),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

class _HeroText extends StatelessWidget {
  const _HeroText();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'TRADITIONAL WISDOM • SPIRITUAL GUIDANCE • PERSONAL GROWTH',
          style: TextStyle(
            color: Color(0xFFD8A25D),
            letterSpacing: 2.2,
            fontSize: 11,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 18),
        Text(
          'Find clarity.\nReconnect with your path.',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width >= 850 ? 62 : 43,
            fontWeight: FontWeight.w800,
            height: 1.02,
            letterSpacing: -1,
          ),
        ),
        const SizedBox(height: 22),
        const Text(
          'Welcome to Mama Rema, an experienced traditional healer offering spiritual guidance and traditional healing services with 20 years of experience.',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 17,
            height: 1.7,
          ),
        ),
        const SizedBox(height: 28),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            FilledButton.icon(
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFFB57A3B),
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 17,
                ),
              ),
              onPressed: () => Navigator.pushNamed(context, '/services'),
              icon: const Icon(Icons.auto_awesome),
              label: const Text('Explore Services'),
            ),
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFD2A361)),
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 17,
                ),
              ),
              onPressed: () => openUrl(whatsappUrl),
              icon: const Icon(Icons.chat_rounded),
              label: const Text('Book via WhatsApp'),
            ),
          ],
        ),
        const SizedBox(height: 28),
        const Row(
          children: [
            Icon(Icons.access_time_rounded, color: Color(0xFFD6A15F), size: 19),
            SizedBox(width: 8),
            Flexible(
              child: Text(
                'Open Monday – Sunday • 08:00 AM – 05:00 PM',
                style: TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _SpiritualVisual extends StatelessWidget {
  const _SpiritualVisual();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 430,
      constraints: const BoxConstraints(maxWidth: 440),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF3B2415), Color(0xFF130B07)],
        ),
        border: Border.all(color: const Color(0xFFD19A55).withOpacity(.28)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD19A55).withOpacity(.10),
            blurRadius: 60,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 30,
            right: 25,
            child: _Smoke(size: 120),
          ),
          Positioned(
            top: 90,
            left: 25,
            child: _Smoke(size: 90),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.local_fire_department_rounded,
                size: 82,
                color: Color(0xFFE5A64D),
              ),
              const SizedBox(height: 12),
              Container(
                width: 160,
                height: 105,
                decoration: BoxDecoration(
                  color: const Color(0xFF5B351E),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(55),
                    bottom: Radius.circular(28),
                  ),
                  border: Border.all(color: const Color(0xFFC88C4C)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.45),
                      blurRadius: 22,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.spa_rounded,
                  color: Color(0xFFE0B376),
                  size: 48,
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'MAMA REMA',
                style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(height: 7),
              const Text(
                '20 YEARS OF EXPERIENCE',
                style: TextStyle(
                  color: Color(0xFFD9A866),
                  letterSpacing: 2,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Smoke extends StatelessWidget {
  final double size;
  const _Smoke({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white.withOpacity(.025),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(.06),
            blurRadius: 40,
            spreadRadius: 20,
          ),
        ],
      ),
    );
  }
}

class _TrustStrip extends StatelessWidget {
  const _TrustStrip();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      color: Colors.black.withOpacity(.22),
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: 35,
        runSpacing: 18,
        children: const [
          _TrustItem(Icons.verified_user_outlined, '20 Years Experience'),
          _TrustItem(Icons.location_on_outlined, 'Vanderbijlpark • Vaal'),
          _TrustItem(Icons.schedule_rounded, 'Open 7 Days'),
          _TrustItem(Icons.chat_bubble_outline_rounded, 'WhatsApp Consultations'),
        ],
      ),
    );
  }
}

class _TrustItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _TrustItem(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 19, color: const Color(0xFFD8A25D)),
        const SizedBox(width: 8),
        Text(text, style: const TextStyle(color: Colors.white70)),
      ],
    );
  }
}

class _HomeServicesPreview extends StatelessWidget {
  const _HomeServicesPreview();

  @override
  Widget build(BuildContext context) {
    final services = [
      ('Love & Relationships', Icons.favorite_border_rounded),
      ('Spiritual Healing', Icons.self_improvement_rounded),
      ('Protection Rituals', Icons.shield_outlined),
      ('Prosperity & Success', Icons.auto_graph_rounded),
      ('Ancestral Consultation', Icons.account_tree_outlined),
      ('Readings & Guidance', Icons.style_outlined),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1120),
        child: Column(
          children: [
            const Text(
              'GUIDANCE FOR LIFE’S MANY PATHS',
              style: TextStyle(
                color: Color(0xFFD9A866),
                letterSpacing: 2.5,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'How We Can Support You',
              style: TextStyle(fontSize: 37, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 14),
            const Text(
              'We offer a range of traditional and spiritual guidance services tailored to individual concerns and personal goals.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white60, height: 1.6),
            ),
            const SizedBox(height: 28),
            LayoutBuilder(
              builder: (context, constraints) {
                final columns = constraints.maxWidth > 900
                    ? 3
                    : constraints.maxWidth > 560
                        ? 2
                        : 1;
                final width =
                    (constraints.maxWidth - (columns - 1) * 16) / columns;
                return Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: services
                      .map(
                        (s) => SizedBox(
                          width: width,
                          child: GlassCard(
                            child: Row(
                              children: [
                                Icon(
                                  s.$2,
                                  color: const Color(0xFFD9A866),
                                  size: 28,
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Text(
                                    s.$1,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                );
              },
            ),
            const SizedBox(height: 28),
            TextButton.icon(
              onPressed: () => Navigator.pushNamed(context, '/services'),
              icon: const Icon(Icons.arrow_forward_rounded),
              label: const Text('View all services'),
            ),
          ],
        ),
      ),
    );
  }
}

class _LocationSection extends StatelessWidget {
  const _LocationSection();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1120),
        child: GlassCard(
          padding: const EdgeInsets.all(32),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth > 700;
              final content = [
                const Icon(
                  Icons.location_on_rounded,
                  color: Color(0xFFD7A15E),
                  size: 40,
                ),
                const SizedBox(width: 18, height: 18),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Serving the Vaal & Gauteng',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Mama Rema is based in Vanderbijlpark and serves people across Gauteng, including Vereeniging and Sasolburg. If you are visiting from another province, you can arrange to meet Mama Rema in Vanderbijlpark.',
                        style: TextStyle(
                          color: Colors.white70,
                          height: 1.7,
                        ),
                      ),
                    ],
                  ),
                ),
              ];
              return wide
                  ? Row(children: content)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: content,
                    );
            },
          ),
        ),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteShell(
      current: '/about',
      child: Column(
        children: [
          const PageIntro(
            eyebrow: 'About Mama Rema',
            title: 'Traditional wisdom, personal guidance.',
            description:
                'Mama Rema is an experienced traditional healer with 20 years of experience, offering a welcoming space for people seeking spiritual guidance, traditional practices and personal clarity.',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: Column(
                children: [
                  GlassCard(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final wide = constraints.maxWidth > 700;
                        final text = Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              'A compassionate approach',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 14),
                            Text(
                              'Every person arrives with a different story. Mama Rema provides a private, respectful environment where clients can discuss matters involving relationships, family, personal growth, business direction and spiritual concerns.',
                              style: TextStyle(
                                color: Colors.white70,
                                height: 1.8,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 18),
                            Text(
                              'Consultations are intended as traditional and spiritual guidance. Results can vary from person to person, and no particular outcome is guaranteed.',
                              style: TextStyle(
                                color: Color(0xFFD8A25D),
                                height: 1.6,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        );
                        return wide
                            ? Row(
                                children: [
                                  const Expanded(child: _AboutVisual()),
                                  const SizedBox(width: 35),
                                  Expanded(child: text),
                                ],
                              )
                            : Column(
                                children: [
                                  const _AboutVisual(),
                                  const SizedBox(height: 30),
                                  text,
                                ],
                              );
                      },
                    ),
                  ),
                  const SizedBox(height: 25),
                  const GlassCard(
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time_filled_rounded,
                          color: Color(0xFFD8A25D),
                          size: 30,
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            'Working hours: Monday to Sunday, 08:00 AM – 05:00 PM.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 80),
          const _Footer(),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

class _AboutVisual extends StatelessWidget {
  const _AboutVisual();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 330,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF5A351D), Color(0xFF17100B)],
        ),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.spa_rounded, size: 70, color: Color(0xFFD8A25D)),
            SizedBox(height: 18),
            Text(
              '20',
              style: TextStyle(fontSize: 58, fontWeight: FontWeight.bold),
            ),
            Text(
              'YEARS OF EXPERIENCE',
              style: TextStyle(
                color: Color(0xFFD8A25D),
                letterSpacing: 2,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      ('Love & Relationship', 'Guidance for love, emotional connections and relationship concerns.', Icons.favorite_border_rounded),
      ('Marriage & Family Matters', 'Marriage blessings, family harmony and guidance through family concerns.', Icons.home_outlined),
      ('Spiritual Healing', 'Traditional spiritual support for people seeking a deeper sense of balance and direction.', Icons.self_improvement_rounded),
      ('Protection Rituals', 'Traditional protection-focused rituals and spiritual support.', Icons.shield_outlined),
      ('Prosperity & Success Blessings', 'Traditional blessings focused on prosperity, opportunity and personal goals.', Icons.auto_graph_rounded),
      ('Business Guidance', 'Spiritual and traditional guidance for business direction and decision-making.', Icons.business_center_outlined),
      ('Traditional Healer Support', 'Support for people seeking traditional healing practices and guidance.', Icons.spa_outlined),
      ('Ancestral Consultation', 'Traditional consultation around ancestral questions and personal spiritual concerns.', Icons.account_tree_outlined),
      ('Good Luck Guidance', 'Traditional guidance for people seeking encouragement around important life goals.', Icons.stars_outlined),
      ('Personal Spiritual Growth', 'Support for reflection, spiritual development and personal clarity.', Icons.self_improvement_outlined),
      ('Bring Back Lost Love', 'Traditional relationship-focused consultation for people dealing with separation or lost connections.', Icons.favorite_rounded),
      ('Removing Relationship Obstacles', 'Guidance for relationship difficulties, communication concerns and perceived obstacles.', Icons.link_off_rounded),
      ('Witchcraft & Dark Spiritual Curse Concerns', 'Traditional spiritual consultation for people who believe they are experiencing curses or negative spiritual influences.', Icons.nights_stay_outlined),
      ('Life Clarity & Guidance', 'A private consultation to help you reflect on personal questions and possible paths forward.', Icons.lightbulb_outline_rounded),
      ('Psychic & Card Readings', 'Intuitive and card-reading sessions for reflection, questions and spiritual guidance.', Icons.style_outlined),
      ('Strengthening Emotional Connections', 'Traditional guidance focused on emotional connection, understanding and relationship support.', Icons.handshake_outlined),
    ];

    return SiteShell(
      current: '/services',
      child: Column(
        children: [
          const PageIntro(
            eyebrow: 'Why Our Services',
            title: 'Great services for life’s important questions.',
            description:
                'We offer great services designed around love, family, spiritual concerns, personal growth, prosperity, business guidance and traditional consultation.',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1120),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final columns = constraints.maxWidth > 900
                      ? 3
                      : constraints.maxWidth > 600
                          ? 2
                          : 1;
                  final width =
                      (constraints.maxWidth - (columns - 1) * 18) / columns;
                  return Wrap(
                    spacing: 18,
                    runSpacing: 18,
                    children: services.map((s) {
                      return SizedBox(
                        width: width,
                        child: GlassCard(
                          padding: const EdgeInsets.all(22),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD29B55).withOpacity(.10),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Icon(
                                  s.$3,
                                  color: const Color(0xFFD9A866),
                                ),
                              ),
                              const SizedBox(height: 17),
                              Text(
                                s.$1,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 9),
                              Text(
                                s.$2,
                                style: const TextStyle(
                                  color: Colors.white60,
                                  height: 1.65,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 30),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              'Important: These services are presented as traditional/spiritual guidance. They are not a substitute for professional medical, legal or financial advice, and outcomes are not guaranteed.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white38, fontSize: 12, height: 1.6),
            ),
          ),
          const SizedBox(height: 60),
          const _Footer(),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SiteShell(
      current: '/contact',
      child: Column(
        children: [
          const PageIntro(
            eyebrow: 'Contact Mama Rema',
            title: 'Ready to arrange a consultation?',
            description:
                'Send a WhatsApp message to enquire about services, availability and arranging a meeting in Vanderbijlpark.',
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1000),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final wide = constraints.maxWidth > 720;
                  final info = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Get in touch',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 18),
                      const _ContactRow(
                        Icons.chat_rounded,
                        'WhatsApp',
                        whatsappNumber,
                      ),
                      const SizedBox(height: 16),
                      const _ContactRow(
                        Icons.location_on_outlined,
                        'Location',
                        'Vanderbijlpark, Vaal, Gauteng',
                      ),
                      const SizedBox(height: 16),
                      const _ContactRow(
                        Icons.schedule_rounded,
                        'Hours',
                        'Monday – Sunday • 08:00 AM – 05:00 PM',
                      ),
                      const SizedBox(height: 28),
                      FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF25D366),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 17,
                          ),
                        ),
                        onPressed: () => openUrl(whatsappUrl),
                        icon: const Icon(Icons.chat),
                        label: const Text('Message on WhatsApp'),
                      ),
                    ],
                  );

                  final social = GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Follow Mama Rema',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Connect on social media for updates and spiritual guidance content.',
                          style: TextStyle(color: Colors.white60, height: 1.6),
                        ),
                        const SizedBox(height: 20),
                        _SocialButton(
                          icon: Icons.facebook,
                          label: 'Facebook',
                          onPressed: () => openUrl(facebookUrl),
                        ),
                        const SizedBox(height: 10),
                        _SocialButton(
                          icon: Icons.music_note_rounded,
                          label: 'TikTok',
                          onPressed: () => openUrl(tiktokUrl),
                        ),
                      ],
                    ),
                  );

                  return wide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: GlassCard(child: info)),
                            const SizedBox(width: 20),
                            Expanded(child: social),
                          ],
                        )
                      : Column(
                          children: [
                            GlassCard(child: info),
                            const SizedBox(height: 20),
                            social,
                          ],
                        );
                },
              ),
            ),
          ),
          const SizedBox(height: 70),
          const _Footer(),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ContactRow(this.icon, this.title, this.value);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: const Color(0xFFD9A866), size: 22),
        const SizedBox(width: 13),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(color: Colors.white60)),
            ],
          ),
        ),
      ],
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;

  const _SocialButton({
    required this.icon,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        alignment: Alignment.centerLeft,
      ),
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 35, 20, 25),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.30),
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(.08)),
        ),
      ),
      child: Column(
        children: [
          const Text(
            'MAMA REMA',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 3,
              fontSize: 17,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Traditional healing • Spiritual guidance • Personal growth',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white54, fontSize: 12),
          ),
          const SizedBox(height: 18),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 8,
            children: [
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/about'),
                child: const Text('About'),
              ),
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/services'),
                child: const Text('Services'),
              ),
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(context, '/contact'),
                child: const Text('Contact'),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Text(
            '© 2026 Mama Rema. All rights reserved.',
            style: TextStyle(color: Colors.white30, fontSize: 11),
          ),
        ],
      ),
    );
  }
}
