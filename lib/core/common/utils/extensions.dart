import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

extension BuildContextHelper on BuildContext {
  double get getHeight => MediaQuery.of(this).size.height;

  double get getWidth => MediaQuery.of(this).size.width;

  AppLocalizations? get locale => AppLocalizations.of(this);

  FocusScopeNode get focus => FocusScope.of(this);
}
