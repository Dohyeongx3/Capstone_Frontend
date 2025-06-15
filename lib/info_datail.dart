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
          cardImageAsset: 'assets/typhoon,rain_card.png',
          linkTitle: '[국민재난안전포털] 태풍 바로가기',
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
          linkTitle: '[국민재난안전포털] 홍수 바로가기',
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
          cardImageAsset: 'assets/typhoon,rain_card.png',
          linkTitle: '[국민재난안전포털] 호우 바로가기',
          linkUrl: 'https://www.safekorea.go.kr/idsiSFK/neo/sfk/cs/contents/prevent/prevent18.html?menuSeq=126',
        ),
      ],
    );
  }
}

class LightningPage extends StatefulWidget {
  const LightningPage({super.key});

  @override
  State<LightningPage> createState() => _LightningPageState();
}

class _LightningPageState extends State<LightningPage> {
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
          '낙뢰 행동요령. '
              '낙뢰 발생 전. 야외 활동, 특히 등산, 캠핑, 골프 등은 취소하고 기상청 앱이나 재난 문자를 통해 날씨 정보를 확인하세요. '
              '번개가 관측되면 즉시 안전한 실내로 이동해야 합니다. '
              '낙뢰 발생 중. 산 정상이나 운동장처럼 높은 곳이나 개방된 공간에 머무르지 마세요. '
              '우산, 낚싯대, 자전거 등 금속 물체를 소지하지 않도록 하고, 나무 밑이나 텐트, 야외 간판 아래에서 피하지 마세요. '
              '실내에 있을 때는 플러그를 뽑고 전기제품 사용을 중단하세요. '
              '낙뢰가 지나간 후. 감전 증상이 있을 경우 즉시 119에 신고하고, 손상된 전기기기는 점검 후 사용하세요. '
              '정전이 발생한 경우 양초는 사용하지 말고 플래시나 손전등을 사용해 주세요.'
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
      disasterName: '돌발 낙뢰 (Lightning Strike)',
      mainImageAsset: 'assets/lightning_detail.png',
      infoRows: [
        InfoRowData(title: '발생 가능 시기', content: '연중 발생 가능 (특히 여름철 오후)'),
        InfoRowData(title: '경보 기준', content: '낙뢰주의보: 20분 이상 지속 예상 시'),
        InfoRowData(title: '피해 위험', content: '감전, 화재, 정전, 인명 피해'),
        InfoRowData(title: '관련 기관', content: '기상청, 한국전력, 행정안전부'),
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
                '낙뢰는 구름과 지면, 구름 간 전기적 불균형으로 생기는 방전 현상으로 순간적으로 매우 높은 전압과 강한 전류를 발생시켜 인명 피해와 화재, 정전 등을 유발합니다.',
              ],
            ),
            SectionBlock(
              title: '특징',
              items: [
                '전조 없이 갑작스럽게 발생 (돌발성)',
                '한 번 번개가 치면 주변에도 연속 낙뢰 가능',
                '여름철 오후 강한 대류 현상에 의해 자주 발생',
              ],
            ),
            SectionBlock(
              title: '발생 환경',
              items: [
                '뇌우, 대기불안정, 국지성 폭우 전후',
                '산, 들판, 해안, 골프장 등 개방된 공간',
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
              title: '감전 사고',
              items: [
                '전신 화상, 심장 마비, 즉사 가능성 있음',
              ],
            ),
            SectionBlock(
              title: '건축물 화재',
              items: [
                '낙뢰에 의해 건물 또는 기계 설비 화재 발생',
              ],
            ),
            SectionBlock(
              title: '정전 및 통신장애',
              items: [
                '전봇대, 송전선 파손 시 지역 전체 정전',
              ],
            ),
            SectionBlock(
              title: '개활지 사고',
              items: [
                '등산로, 캠핑장, 축구장 등에서 직접 맞을 위험',
              ],
            ),
            SectionBlock(
              title: '나무 아래 대기 시 2차 감전',
              items: [
                '뿌리 주변으로 전류 흐름, 매우 위험',
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
                '야외 활동(등산, 캠핑, 골프 등) 취소',
                '기상청 앱 또는 재난 문자 확인',
                '번개 관측 시 안전한 실내로 즉시 이동',
              ],
            ),
            SectionBlock(
              title: '낙뢰 발생 중',
              items: [
                '높은 곳, 개방된 공간에 있지 않기 (산 정상, 운동장 등)',
                '금속 물체(우산, 낚싯대, 자전거) 소지 금지',
                '나무 밑, 텐트, 야외 간판 아래 피하지 않기',
                '실내에선 플러그 뽑고 전기제품 사용 중단',
              ],
            ),
            SectionBlock(
              title: '낙뢰 이후',
              items: [
                '감전 증상 시 즉시 119 신고',
                '손상된 전기기기 점검 후 사용',
                '정전 시는 플래시 및 손전등 사용, 양초 금지',
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
          cardImageAsset: 'assets/lightning_card.png',
          linkTitle: '[국민재난안전포털] 낙뢰 바로가기',
          linkUrl: 'https://www.safekorea.go.kr/idsiSFK/neo/sfk/cs/contents/prevent/prevent03.html?menuSeq=126',
        ),
      ],
    );
  }
}

class HeavysnowPage extends StatefulWidget {
  const HeavysnowPage({super.key});

  @override
  State<HeavysnowPage> createState() => _HeavysnowPageState();
}

class _HeavysnowPageState extends State<HeavysnowPage> {
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
          '대설 행동요령. '
              '대설 예보 전에는 차량을 사전 점검하고 체인을 준비하며, 외출을 최소화하고 식량과 난방 기기를 점검해 주세요. '
              '기상청 앱이나 안전 문자 알림을 설정해 기상 상황을 실시간으로 확인하세요. '
              '대설 중에는 불필요한 외출을 삼가고, 고립될 우려가 있는 도로나 산간지역은 접근하지 마세요. '
              '가능하면 대중교통을 이용하고, 지붕 위의 눈을 제거할 경우 반드시 안전 장비를 착용한 후 작업하세요. '
              '대설 이후에는 빙판길에서 낙상에 주의하고, 미끄럼 방지를 위해 모래나 염화칼슘을 뿌려 주세요. '
              '주변 눈을 치울 때는 적절한 보호 장비를 착용하고, 침수되었거나 결빙된 구간은 피해서 이동하세요.'
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
      disasterName: '대설 (Heavy Snowfall)',
      mainImageAsset: 'assets/heavysnow_detail.png',
      infoRows: [
        InfoRowData(title: '발생 가능 시기', content: '12월 - 02월 (겨울철)'),
        InfoRowData(title: '경보 기준', content: '24시간 적설량 20cm 이상 (중부 기준)'),
        InfoRowData(title: '피해 위험', content: '교통 마비, 구조물 붕괴, 고립, 인명 사고'),
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
                '대설은 짧은 시간에 많은 눈이 집중적으로 내려 일상생활과 교통에 큰 영향을 주고, 구조물 붕괴, 고립, 낙상 등의 2차 피해를 유발하는 기상재해입니다.',
              ],
            ),
            SectionBlock(
              title: '발생 시기',
              items: [
                '주로 12월 - 02월 겨울철',
                '저기압, 북서풍, 대륙성 고기압 등의 영향',
              ],
            ),
            SectionBlock(
              title: '대설 경보 기준',
              items: [
                '중부지방: 24시간 동안 20cm 이상',
                '호남, 제주: 24시간 동안 30cm 이상',
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
              title: '교통 마비',
              items: [
                '차량 고립, 사고, 대중교통 지연',
              ],
            ),
            SectionBlock(
              title: '지붕 붕괴',
              items: [
                '적설 하중으로 건축물 붕괴 (창고, 체육관 등)',
              ],
            ),
            SectionBlock(
              title: '낙상 사고',
              items: [
                '도보 중 미끄러짐으로 인한 골절, 부상',
              ],
            ),
            SectionBlock(
              title: '정전 및 통신 장애',
              items: [
                '전신주 파손, 통신망 두절',
              ],
            ),
            SectionBlock(
              title: '고립 및 동상 위험',
              items: [
                '외부 활동 중 저체온증·동상 발생',
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
              title: '대설 예보 전',
              items: [
                '차량은 사전 점검 및 체인 준비',
                '외출 최소화, 식량·난방 기기 점검',
                '기상청 앱, 안전문자 알림 설정',
              ],
            ),
            SectionBlock(
              title: '대설 중',
              items: [
                '불필요한 외출 삼가기',
                '고립될 우려 있는 도로나 산간지역 접근 금지',
                '가급적 대중교통 이용',
                '지붕 위 적설 제거는 안전장비 착용 후 실시',
              ],
            ),
            SectionBlock(
              title: '대설 이후',
              items: [
                '낙상 주의 (모래·염화칼슘 뿌리기)',
                '주변 눈 치우기 시 적절한 보호장비 착용',
                '침수·결빙 구간 피하기',
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
          cardImageAsset: 'assets/heavysnow_card.png',
          linkTitle: '[국민재난안전포털] 대설 바로가기',
          linkUrl: 'https://www.safekorea.go.kr/idsiSFK/neo/sfk/cs/contents/prevent/prevent05.html?menuSeq=126',
        ),
      ],
    );
  }
}

class HeatwavePage extends StatefulWidget {
  const HeatwavePage({super.key});

  @override
  State<HeatwavePage> createState() => _HeatwavePageState();
}

class _HeatwavePageState extends State<HeatwavePage> {
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
          '폭염 행동요령.'
              '폭염 예보 전에는 기상 예보를 확인하고, 가까운 무더위 쉼터의 위치를 미리 파악해 두세요. '
              '햇빛 차단을 위해 창문이나 블라인드를 활용하고, 노약자나 어린이의 외출을 자제합니다. '
              '폭염 발생 중에는 낮 12시부터 오후 5시 사이의 실외 활동을 자제하세요. '
              '물을 자주 마시고, 카페인이나 알코올이 들어간 음료는 피하세요. '
              '헐렁하고 밝은 색의 옷을 착용하며, 냉방기기를 사용할 땐 무리하지 않도록 주의합니다. '
              '폭염이 오래 지속되거나 이후에는 온열 질환 증상이 나타나면 119에 신고하거나 가까운 의료기관을 방문하세요. '
              '냉방병을 피하기 위해 실내외 온도차를 조절하고, 무더위 쉼터를 적극 활용하며 주변 이웃의 안부도 함께 확인해 주세요.'
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
      disasterName: '폭염 (Heat Wave)',
      mainImageAsset: 'assets/heatwave_detail.png',
      infoRows: [
        InfoRowData(title: '발생 가능 시기', content: '07월 - 09월'),
        InfoRowData(title: '경보 기준', content: '폭염주의보: 33℃ 이상, 폭염경보: 35℃ 이상'),
        InfoRowData(title: '피해 위험', content: '열사병, 탈진, 온열질환, 농작물 피해'),
        InfoRowData(title: '관련 기관', content: '기상청, 질병관리청, 행정안전부'),
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
                '폭염은 여름철 기온이 비정상적으로 높게 오르며, 사람의 건강과 일상생활에 심각한 영향을 미치는 재난성 기상현상입니다.',
              ],
            ),
            SectionBlock(
              title: '기준',
              items: [
                '폭염주의보: 일 최고기온 33℃ 이상 이틀 이상 예상',
                '폭염경보: 일 최고기온 35℃ 이상 이틀 이상 예상',
              ],
            ),
            SectionBlock(
              title: '주 발생 시기',
              items: [
                '07월 중순 - 09월 초',
                '고기압 영향, 대기 정체 등으로 지속 가능',
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
              title: '열사병, 일사병',
              items: [
                '체온 조절 기능 마비 → 의식 소실, 사망 가능',
              ],
            ),
            SectionBlock(
              title: '탈수 및 탈진',
              items: [
                '수분·염분 부족, 어지럼증·근육경련 등 발생',
              ],
            ),
            SectionBlock(
              title: '노약자 및 어린이 위험',
              items: [
                '체온 조절 능력 약해 온열질환 취약',
              ],
            ),
            SectionBlock(
              title: '야외 작업자 위험',
              items: [
                '농사, 건설, 택배, 청소 등 직업군의 고위험',
              ],
            ),
            SectionBlock(
              title: '농축산물 피해',
              items: [
                '작물 고사, 가축 질병 증가',
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
              title: '폭염 예보 전',
              items: [
                '기상 예보 확인, 무더위 쉼터 위치 파악',
                '창문, 블라인드로 실내 햇빛 차단',
                '노약자·어린이 외출 자제',
              ],
            ),
            SectionBlock(
              title: '폭염 발생 중',
              items: [
                '실외 활동 최소화 (특히 12~17시)',
                '물 자주 마시기 (카페인·알코올 음료 X)',
                '헐렁하고 밝은 옷 착용',
                '냉방기기 무리한 사용 자제',
              ],
            ),
            SectionBlock(
              title: '폭염 이후 또는 장기화 시',
              items: [
                '온열질환 증상 시 119 또는 의료기관 방문',
                '냉방병 주의, 실내외 온도차 조절',
                '무더위 쉼터 이용 및 이웃 안부 확인',
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
          cardImageAsset: 'assets/heatwave_card.png',
          linkTitle: '[국민재난안전포털] 폭염 바로가기',
          linkUrl: 'https://www.safekorea.go.kr/idsiSFK/neo/sfk/cs/contents/prevent/prevent07.html?menuSeq=126',
        ),
      ],
    );
  }
}

class EarthquakePage extends StatefulWidget {
  const EarthquakePage({super.key});

  @override
  State<EarthquakePage> createState() => _EarthquakePageState();
}

class _EarthquakePageState extends State<EarthquakePage> {
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
          '지진 행동요령.'
              '지진 발생 전에는 가구는 단단히 고정하고, 낙하물이 없는 안전지대를 미리 확보하세요. '
              '대피소 위치를 파악하고, 가족 연락망을 정리하세요. '
              '손전등, 구급약, 생수 등 비상용품을 준비하세요. '
              '지진 발생 중에는 실내에서는 튼튼한 탁자 아래로 들어가 머리를 보호하고, 진동이 멈출 때까지 기다리세요. '
              '실외에서는 건물, 간판, 유리창 등에서 멀리 떨어지세요. '
              '운전 중일 경우 도로 우측에 정차하고, 라디오로 상황을 확인하세요. '
              '엘리베이터는 절대 사용하지 마세요. '
              '지진 발생 후에는 여진에 대비해 당분간 실내에 머물지 마세요. '
              '가스와 전기 차단을 확인한 후 행동하세요. '
              '구조대의 지시에 따르고, 주변 피해자를 도와주세요.'
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
      disasterName: '지진 (Earthquake)',
      mainImageAsset: 'assets/earthquake_detail.png',
      infoRows: [
        InfoRowData(title: '발생 가능 지역', content: '전국 (특히 활성 단층 인접 지역)'),
        InfoRowData(title: '위험 요인', content: '건물 붕괴, 낙하물, 화재, 2차 여진'),
        InfoRowData(title: '피해 위험', content: '인명 사고, 대피 지연, 정전·가스 누출'),
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
                '지진은 지각판의 충돌이나 단층 이동으로 발생하는 진동으로, 건축물 붕괴, 화재, 낙하물 등의 피해를 유발하는 자연재난입니다.',
              ],
            ),
            SectionBlock(
              title: '주요 피해 양상',
              items: [
                '강한 진동 → 건물 흔들림',
                '2차 피해: 화재, 유리 파손, 전기·가스 폭발',
              ],
            ),
            SectionBlock(
              title: '국내 지진 특징',
              items: [
                '최근 내륙 지진 증가 (경주, 포항 사례 등)',
                '규모 3.0 이상 지진 연간 수십 회 발생',
              ],
            ),
            SectionBlock(
              title: '2차 재난 위험성',
              items: [
                '여진: 최초 지진 후 반복되는 진동으로 추가 붕괴 유발',
                '지진해일(쓰나미): 해안 지진 시 발생 가능',
                '심리적 공황: 대피 혼란, 사회적 불안 증가',
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
              title: '건물 붕괴 및 낙하물',
              items: [
                '내진 설계 미비한 노후 건물 위험',
              ],
            ),
            SectionBlock(
              title: '유리창 파손 및 날카로운 파편',
              items: [
                '창문 근처 피하기',
              ],
            ),
            SectionBlock(
              title: '화재 및 가스 누출',
              items: [
                '진동 후 전기 불꽃, 가스 누출로 2차 피해',
              ],
            ),
            SectionBlock(
              title: '통신·전기·교통 두절',
              items: [
                '엘리베이터 고장, 통신망 마비',
              ],
            ),
            SectionBlock(
              title: '해안가 지진 시 지진해일(쓰나미) 우려',
              items: [
                '바닷가 지역은 즉시 고지대로 대피',
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
              title: '지진 발생 전',
              items: [
                '가구 고정, 낙하물 없는 안전지대 미리 확보',
                '대피소 위치, 가족 연락망 정리',
                '비상용품 준비: 손전등, 구급약, 생수 등',
              ],
            ),
            SectionBlock(
              title: '지진 발생 중',
              items: [
                '실내: 탁자 밑에서 머리 보호, 진동 멈출 때까지 기다리기',
                '실외: 건물, 간판, 유리창에서 멀리 떨어지기',
                '운전 중: 도로 우측 정차, 라디오로 상황 확인',
                '엘리베이터: 절대 사용 금지',
              ],
            ),
            SectionBlock(
              title: '지진 발생 후',
              items: [
                '여진 대비해 당분간 실내에 머물지 않기',
                '가스·전기 차단 확인 후 행동',
                '구조대 지시 따르고 주변 피해자 도와주기',
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
          cardImageAsset: 'assets/earthquake_card.png',
          linkTitle: '[국민재난안전포털] 지진 바로가기',
          linkUrl: 'https://www.safekorea.go.kr/idsiSFK/neo/sfk/cs/contents/prevent/prevent09.html?menuSeq=126',
        ),
      ],
    );
  }
}

class EarthquaketsunamiPage extends StatefulWidget {
  const EarthquaketsunamiPage({super.key});

  @override
  State<EarthquaketsunamiPage> createState() => _EarthquaketsunamiPageState();
}

class _EarthquaketsunamiPageState extends State<EarthquaketsunamiPage> {
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
          '지진해일 발생 시 행동요령. '
              '경보가 발생하면 즉시 고지대로 대피하세요. 해안선에서 최소 1에서 2킬로미터 이상 떨어진 곳으로 이동해야 합니다. '
              '절대 바다 방향으로 이동하거나, 해일을 직접 확인하러 가지 마세요. '
              '해안 산책로, 방파제, 부두 등 위험 지역에서는 즉시 벗어나야 합니다. '
              '해일이 도달하는 중에는, 불가피한 경우 높은 건물의 3층 이상으로 이동하세요. '
              '차량보다는 도보로 이동하는 것이 빠르고 안전합니다. '
              '가족이나 이웃에게 대피를 유도한 뒤, 자신의 안전을 먼저 확보하세요. '
              '해일 이후에는 당국의 안전 안내가 있기 전까지 해안에 접근하지 마세요. '
              '2차 해일에 대비하여 안전 지역에서 대기하세요. '
              '감전 위험이 있는 장소나 파손된 구조물에는 접근하지 마세요.'
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
      disasterName: '지진해일 (Tsunami)',
      mainImageAsset: 'assets/earthquaketsunami_detail.png',
      infoRows: [
        InfoRowData(title: '발생 가능 지역', content: '해안 인근 지역'),
        InfoRowData(title: '경보 기준', content: '인근 해역에서 규모 6.0 이상 해저지진 발생'),
        InfoRowData(title: '피해 위험', content: '고속 해일로 인한 해안 침수, 인명 피해'),
        InfoRowData(title: '관련 기관', content: '기상청, 해양수산부, 행정안전부'),
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
                '지진해일은 해저 지진이나 해저 산사태 등으로 인해 바닷물이 높은 파도로 해안으로 밀려드는 현상입니다.',
              ],
            ),
            SectionBlock(
              title: '특징',
              items: [
                '보이지 않는 속도로 빠르게 접근',
                '2차, 3차 해일이 반복적으로 도달 가능',
                '해안 가까운 지역일수록 피할 시간이 짧음',
              ],
            ),
            SectionBlock(
              title: '국내 주요 사례',
              items: [
                '1983년 일본 니가타 앞바다 지진 시, 동해안 일부 피해 발생',
                '한반도 인근 해역 지진 시 해일 발생 가능성 있음',
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
              title: '고속 해일',
              items: [
                '최대 시속 수백 km, 물러난 바닷물 뒤 강한 파도 도달',
              ],
            ),
            SectionBlock(
              title: '해안 침수 및 건물 파괴',
              items: [
                '저지대·항구·해수욕장 등 침수 가능성 큼',
              ],
            ),
            SectionBlock(
              title: '대피 지연',
              items: [
                '경보 후 수 분 내 도달 → 신속한 대피 필수',
              ],
            ),
            SectionBlock(
              title: '2차, 3차 해일',
              items: [
                '초기 해일 후 반복 파도 도달로 구조 중 사고 위험',
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
              title: '경보 발생 시',
              items: [
                '즉시 고지대로 대피 (해안선 기준 1~2km 이상 떨어지기)',
                '절대 바다 방향으로 이동하거나 확인하러 가지 말 것',
                '해안 산책로·방파제·부두 등 즉시 벗어나기',
              ],
            ),
            SectionBlock(
              title: '해일 도달 중',
              items: [
                '높은 건물의 3층 이상으로 이동 (불가피할 때)',
                '차량보다는 도보 이동이 빠르고 안전',
                '가족·이웃에게 대피 유도 후 개인 안전 우선 확보',
              ],
            ),
            SectionBlock(
              title: '해일 이후',
              items: [
                '당국의 안전 안내 전까지 해안 접근 금지',
                '2차 해일 대비 → 안전지역 대기',
                '감전, 파손 구조물 접근 금지',
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
          cardImageAsset: 'assets/tsunami_card.png',
          linkTitle: '[국민재난안전포털] 지진해일 바로가기',
          linkUrl: 'https://www.safekorea.go.kr/idsiSFK/neo/sfk/cs/contents/prevent/prevent10.html?menuSeq=126',
        ),
      ],
    );
  }
}

class LandslidePage extends StatefulWidget {
  const LandslidePage({super.key});

  @override
  State<LandslidePage> createState() => _LandslidePageState();
}

class _LandslidePageState extends State<LandslidePage> {
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
          '산사태 발생 시 행동요령. '
              '산사태 예보가 있을 경우, 산사태 우려 지역에 거주하는 주민은 즉시 안전지대로 이동해야 합니다. '
              '산 중턱 이상의 주거지에 거주하는 경우에는 일시 대피를 준비하세요. '
              '빗물 유입 통로를 정비하고, 배수로를 점검하여 산사태를 예방합니다. '
              '산사태 발생 징후가 감지되면 즉시 대피해야 합니다. '
              '지반에서 이상한 소리가 나거나 나무가 흔들릴 경우, 산 아래로부터 멀리 떨어진 안전한 곳으로 대피하세요. '
              '사면에 균열이 생기거나 토사가 유입되는 것이 보이면, 즉시 신고하고 안전한 곳으로 이동해야 합니다. '
              '산사태 발생 후에는 2차 붕괴의 위험이 있으므로 현장에 접근하지 마세요. '
              '복구 작업은 반드시 지자체나 소방 당국의 지시에 따라 협조해야 합니다. '
              '통신, 전기, 가스 등 위험 요소가 있는 시설에는 절대 접근하지 마세요.'
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
      disasterName: '산사태 (Landslide)',
      mainImageAsset: 'assets/landslide_detail.png',
      infoRows: [
        InfoRowData(title: '발생 가능 지역', content: '06월 - 09월 집중호우 시기  '),
        InfoRowData(title: '경보 기준', content: '시간당 30mm 이상 강우 시, 산사태 우려 지역'),
        InfoRowData(title: '피해 위험', content: '주택·도로 매몰, 인명 피해, 2차 붕괴'),
        InfoRowData(title: '관련 기관', content: '산림청, 행정안전부'),
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
                '산사태는 집중호우나 지진, 인위적 개발로 인해 산비탈 또는 토사가 한꺼번에 아래로 무너져 내리는 현상입니다.',
              ],
            ),
            SectionBlock(
              title: '주요 발생 조건',
              items: [
                '집중호우, 장마철 지속 강우',
                '무분별한 산지 개발',
                '벌채, 사면 붕괴 등 지반 약화',
              ],
            ),
            SectionBlock(
              title: '특징',
              items: [
                '발생 전 전조현상 있음 (나무 흔들림, 지반 갈라짐 등)',
                '발생 속도가 빨라 즉각적인 대피 필요',
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
              title: '주택·도로 매몰',
              items: [
                '산지 인접 주거지, 도로, 농경지 위험',
              ],
            ),
            SectionBlock(
              title: '집중호우로 인한 지반 붕괴',
              items: [
                '시간당 30mm 이상 강우 시 주의 필요',
              ],
            ),
            SectionBlock(
              title: '사면 붕괴 전조',
              items: [
                '나무 기울어짐, 땅 울림, 물 흐름 증가 등',
              ],
            ),
            SectionBlock(
              title: '2차 붕괴',
              items: [
                '1차 이후 잔여 토사 붕괴 위험',
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
              title: '산사태 예보 시',
              items: [
                '산사태 우려 지역 주민은 즉시 안전지대로 이동',
                '산 중턱 이상의 주거지는 일시 대피 준비',
                '빗물 유입 통로 정비, 배수로 점검',
              ],
            ),
            SectionBlock(
              title: '발생 징후 감지 시',
              items: [
                '지반에서 이상 소리가 나거나 나무가 흔들리면 즉시 산 아래로부터 멀리 대피',
                '사면 균열, 토사 유입 등 감지 시 신고 후 즉시 이동',
              ],
            ),
            SectionBlock(
              title: '발생 후',
              items: [
                '2차 붕괴 가능성 있으므로 현장 접근 금지',
                '지자체 또는 소방 당국 지시에 따라 복구 협조',
                '통신·전기·가스 등 위험 요소 접근 금지',
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
          cardImageAsset: 'assets/landslide_card.png',
          linkTitle: '[국민재난안전포털] 산사태 바로가기',
          linkUrl: 'https://www.safekorea.go.kr/idsiSFK/neo/sfk/cs/contents/prevent/prevent20.html?menuSeq=126',
        ),
      ],
    );
  }
}

class TsunamiPage extends StatefulWidget {
  const TsunamiPage({super.key});

  @override
  State<TsunamiPage> createState() => _TsunamiPageState();
}

class _TsunamiPageState extends State<TsunamiPage> {
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
          '해일 발생 시 행동요령. '
              '먼저, 경보를 수신한 경우에는 해안에서 즉시 고지대로 대피하고, 해발 10미터 이상 지역으로 이동하는 것이 좋습니다. '
              '바닷가나 방파제 등지에는 접근을 즉시 중단해야 하며, 가까운 구조물에 올라가는 대신 충분한 거리를 확보해야 합니다. '
              '해일이 도달할 때에는 고층 건물의 높은 층으로 이동해야 하며, 이동이 불가능한 경우 안전한 장소에서 대기합니다. '
              '구조 요청은 전화보다는 문자 메시지나 재난 안전 앱을 사용하는 것이 더 효율적입니다. '
              '해일 이후에는 2차 해일 가능성에 대비하여 구조가 완료되기 전까지는 절대 원래 위치로 복귀하지 마세요. '
              '침수된 지역에서는 감전 사고가 발생할 수 있으므로 전기 차단을 요청하고, 전기 설비 주변에는 접근하지 않아야 합니다.'
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
      disasterName: '해일 (Tidal Wave)',
      mainImageAsset: 'assets/tsunami_detail.png',
      infoRows: [
        InfoRowData(title: '발생 원인', content: '지진, 화산, 해저 산사태 등으로 인한 해수 급변'),
        InfoRowData(title: '피해 지역', content: '해안 지역, 항구, 저지대 마을'),
        InfoRowData(title: '피해 위험', content: '해안 침수, 구조물 파손, 인명 피해'),
        InfoRowData(title: '관련 기관', content: '기상청, 해양수산부, 행정안전부'),
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
                '해일은 지진, 해저 산사태, 화산 폭발 등 지형적 요인으로 갑자기 해수가 이동하면서 발생하는 거대한 파도입니다. 일반적인 조석(밀물·썰물)과는 구분되는 재해성 자연 현상입니다.',
              ],
            ),
            SectionBlock(
              title: '구분',
              items: [
                '지진해일(Tsunami): 해저 지진으로 발생',
                '폭풍해일(Storm Surge): 태풍과 저기압이 원인',
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
              title: '급격한 해수 상승 및 침수',
              items: [
                '해안 마을, 부두, 저지대 침수 피해 발생',
              ],
            ),
            SectionBlock(
              title: '항만 파괴 및 선박 전복',
              items: [
                '방파제·배 등 구조물 파손',
              ],
            ),
            SectionBlock(
              title: '예고 없이 닥치는 2차·3차 해일',
              items: [
                '최초 파도 이후에도 반복 충격 발생',
              ],
            ),
            SectionBlock(
              title: '해안 접근 시 치명적 위험',
              items: [
                '물러난 바닷물에 접근 → 갑작스러운 역류로 실종',
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
              title: '경보 수신 시',
              items: [
                '해안에서 즉시 고지대로 대피 (해발 10m 이상 권장)',
                '바닷가·방파제 등지 접근 즉시 중단',
                '가까운 구조물로 올라가지 말고 거리 확보',
              ],
            ),
            SectionBlock(
              title: '해일 도달 시',
              items: [
                '고층 건물 내 고층 이동 (이동 불가 시)',
                '구조 요청은 전화보다는 문자 또는 재난 앱 이용',
              ],
            ),
            SectionBlock(
              title: '해일 이후',
              items: [
                '2차 해일에 대비해 구조 완료 전 복귀 금지',
                '침수 지역 감전 사고 주의 (전기 차단 요청)',
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
          cardImageAsset: 'assets/tsunami_card.png',
          linkTitle: '[국민재난안전포털] 해일 바로가기',
          linkUrl: 'https://www.safekorea.go.kr/idsiSFK/neo/sfk/cs/contents/prevent/prevent10.html?menuSeq=126',
        ),
      ],
    );
  }
}

class TidePage extends StatefulWidget {
  const TidePage({super.key});

  @override
  State<TidePage> createState() => _TidePageState();
}

class _TidePageState extends State<TidePage> {
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
          '조류 발생 시 행동요령. '
              '조류가 빠른 해역에서 활동하기 전에는 반드시 해당 지역의 물때표, 즉 간조와 만조 시각을 확인해야 합니다. '
              '해양 체험이나 낚시는 조류가 약한 간조 전후 2시간 이내로 제한하는 것이 안전합니다. '
              '조류가 강해지고 만조 도달이 임박하면 즉시 퇴로가 확보된 위치로 복귀하고, 방파제나 갯바위에서 활동 중일 경우에는 수위 상승에 각별히 주의해야 합니다. '
              '만약 조류에 의해 고립되었다면, 당황하지 말고 위치 정보를 포함하여 119에 신고하고, 높은 지대에서 구조를 기다리세요.'
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
      disasterName: '조수 (Tidal Phenomena)',
      mainImageAsset: 'assets/tide_detail.png',
      infoRows: [
        InfoRowData(title: '발생 원인', content: '달과 태양의 인력에 의한 해수면의 주기적 변화'),
        InfoRowData(title: '피해 위험', content: '간조·만조로 인한 갯벌 고립, 항해 지연'),
        InfoRowData(title: '주의 지역', content: '갯벌, 방파제, 연안 낚시터 등'),
        InfoRowData(title: '관련 기관', content: '해양수산부, 기상청'),
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
                '조수(또는 조석)는 달과 태양의 인력 작용으로 인해 바닷물의 수위가 주기적으로 오르내리는 자연현상입니다. 만조(밀물)와 간조(썰물)의 주기가 있으며, 갯벌 고립사고나 해안가 활동에 영향을 줄 수 있습니다.',
              ],
            ),
            SectionBlock(
              title: '주의 이유',
              items: [
                '일반적 현상이지만, 계절별 조차(수위 차) 변화가 크며',
                '대조기, 슈퍼문 등 특정 시기에는 위험 증가',
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
              title: '갯벌 고립',
              items: [
                '간조 시 진입 → 만조 도달 시 퇴로 차단',
              ],
            ),
            SectionBlock(
              title: '해안 낚시 중 고립',
              items: [
                '테트라포드·방파제 등 물때 예측 실패',
              ],
            ),
            SectionBlock(
              title: '항해·운항 차질',
              items: [
                '간조 시 항로 수심 낮아져 접안 불가',
              ],
            ),
            SectionBlock(
              title: '사전 정보 없이 접근한 관광객',
              items: [
                '물때표 미확인 시 의외의 사고 발생',
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
              title: '갯벌 체험/해안 낚시 전',
              items: [
                '해당 지역 물때표(간조/만조 시각) 필수 확인',
                '체험 가능 시간은 간조 전후 2시간 이내로 제한',
              ],
            ),
            SectionBlock(
              title: '만조 도달 임박 시',
              items: [
                '퇴로 확보된 위치로 즉시 복귀',
                '방파제·갯바위에서 활동 시 수위 상승 주의',
              ],
            ),
            SectionBlock(
              title: '고립 발생 시',
              items: [
                '구조 요청 시 위치 정보 포함해 119 신고',
                '당황하지 말고 높은 지대에서 구조 대기',
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
          cardImageAsset: 'assets/tide_card.png',
          linkTitle: '[국민재난안전포털] 조류 바로가기',
          linkUrl: 'https://www.safekorea.go.kr/idsiSFK/neo/sfk/cs/contents/prevent/prevent10.html?menuSeq=126',
        ),
      ],
    );
  }
}

class FloodingPage extends StatefulWidget {
  const FloodingPage({super.key});

  @override
  State<FloodingPage> createState() => _FloodingPageState();
}

class _FloodingPageState extends State<FloodingPage> {
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
          '침수 발생 시 행동요령. '
              '사전 대비로는 반지하나 1층 주택에 거주하시는 분들은 역류 방지판과 물막이판을 설치하고, 침수 경보를 받으면 전기 차단기를 미리 내려야 합니다. '
              '또한 지하주차장 등 침수 위험 지역에는 차량을 주차하지 마세요. '
              '침수가 진행될 경우, 즉시 고지대나 옥상으로 대피하고, 하수구나 전기장치 근처에는 접근하지 마세요. '
              '지하차도나 도로의 침수 구간은 절대 진입하지 않아야 합니다. '
              '침수 이후에는 반드시 전기와 가스 전문가의 점검을 받은 후 복구를 시작해야 하며, 젖은 가전제품은 절대로 사용하지 마세요. '
              '물 빠진 후에도 감전 사고가 발생할 수 있으니 각별히 주의하시기 바랍니다.'
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
      disasterName: '침수 (Inundation)',
      mainImageAsset: 'assets/flooding_detail.png',
      infoRows: [
        InfoRowData(title: '발생 원인', content: '집중호우, 하천 범람, 하수 역류, 해수 유입 등'),
        InfoRowData(title: '피해 지역', content: '저지대 주택가, 반지하, 도로, 지하상가 등'),
        InfoRowData(title: '피해 위험', content: '가전 침수, 감전, 인명 피해, 교통 마비'),
        InfoRowData(title: '관련 기관', content: '기상청, 소방청, 지자체 재난대응본부'),
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
                '침수는 일정 지역이 비·하천·하수 등의 물로 인해 잠기는 현상입니다. 특히 도심에서는 하수 역류, 빗물 유입으로 지하 주거지·차량·상가가 피해를 입기 쉽습니다.',
              ],
            ),
            SectionBlock(
              title: '구분',
              items: [
                '단시간 강우 → 하수역류 침수',
                '강변·저지대 → 하천 범람 침수',
                '해안지역 → 폭풍 해일·조위 상승 침수',
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
              title: '반지하 주택·저지대 침수',
              items: [
                '하수 역류로 실내 급속도 침수',
              ],
            ),
            SectionBlock(
              title: '감전 및 가스 사고',
              items: [
                '콘센트 침수, 누전, 보일러·가스 유출',
              ],
            ),
            SectionBlock(
              title: '도로 침수 및 차량 고립',
              items: [
                '지하차도, 하천 인근 도로 급속도 물에 잠',
              ],
            ),
            SectionBlock(
              title: '하수도 맨홀 뚜껑 유실',
              items: [
                '물에 잠겨 보이지 않아 보행 중 추락 위험',
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
              title: '사전 대비',
              items: [
                '반지하·1층 주택: 역류방지판, 물막이판 설치',
                '침수 경보 수신 시 전기 차단기 미리 내리기',
                '침수 위험 지역 주차 금지 (지하주차장 등)',
              ],
            ),
            SectionBlock(
              title: '침수 진행 중',
              items: [
                '침수 시작 시 즉시 고지대 또는 옥상으로 대피',
                '하수구, 전기장치 근처 접근 X',
                '지하차도, 도로 침수 구간 진입 절대 금지',
              ],
            ),
            SectionBlock(
              title: '침수 후',
              items: [
                '반드시 전기·가스 전문가 점검 후 복구 시작',
                '젖은 가전제품 사용 금지, 물 빠진 후에도 주의 필요',
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
          cardImageAsset: 'assets/flooding_card.png',
          linkTitle: '[국민재난안전포털] 침수 바로가기',
          linkUrl: 'https://www.safekorea.go.kr/idsiSFK/neo/sfk/cs/contents/prevent/prevent21.html?menuSeq=126',
        ),
      ],
    );
  }
}

class SpacePage extends StatefulWidget {
  const SpacePage({super.key});

  @override
  State<SpacePage> createState() => _SpacePageState();
}

class _SpacePageState extends State<SpacePage> {
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
          '우주전파재난 시 행동요령. '
              '일반 시민의 경우, 일상생활에 직접적인 피해는 드물지만 위성 기반 서비스, 예를 들어 GPS 사용 시 오차가 발생할 수 있다는 점을 인지해야 합니다. '
              '또한 항공기 탑승 시에는 기상청과 항공사의 우주기상 알림을 참고하는 것이 좋습니다. '
              '정부와 관련 기관은 위성, 항공, 전력 시스템에 대한 보호 조치를 강화하고, 태양 활동을 상시 감시하며 즉시 알림 체계를 운영해야 합니다.'
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
      disasterName: '우주전파재난 (Space Weather Hazard)',
      mainImageAsset: 'assets/space_detail.png',
      infoRows: [
        InfoRowData(title: '발생 원인', content: '태양폭발(플레어), 코로나질량방출(CME) 등'),
        InfoRowData(title: '영향 대상', content: '위성, GPS, 항공기 통신, 전력망 등'),
        InfoRowData(title: '피해 위험', content: '통신두절, 항공운항 장애, 위성 고장'),
        InfoRowData(title: '관련 기관', content: '한국천문연구원, 과학기술정보통신부, 기상청'),
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
                '우주전파재난은 태양 활동의 급격한 변화(예: 태양 플레어, CME 등)로 인해 지구 주변의 전자기 환경에 영향을 미치는 현상입니다. 통신, 항공, 위성, 전력 시스템에 장애를 일으킬 수 있습니다.',
              ],
            ),
            SectionBlock(
              title: '주요 원인',
              items: [
                '태양 플레어(Solar Flare)',
                '코로나질량방출(Coronal Mass Ejection)',
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
              title: 'GPS·위성통신 오류',
              items: [
                '위치정보 왜곡, 군사용 장비 오류',
              ],
            ),
            SectionBlock(
              title: '항공기 운항 장애',
              items: [
                '고위도 노선 통신 불능, 경로 변경',
              ],
            ),
            SectionBlock(
              title: '전력망 장애',
              items: [
                '지자기폭풍으로 인한 변압기 손상',
              ],
            ),
            SectionBlock(
              title: '위성 장비 오작동',
              items: [
                '태양 입자에 의한 회로 오류',
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
              title: '일반 시민',
              items: [
                '일상생활에 직접적 피해는 드물지만 위성 기반 서비스 (GPS 등) 사용 시 오차 가능성 인지',
                '항공기 탑승 시 기상청·항공사 우주기상 알림 참고',
              ],
            ),
            SectionBlock(
              title: '정부/기관',
              items: [
                '위성·항공·전력 시스템 보호 조치 강화',
                '태양 활동 감시 및 즉시 알림 체계 운영',
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
          cardImageAsset: 'assets/space_card.png',
          linkTitle: '[국민재난안전포털] 우주전파재난 바로가기',
          linkUrl: 'https://www.safekorea.go.kr/idsiSFK/neo/sfk/cs/contents/prevent/prevent10.html?menuSeq=126',
        ),
      ],
    );
  }
}

class BlazePage extends StatefulWidget {
  const BlazePage({super.key});

  @override
  State<BlazePage> createState() => _BlazePageState();
}

class _BlazePageState extends State<BlazePage> {
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
          '대형 화재 행동요령.'
              '화재 발생 전에 소화기, 경보기, 피난 유도등을 설치하고 정기적으로 점검하세요. '
              '비상 대피 통로를 미리 확인하고 숙지하며, 전기와 가스 시설은 주기적으로 점검해야 합니다. '
              '화재 발생 시 불이 난 것을 인지하면 즉시 "불이야!"라고 외쳐 주변에 알립니다. '
              '연기를 피하려면 자세를 낮추고, 입과 코는 젖은 수건이나 옷으로 가리며 이동하세요. '
              '엘리베이터 대신 반드시 계단을 이용하고, 피할 수 없다면 방문을 닫고 문틈을 막은 뒤 구조를 요청하세요. '
              '화재 이후에는 화상이나 연기 흡입 증상이 있다면 즉시 병원에서 진료를 받습니다. '
              '사고가 발생한 장소에는 접근하지 말고, 재난지원금이나 주거 지원 등 피해 복구 절차를 확인하여 필요한 지원을 받으세요.'
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
      disasterName: '대형 화재 (Blaze)',
      mainImageAsset: 'assets/blaze_detail.png',
      infoRows: [
        InfoRowData(title: '발생 가능 장소', content: '다중이용시설, 공장, 고층 건물 등'),
        InfoRowData(title: '위험 요인', content: '전기 누전, 가스 누출, 방화, 부주의'),
        InfoRowData(title: '피해 위험', content: '질식, 화상, 대피 지연, 인명·재산 피해'),
        InfoRowData(title: '관련 기관', content: '소방청, 경찰청, 행정안전부'),
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
                '대형 화재는 대규모 인명 피해나 재산 피해를 동반하는 화재로,다중이용시설·공장·주거지 등에서 빠르게 확산될 수 있어 사전 예방과 신속한 대응이 중요합니다.',
              ],
            ),
            SectionBlock(
              title: '발생 장소',
              items: [
                '고층 건물, 지하상가, 병원, 공장, 물류센터 등',
              ],
            ),
            SectionBlock(
              title: '주요 원인',
              items: [
                '전기 누전, 가스 누출, 방화, 흡연, 인화물질 취급 부주의 등',
              ],
            ),
            SectionBlock(
              title: '화재 발생 시 피해 유형',
              items: [
                '질식, 화상, 붕괴, 유독가스 중독, 대피 지연으로 인한 대규모 인명 피해',
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
              title: '불길 확산',
              items: [
                '가연성 자재, 구조적 문제로 확산 속도 매우 빠름',
              ],
            ),
            SectionBlock(
              title: '유독가스 흡입',
              items: [
                '질식 및 중독 위험 (CO, 유기화합물 등)',
              ],
            ),
            SectionBlock(
              title: '대피 지연',
              items: [
                '연기 확산으로 시야 확보 어려움',
              ],
            ),
            SectionBlock(
              title: '소방 설비 미작동',
              items: [
                '스프링클러·비상등 등 점검 미흡 시 대응 불가',
              ],
            ),
            SectionBlock(
              title: '패닉 및 붕괴 위험',
              items: [
                '인파 밀집 시 압사 사고 가능',
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
              title: '화재 발생 전',
              items: [
                '소화기·경보기·피난 유도등 설치 및 점검',
                '비상 대피 통로 확인 및 숙지',
                '전기·가스 시설 주기적 점검',
              ],
            ),
            SectionBlock(
              title: '화재 발생 시',
              items: [
                '불이 난 것을 인지하면 즉시 “불이야!” 외치기',
                '연기 피해 낮은 자세로 이동, 입과 코는 젖은 수건으로 가리기',
                '엘리베이터 대신 계단 이용',
                '피할 수 없으면 방 안에서 문틈 막고 구조 요청',
              ],
            ),
            SectionBlock(
              title: '화재 이후',
              items: [
                '화상·연기흡입 등 증상 시 즉시 병원 진료',
                '사고 장소 접근 금지',
                '재난지원금, 주거지원 등 피해 복구 절차 확인',
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
          cardImageAsset: 'assets/blaze_card.png',
          linkTitle: '[국민재난안전포털] 화재 바로가기',
          linkUrl: 'https://www.safekorea.go.kr/idsiSFK/neo/sfk/cs/contents/prevent/SDIJKM5116.html?menuSeq=127',
        ),
      ],
    );
  }
}

class ExplosionPage extends StatefulWidget {
  const ExplosionPage({super.key});

  @override
  State<ExplosionPage> createState() => _ExplosionPageState();
}

class _ExplosionPageState extends State<ExplosionPage> {
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
          '산업 폭발 행동요령.'
              '폭발 위험 징후가 있을 경우, 이상한 냄새나 연기, 소리 등을 감지하면 즉시 관리자에게 보고하세요. '
              '작업장 내에서는 화기 사용을 금지하고, 방진 마스크나 방폭복 같은 보호장비를 반드시 착용해야 합니다. '
              '폭발이 발생하면 폭발음이 들리는 즉시 엎드리거나 자세를 낮추고 머리를 보호하세요. '
              '불길이 있는 방향과 반대쪽으로 신속히 대피하며, 엘리베이터는 사용하지 말고 반드시 계단을 이용해야 합니다. '
              '유독가스가 발생한 경우에는 젖은 천으로 코와 입을 가리고 호흡하세요. '
              '사고 이후에는 부상자가 있을 경우 즉시 119에 신고하고, 유해가스가 우려될 경우 환기를 최소화한 채 실내에 머무르세요. '
              '구조 요청을 한 후에는 반드시 당국의 안내에 따라 행동하시기 바랍니다.'
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
      disasterName: '산업 폭발 (Industrial Explosion)',
      mainImageAsset: 'assets/explosion_detail.png',
      infoRows: [
        InfoRowData(title: '발생 가능 장소', content: '공장, 화학시설, 저장소, 건설현장 등'),
        InfoRowData(title: '위험 요인', content: '가스 누출, 화약류 취급, 정전기, 과열'),
        InfoRowData(title: '피해 위험', content: '폭발 충격, 화재, 유독가스, 다수 인명 피해'),
        InfoRowData(title: '관련 기관', content: '고용노동부, 소방청, 행정안전부'),
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
                '산업 폭발은 산업 현장에서의 가연성 가스, 분진, 화학물질 등의 누출 또는 이상 반응으로 인해 발생하는 대규모 폭발 사고입니다.',
              ],
            ),
            SectionBlock(
              title: '발생 장소',
              items: [
                '석유화학 공장, 제약·화학물질 저장소, 용접 작업장, 가스 충전소 등',
              ],
            ),
            SectionBlock(
              title: '폭발 피해 특성',
              items: [
                '순간적인 폭발 충격 + 연쇄 화재 발생',
                '유독가스 발생 → 2차 인명 피해',
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
              title: '강한 폭발 충격',
              items: [
                '창문 파손, 건물 붕괴, 신체 손상',
              ],
            ),
            SectionBlock(
              title: '연쇄 화재 발생',
              items: [
                '주변 가연물 확산 → 대형화재로 이어짐',
              ],
            ),
            SectionBlock(
              title: '유독가스 누출',
              items: [
                '흡입 시 질식, 화학 화상, 중독 증상',
              ],
            ),
            SectionBlock(
              title: '화학물질 노출',
              items: [
                '피부 접촉·흡입 시 심각한 건강 피해',
              ],
            ),
            SectionBlock(
              title: '2차 폭발 위험',
              items: [
                '누출된 가스·분진 등으로 추가 폭발 가능',
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
              title: '폭발 위험 징후 시',
              items: [
                '이상 냄새, 연기, 소리 감지 즉시 관리자에게 보고',
                '작업장 내 화기 사용 금지',
                '보호장비(방진 마스크, 방폭복 등) 착용 철저',
              ],
            ),
            SectionBlock(
              title: '폭발 발생 시',
              items: [
                '폭발음이 들리면 즉시 엎드리거나 몸을 낮추고 머리 보호',
                '불길 방향 반대로 신속히 대피',
                '엘리베이터 금지, 계단 이용',
                '유독가스 발생 시 젖은 천으로 코·입 가리고 호흡',
              ],
            ),
            SectionBlock(
              title: '사고 이후',
              items: [
                '부상자는 즉시 119 신고',
                '환기는 최소화하고 실내에 머무르기 (유해가스 우려 시)',
                '구조 요청 후 당국 안내에 따르기',
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
          cardImageAsset: 'assets/explosion_card.png',
          linkTitle: '[국민재난안전포털] 폭발 바로가기',
          linkUrl: 'https://www.safekorea.go.kr/idsiSFK/neo/sfk/cs/contents/prevent/SDIJKM5116.html?menuSeq=127',
        ),
      ],
    );
  }
}

class CollapsePage extends StatefulWidget {
  const CollapsePage({super.key});

  @override
  State<CollapsePage> createState() => _CollapsePageState();
}

class _CollapsePageState extends State<CollapsePage> {
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
          '건축물 붕괴 사고 행동요령.'
              '붕괴 징후가 있을 경우, 균열 소리나 벽면의 균열, 진동, 이상한 냄새가 감지되면 즉시 건물 밖으로 대피하세요. '
              '엘리베이터는 사용하지 말고, 관리자나 119에 신고한 후 주변 사람들에게도 위험을 알리세요. '
              '붕괴가 발생하면 무너지는 소리가 들리는 즉시 책상이나 탁자 아래로 들어가 머리를 보호하고, '
              '외부 낙하물로부터 피해를 줄이기 위해 벽 쪽에 밀착해 대기하세요. '
              '엘리베이터는 절대 사용하지 말고, 계단이나 비상구를 이용해 대피합니다. '
              '먼지를 피하기 위해 젖은 수건이나 옷으로 입과 코를 가리세요. '
              '붕괴 이후 매몰되었을 경우에는 큰 소리로 외치기보다는 벽을 두드려 구조 요청을 하세요. '
              '휴대폰 불빛이나 두드리는 소리로 자신의 위치를 알리고, 구조 시까지는 가급적 움직이지 마세요. '
              '구조된 이후에는 붕괴 현장에 접근하지 말고, 의료진의 안내에 따라 행동하세요.'
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
      disasterName: '건축물 붕괴 (Building Collapse)',
      mainImageAsset: 'assets/collapse_detail.png',
      infoRows: [
        InfoRowData(title: '발생 가능 장소', content: '노후 건물, 공사장, 불법 증축 건물 등'),
        InfoRowData(title: '위험 요인', content: '구조 부실, 부실 시공, 지반 침하, 과적재'),
        InfoRowData(title: '피해 위험', content: '붕괴 매몰, 부상, 인명 사고, 2차 사고'),
        InfoRowData(title: '관련 기관', content: '국토교통부, 소방청, 행정안전부'),
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
                '건축물 붕괴는 구조적 약화, 시공 결함, 외부 충격 등에 의해 건물 일부 또는 전체가 무너지는 사고로, 인명 피해와 2차 사고 위험이 매우 높은 재난입니다.',
              ],
            ),
            SectionBlock(
              title: '주요 발생 장소',
              items: [
                '노후화된 건물, 무단 증·개축 건물',
                '대형 건축물 공사 현장',
                '지하층이 있는 건축물',
              ],
            ),
            SectionBlock(
              title: '주요 원인',
              items: [
                '부실시공, 설계 오류, 구조물 부식',
                '지반 침하, 집중호우, 지진 등 외부 요인',
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
              title: '전체 또는 부분 붕괴',
              items: [
                '구조물 전도, 낙하물 추락',
              ],
            ),
            SectionBlock(
              title: '공사현장 위험',
              items: [
                '타워크레인, 거푸집, 철근 구조물 붕괴 가능',
              ],
            ),
            SectionBlock(
              title: '불법 증축·노후 건물',
              items: [
                '하중 초과 및 철근·콘크리트 손상',
              ],
            ),
            SectionBlock(
              title: '지하공간 연쇄 붕괴',
              items: [
                '지하 주차장 붕괴 → 상부 구조 붕괴 연계',
              ],
            ),
            SectionBlock(
              title: '2차 화재·가스 누출',
              items: [
                '배관 파손, 전기 스파크로 인한 화재 가능',
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
              title: '붕괴 징후 시',
              items: [
                '균열 소리, 벽면 균열, 진동, 이상한 냄새 감지 시 즉시 대피',
                '건물 밖으로 빠르게 이동, 가능 시 엘리베이터 사용 금지',
                '관리자 또는 119에 신고 후 주변 사람에게 경고',
              ],
            ),
            SectionBlock(
              title: '붕괴 발생 시',
              items: [
                '무너지는 소리가 나면 책상·탁자 아래로 들어가 머리 보호',
                '외부 낙하물 피해 방지를 위해 벽 쪽 밀착 대기',
                '엘리베이터 절대 금지, 계단이나 비상구 이용',
                '먼지를 피하기 위해 젖은 수건·옷으로 입과 코 가리기',
              ],
            ),
            SectionBlock(
              title: '붕괴 이후',
              items: [
                '매몰 시 큰 소리보다는 “두드리기”로 구조 요청',
                '휴대폰 불빛, 벽 두드림 등으로 위치 알리기',
                '구조 시까지 가급적 움직이지 않기',
                '구조 후에는 현장 접근 삼가고 의료진 안내 받기',
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
          cardImageAsset: 'assets/collapse_card.png',
          linkTitle: '[국민재난안전포털] 붕괴 바로가기',
          linkUrl: 'https://www.safekorea.go.kr/idsiSFK/neo/sfk/cs/contents/prevent/SDIJKM5118.html?menuSeq=127',
        ),
      ],
    );
  }
}

class DamPage extends StatefulWidget {
  const DamPage({super.key});

  @override
  State<DamPage> createState() => _DamPageState();
}

class _DamPageState extends State<DamPage> {
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
          '댐 붕괴 사고 행동요령.'
              '붕괴 징후가 있을 경우, 경고 방송이나 재난 문자를 확인하고 즉시 대피 준비를 합니다. '
              '긴급 방송이 나오면 지체하지 말고 고지대로 이동하세요. '
              '차량보다는 도보로 대피하는 것이 안전합니다. 교통 혼잡을 피할 수 있기 때문입니다.'
              '댐이 붕괴되면, 낮은 지역을 즉시 벗어나 고지대나 건물 옥상 등 높은 곳으로 대피하세요. '
              '물이 빠르게 흐르거나 깊은 곳에는 절대 접근하지 마시고, 가정 내 전기와 가스는 차단하여 감전이나 폭발을 예방합니다. '
              '가족이나 이웃과 함께 행동하고, 고립된 경우 구조를 요청하세요.'
              '사고 이후에는 안전이 확인되기 전까지 절대 해당 지역으로 돌아가지 마세요. '
              '감염병을 예방하기 위해 오염된 물이나 음식물은 섭취하지 않고, 침수된 전기 제품은 사용하지 않아야 합니다. '
              '당국의 복구 지침에 따라 신속하고 안전하게 행동하세요.'
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
      disasterName: '댐 붕괴 (Dam Failure)',
      mainImageAsset: 'assets/dam_detail.png',
      infoRows: [
        InfoRowData(title: '발생 가능 장소', content: '중·대형 댐, 저수지, 하천 상류 지역'),
        InfoRowData(title: '위험 요인', content: '집중호우, 지진, 구조적 결함, 노후화'),
        InfoRowData(title: '피해 위험', content: '급격한 범람, 침수, 인명 피해, 기반 시설 파괴'),
        InfoRowData(title: '관련 기관', content: '환경부, 수자원공사, 행정안전부'),
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
                '댐 붕괴는 집중호우나 지진 등 외부 충격 또는 구조적 결함으로 인해 댐이 무너져 대량의 물이 하류 지역으로 급격히 유입되어 대규모 침수 및 인명 피해를 유발하는 재난입니다.',
              ],
            ),
            SectionBlock(
              title: '주요 발생 원인',
              items: [
                '폭우·홍수로 인한 수위 초과',
                '지반 침하, 댐 노후화, 부실 시공',
                '테러, 외부 충격, 설비 오작동 등',
              ],
            ),
            SectionBlock(
              title: '영향 지역',
              items: [
                '하류 마을, 주거지, 농경지, 도로, 철도, 통신 기반시설',
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
              title: '급격한 대량 범람',
              items: [
                '수십 분 내 저지대 침수',
              ],
            ),
            SectionBlock(
              title: '하류 마을 침수',
              items: [
                '구조 어려움, 고립 위험',
              ],
            ),
            SectionBlock(
              title: '교량·도로 붕괴',
              items: [
                '기반시설 침수 → 복구 장기화',
              ],
            ),
            SectionBlock(
              title: '감전 및 화재 위험',
              items: [
                '변전시설 침수 → 정전 및 누전 사고',
              ],
            ),
            SectionBlock(
              title: '잔해물 유입',
              items: [
                '유목·토사로 추가 피해',
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
              title: '붕괴 징후 시',
              items: [
                '경고 방송·재난 문자 확인 즉시 대피 준비',
                '긴급 방송 시 지체 없이 고지대로 이동',
                '차량보다 도보 대피 권장 (교통 혼잡 피하기)',
              ],
            ),
            SectionBlock(
              title: '붕괴 발생 시',
              items: [
                '낮은 지역은 즉시 벗어나 고지대·건물 옥상으로 대피',
                '유속이 빠르거나 수심이 깊은 곳 접근 금지',
                '가정 내 전기·가스 차단 (감전·폭발 방지)',
                '가족·이웃과 함께 행동하고 고립 시 구조 요청',
              ],
            ),
            SectionBlock(
              title: '붕괴 이후',
              items: [
                '안전 확인 전까지 돌아가지 않기',
                '감염병 예방 위해 수인성 오염물·오염 음식물 주의',
                '침수 후 전기기기 사용 금지',
                '당국 복구 지침 따르기',
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
          cardImageAsset: 'assets/blaze_card.png',
          linkTitle: '[국민재난안전포털] 댐 붕괴 바로가기',
          linkUrl: 'https://www.safekorea.go.kr/idsiSFK/neo/sfk/cs/contents/prevent/SDIJKM5132.html?menuSeq=127',
        ),
      ],
    );
  }
}

class WildfirePage extends StatefulWidget {
  const WildfirePage({super.key});

  @override
  State<WildfirePage> createState() => _WildfirePageState();
}

class _WildfirePageState extends State<WildfirePage> {
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
          '산불 발생 시 행동요령.'
              '산불 주의 시기에는 산행 전에 기상 정보와 산불 정보를 꼭 확인하고, '
              '인화물질인 라이터나 휴대용 버너는 되도록 가져가지 않도록 합니다. '
              '등산 중에는 절대로 흡연하거나 취사하지 마세요.'
              '산불이 발생하면 산 아래로 내려가는 대신 불이 번지는 방향의 반대쪽, 고지대로 대피해야 합니다. '
              '연기로 인한 피해를 줄이기 위해 젖은 수건 등으로 입과 코를 가리고, '
              '대피 중에는 방향을 잃지 않도록 구조물이나 도로선을 따라 이동하세요. '
              '차량 안에 있을 경우 창문을 닫고 송풍기를 틀어 연기 유입을 차단합니다.'
              '산불이 진화된 이후에도 당국의 귀가 안내가 있기 전까지는 자택으로 복귀하지 마세요. '
              '남은 불씨나 재발화에 주의해야 하며, 화재 피해 여부는 보험을 통해 확인하고, '
              '심리적인 충격이 큰 경우에는 심리 회복 지원도 요청할 수 있습니다.'
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
      disasterName: '산불 (Wildfire)',
      mainImageAsset: 'assets/wildfire_detail.png',
      infoRows: [
        InfoRowData(title: '발생 가능 장소', content: '03월 - 05월, 10월 - 05월 (건조기)'),
        InfoRowData(title: '위험 요인', content: '입산자 실화, 논밭두렁 소각, 강풍, 기계 불꽃'),
        InfoRowData(title: '피해 위험', content: '산림·주택 피해, 연기 흡입, 대피 지연, 인명 피해'),
        InfoRowData(title: '관련 기관', content: '산림청, 소방청, 행정안전부'),
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
                '산불은 산림 또는 산림 인접 지역에서 발생한 화재로, 강풍과 건조한 기상 조건에 따라 빠르게 확산되며, 대규모 산림 훼손과 인명 피해를 초래할 수 있는 재난입니다.',
              ],
            ),
            SectionBlock(
              title: '주요 발생 시기',
              items: [
                '봄철: 03월- 05월',
                '가을·겨울철: 10월 - 이듬해 05월',
              ],
            ),
            SectionBlock(
              title: '원인',
              items: [
                '입산자 실화, 불법 소각, 전기설비, 캠핑 불씨 등',
                '천둥·번개로 인한 자연 발화도 일부 존재',
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
              title: '강풍 시 확산 속도 증가',
              items: [
                '분당 수백 미터 확산 가능, 대피 지연 위험',
              ],
            ),
            SectionBlock(
              title: '짙은 연기',
              items: [
                '시야 차단 → 대피 방향 혼란, 흡입 시 질식 위험',
              ],
            ),
            SectionBlock(
              title: '산림 인접 주거지 피해',
              items: [
                '목조 건물, 비닐하우스, 펜션 등 불에 취약',
              ],
            ),
            SectionBlock(
              title: '도로 통제 및 교통 혼잡',
              items: [
                '진화차량, 연기로 인한 대피로 차단',
              ],
            ),
            SectionBlock(
              title: '소방력 접근 곤란',
              items: [
                '험지·산악 지역으로 진입 어려움',
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
              title: '산불 주의 시기',
              items: [
                '산행 전 기상 및 산불 정보 확인',
                '인화물질(라이터, 버너 등) 휴대 자제',
                '등산 중 흡연·취사 절대 금지',
              ],
            ),
            SectionBlock(
              title: '산불 발생 시',
              items: [
                '산 아래로 내려가지 말고 불 반대 방향 고지대로 대피',
                '연기 피해 방지 위해 젖은 수건 등으로 코·입 가리기',
                '대피 시 방향 잃지 않도록 구조물이나 도로선 따라 이동',
                '차량 내 대피 시 창문 닫고 송풍기로 연기 차단',
              ],
            ),
            SectionBlock(
              title: '산불 진화 이후',
              items: [
                '당국의 “귀가 안내” 전까지 자택 복귀 금지',
                '남은 불씨나 재발화 주의',
                '화재 피해 여부 보험 확인, 심리 회복 지원도 요청 가능',
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
          cardImageAsset: 'assets/wildfire_card.png',
          linkTitle: '[국민재난안전포털] 산불 바로가기',
          linkUrl: 'https://www.safekorea.go.kr/idsiSFK/neo/sfk/cs/contents/prevent/SDIJKM5116.html?menuSeq=127',
        ),
      ],
    );
  }
}

class TunnelPage extends StatefulWidget {
  const TunnelPage({super.key});

  @override
  State<TunnelPage> createState() => _TunnelPageState();
}

class _TunnelPageState extends State<TunnelPage> {
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
          '도로터널 사고 행동요령. '
              '사고 발생 전에, 차량 간 안전거리를 확보하고, 라디오 주파수를 긴급 방송 수신이 가능한 채널로 설정하세요. '
              '사고 발생 시에는 즉시 차량을 정차하고, 시동을 끄고 비상등을 켜세요. '
              '차량 키는 꽂은 채로 두고, 문은 열어둡니다. '
              '유도등을 따라 비상구로 대피하고, 젖은 천 등으로 입과 코를 가리세요. '
              '사고 이후에는 터널 외부로 안전하게 대피한 뒤 구조를 요청하세요. '
              '연기를 흡입한 경우 즉시 병원에서 진료를 받습니다. '
              '사고를 목격했다면 경찰이나 한국도로공사에 관련 정보를 제공하세요.'
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
      disasterName: '도로터널 사고 (Road Tunnel Accident)',
      mainImageAsset: 'assets/tunnel_detail.png',
      infoRows: [
        InfoRowData(title: '발생 가능 장소', content: '차량 통행이 많은 중·장거리 터널'),
        InfoRowData(title: '위험 요인', content: '차량 충돌, 화재, 정전, 환기 불량'),
        InfoRowData(title: '피해 위험', content: '대규모 연쇄 추돌, 유독가스, 연기 질식'),
        InfoRowData(title: '관련 기관', content: '국토교통부, 소방청, 한국도로공사'),
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
                '도로터널 사고는 터널 내에서 발생한 차량 충돌, 화재, 정전 등의 사고로 구조 지연, 시야 확보 곤란, 유독가스 축적 등으로 인해 인명 피해가 커질 수 있는 복합 재난입니다.',
              ],
            ),
            SectionBlock(
              title: '주요 사고 유형',
              items: [
                '연쇄 추돌사고, 차량 화재',
                '터널 내 전기·조명·환기 설비 고장',
              ],
            ),
            SectionBlock(
              title: '특징',
              items: [
                '외부와 단절된 밀폐 공간 → 연기·가스 축적 위험',
                '피난 경로 제한 → 대피 지연 가능성 높음',
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
              title: '차량 간 연쇄 추돌',
              items: [
                '정체·급정거 상황에서 후방 차량 충돌 빈번',
              ],
            ),
            SectionBlock(
              title: '터널 내 화재',
              items: [
                '소화와 진입이 어려워 연기 확산이 매우 빠름',
              ],
            ),
            SectionBlock(
              title: '짙은 연기와 유독가스',
              items: [
                '밀폐 구조로 인해 질식 위험 높음',
              ],
            ),
            SectionBlock(
              title: '정전 및 시야 불량',
              items: [
                '조명 장애 시 대피 방향 혼란 초래',
              ],
            ),
            SectionBlock(
              title: '피난 유도 미흡',
              items: [
                '피난구 위치 파악 어려움, 공황 유발',
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
              title: '사고 발생 전',
              items: [
                '차량 간 안전거리 확보',
                '라디오 주파수 설정 (긴급 방송 수신 가능)',
              ],
            ),
            SectionBlock(
              title: '사고 발생 시',
              items: [
                '즉시 차량 정차, 시동 끄고 비상등 켜기',
                '차량 키를 꽂은 채 문은 열어두기',
                '유도등 따라 비상구로 대피',
                '젖은 천 등으로 입·코 가리기',
              ],
            ),
            SectionBlock(
              title: '사고 이후',
              items: [
                '터널 외부로 안전 대피 후 구조 요청',
                '연기 흡입 시 즉시 병원 진료',
                '목격 정보는 경찰이나 한국도로공사에 제공',
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
          cardImageAsset: 'assets/tunnel_card.png',
          linkTitle: '[국민재난안전포털] 도로터널 사고 바로가기',
          linkUrl: 'https://www.safekorea.go.kr/idsiSFK/neo/sfk/cs/contents/prevent/SDIJKM5517.html?menuSeq=127',
        ),
      ],
    );
  }
}

class ElevatorPage extends StatefulWidget {
  const ElevatorPage({super.key});

  @override
  State<ElevatorPage> createState() => _ElevatorPageState();
}

class _ElevatorPageState extends State<ElevatorPage> {
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
          '엘리베이터 사고 발생 시 행동요령. '
              '승강기 안에서 사고가 발생했을 경우, 비상버튼이나 인터폰을 눌러 구조를 요청하세요. '
              '문을 억지로 열거나 탈출을 시도하지 말고, 엘리베이터 바닥에 낮게 앉아 침착하게 대기합니다. '
              '휴대폰 사용이 가능하다면 119나 관리실에 연락하여 도움을 요청하세요. '
              '외부인이 구조하려는 경우에는 전문가인 소방대원이나 기술자가 도착하기 전까지 구조를 시도하지 마세요. '
              '특히, 위에서 문을 열거나 줄을 던지는 등의 행동은 매우 위험합니다. '
              '사고를 예방하기 위해서는 다음 수칙을 지켜야 합니다. '
              '과적 경고가 울리면 탑승을 중단하고, 어린이는 혼자 엘리베이터를 이용하지 않도록 합니다. '
              '또한, 에스컬레이터를 이용할 때에는 손잡이를 꼭 잡는 것이 안전합니다.'
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
      disasterName: '승강기 안전사고 (Elevator Accident)',
      mainImageAsset: 'assets/elevator_detail.png',
      infoRows: [
        InfoRowData(title: '발생 장소', content: '아파트, 학교, 상가, 지하철역 등'),
        InfoRowData(title: '주요 원인', content: '정전, 고장, 문 끼임, 과적, 오작동'),
        InfoRowData(title: '피해 위험', content: '질식, 추락, 끼임, 심리적 충격'),
        InfoRowData(title: '관련 기관', content: '한국승강기안전공단, 소방청, 행정안전부'),
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
                '승강기 안전사고는 엘리베이터나 에스컬레이터에서 발생하는 전기·기계적 이상 또는 이용자 부주의로 인한 사고입니다.',
              ],
            ),
            SectionBlock(
              title: '발생 예시',
              items: [
                '정전으로 인한 멈춤',
                '출입문 끼임',
                '과적 또는 점검 미비로 인한 추락',
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
              title: '문 끼임 사고',
              items: [
                '승강기 문이 갑자기 닫히며 이용자나 물품이 끼임',
              ],
            ),
            SectionBlock(
              title: '정전 및 멈춤',
              items: [
                '정전 또는 전기 오류로 갇히는 상황 발생',
              ],
            ),
            SectionBlock(
              title: '끼임·낙상',
              items: [
                '승강기와 층 사이 틈에 발이 빠지는 사고',
              ],
            ),
            SectionBlock(
              title: '심리적 불안정',
              items: [
                '밀폐된 공간에서 갇혀 공황, 호흡곤란 유발',
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
              title: '승강기 안에서 사고 발생 시',
              items: [
                '비상버튼 또는 인터폰을 눌러 구조 요청',
                '문을 억지로 열거나 탈출 시도 X',
                '엘리베이터 바닥에 낮게 앉아 대기',
                '휴대폰 사용 가능 시 119 또는 관리실 연락',
              ],
            ),
            SectionBlock(
              title: '외부인이 구조할 경우',
              items: [
                '전문가(소방/기술자) 도착 전 구조 시도 X',
                '위에서 문을 열거나 줄을 던지는 행동은 위험',
              ],
            ),
            SectionBlock(
              title: '사고 예방을 위한 이용 수칙',
              items: [
                '과적 경고 시 탑승 중단',
                '어린이 혼자 탑승 X',
                '에스컬레이터 이용 시 손잡이 잡기 권장',
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
          cardImageAsset: 'assets/elevator_card.png',
          linkTitle: '[국민재난안전포털] 승강기 안전 바로가기',
          linkUrl: 'https://www.safekorea.go.kr/idsiSFK/neo/sfk/cs/contents/prevent/SDIJK15043.html?cd1=43&cd2=999&pagecd=SDIJK150.43&menuSeq=128',
        ),
      ],
    );
  }
}

class FirstaidPage extends StatefulWidget {
  const FirstaidPage({super.key});

  @override
  State<FirstaidPage> createState() => _FirstaidPageState();
}

class _FirstaidPageState extends State<FirstaidPage> {
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
          '응급 처치 시 행동요령. '
              '기본 원칙은 의식을 확인한 뒤, 119에 신고하고 즉시 처치하는 순서를 기억하는 것입니다. '
              '무엇보다도 직접 처치를 하기 전에 본인의 안전을 먼저 확보해야 합니다. '
              '외부인이 응급 처치를 할 경우, 상황에 따라 다음과 같이 조치합니다. '
              '출혈이 있을 때는 깨끗한 천으로 상처 부위를 눌러 지혈하고, 지혈대는 반드시 전문가의 지시에 따라 사용합니다. '
              '화상이 있을 경우에는 흐르는 찬물에 10분에서 20분 정도 화상 부위를 식혀야 합니다. '
              '기도가 폐쇄되었을 때는 하임리히법을 실시해야 합니다. '
              '심정지가 발생하면 즉시 의식을 확인하고, 심폐소생술인 CPR을 시행하며, 자동제세동기 AED가 있다면 함께 사용합니다. '
              '골절이 의심될 경우에는 부목으로 환부를 고정하고, 움직이지 않도록 한 뒤 병원으로 즉시 이동합니다.'
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
      disasterName: '응급처치 (First Aid)',
      mainImageAsset: 'assets/firstaid_detail.png',
      infoRows: [
        InfoRowData(title: '발생 장소', content: '가정, 학교, 직장, 야외 등 일상 모든 공간'),
        InfoRowData(title: '주요 원인', content: '골절, 화상, 출혈, 기도 폐쇄, 심정지 등'),
        InfoRowData(title: '피해 위험', content: '2차 감염, 출혈 과다, 뇌 손상, 사망'),
        InfoRowData(title: '관련 기관', content: '소방청, 대한적십자사, 보건복지부'),
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
                '응급처치는 사고나 질병 발생 직후 전문 의료진이 도착하기 전까지 생명을 지키고 상처를 악화시키지 않기 위해 시행하는 기본적인 응급 대응입니다.',
              ],
            ),
            SectionBlock(
              title: '중요성',
              items: [
                '심정지 시 4분 이내 응급처치 여부가 생존율에 결정적',
                '일반인이 알고 있는 간단한 대처법만으로도 생명 구조 가능',
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
              title: '처치 지연',
              items: [
                '적절한 응급처치 미숙으로 상황 악화',
              ],
            ),
            SectionBlock(
              title: '잘못된 대처',
              items: [
                '이물질 제거 실패, 화상에 얼음 대기 등 오히려 위험',
              ],
            ),
            SectionBlock(
              title: '도움 요청 지연',
              items: [
                '119 신고보다 당황한 상태로 오작동 또는 방관',
              ],
            ),
            SectionBlock(
              title: '보호 장비 미비',
              items: [
                '감염 위험, CPR 시 입 대 입 구조 중 감염 전파',
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
              title: '기본 원칙',
              items: [
                '의식 확인 → 119 신고 → 즉시 처치 순서 기억',
                '직접 처치 전 본인 안전 확보',
              ],
            ),
            SectionBlock(
              title: '외부인이 구조할 경우',
              items: [
                '출혈: 깨끗한 천으로 압박 후 지혈, 지혈대는 전문가 지시 시 사용',
                '화상: 흐르는 찬물에 10~20분 식히기',
                '기도 폐쇄: 하임리히법 실시',
                '심정지: 의식 확인 후 즉시 심폐소생술(CPR), 자동제세동기(AED) 사용',
                '골절: 부목 고정, 환부 움직이지 않게 하고 즉시 병원 이동',
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
          cardImageAsset: 'assets/firstaid_card.png',
          linkTitle: '[국민재난안전포털] 응급처치 바로가기',
          linkUrl: 'https://www.safekorea.go.kr/idsiSFK/neo/sfk/cs/contents/prevent/SDIJK14433.html?cd1=33&cd2=999&pagecd=SDIJK144.33&menuSeq=128',
        ),
      ],
    );
  }
}

class CPRPage extends StatefulWidget {
  const CPRPage({super.key});

  @override
  State<CPRPage> createState() => _CPRPageState();
}

class _CPRPageState extends State<CPRPage> {
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
          '심정지 환자 발생 시 심폐소생술 CPR 행동요령. '
              'Step 1. 반응 확인 및 119 신고. '
              '환자의 어깨를 가볍게 두드리며 "괜찮으세요?"라고 물어 반응을 확인합니다. '
              '반응이 없다면 즉시 119에 신고하고, 주변 사람들에게 도움을 요청합니다. '
              '가능하다면 자동제세동기, 즉 AED를 가져오도록 합니다. '
              'Step 2. 가슴 압박 시행. '
              '압박 위치는 양쪽 유두 사이, 가슴 중앙입니다. '
              '손바닥을 겹쳐서 체중을 실어 강하게 압박합니다. '
              '압박 깊이는 5에서 6센티미터, 속도는 분당 100에서 120회가 적절합니다. '
              '리듬 예시는 “Stayin’ Alive” 노래의 템포와 유사한 1분에 104 비트입니다. '
              'Step 3. AED 사용. '
              'AED가 도착하면 기계의 음성 안내에 따라 패드를 부착합니다. '
              '“전기 충격” 버튼은 반드시 모두 떨어진 상태에서 눌러야 합니다. '
              '이후에는 가슴 압박과 AED 사용을 반복하며, 의료진이 도착할 때까지 계속합니다.'
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
      disasterName: '심폐소생술 (CPR)',
      mainImageAsset: 'assets/cpr_detail.png',
      infoRows: [
        InfoRowData(title: '필요 상황', content: '심정지, 호흡 정지, 의식 없음'),
        InfoRowData(title: '주요 원인', content: '심근경색, 호흡곤란, 기도폐쇄, 익수 등'),
        InfoRowData(title: '시행 목적', content: '뇌 손상 예방, 생명 유지'),
        InfoRowData(title: '관련 기관', content: '소방청, 보건복지부, 대한적십자사'),
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
                '심폐소생술(CPR)은 심장과 호흡이 멈춘 사람의 생명을 되살리기 위한 기본 응급처치 방법입니다. 뇌 손상을 막기 위해 4분 이내 실시하는 것이 매우 중요합니다.',
              ],
            ),
            SectionBlock(
              title: '중요성',
              items: [
                '심정지 후 1분마다 생존율 약 7~10%씩 감소',
                '일반인도 배워서 시행 가능, AED와 병행 시 생존율 2배 이상 증가',
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
              title: '초기 지연',
              items: [
                '4분 이내 CPR이 없을 경우 뇌 손상 위험',
              ],
            ),
            SectionBlock(
              title: '주저함/두려움',
              items: [
                '구조자들이 “내가 해도 되나”라고 망설이는 경우 많음',
              ],
            ),
            SectionBlock(
              title: '오류 있는 가슴압박',
              items: [
                '깊이 부족, 속도 느림, 위치 틀림 등이 심장 재기동 실패 원인',
              ],
            ),
            SectionBlock(
              title: 'AED 부재',
              items: [
                '자동제세동기 미비 또는 사용법 미숙 시 회복 지연',
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
              title: 'Step 1. 반응 확인 및 119 신고',
              items: [
                '어깨를 가볍게 두드리며 "괜찮으세요?" 확인',
                '반응 없으면 즉시 119 신고 및 주변 도움 요청',
                '가능하면 AED(제세동기) 요청',
              ],
            ),
            SectionBlock(
              title: 'Step 2. 가슴 압박 시행',
              items: [
                '위치: 양쪽 유두 사이 가슴 중앙',
                '자세: 손바닥 겹쳐서 체중 실어 압박',
                '깊이: 5~6cm, 속도: 분당 100~120회',
                '리듬 예시:“Stayin’ Alive” 템포 (BPM 104)',
              ],
            ),
            SectionBlock(
              title: 'Step 3. AED 사용 (있을 경우)',
              items: [
                '기계 음성 안내에 따라 패드 부착',
                '“전기 충격” 버튼은 분리된 상태에서만 누름',
                '이후 압박과 AED 반복(의료진 도착 전까지)',
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
          cardImageAsset: 'assets/cpr_card.png',
          linkTitle: '[국민재난안전포털] 심폐소생술 바로가기',
          linkUrl: 'https://www.safekorea.go.kr/idsiSFK/neo/sfk/cs/contents/prevent/SDIJK14739.html?cd1=39&cd2=999&pagecd=SDIJK147.39&menuSeq=128',
        ),
      ],
    );
  }
}

class Hikingpage extends StatefulWidget {
  const Hikingpage({super.key});

  @override
  State<Hikingpage> createState() => _HikingpageState();
}

class _HikingpageState extends State<Hikingpage> {
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
          '산행 시 행동요령입. '
              '먼저 산행 전에 해야 할 일입니다. '
              '기상 정보를 미리 확인하고, 무리한 일정은 피해야 합니다. '
              '등산로는 사전에 확인하고, 반드시 공식 탐방로 위주로 계획합니다. '
              '산행 시간과 코스는 가족이나 지인에게 미리 공유하세요. '
              '다음은 산행 중 주의사항입니다. '
              '지정된 탐방로에서 벗어나지 말고, 비상식량과 물, 휴대전화, 손전등을 반드시 챙깁니다. '
              '낙석이나 가파른 구간에서는 한 사람씩 조심스럽게 통과해야 합니다. '
              '마지막으로 사고가 발생했을 때입니다. '
              '즉시 119 또는 산악구조대에 신고하고, 위치 전송이 가능한 앱을 활용합니다. '
              '부상으로 인해 움직이기 어렵다면 눈에 잘 띄는 곳에서 구조를 기다리세요. '
              '저체온증이 우려될 경우에는 최대한 체온을 유지하고, 불필요한 움직임은 삼가야 합니다.'
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
      disasterName: '산행 안전사고 (Hiking Accident Safety)',
      mainImageAsset: 'assets/hiking_detail.png',
      infoRows: [
        InfoRowData(title: '발생 시기', content: '봄·가을 등산 성수기, 기상 악화 시'),
        InfoRowData(title: '주요 원인', content: '미끄럼, 낙석, 실족, 탈진, 길 잃음'),
        InfoRowData(title: '피해 위험', content: '골절, 저체온증, 실종, 사망'),
        InfoRowData(title: '관련 기관', content: '산림청, 소방청, 국립공원공단'),
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
                '산행 안전사고는 등산이나 트레킹 중 발생하는 낙상, 실족, 조난, 기상 변화 등으로 인한 각종 인명사고를 말합니다.',
              ],
            ),
            SectionBlock(
              title: '중요성',
              items: [
                '구조가 지연되기 쉬운 지형',
                '기상 변화가 급격하며, 체력 고갈 시 위험 가중',
                '혼자 산행 시 사고 발견이 늦어짐',
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
              title: '실족·미끄럼',
              items: [
                '낙엽, 눈·비로 미끄러운 길에서 넘어짐',
              ],
            ),
            SectionBlock(
              title: '길 잃음 / 조난',
              items: [
                '구조자들이 “내가 해도 되나”라고 망설이는 경우 많음',
              ],
            ),
            SectionBlock(
              title: '저체온증·탈수',
              items: [
                '급격한 기온 변화에 대비하지 못한 복장',
                '물 부족, 무리한 코스 진행 시 탈진',
              ],
            ),
            SectionBlock(
              title: '통신 두절',
              items: [
                '산악 지역의 통신 음영으로 구조 지연',
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
              title: '산행 전',
              items: [
                '기상 정보 확인 및 무리한 계획 피하기',
                '등산로 사전 확인 (공식 탐방로 위주)',
                '가족·지인에게 산행 시간과 코스 공유',
              ],
            ),
            SectionBlock(
              title: '산행 중',
              items: [
                '지정된 탐방로 이탈 금지',
                '비상식량·물·휴대전화·손전등 지참',
                '낙석·가파른 구간에서는 한 사람씩 통과',
              ],
            ),
            SectionBlock(
              title: '사고 발생 시',
              items: [
                '119 또는 산악구조대에 즉시 신고 (위치 전송 가능 앱 활용)',
                '움직이기 어려운 경우 눈에 띄는 곳에서 구조 대기',
                '저체온 우려 시 보온 유지, 불필요한 움직임 금지',
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
          cardImageAsset: 'assets/hiking_card.png',
          linkTitle: '[국민재난안전포털] 산행안전 바로가기',
          linkUrl: 'https://www.safekorea.go.kr/idsiSFK/neo/sfk/cs/contents/prevent/SDIJK14029.html?cd1=29&cd2=999&pagecd=SDIJK140.29&menuSeq=128',
        ),
      ],
    );
  }
}