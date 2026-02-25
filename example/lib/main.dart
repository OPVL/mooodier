import 'package:flutter/material.dart';
import 'package:mooodier/mooodier.dart';

import 'component_catalog_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;
  Color _seedColor = Colors.blue;
  AccessibilityConfig _accessibility = const AccessibilityConfig();

  void _toggleTheme() {
    setState(() {
      _themeMode =
          _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  void _updateSeedColor(Color color) {
    setState(() {
      _seedColor = color;
    });
  }

  void _updateAccessibility(AccessibilityConfig config) {
    setState(() {
      _accessibility = config;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mooodier UI Showcase',
      debugShowCheckedModeBanner: false,
      theme: CustomTheme.light(
        seedColor: _seedColor,
        accessibility: _accessibility,
      ),
      darkTheme: CustomTheme.dark(
        seedColor: _seedColor,
        accessibility: _accessibility,
      ),
      themeMode: _themeMode,
      home: StorybookHome(
        onThemeToggle: _toggleTheme,
        onSeedColorChange: _updateSeedColor,
        onAccessibilityChange: _updateAccessibility,
        currentThemeMode: _themeMode,
        currentSeedColor: _seedColor,
        currentAccessibility: _accessibility,
      ),
    );
  }
}

class StorybookHome extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final ValueChanged<Color> onSeedColorChange;
  final ValueChanged<AccessibilityConfig> onAccessibilityChange;
  final ThemeMode currentThemeMode;
  final Color currentSeedColor;
  final AccessibilityConfig currentAccessibility;

  const StorybookHome({
    super.key,
    required this.onThemeToggle,
    required this.onSeedColorChange,
    required this.onAccessibilityChange,
    required this.currentThemeMode,
    required this.currentSeedColor,
    required this.currentAccessibility,
  });

  @override
  State<StorybookHome> createState() => _StorybookHomeState();
}

class _StorybookHomeState extends State<StorybookHome> {
  int _selectedIndex = 0;

  final List<_NavItem> _navItems = const [
    _NavItem(
      title: 'Component Catalog',
      icon: Icons.dashboard,
    ),
    _NavItem(
      title: 'Theme Settings',
      icon: Icons.palette,
    ),
    _NavItem(
      title: 'Accessibility',
      icon: Icons.accessibility,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mooodier UI Showcase'),
        actions: [
          IconButton(
            icon: Icon(
              widget.currentThemeMode == ThemeMode.light
                  ? Icons.dark_mode
                  : Icons.light_mode,
            ),
            onPressed: widget.onThemeToggle,
            tooltip: 'Toggle theme',
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: theme.colorScheme.primary,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Icon(
                    Icons.palette,
                    size: 48,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Mooodier UI',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Component Storybook',
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),
            ..._navItems.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              return ListTile(
                leading: Icon(item.icon),
                title: Text(item.title),
                selected: _selectedIndex == index,
                onTap: () {
                  setState(() {
                    _selectedIndex = index;
                  });
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          const ComponentCatalogPage(title: 'Component Catalog'),
          ThemeSettingsPage(
            currentSeedColor: widget.currentSeedColor,
            onSeedColorChange: widget.onSeedColorChange,
          ),
          AccessibilitySettingsPage(
            currentConfig: widget.currentAccessibility,
            onConfigChange: widget.onAccessibilityChange,
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  final String title;
  final IconData icon;

  const _NavItem({
    required this.title,
    required this.icon,
  });
}

class ThemeSettingsPage extends StatelessWidget {
  final Color currentSeedColor;
  final ValueChanged<Color> onSeedColorChange;

  const ThemeSettingsPage({
    super.key,
    required this.currentSeedColor,
    required this.onSeedColorChange,
  });

  @override
  Widget build(BuildContext context) {
    final colorOptions = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.purple,
      Colors.orange,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
    ];

    return ListView(
      padding: Spacings.screenPadding,
      children: [
        const SectionHeader(title: 'Seed Color'),
        const SizedBox(height: Spacings.md),
        const InfoBanner(
          title: 'Theme Customization',
          message:
              'Select a seed color to generate a complete Material 3 color scheme.',
          icon: Icons.info_outline,
        ),
        const SizedBox(height: Spacings.lg),
        Wrap(
          spacing: Spacings.md,
          runSpacing: Spacings.md,
          children: colorOptions.map((color) {
            final isSelected = color == currentSeedColor;
            return GestureDetector(
              onTap: () => onSeedColorChange(color),
              child: Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: Radii.medium,
                  border: Border.all(
                    color: isSelected ? Colors.white : Colors.transparent,
                    width: 3,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: color.withValues(alpha: 0.5),
                            blurRadius: 12,
                            spreadRadius: 2,
                          ),
                        ]
                      : null,
                ),
                child: isSelected
                    ? const Icon(Icons.check, color: Colors.white, size: 32)
                    : null,
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: Spacings.xl),
        const Section(
          title: 'Color Scheme Preview',
          children: [
            _ColorSchemePreview(),
          ],
        ),
      ],
    );
  }
}

class _ColorSchemePreview extends StatelessWidget {
  const _ColorSchemePreview();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return SurfaceCard(
      child: Column(
        children: [
          _ColorSwatch('Primary', scheme.primary, scheme.onPrimary),
          const SizedBox(height: Spacings.sm),
          _ColorSwatch('Secondary', scheme.secondary, scheme.onSecondary),
          const SizedBox(height: Spacings.sm),
          _ColorSwatch('Tertiary', scheme.tertiary, scheme.onTertiary),
          const SizedBox(height: Spacings.sm),
          _ColorSwatch('Surface', scheme.surface, scheme.onSurface),
        ],
      ),
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  final String label;
  final Color background;
  final Color foreground;

  const _ColorSwatch(this.label, this.background, this.foreground);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(Spacings.md),
      decoration: BoxDecoration(
        color: background,
        borderRadius: Radii.small,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: foreground,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '#${background.value.toRadixString(16).substring(2).toUpperCase()}',
            style: TextStyle(
              color: foreground.withValues(alpha: 0.7),
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

class AccessibilitySettingsPage extends StatelessWidget {
  final AccessibilityConfig currentConfig;
  final ValueChanged<AccessibilityConfig> onConfigChange;

  const AccessibilitySettingsPage({
    super.key,
    required this.currentConfig,
    required this.onConfigChange,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: Spacings.screenPadding,
      children: [
        const InfoBanner(
          title: 'Accessibility Features',
          message:
              'Adjust these settings to make the UI more accessible. Changes apply in real-time.',
          icon: Icons.accessibility_new,
        ),
        const SizedBox(height: Spacings.lg),
        SurfaceCard(
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Large Text'),
                subtitle: const Text('Increase text sizes'),
                value: currentConfig.largeText,
                onChanged: (value) {
                  onConfigChange(
                    AccessibilityConfig(
                      largeText: value,
                      textScaleFactor: value ? 1.3 : 1.0,
                      largeTouchTargets: currentConfig.largeTouchTargets,
                      highContrast: currentConfig.highContrast,
                      reducedAnimation: currentConfig.reducedAnimation,
                    ),
                  );
                },
              ),
              const Divider(height: 1),
              SwitchListTile(
                title: const Text('Large Touch Targets'),
                subtitle: const Text('Bigger buttons and interactive elements'),
                value: currentConfig.largeTouchTargets,
                onChanged: (value) {
                  onConfigChange(
                    AccessibilityConfig(
                      largeText: currentConfig.largeText,
                      textScaleFactor: currentConfig.textScaleFactor,
                      largeTouchTargets: value,
                      highContrast: currentConfig.highContrast,
                      reducedAnimation: currentConfig.reducedAnimation,
                    ),
                  );
                },
              ),
              const Divider(height: 1),
              SwitchListTile(
                title: const Text('High Contrast'),
                subtitle: const Text('Enhanced color contrast'),
                value: currentConfig.highContrast,
                onChanged: (value) {
                  onConfigChange(
                    AccessibilityConfig(
                      largeText: currentConfig.largeText,
                      textScaleFactor: currentConfig.textScaleFactor,
                      largeTouchTargets: currentConfig.largeTouchTargets,
                      highContrast: value,
                      reducedAnimation: currentConfig.reducedAnimation,
                    ),
                  );
                },
              ),
              const Divider(height: 1),
              SwitchListTile(
                title: const Text('Reduced Animation'),
                subtitle: const Text('Simpler transitions'),
                value: currentConfig.reducedAnimation,
                onChanged: (value) {
                  onConfigChange(
                    AccessibilityConfig(
                      largeText: currentConfig.largeText,
                      textScaleFactor: currentConfig.textScaleFactor,
                      largeTouchTargets: currentConfig.largeTouchTargets,
                      highContrast: currentConfig.highContrast,
                      reducedAnimation: value,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: Spacings.xl),
        Section(
          title: 'Preview',
          children: [
            ActionButton(
              text: 'Sample Button',
              icon: Icons.touch_app,
              onPressed: () {},
            ),
            const SizedBox(height: Spacings.md),
            const SurfaceCard(
              child: Text(
                'This is sample text to demonstrate the accessibility settings in action.',
              ),
            ),
          ],
        ),
      ],
    );
  }
}
