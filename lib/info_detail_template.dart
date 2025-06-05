import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DisasterPageTemplate extends StatefulWidget {
  final String appBarTitle;
  final String headerTitle;
  final String disasterName;
  final String mainImageAsset;
  final List<InfoRowData> infoRows;
  final String updateDate;
  final List<String> tabFilters;
  final List<Widget> tabContents;

  const DisasterPageTemplate({
    super.key,
    required this.appBarTitle,
    required this.headerTitle,
    required this.disasterName,
    required this.mainImageAsset,
    required this.infoRows,
    required this.updateDate,
    required this.tabFilters,
    required this.tabContents,
  });

  @override
  State<DisasterPageTemplate> createState() => _DisasterPageTemplateState();
}

class _DisasterPageTemplateState extends State<DisasterPageTemplate> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appBarTitle),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 상단 정보
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.headerTitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.disasterName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0073FF),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Center(
                  child: Image.asset(
                    widget.mainImageAsset,
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 24),
                ...widget.infoRows.map((row) => Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: InfoRow(title: row.title, content: row.content),
                )),
                const SizedBox(height: 24),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    '*업데이트: ${widget.updateDate}',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 8),
                const Divider(color: Colors.grey, thickness: 0.5),
              ],
            ),
          ),
          // 필터바
          Center(
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(widget.tabFilters.length, (index) {
                    final bool isSelected = _selectedTabIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedTabIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF0073FF) : Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                            color: const Color(0xFF0073FF),
                            width: 1.5,
                          ),
                        ),
                        child: Text(
                          widget.tabFilters[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ),
          // 탭별 내용
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, MediaQuery.of(context).padding.bottom + 16.0,),
              child: widget.tabContents[_selectedTabIndex],
            ),
          ),
        ],
      ),
    );
  }
}

class InfoRowData {
  final String title;
  final String content;
  InfoRowData({required this.title, required this.content});
}

class InfoRow extends StatelessWidget {
  final String title;
  final String content;
  const InfoRow({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14, color: Colors.black)),
        const SizedBox(width: 8),
        const Text('|', style: TextStyle(color: Colors.grey)),
        const SizedBox(width: 8),
        Text(content, style: const TextStyle(fontSize: 14, color: Colors.grey)),
      ],
    );
  }
}

class UnorderedList extends StatelessWidget {
  final List<String> items;
  final Color color;
  const UnorderedList({super.key, required this.items, this.color = Colors.grey});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 6),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('• ', style: TextStyle(fontSize: 14, color: color, height: 1.4)),
              Expanded(
                child: Text(item, style: TextStyle(fontSize: 14, color: color, height: 1.4)),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class SectionBlock {
  final String title;
  final List<String> items;
  SectionBlock({required this.title, required this.items});
}

class DisasterOverviewSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<SectionBlock> blocks;

  const DisasterOverviewSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.blocks,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFFAFAFA),
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            const SizedBox(height: 4),
            Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.black54, fontStyle: FontStyle.italic)),
            const SizedBox(height: 12),
            const Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 12),
            ...blocks.map((block) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(block.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF0073FF))),
                  const SizedBox(height: 8),
                  UnorderedList(items: block.items),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class RiskFactorsSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<SectionBlock> blocks;

  const RiskFactorsSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.blocks,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFFAFAFA),
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            const SizedBox(height: 4),
            Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.black54, fontStyle: FontStyle.italic)),
            const SizedBox(height: 12),
            const Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 12),
            ...blocks.map((block) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(block.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF0073FF))),
                  const SizedBox(height: 8),
                  UnorderedList(items: block.items),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class BehaviorTipsSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<SectionBlock> blocks;
  final VoidCallback? onTtsPressed;
  final bool isSpeaking;

  const BehaviorTipsSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.blocks,
    this.onTtsPressed,
    this.isSpeaking = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFFAFAFA),
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text(subtitle, style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic)),
                    ],
                  ),
                ),
                if (onTtsPressed != null)
                  GestureDetector(
                    onTap: onTtsPressed,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6200),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        isSpeaking ? '중지' : 'TTS',
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            ...blocks.map((block) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(block.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF0073FF))),
                  const SizedBox(height: 8),
                  UnorderedList(items: block.items),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class RelatedMaterialsSection extends StatelessWidget {
  final String title;
  final String subtitle;
  final String cardImageAsset;
  final String linkTitle;
  final String linkUrl;

  const RelatedMaterialsSection({
    super.key,
    required this.title,
    required this.subtitle,
    required this.cardImageAsset,
    required this.linkTitle,
    required this.linkUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFFAFAFA),
      padding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black)),
            const SizedBox(height: 4),
            Text(subtitle, style: const TextStyle(fontSize: 14, color: Colors.black54, fontStyle: FontStyle.italic)),
            const SizedBox(height: 12),
            const Divider(color: Colors.grey, thickness: 0.5),
            const SizedBox(height: 12),
            const Text(
              '행정안전부 카드뉴스',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF0073FF)),
            ),
            const SizedBox(height: 8),
            Center(
              child: Image.asset(
                cardImageAsset,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              '외부링크',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF0073FF)),
            ),
            const SizedBox(height: 8),
            Center(
              child: GestureDetector(
                onTap: () async {
                  final Uri url = Uri.parse(linkUrl);
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url, mode: LaunchMode.externalApplication);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('링크를 열 수 없습니다.')),
                    );
                  }
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0073FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    linkTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
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