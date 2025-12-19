import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scube_task/core/theme/app_colors.dart';
import 'package:scube_task/features/dashboard/widgets/arc_gauge_indicator.dart';

class DataViewScreen extends StatefulWidget {
  const DataViewScreen({super.key});

  @override
  State<DataViewScreen> createState() => _DataViewScreenState();
}

class _DataViewScreenState extends State<DataViewScreen> {
  bool _isDataView = true;
  bool _isTodayData = true;
  bool _isRevenueInfoExpanded = true;
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();

  List<_EnergyData> get _energyData {
    final key = '${_isDataView ? 'data' : 'revenue'}_${_isTodayData ? 'today' : 'custom'}';
    return _energySets[key] ?? const [];
  }

  List<_EnergyData> get _todayEnergyData {
    final key = '${_isDataView ? 'data' : 'revenue'}_today';
    return _energySets[key] ?? const [];
  }

  List<_EnergyData> get _customEnergyData {
    final key = '${_isDataView ? 'data' : 'revenue'}_custom';
    return _energySets[key] ?? const [];
  }

  _CenterGauge get _gauge {
    return _isDataView ? _CenterGauge.data : _CenterGauge.revenue;
  }

  String get _energyTitle => _isDataView ? 'Energy Chart' : 'Revenue Chart';

  String get _totalLabel => _isDataView ? '5.53 kw' : '৳ 12.4k';

  String get _customTotalLabel => _isDataView ? '20.05 kw' : '৳ 20.0k';

  List<_RevenueEntry> get _revenueInfo => _revenueInfoList;

  String _formatDate(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month/${date.year}';
  }

  Future<void> _pickDate(TextEditingController controller) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 10),
      lastDate: DateTime(now.year + 10),
    );

    if (picked != null) {
      setState(() {
        controller.text = _formatDate(picked);
      });
    }
  }

  @override
  void dispose() {
    _fromDateController.dispose();
    _toDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final width = size.width;
    final bgColor = const Color(0xFFE5EDF6);
    final borderColor = const Color(0xFFC1CAD8);

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            _Header(width: width),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: width * 0.045,
                  vertical: width * 0.035,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(width * 0.06),
                    border: Border.all(color: borderColor, width: 1.2),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: width * 0.04),
                      _SegmentedTabs(
                        width: width,
                        activeLabel: 'Data View',
                        inactiveLabel: 'Revenue View',
                        isLeftActive: _isDataView,
                        onLeftTap: () => setState(() => _isDataView = true),
                        onRightTap: () => setState(() => _isDataView = false),
                      ),
                      SizedBox(height: width * 0.08),
                      _RingSection(width: width, gauge: _gauge),
                      SizedBox(height: width * 0.08),
                      if (_isDataView) ...[
                        _SegmentedTabs(
                          width: width,
                          activeLabel: 'Today Data',
                          inactiveLabel: 'Custom Date Data',
                          isLeftActive: _isTodayData,
                          onLeftTap: () => setState(() => _isTodayData = true),
                          onRightTap: () => setState(() => _isTodayData = false),
                        ),
                        SizedBox(height: width * 0.06),
                        if (_isTodayData) ...[
                          _EnergyCard(
                            width: width,
                            borderColor: borderColor,
                            data: _energyData,
                            title: _energyTitle,
                            total: _totalLabel,
                          ),
                        ] else ...[
                          _DateRangeBar(
                            width: width,
                            borderColor: borderColor,
                            fromController: _fromDateController,
                            toController: _toDateController,
                            onFromTap: () => _pickDate(_fromDateController),
                            onToTap: () => _pickDate(_toDateController),
                            onSearch: () => setState(() {}),
                          ),
                          SizedBox(height: width * 0.05),
                          _EnergyCard(
                            width: width,
                            borderColor: borderColor,
                            data: _customEnergyData,
                            title: _energyTitle,
                            total: _customTotalLabel,
                          ),
                          SizedBox(height: width * 0.05),
                          _EnergyCard(
                            width: width,
                            borderColor: borderColor,
                            data: _todayEnergyData,
                            title: _energyTitle,
                            total: _totalLabel,
                          ),
                        ],
                        SizedBox(height: width * 0.08),
                      ] else ...[
                        _RevenueInfoCard(
                          width: width,
                          borderColor: borderColor,
                          isExpanded: _isRevenueInfoExpanded,
                          onToggle: () => setState(() {
                            _isRevenueInfoExpanded = !_isRevenueInfoExpanded;
                          }),
                          items: _revenueInfo,
                        ),
                        SizedBox(height: width * 0.08),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: width * 0.025,
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: Icon(
              Icons.arrow_back,
              color: const Color(0xFF1E2556),
              size: width * 0.08,
            ),
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
                onPressed: () {},
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
      ),
    );
  }
}

class _SegmentedTabs extends StatelessWidget {
  const _SegmentedTabs({
    required this.width,
    this.activeLabel = 'Data View',
    this.inactiveLabel = 'Revenue View',
    required this.isLeftActive,
    required this.onLeftTap,
    required this.onRightTap,
  });

  final double width;
  final String activeLabel;
  final String inactiveLabel;
  final bool isLeftActive;
  final VoidCallback onLeftTap;
  final VoidCallback onRightTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = const Color(0xFFC1CAD8);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.04),
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.04,
        vertical: width * 0.02,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(width * 0.055),
        border: Border.all(color: borderColor, width: 1.2),
      ),
      child: Row(
        children: [
          _DotLabel(
            label: activeLabel,
            active: isLeftActive,
            dotColor: isLeftActive ? AppColors.primary : const Color(0xFF9CA3AF),
            onTap: onLeftTap,
          ),
          SizedBox(width: width * 0.08),
          _DotLabel(
            label: inactiveLabel,
            active: !isLeftActive,
            dotColor: isLeftActive ? const Color(0xFF9CA3AF) : AppColors.primary,
            onTap: onRightTap,
          ),
        ],
      ),
    );
  }
}

class _RingSection extends StatelessWidget {
  const _RingSection({required this.width, required this.gauge});

  final double width;
  final _CenterGauge gauge;

  @override
  Widget build(BuildContext context) {
    final ringSize = width * 0.62;

    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            ArcGaugeIndicator(
              size: ringSize,
              value: gauge.progress,
              trackColor: gauge.backgroundColor,
              gradientColors: [
                gauge.valueColor,
                Color.lerp(gauge.valueColor, Colors.white, 0.32)!,
              ],
            ),
            Column(
              children: [
                Text(
                  gauge.value,
                  style: GoogleFonts.manrope(
                    color: const Color(0xFF111433),
                    fontSize: width * 0.09,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  gauge.unit,
                  style: GoogleFonts.manrope(
                    color: const Color(0xFF111433),
                    fontSize: width * 0.05,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _DateRangeBar extends StatelessWidget {
  const _DateRangeBar({
    required this.width,
    required this.borderColor,
    required this.fromController,
    required this.toController,
    required this.onFromTap,
    required this.onToTap,
    required this.onSearch,
  });

  final double width;
  final Color borderColor;
  final TextEditingController fromController;
  final TextEditingController toController;
  final VoidCallback onFromTap;
  final VoidCallback onToTap;
  final VoidCallback onSearch;

  @override
  Widget build(BuildContext context) {
    final fieldHeight = width * 0.10;
    final radius = width * 0.014;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.04),
      child: Row(
        children: [
          Expanded(
            child: _DateField(
              controller: fromController,
              hint: 'From Date',
              borderColor: borderColor,
              height: fieldHeight,
              radius: radius,
              onTap: onFromTap,
            ),
          ),
          SizedBox(width: width * 0.03),
          Expanded(
            child: _DateField(
              controller: toController,
              hint: 'To Date',
              borderColor: borderColor,
              height: fieldHeight,
              radius: radius,
              onTap: onToTap,
            ),
          ),
          SizedBox(width: width * 0.03),
          SizedBox(
            height: fieldHeight,
            width: fieldHeight,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: Size(fieldHeight, fieldHeight),
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius),
                ),
                side: BorderSide(color: AppColors.primary, width: 1.5),
              ),
              onPressed: onSearch,
              child: Icon(
                Icons.search,
                color: AppColors.primary,
                size: fieldHeight * 0.32,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  const _DateField({
    required this.controller,
    required this.hint,
    required this.borderColor,
    required this.height,
    required this.radius,
    required this.onTap,
  });

  final TextEditingController controller;
  final String hint;
  final Color borderColor;
  final double height;
  final double radius;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextField(
        controller: controller,
        readOnly: true,
        onTap: onTap,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hint,
          hintStyle: GoogleFonts.manrope(
            color: const Color(0xFF6B7280),
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: height * 0.25,
            vertical: height * 0.28,
          ),
          suffixIcon: Icon(
            Icons.calendar_today_outlined,
            size: height * 0.32,
            color: const Color(0xFF6B7280),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: borderColor, width: 1.2),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radius),
            borderSide: BorderSide(color: AppColors.primary, width: 1.4),
          ),
        ),
      ),
    );
  }
}

class _RevenueInfoCard extends StatelessWidget {
  const _RevenueInfoCard({
    required this.width,
    required this.borderColor,
    required this.isExpanded,
    required this.onToggle,
    required this.items,
  });

  final double width;
  final Color borderColor;
  final bool isExpanded;
  final VoidCallback onToggle;
  final List<_RevenueEntry> items;

  @override
  Widget build(BuildContext context) {
    final radius = width * 0.04;
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: width * 0.04),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor, width: 1.2),
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
            onTap: onToggle,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.04,
                vertical: width * 0.035,
              ),
              child: Row(
                children: [
                  Icon(Icons.bar_chart, color: const Color(0xFF1E2556), size: width * 0.06),
                  SizedBox(width: width * 0.03),
                  Text(
                    'Data & Cost Info',
                    style: GoogleFonts.manrope(
                      color: const Color(0xFF0E103A),
                      fontSize: width * 0.045,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    width: width * 0.1,
                    height: width * 0.1,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Padding(
              padding: EdgeInsets.fromLTRB(
                width * 0.05,
                0,
                width * 0.05,
                width * 0.045,
              ),
              child: Column(
                children: items
                    .map(
                      (item) => Padding(
                        padding: EdgeInsets.only(bottom: width * 0.035),
                        child: _RevenueInfoRow(
                          title: 'Data ${item.index}',
                          data: item.data,
                          costTitle: 'Cost ${item.index}',
                          cost: item.cost,
                          width: width,
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
        ],
      ),
    );
  }
}

class _RevenueInfoRow extends StatelessWidget {
  const _RevenueInfoRow({
    required this.title,
    required this.data,
    required this.costTitle,
    required this.cost,
    required this.width,
  });

  final String title;
  final String data;
  final String costTitle;
  final String cost;
  final double width;

  @override
  Widget build(BuildContext context) {
    final labelStyle = GoogleFonts.manrope(
      color: const Color(0xFF6B7280),
      fontSize: width * 0.04,
      fontWeight: FontWeight.w700,
    );
    final valueStyle = GoogleFonts.manrope(
      color: const Color(0xFF0E103A),
      fontSize: width * 0.045,
      fontWeight: FontWeight.w800,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: '$title : ',
            style: labelStyle,
            children: [
              TextSpan(text: data, style: valueStyle),
            ],
          ),
        ),
        SizedBox(height: width * 0.01),
        RichText(
          text: TextSpan(
            text: '$costTitle : ',
            style: labelStyle,
            children: [
              TextSpan(text: cost, style: valueStyle),
            ],
          ),
        ),
      ],
    );
  }
}

class _EnergyCard extends StatelessWidget {
  const _EnergyCard({
    required this.width,
    required this.borderColor,
    required this.data,
    required this.title,
    required this.total,
  });

  final double width;
  final Color borderColor;
  final List<_EnergyData> data;
  final String title;
  final String total;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: width * 0.04),
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.045,
        vertical: width * 0.04,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(width * 0.04),
        border: Border.all(color: borderColor, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: GoogleFonts.manrope(
                  color: const Color(0xFF0E103A),
                  fontSize: width * 0.055,
                  fontWeight: FontWeight.w800,
                ),
              ),
              Text(
                total,
                style: GoogleFonts.manrope(
                  color: const Color(0xFF0E103A),
                  fontSize: width * 0.07,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          SizedBox(height: width * 0.04),
          ...data.map(
            (item) => Padding(
              padding: EdgeInsets.only(bottom: width * 0.03),
              child: _EnergyRow(
                item: item,
                borderColor: borderColor,
                width: width,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EnergyRow extends StatelessWidget {
  const _EnergyRow({
    required this.item,
    required this.borderColor,
    required this.width,
  });

  final _EnergyData item;
  final Color borderColor;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1.1),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          SizedBox(
            width: width * 0.2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: item.color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 20),
                Flexible(
                  child: Text(
                    item.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.manrope(
                      color: const Color(0xFF0E103A),
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: width * 0.16,
            color: borderColor,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _KeyValueRow(label: 'Data', value: item.data),
              const SizedBox(height: 2),
              _KeyValueRow(label: 'Cost', value: item.cost),
            ],
          ),
        ],
      ),
    );
  }
}

class _KeyValueRow extends StatelessWidget {
  const _KeyValueRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          '$label   :  ',
          style: GoogleFonts.manrope(
            color: const Color(0xFF6B7280),
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.manrope(
            color: const Color(0xFF0E103A),
            fontSize: 13,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _DotLabel extends StatelessWidget {
  const _DotLabel({
    required this.label,
    required this.active,
    required this.dotColor,
    required this.onTap,
  });

  final String label;
  final bool active;
  final Color dotColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textColor = active ? AppColors.primary : const Color(0xFF6B7280);

    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            Icons.radio_button_checked,
            size: 20,
            color: dotColor,
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: GoogleFonts.manrope(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _EnergyData {
  const _EnergyData({
    required this.label,
    required this.color,
    required this.data,
    required this.cost,
  });

  final String label;
  final Color color;
  final String data;
  final String cost;
}

class _CenterGauge {
  const _CenterGauge({
    required this.value,
    required this.unit,
    required this.progress,
    required this.backgroundColor,
    required this.valueColor,
  });

  final String value;
  final String unit;
  final double progress;
  final Color backgroundColor;
  final Color valueColor;

  static const _CenterGauge data = _CenterGauge(
    value: '55.00',
    unit: 'kWh/Sqft',
    progress: 0.72,
    backgroundColor: Color(0xFFDFF0FF),
    valueColor: Color(0xFF3D8BEF),
  );

  static const _CenterGauge revenue = _CenterGauge(
    value: '8897455',
    unit: 'tk',
    progress: 0.78,
    backgroundColor: Color(0xFFE6F3FF),
    valueColor: Color(0xFF3D8BEF),
  );
}

class _RevenueEntry {
  const _RevenueEntry({
    required this.index,
    required this.data,
    required this.cost,
  });

  final int index;
  final String data;
  final String cost;
}

const Map<String, List<_EnergyData>> _energySets = {
  'data_today': [
    _EnergyData(
      label: 'Data A',
      color: Color(0xFF1DA1F2),
      data: '2798.50 (29.53%)',
      cost: '35689 ৳',
    ),
    _EnergyData(
      label: 'Data B',
      color: Color(0xFF64B5F6),
      data: '72598.50 (35.39%)',
      cost: '5259689 ৳',
    ),
    _EnergyData(
      label: 'Data C',
      color: Color(0xFF9C27B0),
      data: '6598.36 (83.90%)',
      cost: '5698756 ৳',
    ),
    _EnergyData(
      label: 'Data D',
      color: Color(0xFFFFA726),
      data: '6598.26 (36.59%)',
      cost: '356987 ৳',
    ),
  ],
  'data_custom': [
    _EnergyData(
      label: 'Data A',
      color: Color(0xFF1DA1F2),
      data: '1810.20 (22.10%)',
      cost: '20543 ৳',
    ),
    _EnergyData(
      label: 'Data B',
      color: Color(0xFF64B5F6),
      data: '52670.00 (41.20%)',
      cost: '3987456 ৳',
    ),
    _EnergyData(
      label: 'Data C',
      color: Color(0xFF9C27B0),
      data: '3890.36 (18.30%)',
      cost: '2356789 ৳',
    ),
    _EnergyData(
      label: 'Data D',
      color: Color(0xFFFFA726),
      data: '2190.15 (18.40%)',
      cost: '150987 ৳',
    ),
  ],
  'revenue_today': [
    _EnergyData(
      label: 'Revenue A',
      color: Color(0xFF1DA1F2),
      data: '22,980 (25.0%)',
      cost: '৳ 125,000',
    ),
    _EnergyData(
      label: 'Revenue B',
      color: Color(0xFF64B5F6),
      data: '41,890 (35.0%)',
      cost: '৳ 210,000',
    ),
    _EnergyData(
      label: 'Revenue C',
      color: Color(0xFF9C27B0),
      data: '31,200 (25.0%)',
      cost: '৳ 158,000',
    ),
    _EnergyData(
      label: 'Revenue D',
      color: Color(0xFFFFA726),
      data: '12,450 (15.0%)',
      cost: '৳ 96,500',
    ),
  ],
  'revenue_custom': [
    _EnergyData(
      label: 'Revenue A',
      color: Color(0xFF1DA1F2),
      data: '15,600 (23.0%)',
      cost: '৳ 102,000',
    ),
    _EnergyData(
      label: 'Revenue B',
      color: Color(0xFF64B5F6),
      data: '30,900 (32.0%)',
      cost: '৳ 185,000',
    ),
    _EnergyData(
      label: 'Revenue C',
      color: Color(0xFF9C27B0),
      data: '29,800 (30.0%)',
      cost: '৳ 170,000',
    ),
    _EnergyData(
      label: 'Revenue D',
      color: Color(0xFFFFA726),
      data: '11,000 (15.0%)',
      cost: '৳ 88,900',
    ),
  ],
};

const List<_RevenueEntry> _revenueInfoList = [
  _RevenueEntry(index: 1, data: '2798.50 (29.53%)', cost: '35689 ৳'),
  _RevenueEntry(index: 2, data: '2798.50 (29.53%)', cost: '35689 ৳'),
  _RevenueEntry(index: 3, data: '2798.50 (29.53%)', cost: '35689 ৳'),
  _RevenueEntry(index: 4, data: '2798.50 (29.53%)', cost: '35689 ৳'),
];
