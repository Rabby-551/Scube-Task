import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scube_task/core/theme/app_colors.dart';
import 'package:scube_task/features/dashboard/widgets/data_card.dart';
import 'package:scube_task/features/dashboard/widgets/feature_button.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool _showSource = true;

  final List<_DataCardInfo> _sourceData = const [
    _DataCardInfo(
      title: 'Data View',
      statusLabel: 'Active',
      statusColor: AppColors.primary,
      assetPath: 'assets/dashboard/icons/icon_1.png',
      accentColor: Color(0xFF4DB6E6),
      data1: '55505.63',
      data2: '58805.63',
    ),
    _DataCardInfo(
      title: 'Data Type 2',
      statusLabel: 'Active',
      statusColor: AppColors.primary,
      assetPath: 'assets/dashboard/icons/icon_2.png',
      accentColor: Color(0xFFF2A53B),
      data1: '55505.63',
      data2: '58805.63',
    ),
    _DataCardInfo(
      title: 'Data Type 3',
      statusLabel: 'Inactive',
      statusColor: Color(0xFFE14C4C),
      assetPath: 'assets/dashboard/icons/icon_3.png',
      accentColor: Color(0xFF4DB6E6),
      data1: '55505.63',
      data2: '58805.63',
    ),
  ];

  final List<_DataCardInfo> _loadData = const [
    _DataCardInfo(
      title: 'Load A',
      statusLabel: 'Active',
      statusColor: AppColors.primary,
      assetPath: 'assets/dashboard/icons/icon_4.png',
      accentColor: Color(0xFFF2A53B),
      data1: '33210.20',
      data2: '44210.10',
    ),
    _DataCardInfo(
      title: 'Load B',
      statusLabel: 'Active',
      statusColor: AppColors.primary,
      assetPath: 'assets/dashboard/icons/icon_5.png',
      accentColor: Color(0xFF4DB6E6),
      data1: '22010.50',
      data2: '31010.22',
    ),
  ];

  List<_FeatureShortcut> get _features => const [
        _FeatureShortcut(
          label: 'Analysis Pro',
          assetPath: 'assets/dashboard/icons/icon_6.png',
        ),
        _FeatureShortcut(
          label: 'G. Generator',
          assetPath: 'assets/dashboard/icons/icon_7.png',
        ),
        _FeatureShortcut(
          label: 'Plant Summery',
          assetPath: 'assets/dashboard/icons/icon_1.png',
        ),
        _FeatureShortcut(
          label: 'Natural Gas',
          assetPath: 'assets/dashboard/icons/icon_2.png',
        ),
        _FeatureShortcut(
          label: 'D. Generator',
          assetPath: 'assets/dashboard/icons/icon_3.png',
        ),
        _FeatureShortcut(
          label: 'Water Process',
          assetPath: 'assets/dashboard/icons/icon_4.png',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final height = size.height;
    final horizontalPadding = width * 0.05;

    return Scaffold(
      backgroundColor: const Color(0xFFE5EDF6),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding,
            vertical: width * 0.04,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(width),
              SizedBox(height: width * 0.04),
              _buildSummaryCard(width, height),
              SizedBox(height: width * 0.05),
              _buildFeatureGrid(width),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(double width) {
    return Row(
      children: [
        IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: const Color(0xFF1E2556),
            size: width * 0.08,
          ),
          onPressed: () {
            Navigator.of(context).maybePop();
          },
        ),
        Expanded(
          child: Center(
            child: Text(
              'SCM',
              style: GoogleFonts.manrope(
                color: const Color(0xFF0D1140),
                fontSize: width * 0.065,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Notifications tapped')),
                );
              },
              icon: Icon(
                Icons.notifications_none_outlined,
                color: const Color(0xFF1E2556),
                size: width * 0.08,
              ),
            ),
            Positioned(
              right: width * 0.022,
              top: width * 0.028,
              child: Container(
                width: width * 0.035,
                height: width * 0.035,
                decoration: BoxDecoration(
                  color: const Color(0xFFE03232),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryCard(double width, double height) {
    final cardRadius = 26.0;
    final tabHeight = width * 0.14;
    final panelHeight = height * 0.64;

    return DefaultTabController(
      length: 3,
      child: Container(
        padding: EdgeInsets.all(width * 0.04),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(cardRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              height: tabHeight,
              decoration: BoxDecoration(
                color: const Color(0xFFE8EDF5),
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: const Color(0xFFD0D6E0)),
              ),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(14),
                ),
                labelColor: Colors.white,
                unselectedLabelColor: const Color(0xFF7D8595),
                labelStyle: GoogleFonts.manrope(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
                unselectedLabelStyle: GoogleFonts.manrope(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
                tabs: const [
                  Tab(text: 'Summary'),
                  Tab(text: 'SLD'),
                  Tab(text: 'Data'),
                ],
              ),
            ),
            SizedBox(height: width * 0.04),
            SizedBox(
              height: panelHeight,
              child: TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildSummeryTab(width),
                  _buildPlaceholderTab(width, 'SLD content coming soon'),
                  _buildPlaceholderTab(width, 'Data content coming soon'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummeryTab(double width) {
    final ringSize = width * 0.58;

    final data = _showSource ? _sourceData : _loadData;
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: width * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Electricity',
            textAlign: TextAlign.center,
            style: GoogleFonts.manrope(
              color: const Color(0xFF8A8F96),
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          Divider(color: Colors.grey.shade400, thickness: 1),
          SizedBox(height: width * 0.02),
          _buildDonut(ringSize),
          SizedBox(height: width * 0.04),
          _buildToggle(width),
          SizedBox(height: width * 0.03),
          Divider(color: Colors.grey.shade400, thickness: 1),
          SizedBox(height: width * 0.02),
          ..._buildDataCards(data, width),
        ],
      ),
    );
  }

  List<Widget> _buildDataCards(List<_DataCardInfo> data, double width) {
    final cards = <Widget>[];
    for (var i = 0; i < data.length; i++) {
      final item = data[i];
      cards.add(
        DashboardDataCard(
          title: item.title,
          statusLabel: item.statusLabel,
          statusColor: item.statusColor,
          assetPath: item.assetPath,
          accentColor: item.accentColor,
          data1: item.data1,
          data2: item.data2,
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${item.title} tapped'),
                duration: const Duration(milliseconds: 900),
              ),
            );
          },
        ),
      );
      if (i != data.length - 1) {
        cards.add(SizedBox(height: width * 0.04));
      }
    }
    return cards;
  }

  Widget _buildToggle(double width) {
    return Container(
      height: width * 0.14,
      decoration: BoxDecoration(
        color: const Color(0xFFE5E9EE),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: const Color(0xFFD0D6E0)),
      ),
      child: Row(
        children: [
          _buildToggleButton(
            label: 'Source',
            isActive: _showSource,
            onTap: () => setState(() => _showSource = true),
            width: width,
          ),
          _buildToggleButton(
            label: 'Load',
            isActive: !_showSource,
            onTap: () => setState(() => _showSource = false),
            width: width,
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required String label,
    required bool isActive,
    required VoidCallback onTap,
    required double width,
  }) {
    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        margin: EdgeInsets.symmetric(horizontal: width * 0.012, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(22),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: onTap,
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.manrope(
                color: isActive ? Colors.white : const Color(0xFF7D8595),
                fontWeight: FontWeight.w800,
                fontSize: width * 0.05,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDonut(double size) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: size * 0.6,
              height: size * 0.6,
              child: CircularProgressIndicator(
                value: 0.9,
                strokeWidth: size * 0.10,
                strokeCap: StrokeCap.round,
                backgroundColor: const Color(0xFFE0E8EE),
                valueColor:
                    AlwaysStoppedAnimation<Color>(const Color(0xFF2B89C7)),
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Total Power',
                  style: GoogleFonts.manrope(
                    color: const Color(0xFF0D1140),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '5.53 kw',
                  style: GoogleFonts.manrope(
                    color: const Color(0xFF0D1140),
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderTab(double width, String message) {
    return Center(
      child: Text(
        message,
        textAlign: TextAlign.center,
        style: GoogleFonts.manrope(
          color: AppColors.textBody,
          fontSize: width * 0.045,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildFeatureGrid(double width) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: width * 0.04,
      crossAxisSpacing: width * 0.04,
      childAspectRatio: 2.9,
      children: _features
          .map(
            (item) => FeatureButton(
              label: item.label,
              assetPath: item.assetPath,
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${item.label} tapped'),
                    duration: const Duration(milliseconds: 900),
                  ),
                );
              },
            ),
          )
          .toList(),
    );
  }
}

class _DataCardInfo {
  const _DataCardInfo({
    required this.title,
    required this.statusLabel,
    required this.statusColor,
    required this.assetPath,
    required this.accentColor,
    required this.data1,
    required this.data2,
  });

  final String title;
  final String statusLabel;
  final Color statusColor;
  final String assetPath;
  final Color accentColor;
  final String data1;
  final String data2;
}

class _FeatureShortcut {
  const _FeatureShortcut({
    required this.label,
    required this.assetPath,
  });

  final String label;
  final String assetPath;
}
