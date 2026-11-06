import 'package:flutter/material.dart';

void main() {
  runApp(const NaijaLinkApp());
}

class NaijaLinkApp extends StatelessWidget {
  const NaijaLinkApp({super.key});

  static const green = Color(0xFF138A45);
  static const orange = Color(0xFFF28C28);
  static const ink = Color(0xFF183328);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NaijaLink',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF7F9F7),
        colorScheme: ColorScheme.fromSeed(
          seedColor: green,
          primary: green,
          secondary: orange,
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFF7F9F7),
          foregroundColor: ink,
          surfaceTintColor: Colors.transparent,
        ),
        fontFamily: 'Roboto',
      ),
      home: const MarketplaceShell(),
    );
  }
}

class MarketplaceShell extends StatefulWidget {
  const MarketplaceShell({super.key});

  @override
  State<MarketplaceShell> createState() => _MarketplaceShellState();
}

class _MarketplaceShellState extends State<MarketplaceShell> {
  int _tab = 0;
  String _role = 'Buyer';

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(role: _role),
      const ExplorePage(),
      const DeliveriesPage(),
      ProfilePage(
        role: _role,
        onRoleChanged: (role) => setState(() => _role = role),
      ),
    ];

    return Scaffold(
      body: SafeArea(child: IndexedStack(index: _tab, children: pages)),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _tab,
        onDestinationSelected: (index) => setState(() => _tab = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Explore'),
          NavigationDestination(icon: Icon(Icons.local_shipping_outlined), selectedIcon: Icon(Icons.local_shipping), label: 'Deliveries'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.role});
  final String role;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Row(
                children: [
                  const BrandMark(size: 44),
                  const SizedBox(width: 10),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('NaijaLink', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: NaijaLinkApp.ink)),
                        Text('Your city, your link', style: TextStyle(fontSize: 12, color: Colors.black54)),
                      ],
                    ),
                  ),
                  IconButton.filledTonal(
                    tooltip: 'Notifications',
                    onPressed: () => _notice(context, 'Notifications will appear here.'),
                    icon: const Icon(Icons.notifications_none),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: NaijaLinkApp.green,
                  borderRadius: BorderRadius.circular(22),
                  gradient: const LinearGradient(colors: [NaijaLinkApp.green, Color(0xFF0D6B35)], begin: Alignment.topLeft, end: Alignment.bottomRight),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Good day, $role 👋', style: const TextStyle(color: Colors.white70, fontSize: 14)),
                    const SizedBox(height: 5),
                    const Text('What are you looking for?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 21)),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () => _notice(context, 'Search is a demo. Catalog browsing will be connected next.'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(13)),
                        child: const Row(children: [Icon(Icons.search, color: NaijaLinkApp.green), SizedBox(width: 9), Text('Search products or sellers', style: TextStyle(color: Colors.black54)), Spacer(), Icon(Icons.tune, color: NaijaLinkApp.green)]),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const SectionTitle('Delivery options'), Text('IBADAN', style: TextStyle(color: NaijaLinkApp.green, fontWeight: FontWeight.w800, letterSpacing: 1))],
              ),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(child: _DeliveryOption(icon: Icons.flash_on_rounded, title: 'Local delivery', subtitle: 'Around Ibadan', color: NaijaLinkApp.green, onTap: () => _notice(context, 'Local delivery selected. Live rider matching will be added next.'))),
                const SizedBox(width: 12),
                Expanded(child: _DeliveryOption(icon: Icons.directions_bus_filled, title: 'Inter-state', subtitle: 'Choose a park', color: NaijaLinkApp.orange, onTap: () => _notice(context, 'Inter-state delivery: choose a destination state and approved park.'))),
              ]),
              const SizedBox(height: 23),
              const SectionTitle('Shop by category'),
              const SizedBox(height: 12),
              const Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [CategoryChip(icon: Icons.restaurant, label: 'Food'), CategoryChip(icon: Icons.checkroom, label: 'Fashion'), CategoryChip(icon: Icons.medical_services_outlined, label: 'Health'), CategoryChip(icon: Icons.menu_book, label: 'Books')]),
              const SizedBox(height: 24),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const SectionTitle('Popular near you'), TextButton(onPressed: () => _notice(context, 'Explore the full catalog.'), child: const Text('See all'))]),
              const SizedBox(height: 5),
              SizedBox(
                height: 224,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    ProductCard(icon: Icons.lunch_dining, title: 'Local lunch pack', seller: 'Mariam’s Kitchen', price: '₦3,500', color: Color(0xFFFFE9CF)),
                    ProductCard(icon: Icons.shopping_bag_outlined, title: 'Everyday tote bag', seller: 'Bodija Finds', price: '₦8,000', color: Color(0xFFE0F0E6)),
                    ProductCard(icon: Icons.menu_book, title: 'Study essentials', seller: 'Campus Books', price: '₦5,200', color: Color(0xFFFFE7E1)),
                  ],
                ),
              ),
              const SizedBox(height: 23),
              const SectionTitle('Riders nearby'),
              const SizedBox(height: 10),
              const RiderTile(name: 'Ayo O.', rating: '4.9', deliveries: '128 deliveries', eta: '8 min'),
              const RiderTile(name: 'Tomiwa A.', rating: '4.8', deliveries: '96 deliveries', eta: '12 min'),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(color: const Color(0xFFFFF3E7), borderRadius: BorderRadius.circular(16)),
                child: const Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(Icons.info_outline, color: NaijaLinkApp.orange), SizedBox(width: 10), Expanded(child: Text('Sample rider listings for the app preview. Real availability, ratings, pricing, and live locations are not connected yet.', style: TextStyle(color: NaijaLinkApp.ink, fontSize: 12, height: 1.4)))]),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

class ExplorePage extends StatelessWidget {
  const ExplorePage({super.key});

  @override
  Widget build(BuildContext context) => _SimplePage(
        icon: Icons.storefront_outlined,
        title: 'Explore NaijaLink',
        subtitle: 'Browse seller catalogs, search products, and ask sellers questions. Catalog listings will appear here when the backend is connected.',
        action: 'Search catalog',
      );
}

class DeliveriesPage extends StatelessWidget {
  const DeliveriesPage({super.key});

  @override
  Widget build(BuildContext context) => _SimplePage(
        icon: Icons.route_outlined,
        title: 'Track a delivery',
        subtitle: 'Your orders and tracking numbers will show here. Active local deliveries are planned to include consent-based live rider location.',
        action: 'Enter tracking number',
      );
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.role, required this.onRoleChanged});
  final String role;
  final ValueChanged<String> onRoleChanged;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        const SizedBox(height: 12),
        const BrandMark(size: 58),
        const SizedBox(height: 12),
        const Text('Your NaijaLink profile', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: NaijaLinkApp.ink)),
        const SizedBox(height: 5),
        const Text('Choose a preview role. This is not a real account or authentication flow.', style: TextStyle(color: Colors.black54, height: 1.4)),
        const SizedBox(height: 22),
        const Text('Preview dashboard as', style: TextStyle(fontWeight: FontWeight.w700)),
        const SizedBox(height: 10),
        Wrap(spacing: 8, runSpacing: 8, children: ['Buyer', 'Seller', 'Rider', 'Admin'].map((item) => ChoiceChip(label: Text(item), selected: role == item, onSelected: (_) => onRoleChanged(item))).toList()),
        const SizedBox(height: 20),
        const _ProfileOption(icon: Icons.security, title: 'Account & verification', subtitle: 'Email login, biometrics, and approved NIN verification are planned.'),
        const _ProfileOption(icon: Icons.account_balance_wallet_outlined, title: 'Payments & earnings', subtitle: 'Payment provider and rider payout integration are not connected.'),
        const _ProfileOption(icon: Icons.support_agent, title: 'AI help & support', subtitle: 'English AI assistance and human support options are planned.'),
        const _ProfileOption(icon: Icons.star_outline, title: 'Ratings and reviews', subtitle: 'Order-verified buyer and seller feedback for riders is planned.'),
      ],
    );
  }
}

class _SimplePage extends StatelessWidget {
  const _SimplePage({required this.icon, required this.title, required this.subtitle, required this.action});
  final IconData icon;
  final String title;
  final String subtitle;
  final String action;

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Container(width: 86, height: 86, decoration: BoxDecoration(color: NaijaLinkApp.green.withOpacity(.1), shape: BoxShape.circle), child: Icon(icon, size: 40, color: NaijaLinkApp.green)),
            const SizedBox(height: 20),
            Text(title, style: const TextStyle(fontSize: 23, fontWeight: FontWeight.w800, color: NaijaLinkApp.ink), textAlign: TextAlign.center),
            const SizedBox(height: 9),
            Text(subtitle, style: const TextStyle(color: Colors.black54, height: 1.5), textAlign: TextAlign.center),
            const SizedBox(height: 20),
            FilledButton(onPressed: () => _notice(context, 'This feature is part of the next implementation milestone.'), child: Text(action)),
          ]),
        ),
      );
}

class BrandMark extends StatelessWidget {
  const BrandMark({super.key, required this.size});
  final double size;

  @override
  Widget build(BuildContext context) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: NaijaLinkApp.green, borderRadius: BorderRadius.circular(size * .32)),
        child: Stack(alignment: Alignment.center, children: [
          Icon(Icons.location_on, size: size * .72, color: Colors.white),
          Icon(Icons.link, size: size * .36, color: NaijaLinkApp.orange),
        ]),
      );
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) => Text(text, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: NaijaLinkApp.ink));
}

class _DeliveryOption extends StatelessWidget {
  const _DeliveryOption({required this.icon, required this.title, required this.subtitle, required this.color, required this.onTap});
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        borderRadius: BorderRadius.circular(17),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(17), border: Border.all(color: const Color(0xFFE8ECE9))),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Container(width: 39, height: 39, decoration: BoxDecoration(color: color.withOpacity(.1), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: color)), const SizedBox(height: 12), Text(title, style: const TextStyle(fontWeight: FontWeight.w800)), const SizedBox(height: 3), Text(subtitle, style: const TextStyle(color: Colors.black54, fontSize: 12))]),
        ),
      );
}

class CategoryChip extends StatelessWidget {
  const CategoryChip({super.key, required this.icon, required this.label});
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) => Column(children: [Container(width: 58, height: 58, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(18), border: Border.all(color: const Color(0xFFE8ECE9))), child: Icon(icon, color: NaijaLinkApp.green)), const SizedBox(height: 6), Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600))]);
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.icon, required this.title, required this.seller, required this.price, required this.color});
  final IconData icon;
  final String title;
  final String seller;
  final String price;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
        width: 158,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(17), border: Border.all(color: const Color(0xFFE8ECE9))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Expanded(child: Container(width: double.infinity, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(13)), child: Icon(icon, size: 43, color: NaijaLinkApp.ink))), const SizedBox(height: 9), Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)), Text(seller, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.black54, fontSize: 11)), const SizedBox(height: 4), Text(price, style: const TextStyle(color: NaijaLinkApp.green, fontWeight: FontWeight.w800))]),
      );
}

class RiderTile extends StatelessWidget {
  const RiderTile({super.key, required this.name, required this.rating, required this.deliveries, required this.eta});
  final String name;
  final String rating;
  final String deliveries;
  final String eta;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: 9),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), border: Border.all(color: const Color(0xFFE8ECE9))),
        child: Row(children: [CircleAvatar(backgroundColor: const Color(0xFFE4F2E9), child: Text(name.substring(0, 1), style: const TextStyle(color: NaijaLinkApp.green, fontWeight: FontWeight.bold))), const SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(name, style: const TextStyle(fontWeight: FontWeight.w700)), Text(deliveries, style: const TextStyle(color: Colors.black54, fontSize: 11))])), const Icon(Icons.star, color: NaijaLinkApp.orange, size: 17), Text(rating, style: const TextStyle(fontWeight: FontWeight.w700)), const SizedBox(width: 12), Text(eta, style: const TextStyle(color: NaijaLinkApp.green, fontWeight: FontWeight.w700, fontSize: 12))]),
      );
}

class _ProfileOption extends StatelessWidget {
  const _ProfileOption({required this.icon, required this.title, required this.subtitle});
  final IconData icon;
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) => ListTile(contentPadding: const EdgeInsets.symmetric(vertical: 4), leading: Icon(icon, color: NaijaLinkApp.green), title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)), subtitle: Text(subtitle), isThreeLine: true);
}

void _notice(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message), behavior: SnackBarBehavior.floating));
}
