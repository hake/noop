# Colorful-card UI refresh — preview

This redesign updates **shared design tokens and card surfaces** (not navigation or features). The default Liquid Today shell, classic Today, and all `NoopCard` / `StrandCard` screens pick up the new look automatically.

## What changed visually

- **Canvas:** soft off-white (`#F6F5F2`) in light mode; soft charcoal in dark mode.
- **Cards:** 28pt corner radius, white fills, **pastel domain washes** on tinted cards, light drop shadows on light mode.
- **Pills:** `StatePill` and `TrendChip` use fuller pastel fills (mockup-style stat pills).
- **Liquid sky:** pastel sky-blue / peach horizon in light mode; subdued blue-grey in dark (aligned on iOS + Android).
- **Hero card:** light sky-blue frosted surface (`heroFill`).

## How to preview

### macOS (reference app)

```bash
xcodegen generate
xcodebuild -project Strand.xcodeproj -scheme Strand \
  -destination 'platform=macOS' CODE_SIGNING_ALLOWED=NO build
```

Open **Today** (Liquid Today is on by default). Toggle **Settings → Appearance → Light** to see the colorful-card light theme.

DEBUG screenshot harness (single screen):

```bash
# Example: Liquid Today only
xcodebuild … -scheme NOOPiOS …  # device/simulator
# Launch with: --demo-screen liquidtoday
```

### iOS

Same as macOS with scheme **NOOPiOS** and a simulator destination. Liquid Today: Settings → *Liquid home* toggle (default on).

### Android

```bash
cd android && ./gradlew assembleFullDebug
```

Install the Full debug APK. **Today** uses the liquid header sky and shared `NoopCard` components.

## Key files

| Layer | Files |
|-------|--------|
| Swift tokens + card surface | `Packages/StrandDesign/Sources/StrandDesign/NoopVisualStyle.swift`, `Palette.swift`, `StatePill.swift`, `Components.swift` |
| Liquid atmosphere | `Strand/Liquid/LiquidSky.swift` |
| Android tokens | `android/.../PaletteTokens.kt`, `Theme.kt` |
| Android cards + sky | `android/.../Components.kt`, `LiquidSky.kt` |
