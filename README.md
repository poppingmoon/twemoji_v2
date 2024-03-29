# twemoji_v2
> Originally maintained by [hadi-codes](https://github.com/hadi-codes), extended to support the newest set of twemoji.

[Twemoji](https://twemoji.twitter.com/) for Flutter, supports SVG

Based on [jdecked's fork of twemoji (v14.1.2)](https://github.com/jdecked/twemoji)

<img src="https://raw.githubusercontent.com/DynxstyGIT/twemoji_v2/main/art/1.png" width=270>

## Usage

**Twemoji** to display single emojis

```dart
Twemoji(
  emoji: '🍕',
  height: 50,
  width: 50,
)
```

**TwemojiText** returns a widget with rendered text with twitter emojis

```dart
TwemojiText(
  text: 'wow 💻👩‍💻👨‍💻 ',
),
```

**TwemojiTextSpan** with **RichText** and it will render the text with twitter Emojies

```dart
RichText(
  text: TwemojiTextSpan(
  text: 'Text 🍕🍔🌭🍿🧂🥓🥨🥐🍞🥞🥞',
  style: Theme.of(context).textTheme.headline6,
  ),
)
```
