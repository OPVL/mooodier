import 'package:flutter/material.dart';
import 'package:mooodier/mooodier.dart';

class ComponentCatalogPage extends StatefulWidget {
  final String title;

  const ComponentCatalogPage({
    super.key,
    this.title = 'UI Catalog',
  });

  @override
  State<ComponentCatalogPage> createState() => _ComponentCatalogPageState();
}

class _ComponentCatalogPageState extends State<ComponentCatalogPage> {
  double _animationSpeed = 1.5;
  bool _lowercaseEnabled = true;

  void _showFrostedModal(BuildContext context) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.3),
      builder: (context) => Stack(
        children: [
          // Frosted glass backdrop covering the whole screen
          Positioned.fill(
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: FrostedGlassContainer(
                blur: 20,
                opacity: 0.1,
                child: const SizedBox.expand(),
              ),
            ),
          ),
          // Centered modal content
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surface
                    .withValues(alpha: 0.8),
                borderRadius: Radii.large,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.all(Spacings.xl),
              child: SizedBox(
                width: 300,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 64,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: Spacings.md),
                    Text(
                      'Frosted Modal',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: Spacings.sm),
                    Text(
                      'This modal uses FrostedGlassContainer as a full-screen backdrop',
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: Spacings.lg),
                    ActionButton(
                      text: 'Close',
                      icon: Icons.close,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final gradientColors = [
      theme.colorScheme.primary.withValues(alpha: 0.75),
      theme.colorScheme.secondary.withValues(alpha: 0.5),
      theme.colorScheme.tertiary.withValues(alpha: 0.55),
      theme.colorScheme.primary.withValues(alpha: 0.75),
    ];

    return Scaffold(
      body: ListView(
        padding: Spacings.screenPadding,
        children: [
          SizedBox(
            key: const Key('visual-language-preview'),
            height: 220,
            child: ClipRRect(
              borderRadius: Radii.large,
              child: AnimatedGradientContainer(
                colors: gradientColors,
                pauseWhenOffscreen: false,
                animationSpeed: _animationSpeed,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(Spacings.lg),
                    child: FormattedText(
                      'Visual Language Preview',
                      forceLowercase: _lowercaseEnabled,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: Spacings.xl),
          Section(
            title: 'Surface Cards',
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SurfaceCard(
                    variant: SurfaceVariant.elevated,
                    child: FormattedText('Elevated card surface',
                        forceLowercase: _lowercaseEnabled),
                  ),
                  SurfaceCard(
                    variant: SurfaceVariant.outlined,
                    child: FormattedText('Outlined card surface',
                        forceLowercase: _lowercaseEnabled),
                  ),
                  SurfaceCard(
                    variant: SurfaceVariant.glass,
                    child: FormattedText('Glass card surface',
                        forceLowercase: _lowercaseEnabled),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: Spacings.xl),
          Section(
            title: 'Formatted Text',
            children: [
              SurfaceCard(
                variant: SurfaceVariant.outlined,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Force Lowercase',
                          style: theme.textTheme.titleMedium,
                        ),
                        Switch(
                          value: _lowercaseEnabled,
                          onChanged: (value) {
                            setState(() {
                              _lowercaseEnabled = value;
                            });
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: Spacings.md),
                    const Divider(),
                    const SizedBox(height: Spacings.md),
                    Text(
                      'Examples:',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: Spacings.sm),
                    FormattedText(
                      'THIS TEXT Will Be Formatted',
                      forceLowercase: _lowercaseEnabled,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: Spacings.sm),
                    FormattedText(
                      'Perfect For Design Systems That Prefer Lowercase',
                      forceLowercase: _lowercaseEnabled,
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: Spacings.sm),
                    FormattedText(
                      'HEADINGS, LABELS, AND UI TEXT',
                      forceLowercase: _lowercaseEnabled,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: Spacings.md),
                    const Divider(),
                    const SizedBox(height: Spacings.md),
                    Text(
                      'Text Field:',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.secondary,
                      ),
                    ),
                    const SizedBox(height: Spacings.sm),
                    FormattedTextField(
                      initialValue: 'Type ANYTHING Here',
                      forceLowercase: _lowercaseEnabled,
                      decoration: InputDecoration(
                        labelText: 'Formatted Input',
                        hintText: 'Try typing in capitals...',
                        border: const OutlineInputBorder(),
                        helperText: _lowercaseEnabled
                            ? 'Text is automatically lowercased'
                            : 'Text is displayed as typed',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const InfoBanner(
            title: 'Library Ready',
            message:
                'This package standardises shared visual components for consistent app UI.',
            icon: Icons.palette_outlined,
          ),
          const SizedBox(height: Spacings.xl),
          Section(
            title: 'Animated Gradient Background',
            children: [
              SizedBox(
                height: 180,
                child: ClipRRect(
                  borderRadius: Radii.large,
                  child: AnimatedGradientContainer(
                    colors: gradientColors,
                    pauseWhenOffscreen: false,
                    animationSpeed: _animationSpeed,
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(Spacings.lg),
                        child: FormattedText(
                          'self-blurred gradient',
                          forceLowercase: true,
                          style: theme.textTheme.titleLarge?.copyWith(
                            color: theme.colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: Spacings.md),
              SurfaceCard(
                variant: SurfaceVariant.outlined,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Animation Speed: ${_animationSpeed.toStringAsFixed(1)}x',
                          style: theme.textTheme.titleMedium,
                        ),
                        Text(
                          _animationSpeed < 0.8
                              ? 'Slow'
                              : _animationSpeed > 1.5
                                  ? 'Fast'
                                  : 'Normal',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.secondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: Spacings.sm),
                    Slider(
                      padding: EdgeInsets.symmetric(vertical: Spacings.sm),
                      value: _animationSpeed,
                      min: 0.1,
                      max: 3.0,
                      divisions: 29,
                      label: '${_animationSpeed.toStringAsFixed(1)}x',
                      onChanged: (value) {
                        setState(() {
                          _animationSpeed = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: Spacings.xl),
          Section(
            title: 'Frosted Glass Overlay',
            children: [
              const SizedBox(
                key: Key('frosted-glass-overlay'),
                height: 200,
                child: Stack(
                  children: [
                    // Background gradient to show glass effect
                    ClipRRect(
                      borderRadius: Radii.large,
                      child: AnimatedGradientContainer(
                        pauseWhenOffscreen: false,
                        animationSpeed: 0.8,
                      ),
                    ),
                    // Frosted glass overlay
                    Center(
                      child: FrostedGlassContainer(
                        blur: 15,
                        opacity: 0.15,
                        borderRadius: Radii.medium,
                        padding: EdgeInsets.all(Spacings.lg),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.blur_on, size: 48),
                            SizedBox(height: Spacings.sm),
                            Text(
                              'Glass Overlay',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: Spacings.md),
              ActionButton(
                text: 'Show Frosted Modal',
                icon: Icons.open_in_new,
                onPressed: () => _showFrostedModal(context),
              ),
            ],
          ),
          const Section(
            title: 'Actions',
            children: [
              ActionButton(
                text: 'Primary action',
                icon: Icons.check,
              ),
              SizedBox(height: Spacings.sm),
              ActionButton(
                text: 'Subtle action',
                variant: ActionButtonVariant.subtle,
              ),
            ],
          ),
          Section(
            title: 'List Tile',
            children: [
              SurfaceCard(
                variant: SurfaceVariant.outlined,
                padding: EdgeInsets.zero,
                child: Column(
                  children: const [
                    CustomListTile(
                      title: 'Theme',
                      subtitle: 'Material 3 with accessibility-aware styling',
                      leadingIcon: Icons.color_lens_outlined,
                    ),
                    Divider(height: 0),
                    CustomListTile(
                      title: 'Effects',
                      subtitle: 'Animated gradients and frosted surfaces',
                      leadingIcon: Icons.blur_on,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
