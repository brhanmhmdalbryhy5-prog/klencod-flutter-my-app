import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(const VaultApp());

class VaultApp extends StatelessWidget {
  const VaultApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'VAULT',
      theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: const Color(0xFF060606)),
      home: const Directionality(textDirection: TextDirection.rtl, child: VaultHome()),
    );
  }
}

class VaultHome extends StatefulWidget {
  const VaultHome({super.key});
  @override
  State<VaultHome> createState() => _VaultHomeState();
}

class _VaultHomeState extends State<VaultHome> with SingleTickerProviderStateMixin {
  int index = 0;
  late AnimationController _ctrl;
  final Color gold = const Color(0xFFD4AF37);
  final Color goldLight = const Color(0xFFFFE9A8);

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat();
  }
  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // إضاءات خلفية
          Positioned(top: -60, left: -60, child: _glow(300, gold.withOpacity(0.22))),
          Positioned(bottom: 120, right: -80, child: _glow(280, const Color(0xFF7A5C00).withOpacity(0.25))),

          SafeArea(
            child: IndexedStack(
              index: index,
              children: [
                _homePage(),
                _vaultPage(),
                _conciergePage(),
                _profilePage(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: AnimatedBuilder(
        animation: _ctrl,
        builder: (_, __) {
          return Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: gold.withOpacity(0.5 + 0.3 * math.sin(_ctrl.value * math.pi * 2)), blurRadius: 25, spreadRadius: 4)],
            ),
            child: FloatingActionButton(
              backgroundColor: gold,
              foregroundColor: Colors.black,
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: const Color(0xFF141414),
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
                  builder: (_) => Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(mainAxisSize: MainAxisSize.min, children: [
                      Container(width: 50, height: 5, decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(10))),
                      const SizedBox(height: 18),
                      const Text('🔐 طلب خاص', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                      const SizedBox(height: 8),
                      const Text('اكتب أي شيء تريده، والكونسيرج الخاص بك سيجلبه لك خلال 24 ساعة.', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 18),
                      TextField(decoration: InputDecoration(hintText: 'مثال: أريد ساعة 【entity-Rolex¦canonical_name=Rolex】 نادرة...', filled: true, fillColor: Colors.white.withOpacity(0.07), border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none))),
                      const SizedBox(height: 14),
                      SizedBox(width: double.infinity, child: ElevatedButton(onPressed: () => Navigator.pop(context), style: ElevatedButton.styleFrom(backgroundColor: gold, foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))), child: const Text('إرسال للكونسيرج ✨', style: TextStyle(fontWeight: FontWeight.w900)))),
                      const SizedBox(height: 10),
                    ]),
                  ),
                );
              },
              child: const Icon(Icons.diamond, size: 28),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.black,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          _navItem(Icons.home, 0),
          _navItem(Icons.account_balance_wallet, 1),
          const SizedBox(width: 40),
          _navItem(Icons.support_agent, 2),
          _navItem(Icons.person, 3),
        ]),
      ),
    );
  }

  Widget _glow(double s, Color c) => Container(width: s, height: s, decoration: BoxDecoration(shape: BoxShape.circle, color: c));

  Widget _navItem(IconData icon, int i) {
    bool active = index == i;
    return IconButton(
      onPressed: () => setState(() => index = i),
      icon: Icon(icon, size: 28, color: active ? gold : Colors.grey),
    );
  }

  // ============ الصفحة 1 : الرئيسية ============
  Widget _homePage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('أهلاً بك، سيد', style: TextStyle(color: Colors.grey[400], fontSize: 13)),
            const Text('【entity-عبدالله الشريف¦canonical_name=عبدالله الشريف】', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
          ]),
          Stack(children: [
            const CircleAvatar(radius: 24, backgroundColor: Color(0xFF1A1A1A), child: Text('👑', style: TextStyle(fontSize: 22))),
            Positioned(right: 0, bottom: 0, child: Container(width: 12, height: 12, decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle, border: Border.all(color: Colors.black, width: 2)))),
          ]),
        ]),
        const SizedBox(height: 18),

        // بطاقة العضوية السوداء
        Container(
          width: double.infinity, padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26),
            gradient: const LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [Color(0xFF2A2A2A), Color(0xFF000000), Color(0xFF1A1400)]),
            border: Border.all(color: gold.withOpacity(0.6)),
            boxShadow: [BoxShadow(color: gold.withOpacity(0.25), blurRadius: 30, offset: const Offset(0, 15))],
          ),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Text('VAULT', style: TextStyle(color: gold, fontWeight: FontWeight.w900, fontSize: 20, letterSpacing: 3)),
              const Text('BLACK CARD', style: TextStyle(color: Colors.grey, fontSize: 10, letterSpacing: 2)),
            ]),
            const SizedBox(height: 22),
            const Text('••••  ••••  ••••  2026', style: TextStyle(fontSize: 20, letterSpacing: 3, fontWeight: FontWeight.bold)),
            const SizedBox(height: 14),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text('الرصيد الذهبي', style: TextStyle(color: Colors.grey, fontSize: 11)), Text('128.5 g ذهب', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w900, color: Colors.white))]),
              Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: gold, borderRadius: BorderRadius.circular(20)), child: const Text('VIP • ELITE', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 11))),
            ]),
          ]),
        ),
        const SizedBox(height: 20),

        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Text('🔥 مزادات تنتهي قريباً', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
          Text('عرض الكل', style: TextStyle(color: gold, fontSize: 13)),
        ]),
        const SizedBox(height: 12),

        _auctionCard('⌚', 'Rolex Daytona 1969', 'نادر جداً - قطعة واحدة في العالم', '89,500 \$', '02:14:33', Colors.orange),
        _auctionCard('🚗', '【entity-Rolls-Royce¦canonical_name=Rolls-Royce】 Phantom', 'نسخة خاصة - صنعاء', '420,000 \$', '05:42:10', Colors.blue),
        _auctionCard('🏛️', 'قصر في حدة - صنعاء', '12 غرفة + مسبح + مهبط', '1,250,000 \$', '11:20:05', Colors.green),

        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(color: gold.withOpacity(0.08), borderRadius: BorderRadius.circular(20), border: Border.all(color: gold.withOpacity(0.3))),
          child: Row(children: [
            Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: gold, shape: BoxShape.circle), child: const Text('🤵', style: TextStyle(fontSize: 22))),
            const SizedBox(width: 14),
            const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('كونسيرجك الخاص متاح الآن', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              Text('أحمد جاهز لخدمتك - يرد خلال دقيقة', style: TextStyle(color: Colors.grey, fontSize: 12)),
            ])),
            Icon(Icons.arrow_forward_ios, color: gold, size: 16),
          ]),
        ),
      ]),
    );
  }

  Widget _auctionCard(String emoji, String title, String desc, String price, String time, Color dotColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white.withOpacity(0.08))),
      child: Row(children: [
        Container(width: 62, height: 62, decoration: BoxDecoration(color: Colors.white.withOpacity(0.08), borderRadius: BorderRadius.circular(16)), child: Center(child: Text(emoji, style: const TextStyle(fontSize: 28)))),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          Text(desc, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          const SizedBox(height: 6),
          Row(children: [
            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: Colors.red.withOpacity(0.15), borderRadius: BorderRadius.circular(10)), child: Row(children: [Container(width: 6, height: 6, decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle)), const SizedBox(width: 4), Text(time, style: const TextStyle(color: Colors.redAccent, fontSize: 11, fontWeight: FontWeight.bold))])),
            const SizedBox(width: 8),
            Text(price, style: TextStyle(color: gold, fontWeight: FontWeight.w900, fontSize: 14)),
          ]),
        ])),
        Icon(Icons.favorite_border, color: gold),
      ]),
    );
  }

  // ============ الصفحة 2 : الخزنة ============
  Widget _vaultPage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('خزنتك الخاصة 🔐', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
        const Text('كل ما تملكه، في مكان واحد سري', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 20),
        Row(children: [
          Expanded(child: _statBox('إجمالي الثروة', '2.4M \$', '+12.5%')),
          const SizedBox(width: 12),
          Expanded(child: _statBox('ذهب', '128.5 g', '+2.1 g')),
        ]),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: _statBox('مقتنيات', '14 قطعة', '3 نادرة')),
          const SizedBox(width: 12),
          Expanded(child: _statBox('نقاط VIP', '8,940', 'المستوى: ملكي')),
        ]),
        const SizedBox(height: 20),
        const Text('مقتنياتي', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
        const SizedBox(height: 12),
        _vaultItem('⌚', '【entity-Patek Philippe¦canonical_name=Patek Philippe】', 'تم الشراء 2025', '45,000 \$'),
        _vaultItem('💎', 'ألماسة 5 قيراط', 'موثقة - GIA', '82,000 \$'),
        _vaultItem('🖼️', 'لوحة نادرة', 'من مزاد لندن', '120,000 \$'),
      ]),
    );
  }

  Widget _statBox(String label, String value, String change) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(18), border: Border.all(color: Colors.white.withOpacity(0.07))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
        Text(change, style: TextStyle(color: gold, fontSize: 12, fontWeight: FontWeight.bold)),
      ]),
    );
  }

  Widget _vaultItem(String e, String t, String s, String p) {
    return ListTile(
      leading: Container(width: 50, height: 50, decoration: BoxDecoration(color: gold.withOpacity(0.12), borderRadius: BorderRadius.circular(14)), child: Center(child: Text(e, style: const TextStyle(fontSize: 22)))),
      title: Text(t, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(s, style: const TextStyle(color: Colors.grey)),
      trailing: Text(p, style: TextStyle(color: gold, fontWeight: FontWeight.w900)),
    );
  }

  // ============ الصفحة 3 : الكونسيرج ============
  Widget _conciergePage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('الكونسيرج الخاص 🤵', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
        const Text('اطلب أي شيء، ونحن ننفذه', style: TextStyle(color: Colors.grey)),
        const SizedBox(height: 18),
        GridView.count(
          shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 1.1,
          children: [
            _service('✈️', 'طائرة خاصة', 'احجز خلال ساعة'),
            _service('🍽️', 'مطعم VIP', 'طاولة في أي مكان'),
            _service('🏨', 'فندق 7 نجوم', 'جناح ملكي'),
            _service('🎁', 'هدية نادرة', 'نجهزها لك'),
            _service('🚗', 'سيارة فاخرة', 'مع سائق خاص'),
            _service('🎫', 'تذاكر حصرية', 'حفلات ومباريات'),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(gradient: LinearGradient(colors: [gold, goldLight]), borderRadius: BorderRadius.circular(20)),
          child: const Row(children: [
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('هل لديك طلب مجنون؟', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 17)),
              Text('نحن متخصصون في المستحيل.', style: TextStyle(color: Colors.black54)),
            ])),
            Text('💬', style: TextStyle(fontSize: 30)),
          ]),
        ),
      ]),
    );
  }

  Widget _service(String e, String t, String s) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white.withOpacity(0.08))),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(e, style: const TextStyle(fontSize: 30)),
        const SizedBox(height: 10),
        Text(t, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
        Text(s, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ]),
    );
  }

  // ============ الصفحة 4 : البروفايل ============
  Widget _profilePage() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 100),
      child: Column(children: [
        const SizedBox(height: 10),
        Container(padding: const EdgeInsets.all(3), decoration: BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [gold, goldLight, gold])), child: const CircleAvatar(radius: 50, backgroundColor: Colors.black, child: Text('👑', style: TextStyle(fontSize: 40)))),
        const SizedBox(height: 12),
        const Text('عبدالله الشريف', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
        Container(margin: const EdgeInsets.only(top: 6), padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5), decoration: BoxDecoration(color: gold, borderRadius: BorderRadius.circular(20)), child: const Text('عضو مؤسس • FOUNDER', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 11))),
        const SizedBox(height: 24),
        _profileTile(Icons.person, 'الملف الشخصي'),
        _profileTile(Icons.notifications, 'الإشعارات السرية'),
        _profileTile(Icons.security, 'الحماية والخصوصية'),
        _profileTile(Icons.card_giftcard, 'دعوة صديق - اكسب ذهب'),
        _profileTile(Icons.settings, 'الإعدادات'),
        const SizedBox(height: 20),
        const Text('VAULT • صنع في صنعاء بفخامة', style: TextStyle(color: Colors.grey, fontSize: 12)),
      ]),
    );
  }

  Widget _profileTile(IconData icon, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.05), borderRadius: BorderRadius.circular(16)),
      child: ListTile(leading: Icon(icon, color: gold), title: Text(title), trailing: const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey)),
    );
  }
}