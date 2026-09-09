import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../app_scope.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/question.dart';
import '../../domain/career_scoring.dart';
import '../../domain/eq_scoring.dart';
import '../../domain/scoring.dart';
import '../../l10n/app_localizations.dart';
import '../../router/app_router.dart';
import '../../state/test_session.dart';
import '../widgets/organic_widgets.dart';

/// One-question-per-screen flow with a progress bar and Likert options.
class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  bool _transitioning = false;
  int? _pendingValue;

  /// Likert labels for the active test: the career test rates activities by
  /// like/dislike, the EQ test by agreement, the Big Five by accuracy.
  List<String> _likertLabels(AppLocalizations l10n, String testId) {
    switch (testId) {
      case 'career':
        return <String>[
          l10n.careerLikert1,
          l10n.careerLikert2,
          l10n.careerLikert3,
          l10n.careerLikert4,
          l10n.careerLikert5,
        ];
      case 'eq':
        return <String>[
          l10n.agreeLikert1,
          l10n.agreeLikert2,
          l10n.agreeLikert3,
          l10n.agreeLikert4,
          l10n.agreeLikert5,
        ];
      default:
        return <String>[
          l10n.likert1,
          l10n.likert2,
          l10n.likert3,
          l10n.likert4,
          l10n.likert5,
        ];
    }
  }

  Future<void> _select(int value) async {
    if (_transitioning) return;
    final session = AppScope.sessionOf(context);
    setState(() {
      _transitioning = true;
      _pendingValue = value;
    });
    // Brief highlight so the choice registers before advancing (design: 200ms).
    await Future<void>.delayed(const Duration(milliseconds: 200));
    if (!mounted) return;

    final bool wasLast = session.currentIndex == session.total - 1;
    await session.answerCurrent(value);
    if (!mounted) return;

    if (wasLast && session.isComplete) {
      await _finish(session);
      return;
    }
    setState(() {
      _transitioning = false;
      _pendingValue = null;
    });
  }

  /// Scores the completed test and routes to the matching results screen.
  Future<void> _finish(TestSession session) async {
    switch (session.testId) {
      case 'career':
        final result = scoreCareer(session.answers);
        await AppScope.careerResultsOf(context).complete(result);
        if (!mounted) return;
        context.go(Routes.careerResults);
      case 'eq':
        final result = scoreEq(session.answers);
        await AppScope.eqResultsOf(context).complete(result);
        if (!mounted) return;
        context.go(Routes.eqResults);
      default:
        final result = scoreAnswers(session.answers);
        await AppScope.resultsOf(context).complete(result);
        if (!mounted) return;
        context.go(Routes.results);
    }
  }

  void _back(TestSession session) {
    if (_transitioning) return;
    if (session.canGoBack) {
      session.goBack();
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final session = AppScope.sessionOf(context);
    final String lang = Localizations.localeOf(context).languageCode;

    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
          animation: session,
          builder: (BuildContext context, _) {
            final TestItem q = session.currentQuestion;
            final int? selected =
                _pendingValue ?? session.responseFor(q.id);
            final double progress = session.currentPosition / session.total;

            return Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      BackChevron(onTap: () => _back(session)),
                      Text(
                        l10n.questionProgress(
                          session.currentPosition,
                          session.total,
                        ),
                        style: AppFonts.body(
                          size: 13,
                          color: AppColors.muted,
                          weight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _ProgressBar(value: progress),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      switchInCurve: Curves.easeOut,
                      transitionBuilder: (Widget child, Animation<double> a) {
                        return FadeTransition(
                          opacity: a,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0, 0.06),
                              end: Offset.zero,
                            ).animate(a),
                            child: child,
                          ),
                        );
                      },
                      child: Column(
                        key: ValueKey<int>(session.currentIndex),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            q.text.resolve(lang),
                            textAlign: TextAlign.center,
                            style: AppFonts.body(
                              size: 22,
                              weight: FontWeight.w600,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 32),
                          ..._buildOptions(l10n, session.testId, selected),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildOptions(
    AppLocalizations l10n,
    String testId,
    int? selected,
  ) {
    final List<String> labels = _likertLabels(l10n, testId);
    return <Widget>[
      for (int i = 0; i < labels.length; i++) ...<Widget>[
        _LikertOption(
          label: labels[i],
          selected: selected == i + 1,
          onTap: () => _select(i + 1),
        ),
        if (i < labels.length - 1) const SizedBox(height: 10),
      ],
    ];
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadii.pill),
      child: Stack(
        children: <Widget>[
          Container(height: 6, color: AppColors.surface),
          AnimatedFractionallySizedBox(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeInOut,
            widthFactor: value.clamp(0.0, 1.0),
            child: Container(
              height: 6,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[AppColors.accent, AppColors.accentLight],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LikertOption extends StatelessWidget {
  const _LikertOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: selected ? AppColors.accentTint : AppColors.surface,
          borderRadius: BorderRadius.circular(AppRadii.pill),
          border: Border.all(
            color: selected
                ? AppColors.accent
                : AppColors.text.withValues(alpha: 0.10),
            width: 2,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AppFonts.body(
            size: 15,
            weight: selected ? FontWeight.w600 : FontWeight.w400,
            color: selected ? AppColors.accent : AppColors.text,
          ),
        ),
      ),
    );
  }
}
