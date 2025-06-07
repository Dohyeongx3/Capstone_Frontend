import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'info_detail_template.dart';

class TyphoonPage extends StatefulWidget {
  const TyphoonPage({super.key});

  @override
  State<TyphoonPage> createState() => _TyphoonPageState();
}

class _TyphoonPageState extends State<TyphoonPage> {
  final FlutterTts flutterTts = FlutterTts();
  bool isSpeaking = false;

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  Future<void> _toggleTts() async {
    if (isSpeaking) {
      await flutterTts.stop();
    } else {
      await flutterTts.setLanguage('ko-KR');
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.speak(
        '태풍 행동요령.'
          '태풍 발생 전에는 창문, 간판, 지붕 등 고정 여부 확인. 하천, 산 근처 주거자는 사전 대피 검토. 비상식량, 손전등, 라디오, 배터리를 준비하세요. '
          '태풍 진행 중에는 외출을 자제하고 실내에 머무르세요. 뉴스와 재난 문자로 정보를 확인하세요. 침수된 곳과 전신주 접근을 피하세요. '
          '태풍 지나간 후에는 쓰러진 전신주나 잔해에 접근하지 마세요. 침수 지역을 피해 이동하세요. 피해 발생 시 즉시 119나 지자체에 신고하세요.',
      );
    }
    setState(() {
      isSpeaking = !isSpeaking;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DisasterPageTemplate(
      appBarTitle: '재난정보',
      headerTitle: '행정안전부 국민행동요령 안내',
      disasterName: '태풍 (Typhoon)',
      mainImageAsset: 'assets/typhoon_detail.png',
      infoRows: [
        InfoRowData(title: '발생 가능 시기', content: '6월~10월'),
        InfoRowData(title: '경보 기준', content: '최대풍속 25m/s 이상'),
        InfoRowData(title: '피해 위험', content: '침수, 정전, 인명 피해'),
        InfoRowData(title: '관련 기관', content: '기상청, 안전신문고'),
      ],
      updateDate: '2025.05.27',
      tabFilters: ['재난 개요', '위험 요소', '행동요령', '관련 자료'],
      tabContents: [
        // 1. 재난 개요
        DisasterOverviewSection(
          title: '재난 개요',
          subtitle: 'Disaster Overview',
          blocks: [
            SectionBlock(
              title: '정의',
              items: [
                '태풍은 북서태평양에서 발생하는 중심 최대풍속 17m/s 이상의 열대 저기압입니다.',
                '강한 바람과 많은 비를 동반하며, 주로 여름~가을 사이에 발생합니다.',
              ],
            ),
            SectionBlock(
              title: '발생 시기 및 특징',
              items: [
                '발생 시기: 6월 ~ 10월',
                '이동 경로: 북서진 → 한반도 접근 가능성',
                '영향 지역: 해안가, 저지대, 지하차도 등',
              ],
            ),
            SectionBlock(
              title: '태풍 분류 기준',
              items: [
                '강도: 약(17m/s), 중(25m/s), 강(33m/s), 매우 강(44m/s)',
                '크기: 소형, 중형, 대형 (반경 기준)',
              ],
            ),
          ],
        ),
        // 2. 위험 요소
        DisasterOverviewSection(
          title: '위험 요소',
          subtitle: 'Risk Factors',
          blocks: [
            SectionBlock(
              title: '하천·도로 침수',
              items: [
                '폭우로 인해 도로 및 저지대 침수',
                '차량 고립 위험',
              ],
            ),
            SectionBlock(
              title: '유리창 파손',
              items: [
                '강풍으로 인해 유리창 파손 및 낙하물 위험',
              ],
            ),
            SectionBlock(
              title: '정전 및 감전 사고',
              items: [
                '전신주 파손 및 침수로 인한 전기 사고',
              ],
            ),
            SectionBlock(
              title: '건축물 붕괴',
              items: [
                '노후 주택이나 임시 구조물 붕괴 가능',
              ],
            ),
            SectionBlock(
              title: '산사태 및 급경사 붕괴',
              items: [
                '지반 약화로 인한 붕괴 위험, 특히 산지 거주자 유의',
              ],
            ),
          ],
        ),
        // 3. 행동요령
        BehaviorTipsSection(
          title: '행동요령',
          subtitle: 'Behavior Tips',
          blocks: [
            SectionBlock(
              title: '태풍 발생 전',
              items: [
                '창문, 간판, 지붕 등 고정 여부 확인',
                '하천·산 근처 주거자는 사전 대피 검토',
                '비상식량, 손전등, 라디오, 예비 배터리 준비',
              ],
            ),
            SectionBlock(
              title: '태풍 진행 중',
              items: [
                '외출 자제, 실내에서 대기',
                '뉴스·재난 문자로 최신 정보 확인',
                '침수된 곳, 엘리베이터, 전신주 접근 금지',
              ],
            ),
            SectionBlock(
              title: '태풍 지나간 후',
              items: [
                '쓰러진 전신주·건물 잔해 접근 금지',
                '침수 지역 도보·운전 피하기',
                '피해 발생 시 즉시 신고 (119, 지자체 등)',
              ],
            ),
          ],
          onTtsPressed: _toggleTts,
          isSpeaking: isSpeaking,
        ),
        // 4. 관련 자료
        RelatedMaterialsSection(
          title: '관련 자료',
          subtitle: 'Related Materials',
          cardImageAsset: 'assets/typhoon_card.png',
          linkTitle: '국민재난안전포털 바로가기',
          linkUrl: 'https://www.safekorea.go.kr/idsiSFK/neo/sfk/cs/contents/prevent/prevent02.html?menuSeq=126',
        ),
      ],
    );
  }
}

class FloodPage extends StatefulWidget {
  const FloodPage({super.key});

  @override
  State<FloodPage> createState() => _FloodPageState();
}

class _FloodPageState extends State<FloodPage> {
  final FlutterTts flutterTts = FlutterTts();
  bool isSpeaking = false;

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  Future<void> _toggleTts() async {
    if (isSpeaking) {
      await flutterTts.stop();
    } else {
      await flutterTts.setLanguage('ko-KR');
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.speak(
          '홍수 행동요령. '
              '홍수 발생 전에는 TV와 라디오를 통해 기상 정보를 확인하세요. 집 주변의 배수구와 하수구를 정리하고, 차량은 고지대로 옮기세요. '
              '가전제품과 귀중품은 높은 곳에 보관하세요. '
              '홍수 진행 중에는 침수된 도로나 지하차도에는 진입하지 마세요. 맨홀이나 전봇대, 전기시설 근처에는 접근하지 마세요. '
              '위험이 발생하면 119나 112에 신고하고, 어린이는 절대 밖에 나가지 않도록 지도하세요. '
              '홍수 지나간 후에는 실내외 청소 전에는 반드시 전기를 차단했는지 확인하세요. 오염된 음식물은 반드시 폐기하고, 수돗물이 오염되었을 경우 반드시 끓여 마시세요. '
              '손을 자주 씻고 감염병을 예방하세요.'
      );
    }
    setState(() {
      isSpeaking = !isSpeaking;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DisasterPageTemplate(
      appBarTitle: '재난정보',
      headerTitle: '행정안전부 국민행동요령 안내',
      disasterName: '도심 홍수 (Urban Flooding)',
      mainImageAsset: 'assets/flood_detail.png',
      infoRows: [
        InfoRowData(title: '발생 가능 시기', content: '6월~9월'),
        InfoRowData(title: '경보 기준', content: '하천 수위 상승, 하천 범람 우려'),
        InfoRowData(title: '피해 위험', content: '침수, 감전, 도로 붕괴, 인명 피해'),
        InfoRowData(title: '관련 기관', content: '기상청, 행정안전부, 소방청'),
      ],
      updateDate: '2025.05.27',
      tabFilters: ['재난 개요', '위험 요소', '행동요령', '관련 자료'],
      tabContents: [
        // 1. 재난 개요
        DisasterOverviewSection(
          title: '재난 개요',
          subtitle: 'Disaster Overview',
          blocks: [
            SectionBlock(
              title: '정의',
              items: [
                '홍수는 폭우, 제방 붕괴, 하천 범람 등으로 인해 물이 넘쳐나는 현상입니다.',
                '주택·도로 침수, 농경지 피해, 인명 사고 등을 유발합니다.',
              ],
            ),
            SectionBlock(
              title: '발생 원인',
              items: [
                '짧은 시간 내 많은 강수',
                '배수시설 용량 초과',
                '포장도로 면적 증가 → 지면 흡수력 부족',
              ],
            ),
            SectionBlock(
              title: '피해 지역',
              items: [
                '저지대, 지하차도, 반지하 주택, 공사장 주변',
              ],
            ),
            SectionBlock(
              title: '영향',
              items: [
                '차량 고립, 감전 사고, 주택 침수, 지하철역 침수 등',
              ],
            ),
          ],
        ),
        // 2. 위험 요소
        RiskFactorsSection(
          title: '위험 요소',
          subtitle: 'Risk Factors',
          blocks: [
            SectionBlock(
              title: '지하차도 침수',
              items: [
                '짧은 시간 내 수위 상승, 차량 고립 및 익사 위험',
              ],
            ),
            SectionBlock(
              title: '주택·상가 침수',
              items: [
                '실내 정전, 감전, 가전제품 파손 가능',
              ],
            ),
            SectionBlock(
              title: '정전 및 감전 사고',
              items: [
                '침수된 전기시설 접근 시 위험',
              ],
            ),
            SectionBlock(
              title: '도로 붕괴 / 침하',
              items: [
                '보행 중 하수구 및 맨홀 추락 위험',
              ],
            ),
            SectionBlock(
              title: '하천 범람',
              items: [
                '범람 시 급속한 수위 상승, 대피 지연',
              ],
            ),
          ],
        ),
        // 3. 행동요령 (TTS 버튼 포함)
        BehaviorTipsSection(
          title: '행동요령',
          subtitle: 'Behavior Tips',
          blocks: [
            SectionBlock(
              title: '홍수 발생 전',
              items: [
                'TV·라디오 통해 기상 정보 확인',
                '집 주변 배수구, 하수구 정리',
                '차량은 고지대로 이동',
                '가전제품, 귀중품은 높은 곳에 보관',
              ],
            ),
            SectionBlock(
              title: '홍수 진행 중',
              items: [
                '침수 도로·지하차도 진입 금지',
                '맨홀, 전봇대, 전기시설 근처 접근 금지',
                '위험 발생 시 119·112 신고',
                '어린이는 절대 밖에 나가지 않도록 지도',
              ],
            ),
            SectionBlock(
              title: '홍수 지나간 후',
              items: [
                '실내외 청소 시 전기 차단 확인',
                '오염된 음식물은 반드시 폐기',
                '수돗물 오염 의심 시 끓여 마시기',
                '손 씻기, 감염병 예방',
              ],
            ),
          ],
          onTtsPressed: _toggleTts,
          isSpeaking: isSpeaking,
        ),
        // 4. 관련 자료
        RelatedMaterialsSection(
          title: '관련 자료',
          subtitle: 'Related Materials',
          cardImageAsset: 'assets/flood_card.png',
          linkTitle: '국민재난안전포털 바로가기',
          linkUrl: 'https://www.safekorea.go.kr/idsiSFK/neo/sfk/cs/contents/prevent/prevent13.html?menuSeq=126',
        ),
      ],
    );
  }
}

class RainfallPage extends StatefulWidget {
  const RainfallPage({super.key});

  @override
  State<RainfallPage> createState() => _RainfallPageState();
}

class _RainfallPageState extends State<RainfallPage> {
  final FlutterTts flutterTts = FlutterTts();
  bool isSpeaking = false;

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  Future<void> _toggleTts() async {
    if (isSpeaking) {
      await flutterTts.stop();
    } else {
      await flutterTts.setLanguage('ko-KR');
      await flutterTts.setSpeechRate(0.5);
      await flutterTts.speak(
          '집중호우 행동요령.'
              '집중호우 전에는 기상청과 재난 문자를 주기적으로 확인하고, 침수가 예상되는 지하나 저지대에 거주하는 분들은 사전에 대피를 준비해야 합니다. '
              '하수구와 배수구 주변의 쓰레기를 제거하고, 차량은 고지대로 이동 주차하세요. '
              '집중호우 중에는 침수된 도로나 지하차도에 절대 진입하지 말고, 전기 설비나 누전이 의심되는 장소에는 접근하지 마세요. '
              '반지하 및 지하 공간에 있다면 즉시 대피하고, 외출은 자제하며 어린이와 노약자는 실내에 머무르도록 합니다. '
              '집중호우가 지나간 후에는 침수된 전기기기나 가전제품은 사용하지 마시고, 음식물은 오염 여부를 반드시 확인한 뒤 섭취해야 합니다. '
              '피부병이나 감염병을 예방하기 위해 손 씻기 등 위생 관리를 철저히 해 주세요.'
      );
    }
    setState(() {
      isSpeaking = !isSpeaking;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DisasterPageTemplate(
      appBarTitle: '재난정보',
      headerTitle: '행정안전부 국민행동요령 안내',
      disasterName: '집중 호우 (Heavy Rainfall)',
      mainImageAsset: 'assets/rain_detail.png',
      infoRows: [
        InfoRowData(title: '발생 가능 시기', content: '6월~9월'),
        InfoRowData(title: '경보 기준', content: '시간당 30mm 이상 강우'),
        InfoRowData(title: '피해 위험', content: '침수, 산사태, 도로 유실, 인명 사고'),
        InfoRowData(title: '관련 기관', content: '기상청, 행정안전부'),
      ],
      updateDate: '2025.05.27',
      tabFilters: ['재난 개요', '위험 요소', '행동요령', '관련 자료'],
      tabContents: [
        // 1. 재난 개요
        DisasterOverviewSection(
          title: '재난 개요',
          subtitle: 'Disaster Overview',
          blocks: [
            SectionBlock(
              title: '정의',
              items: [
                '집중호우는 짧은 시간 동안 매우 많은 비가 집중적으로 내리는 현상으로 하수도, 배수 시설이 감당하지 못해 침수, 산사태, 교통 두절 등 피해로 이어집니다.',
              ],
            ),
            SectionBlock(
              title: '주요 발생 시기',
              items: [
                '발생 시기: 06월 - 09월, 특히 장마철',
                '정체전선, 태풍, 국지성 소나기 등과 관련',
              ],
            ),
            SectionBlock(
              title: '주로 피해가 발생하는 지역',
              items: [
                '저지대, 반지하 주택, 지하차도, 산지 인근',
              ],
            ),
          ],
        ),
        // 2. 위험 요소
        RiskFactorsSection(
          title: '위험 요소',
          subtitle: 'Risk Factors',
          blocks: [
            SectionBlock(
              title: '지하차도 침수',
              items: [
                '차량 고립 및 익사 사고 다수 발생',
              ],
            ),
            SectionBlock(
              title: '반지하·지하공간 침수',
              items: [
                '대피 지연 시 고립·인명 사고 위험',
              ],
            ),
            SectionBlock(
              title: '감전 사고',
              items: [
                '침수된 전기 설비 접근 시 감전 가능',
              ],
            ),
            SectionBlock(
              title: '산사태 및 급경사지 붕괴',
              items: [
                '집중 강우로 토사가 무너질 수 있음',
              ],
            ),
            SectionBlock(
              title: '도로 유실 및 포트홀 발생',
              items: [
                '지반 약화로 도로 붕괴, 보행자 추락 위험',
              ],
            ),
          ],
        ),
        // 3. 행동요령 (TTS 버튼 포함)
        BehaviorTipsSection(
          title: '행동요령',
          subtitle: 'Behavior Tips',
          blocks: [
            SectionBlock(
              title: '집중호우 전',
              items: [
                '기상청·재난 문자 주기적으로 확인',
                '침수 예상 지역(지하, 저지대 등) 주민은 사전 대피 준비',
                '하수구와 배수구 주변 쓰레기 제거',
                '차량은 고지대로 이동 주차',
              ],
            ),
            SectionBlock(
              title: '집중호우 중',
              items: [
                '침수된 도로나 지하차도 진입 금지',
                '전기 설비 또는 누전된 장소 접근 금지',
                '반지하 및 지하공간은 즉시 대피',
                '외출 자제, 특히 어린이와 노약자는 실내 대기',
              ],
            ),
            SectionBlock(
              title: '집중호우 후',
              items: [
                '침수된 전기기기, 가전제품 사용 금지',
                '음식물은 오염 여부 확인 후 섭취',
                '피부병, 위생 문제 예방 위해 손씻기 등 철저 관리',
              ],
            ),
          ],
          onTtsPressed: _toggleTts,
          isSpeaking: isSpeaking,
        ),
        // 4. 관련 자료
        RelatedMaterialsSection(
          title: '관련 자료',
          subtitle: 'Related Materials',
          cardImageAsset: 'assets/rain_card.png',
          linkTitle: '국민재난안전포털 바로가기',
          linkUrl: 'https://www.safekorea.go.kr/idsiSFK/neo/sfk/cs/contents/prevent/prevent13.html?menuSeq=126',
        ),
      ],
    );
  }
}