import 'package:flutter/material.dart';

import '../color_scheme.dart';

TabBarThemeData get tabBarTheme => TabBarThemeData(
      labelColor: colorSchemeLight.primary, // Color for selected tab label
      unselectedLabelColor: colorSchemeLight.onSurface
          .withOpacity(0.4), // Color for unselected tab label
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 4.0, // Thickness of the indicator line
          color:
              colorSchemeLight.primary, // Color of the selected indicator line
        ),
        insets: const EdgeInsets.symmetric(horizontal: 0), // Full-width line
      ),
      indicatorColor: colorSchemeLight.primary,
    );
