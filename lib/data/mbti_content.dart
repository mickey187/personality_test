import 'models/mbti.dart';
import 'models/question.dart';

/// Short label + one-line description per pole, used on the axis strength
/// bars on the results screen.
class MbtiAxisContent {
  const MbtiAxisContent({
    required this.poleLabel,
    required this.poleDescription,
  });

  final Map<MbtiPole, LocalizedText> poleLabel;
  final Map<MbtiPole, LocalizedText> poleDescription;
}

/// Axis content keyed by [MbtiAxis]. Amharic mirrors English for now — TODO:
/// follow-up localization pass.
const Map<MbtiAxis, MbtiAxisContent> kMbtiAxisContent = <MbtiAxis, MbtiAxisContent>{
  MbtiAxis.ei: MbtiAxisContent(
    poleLabel: <MbtiPole, LocalizedText>{
      MbtiPole.e: LocalizedText(en: 'Extraversion', am: 'Extraversion'),
      MbtiPole.i: LocalizedText(en: 'Introversion', am: 'Introversion'),
    },
    poleDescription: <MbtiPole, LocalizedText>{
      MbtiPole.e: LocalizedText(
        en: 'You draw energy from people and the outside world.',
        am: 'You draw energy from people and the outside world.',
      ),
      MbtiPole.i: LocalizedText(
        en: 'You draw energy from quiet reflection and your inner world.',
        am: 'You draw energy from quiet reflection and your inner world.',
      ),
    },
  ),
  MbtiAxis.sn: MbtiAxisContent(
    poleLabel: <MbtiPole, LocalizedText>{
      MbtiPole.s: LocalizedText(en: 'Sensing', am: 'Sensing'),
      MbtiPole.n: LocalizedText(en: 'Intuition', am: 'Intuition'),
    },
    poleDescription: <MbtiPole, LocalizedText>{
      MbtiPole.s: LocalizedText(
        en: 'You focus on concrete facts and present realities.',
        am: 'You focus on concrete facts and present realities.',
      ),
      MbtiPole.n: LocalizedText(
        en: 'You focus on patterns, ideas, and future possibilities.',
        am: 'You focus on patterns, ideas, and future possibilities.',
      ),
    },
  ),
  MbtiAxis.tf: MbtiAxisContent(
    poleLabel: <MbtiPole, LocalizedText>{
      MbtiPole.t: LocalizedText(en: 'Thinking', am: 'Thinking'),
      MbtiPole.f: LocalizedText(en: 'Feeling', am: 'Feeling'),
    },
    poleDescription: <MbtiPole, LocalizedText>{
      MbtiPole.t: LocalizedText(
        en: 'You decide based on logic and objective consistency.',
        am: 'You decide based on logic and objective consistency.',
      ),
      MbtiPole.f: LocalizedText(
        en: 'You decide based on values and how people are affected.',
        am: 'You decide based on values and how people are affected.',
      ),
    },
  ),
  MbtiAxis.jp: MbtiAxisContent(
    poleLabel: <MbtiPole, LocalizedText>{
      MbtiPole.j: LocalizedText(en: 'Judging', am: 'Judging'),
      MbtiPole.p: LocalizedText(en: 'Perceiving', am: 'Perceiving'),
    },
    poleDescription: <MbtiPole, LocalizedText>{
      MbtiPole.j: LocalizedText(
        en: 'You like structure, plans, and closure.',
        am: 'You like structure, plans, and closure.',
      ),
      MbtiPole.p: LocalizedText(
        en: 'You like flexibility and keeping your options open.',
        am: 'You like flexibility and keeping your options open.',
      ),
    },
  ),
};

/// Descriptive copy for one of the 16 personality types: an original tagline
/// (deliberately distinct from any proprietary instrument's nicknames), a
/// short summary, a few strengths, and one growth tip.
class MbtiTypeContent {
  const MbtiTypeContent({
    required this.name,
    required this.summary,
    required this.strengths,
    required this.growthTip,
  });

  final LocalizedText name;
  final LocalizedText summary;
  final List<LocalizedText> strengths;
  final LocalizedText growthTip;
}

/// All 16 type codes, English-only for now (Amharic mirrors English pending a
/// follow-up localization pass). Copy is self-insight framed, not diagnostic.
const Map<String, MbtiTypeContent> kMbtiTypeContent = <String, MbtiTypeContent>{
  'INTJ': MbtiTypeContent(
    name: LocalizedText(en: 'The Systems Thinker', am: 'The Systems Thinker'),
    summary: LocalizedText(
      en: 'You combine big-picture thinking with a drive to turn ideas into '
          'workable plans.',
      am: 'You combine big-picture thinking with a drive to turn ideas into '
          'workable plans.',
    ),
    strengths: <LocalizedText>[
      LocalizedText(en: 'Strategic, long-range thinking', am: 'Strategic, long-range thinking'),
      LocalizedText(en: 'Independent problem-solving', am: 'Independent problem-solving'),
      LocalizedText(en: 'High personal standards', am: 'High personal standards'),
    ],
    growthTip: LocalizedText(
      en: 'Share your reasoning along the way, not just the conclusion — it '
          'helps others follow and buy in.',
      am: 'Share your reasoning along the way, not just the conclusion — it '
          'helps others follow and buy in.',
    ),
  ),
  'INTP': MbtiTypeContent(
    name: LocalizedText(en: 'The Analyst', am: 'The Analyst'),
    summary: LocalizedText(
      en: 'You’re driven to understand how things work, and you enjoy '
          'picking ideas apart for their own sake.',
      am: 'You’re driven to understand how things work, and you enjoy '
          'picking ideas apart for their own sake.',
    ),
    strengths: <LocalizedText>[
      LocalizedText(en: 'Sharp logical analysis', am: 'Sharp logical analysis'),
      LocalizedText(en: 'Comfortable with abstract ideas', am: 'Comfortable with abstract ideas'),
      LocalizedText(en: 'Objective and open-minded', am: 'Objective and open-minded'),
    ],
    growthTip: LocalizedText(
      en: 'Set a deadline for "good enough" — perfecting an idea can quietly '
          'replace acting on it.',
      am: 'Set a deadline for "good enough" — perfecting an idea can quietly '
          'replace acting on it.',
    ),
  ),
  'ENTJ': MbtiTypeContent(
    name: LocalizedText(en: 'The Director', am: 'The Director'),
    summary: LocalizedText(
      en: 'You naturally take charge, organizing people and resources '
          'toward a clear goal.',
      am: 'You naturally take charge, organizing people and resources '
          'toward a clear goal.',
    ),
    strengths: <LocalizedText>[
      LocalizedText(en: 'Decisive leadership', am: 'Decisive leadership'),
      LocalizedText(en: 'Efficient planning', am: 'Efficient planning'),
      LocalizedText(en: 'Confident under pressure', am: 'Confident under pressure'),
    ],
    growthTip: LocalizedText(
      en: 'Pause to ask how a decision lands with people, not just whether '
          'it’s the fastest path.',
      am: 'Pause to ask how a decision lands with people, not just whether '
          'it’s the fastest path.',
    ),
  ),
  'ENTP': MbtiTypeContent(
    name: LocalizedText(en: 'The Innovator', am: 'The Innovator'),
    summary: LocalizedText(
      en: 'You love exploring new ideas and debating them, energized by '
          'possibility more than routine.',
      am: 'You love exploring new ideas and debating them, energized by '
          'possibility more than routine.',
    ),
    strengths: <LocalizedText>[
      LocalizedText(en: 'Quick, creative thinking', am: 'Quick, creative thinking'),
      LocalizedText(en: 'Comfortable challenging assumptions', am: 'Comfortable challenging assumptions'),
      LocalizedText(en: 'Adaptable to new situations', am: 'Adaptable to new situations'),
    ],
    growthTip: LocalizedText(
      en: 'Pick one idea and follow it through — momentum matters as much '
          'as inspiration.',
      am: 'Pick one idea and follow it through — momentum matters as much '
          'as inspiration.',
    ),
  ),
  'INFJ': MbtiTypeContent(
    name: LocalizedText(en: 'The Insightful Guide', am: 'The Insightful Guide'),
    summary: LocalizedText(
      en: 'You combine a rich inner world with a genuine care for people, '
          'often sensing what others need before they say it.',
      am: 'You combine a rich inner world with a genuine care for people, '
          'often sensing what others need before they say it.',
    ),
    strengths: <LocalizedText>[
      LocalizedText(en: 'Deep empathy', am: 'Deep empathy'),
      LocalizedText(en: 'Thoughtful, values-driven decisions', am: 'Thoughtful, values-driven decisions'),
      LocalizedText(en: 'Sees meaning and long-term patterns', am: 'Sees meaning and long-term patterns'),
    ],
    growthTip: LocalizedText(
      en: 'Voice your own needs as clearly as you notice everyone else’s.',
      am: 'Voice your own needs as clearly as you notice everyone else’s.',
    ),
  ),
  'INFP': MbtiTypeContent(
    name: LocalizedText(en: 'The Idealist', am: 'The Idealist'),
    summary: LocalizedText(
      en: 'You’re guided by a strong inner sense of values and want your '
          'life and work to feel meaningful.',
      am: 'You’re guided by a strong inner sense of values and want your '
          'life and work to feel meaningful.',
    ),
    strengths: <LocalizedText>[
      LocalizedText(en: 'Strong personal values', am: 'Strong personal values'),
      LocalizedText(en: 'Creative and imaginative', am: 'Creative and imaginative'),
      LocalizedText(en: 'Genuinely caring', am: 'Genuinely caring'),
    ],
    growthTip: LocalizedText(
      en: 'Break a big meaningful goal into small concrete steps so it '
          'doesn’t stay only a feeling.',
      am: 'Break a big meaningful goal into small concrete steps so it '
          'doesn’t stay only a feeling.',
    ),
  ),
  'ENFJ': MbtiTypeContent(
    name: LocalizedText(en: 'The Motivator', am: 'The Motivator'),
    summary: LocalizedText(
      en: 'You’re energized by helping others grow, often the one who '
          'rallies a group toward a shared goal.',
      am: 'You’re energized by helping others grow, often the one who '
          'rallies a group toward a shared goal.',
    ),
    strengths: <LocalizedText>[
      LocalizedText(en: 'Warm, persuasive communication', am: 'Warm, persuasive communication'),
      LocalizedText(en: 'Genuine investment in others', am: 'Genuine investment in others'),
      LocalizedText(en: 'Organized and goal-driven', am: 'Organized and goal-driven'),
    ],
    growthTip: LocalizedText(
      en: 'It’s okay to let others struggle a little — growth isn’t always '
          'yours to manage.',
      am: 'It’s okay to let others struggle a little — growth isn’t always '
          'yours to manage.',
    ),
  ),
  'ENFP': MbtiTypeContent(
    name: LocalizedText(en: 'The Enthusiast', am: 'The Enthusiast'),
    summary: LocalizedText(
      en: 'You bring warmth and energy to everything, curious about people '
          'and ideas alike.',
      am: 'You bring warmth and energy to everything, curious about people '
          'and ideas alike.',
    ),
    strengths: <LocalizedText>[
      LocalizedText(en: 'Enthusiastic and engaging', am: 'Enthusiastic and engaging'),
      LocalizedText(en: 'Sees possibilities everywhere', am: 'Sees possibilities everywhere'),
      LocalizedText(en: 'Warm and people-focused', am: 'Warm and people-focused'),
    ],
    growthTip: LocalizedText(
      en: 'Give one project your full follow-through before starting the '
          'next exciting thing.',
      am: 'Give one project your full follow-through before starting the '
          'next exciting thing.',
    ),
  ),
  'ISTJ': MbtiTypeContent(
    name: LocalizedText(en: 'The Organizer', am: 'The Organizer'),
    summary: LocalizedText(
      en: 'You’re dependable and thorough, valuing facts, order, and '
          'following through on commitments.',
      am: 'You’re dependable and thorough, valuing facts, order, and '
          'following through on commitments.',
    ),
    strengths: <LocalizedText>[
      LocalizedText(en: 'Reliable and consistent', am: 'Reliable and consistent'),
      LocalizedText(en: 'Detail-oriented', am: 'Detail-oriented'),
      LocalizedText(en: 'Strong sense of duty', am: 'Strong sense of duty'),
    ],
    growthTip: LocalizedText(
      en: 'When a plan clearly isn’t working, treat changing course as '
          'discipline, not a failure.',
      am: 'When a plan clearly isn’t working, treat changing course as '
          'discipline, not a failure.',
    ),
  ),
  'ISFJ': MbtiTypeContent(
    name: LocalizedText(en: 'The Supporter', am: 'The Supporter'),
    summary: LocalizedText(
      en: 'You quietly take care of the people and details others '
          'overlook, valuing loyalty and stability.',
      am: 'You quietly take care of the people and details others '
          'overlook, valuing loyalty and stability.',
    ),
    strengths: <LocalizedText>[
      LocalizedText(en: 'Attentive and considerate', am: 'Attentive and considerate'),
      LocalizedText(en: 'Loyal and dependable', am: 'Loyal and dependable'),
      LocalizedText(en: 'Practical helpfulness', am: 'Practical helpfulness'),
    ],
    growthTip: LocalizedText(
      en: 'Ask for support as readily as you give it.',
      am: 'Ask for support as readily as you give it.',
    ),
  ),
  'ESTJ': MbtiTypeContent(
    name: LocalizedText(en: 'The Coordinator', am: 'The Coordinator'),
    summary: LocalizedText(
      en: 'You bring order and clear expectations to any group, focused on '
          'getting things done properly.',
      am: 'You bring order and clear expectations to any group, focused on '
          'getting things done properly.',
    ),
    strengths: <LocalizedText>[
      LocalizedText(en: 'Organized and efficient', am: 'Organized and efficient'),
      LocalizedText(en: 'Clear, direct communication', am: 'Clear, direct communication'),
      LocalizedText(en: 'Follows through reliably', am: 'Follows through reliably'),
    ],
    growthTip: LocalizedText(
      en: 'Leave room for someone else’s way of doing it, even if yours is '
          'more efficient.',
      am: 'Leave room for someone else’s way of doing it, even if yours is '
          'more efficient.',
    ),
  ),
  'ESFJ': MbtiTypeContent(
    name: LocalizedText(en: 'The Harmonizer', am: 'The Harmonizer'),
    summary: LocalizedText(
      en: 'You’re attentive to others’ needs and work hard to keep groups '
          'connected and running smoothly.',
      am: 'You’re attentive to others’ needs and work hard to keep groups '
          'connected and running smoothly.',
    ),
    strengths: <LocalizedText>[
      LocalizedText(en: 'Warm and sociable', am: 'Warm and sociable'),
      LocalizedText(en: 'Organized and dependable', am: 'Organized and dependable'),
      LocalizedText(en: 'Attuned to group needs', am: 'Attuned to group needs'),
    ],
    growthTip: LocalizedText(
      en: 'Not every disagreement needs smoothing over — some are worth '
          'sitting with.',
      am: 'Not every disagreement needs smoothing over — some are worth '
          'sitting with.',
    ),
  ),
  'ISTP': MbtiTypeContent(
    name: LocalizedText(en: 'The Problem Solver', am: 'The Problem Solver'),
    summary: LocalizedText(
      en: 'You’re calm and hands-on, good at figuring out how things work '
          'by trying them.',
      am: 'You’re calm and hands-on, good at figuring out how things work '
          'by trying them.',
    ),
    strengths: <LocalizedText>[
      LocalizedText(en: 'Practical troubleshooting', am: 'Practical troubleshooting'),
      LocalizedText(en: 'Calm under pressure', am: 'Calm under pressure'),
      LocalizedText(en: 'Independent and adaptable', am: 'Independent and adaptable'),
    ],
    growthTip: LocalizedText(
      en: 'Loop people in on what you’re thinking before you’ve already '
          'moved on to the fix.',
      am: 'Loop people in on what you’re thinking before you’ve already '
          'moved on to the fix.',
    ),
  ),
  'ISFP': MbtiTypeContent(
    name: LocalizedText(en: 'The Artisan', am: 'The Artisan'),
    summary: LocalizedText(
      en: 'You experience the world through your senses and values, often '
          'expressing yourself quietly through what you make or do.',
      am: 'You experience the world through your senses and values, often '
          'expressing yourself quietly through what you make or do.',
    ),
    strengths: <LocalizedText>[
      LocalizedText(en: 'Aesthetic sensitivity', am: 'Aesthetic sensitivity'),
      LocalizedText(en: 'Gentle and adaptable', am: 'Gentle and adaptable'),
      LocalizedText(en: 'Quietly values-driven', am: 'Quietly values-driven'),
    ],
    growthTip: LocalizedText(
      en: 'Speak up about your preferences before a decision is made, not '
          'just after.',
      am: 'Speak up about your preferences before a decision is made, not '
          'just after.',
    ),
  ),
  'ESTP': MbtiTypeContent(
    name: LocalizedText(en: 'The Doer', am: 'The Doer'),
    summary: LocalizedText(
      en: 'You’re energetic and pragmatic, most comfortable acting in the '
          'moment rather than planning far ahead.',
      am: 'You’re energetic and pragmatic, most comfortable acting in the '
          'moment rather than planning far ahead.',
    ),
    strengths: <LocalizedText>[
      LocalizedText(en: 'Quick, practical action', am: 'Quick, practical action'),
      LocalizedText(en: 'Confident and adaptable', am: 'Confident and adaptable'),
      LocalizedText(en: 'Reads a room fast', am: 'Reads a room fast'),
    ],
    growthTip: LocalizedText(
      en: 'Slow down for decisions with long-term consequences.',
      am: 'Slow down for decisions with long-term consequences.',
    ),
  ),
  'ESFP': MbtiTypeContent(
    name: LocalizedText(en: 'The Improviser', am: 'The Improviser'),
    summary: LocalizedText(
      en: 'You bring spontaneous energy and warmth wherever you go, living '
          'fully in the present moment.',
      am: 'You bring spontaneous energy and warmth wherever you go, living '
          'fully in the present moment.',
    ),
    strengths: <LocalizedText>[
      LocalizedText(en: 'Warm and enthusiastic', am: 'Warm and enthusiastic'),
      LocalizedText(en: 'Practical and hands-on', am: 'Practical and hands-on'),
      LocalizedText(en: 'Adapts quickly to change', am: 'Adapts quickly to change'),
    ],
    growthTip: LocalizedText(
      en: 'A little planning ahead can save your future self a scramble.',
      am: 'A little planning ahead can save your future self a scramble.',
    ),
  ),
};
