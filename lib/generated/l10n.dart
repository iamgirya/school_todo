// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Мои дела`
  String get taskListTitleName {
    return Intl.message(
      'Мои дела',
      name: 'taskListTitleName',
      desc: '',
      args: [],
    );
  }

  /// `Выполнено - {completedCount}`
  String taskListTitleCompleted(Object completedCount) {
    return Intl.message(
      'Выполнено - $completedCount',
      name: 'taskListTitleCompleted',
      desc: '',
      args: [completedCount],
    );
  }

  /// `Новое`
  String get taskListFastTaskHint {
    return Intl.message(
      'Новое',
      name: 'taskListFastTaskHint',
      desc: '',
      args: [],
    );
  }

  /// `СОХРАНИТЬ`
  String get editorSaveButton {
    return Intl.message(
      'СОХРАНИТЬ',
      name: 'editorSaveButton',
      desc: '',
      args: [],
    );
  }

  /// `Важность`
  String get editorImportanceTitle {
    return Intl.message(
      'Важность',
      name: 'editorImportanceTitle',
      desc: '',
      args: [],
    );
  }

  /// `Сделать до`
  String get editorDeadlineTitle {
    return Intl.message(
      'Сделать до',
      name: 'editorDeadlineTitle',
      desc: '',
      args: [],
    );
  }

  /// `Удалить`
  String get editorDeleteButton {
    return Intl.message(
      'Удалить',
      name: 'editorDeleteButton',
      desc: '',
      args: [],
    );
  }

  /// `Нет`
  String get editorImportanceBasic {
    return Intl.message(
      'Нет',
      name: 'editorImportanceBasic',
      desc: '',
      args: [],
    );
  }

  /// `!!Высокий`
  String get editorImportanceImportant {
    return Intl.message(
      '!!Высокий',
      name: 'editorImportanceImportant',
      desc: '',
      args: [],
    );
  }

  /// `Низкий`
  String get editorImportanceLow {
    return Intl.message(
      'Низкий',
      name: 'editorImportanceLow',
      desc: '',
      args: [],
    );
  }

  /// `Нет`
  String get noWord {
    return Intl.message(
      'Нет',
      name: 'noWord',
      desc: '',
      args: [],
    );
  }

  /// `Что-то надо сделать...`
  String get editorTextTaskHint {
    return Intl.message(
      'Что-то надо сделать...',
      name: 'editorTextTaskHint',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ru', countryCode: 'RU'),
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
