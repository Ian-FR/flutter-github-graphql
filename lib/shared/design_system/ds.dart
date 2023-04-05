import 'package:flutter/material.dart';

class SpacingTokens {
  final xxsmall = 4.0;
  final xsmall = 8.0;
  final small = 12.0;
  final medium = 16.0;
  final large = 24.0;
  final xlarge = 32.0;
  final xxlarge = 40.0;
}

class TypographyTokens {
  final title = const TextStyle(fontSize: 20, fontWeight: FontWeight.w500);
  final subtitle = const TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
  final body1 = const TextStyle(fontSize: 16, fontWeight: FontWeight.normal);
  final body2 = const TextStyle(fontSize: 14, fontWeight: FontWeight.normal);
  final caption = const TextStyle(fontSize: 12, fontWeight: FontWeight.w300);
  final button = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);
}

class DS {
  DS._()
      : spacing = SpacingTokens(),
        typography = TypographyTokens();

  final SpacingTokens spacing;
  final TypographyTokens typography;
}

final ds = DS._();
