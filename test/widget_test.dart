// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:curimba/models/card_model.dart';
import 'package:curimba/navigation_service.dart';
import 'package:curimba/screens/create_card.dart';
import 'package:curimba/screens/home.dart';
import 'package:curimba/screens/list_cards.dart';
import 'package:curimba/screens/recomended_cards.dart';
import 'package:curimba/view_models/card_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'fake_locator.dart';
import 'mocks.dart';

// Mocks

void main() {
  setUpAll(() {
    SharedPreferences.setMockInitialValues({'userId': 1});
    setUpFakeLocator();
  });

  group('Home Widget', () {
    testWidgets('should display all options', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(
        home: Home(),
      ));

      expect(find.text('CADASTRAR CARTÃO'), findsOneWidget);
      expect(find.text('LISTAR CARTÕES'), findsOneWidget);
      expect(find.text('CARTÕES RECOMENDADOS'), findsOneWidget);
    });

    testWidgets("on click 'CADASTRAR CARTÃO' should redirect to CreateCard",
        (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();

      await tester.pumpWidget(MultiProvider(
          providers: [
            ChangeNotifierProvider<CardViewModel>.value(value: CardViewModel()),
          ],
          child: MaterialApp(
            navigatorKey: fakeLocator<NavigationService>().navigatorKey,
            onGenerateRoute: (routeSettings) =>
                fakeLocator<NavigationService>().generateRoute(routeSettings),
            home: Home(),
            navigatorObservers: [mockObserver],
          )));

      await tester.tap(find.text('CADASTRAR CARTÃO'));
      await tester.pumpAndSettle();

      verify(mockObserver.didPush(any, any));
      expect(find.byType(CreateCard), findsOneWidget);
    });

    testWidgets("on click 'LISTAR CARTÕES' should redirect to CardsList",
        (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();
      final mockCardViewModel = MockCardViewModel();

      when(mockCardViewModel.cards).thenReturn(List());

      await tester.pumpWidget(MultiProvider(
          providers: [
            ChangeNotifierProvider<CardViewModel>.value(
                value: mockCardViewModel),
          ],
          child: MaterialApp(
            home: Home(),
            navigatorKey: fakeLocator<NavigationService>().navigatorKey,
            onGenerateRoute: (routeSettings) =>
                fakeLocator<NavigationService>().generateRoute(routeSettings),
            navigatorObservers: [mockObserver],
          )));

      await tester.tap(find.text('LISTAR CARTÕES'));
      await tester.pumpAndSettle();

      verify(mockObserver.didPush(any, any));
      expect(find.byType(ListCards), findsOneWidget);
    });

    testWidgets(
        "on click 'CARTÕES RECOMENDADOS' should redirect to RecommendedCards",
        (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();
      final mockCardViewModel = MockCardViewModel();

      when(mockCardViewModel.invoiceCards).thenReturn(List());

      await tester.pumpWidget(MultiProvider(
          providers: [
            ChangeNotifierProvider<CardViewModel>.value(
                value: mockCardViewModel),
          ],
          child: MaterialApp(
            home: Home(),
            navigatorKey: fakeLocator<NavigationService>().navigatorKey,
            onGenerateRoute: (routeSettings) =>
                fakeLocator<NavigationService>().generateRoute(routeSettings),
            navigatorObservers: [mockObserver],
          )));

      await tester.tap(find.text('CARTÕES RECOMENDADOS'));
      await tester.pumpAndSettle();

      verify(mockObserver.didPush(any, any));
      expect(find.byType(RecommendedCards), findsOneWidget);
    });
  });

  group('ListCards Widget', () {
    testWidgets("on list card should display all registered cards",
        (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();
      final mockCardViewModel = MockCardViewModel();
      final registeredCard = [
        CardModel(
            lastNumbers: "1111",
            brandName: "Brand1",
            expiryDate: "11",
            usersId: 1),
        CardModel(
            lastNumbers: "2222",
            brandName: "Brand2",
            expiryDate: "12",
            usersId: 1),
        CardModel(
            lastNumbers: "3333",
            brandName: "Brand3",
            expiryDate: "13",
            usersId: 1),
        CardModel(
            lastNumbers: "4444",
            brandName: "Brand4",
            expiryDate: "14",
            usersId: 1),
      ];

      when(mockCardViewModel.cards).thenReturn(registeredCard);

      await tester.pumpWidget(MultiProvider(
          providers: [
            ChangeNotifierProvider<CardViewModel>.value(
                value: mockCardViewModel),
          ],
          child: MaterialApp(
            home: ListCards(),
            navigatorObservers: [mockObserver],
          )));
      expect(find.text("Brand1"), findsOneWidget);
      expect(find.text("Brand2"), findsOneWidget);
      expect(find.text("Brand3"), findsOneWidget);
      expect(find.text("Brand4"), findsOneWidget);
    });
  });

  group('RecommendedCards Widget', () {
    testWidgets(
        "on list recommended cards should display all recommended cards",
        (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();
      final mockCardViewModel = MockCardViewModel();
      final recommendedCard = [
        CardModel(
            lastNumbers: "1111",
            brandName: "Brand1",
            expiryDate: "11",
            usersId: 1),
        CardModel(
            lastNumbers: "2222",
            brandName: "Brand2",
            expiryDate: "12",
            usersId: 1),
        CardModel(
            lastNumbers: "3333",
            brandName: "Brand3",
            expiryDate: "13",
            usersId: 1),
        CardModel(
            lastNumbers: "4444",
            brandName: "Brand4",
            expiryDate: "14",
            usersId: 1),
      ];

      when(mockCardViewModel.invoiceCards).thenReturn(recommendedCard);

      await tester.pumpWidget(MultiProvider(
          providers: [
            ChangeNotifierProvider<CardViewModel>.value(
                value: mockCardViewModel),
          ],
          child: MaterialApp(
            home: RecommendedCards(),
            navigatorObservers: [mockObserver],
          )));
      expect(find.text("Brand1"), findsOneWidget);
      expect(find.text("Brand2"), findsOneWidget);
      expect(find.text("Brand3"), findsOneWidget);
      expect(find.text("Brand4"), findsOneWidget);
    });
  });

  group('CreateCart Widget', () {
    testWidgets("should display fields", (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();

      await tester.pumpWidget(MultiProvider(
          providers: [
            ChangeNotifierProvider<CardViewModel>.value(value: CardViewModel()),
          ],
          child: MaterialApp(
            home: CreateCard(),
            navigatorObservers: [mockObserver],
          )));
      expect(find.text("Visa"), findsOneWidget);
      expect(find.text("•••• •••• •••• 4444"), findsOneWidget);
      expect(find.text("DD"), findsOneWidget);
      expect(find.text("CADASTRAR CARTÃO"), findsOneWidget);
    });

    // testWidgets(
    //     "on click 'CADASTRAR CARTÃO' with valid field should create card",
    //     (WidgetTester tester) async {
    //   final mockObserver = MockNavigatorObserver();
    //   final mockCardViewModel = MockCardViewModel();
    //
    //   when(mockCardViewModel.register(
    //     CardModel(
    //       lastNumbers: "•••• •••• •••• 1234",
    //       brandName: "brand",
    //       expiryDate: "10",
    //       usersId: 1,
    //     ),
    //   )).thenAnswer(((_) => new Future(() => 1)));
    //
    //   await tester.pumpWidget(MultiProvider(
    //       providers: [
    //         ChangeNotifierProvider<CardViewModel>.value(
    //             value: mockCardViewModel),
    //       ],
    //       child: MaterialApp(
    //         home: CreateCard(),
    //         navigatorKey: fakeLocator<NavigationService>().navigatorKey,
    //         onGenerateRoute: (routeSettings) =>
    //             fakeLocator<NavigationService>().generateRoute(routeSettings),
    //         navigatorObservers: [mockObserver],
    //       )));
    //
    //   var registerBtn = find.byType(RaisedButton);
    //   var formFields = find.byType(TextFormField);
    //
    //   await tester.enterText(formFields.at(0), "brand");
    //   await tester.enterText(formFields.at(1), "1234");
    //   await tester.enterText(formFields.at(2), "10");
    //
    //   await tester.tap(registerBtn);
    //
    //   verify(mockCardViewModel.register(any)).called(1);
    // });

    testWidgets(
        "on click 'CADASTRAR CARTÃO' with empty field should return error",
        (WidgetTester tester) async {
      final mockObserver = MockNavigatorObserver();

      await tester.pumpWidget(MultiProvider(
          providers: [
            ChangeNotifierProvider<CardViewModel>.value(value: CardViewModel()),
          ],
          child: MaterialApp(
            home: CreateCard(),
            navigatorObservers: [mockObserver],
          )));

      var registerBtn = find.byType(RaisedButton);
      var formFields = find.byType(TextFormField);

      await tester.enterText(formFields.at(0), "brand");
      await tester.enterText(formFields.at(1), "1234");

      await tester.tap(registerBtn);
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.text("Complete o campo"), findsOneWidget);
    });

    // testWidgets(
    //     "on click 'CADASTRAR CARTÃO' with invalid last numbers should return error",
    //     (WidgetTester tester) async {
    //   final mockObserver = MockNavigatorObserver();
    //
    //   await tester.pumpWidget(MultiProvider(
    //       providers: [
    //         ChangeNotifierProvider<CardViewModel>.value(value: CardViewModel()),
    //       ],
    //       child: MaterialApp(
    //         home: CreateCard(),
    //         navigatorObservers: [mockObserver],
    //       )));
    //
    //   var registerBtn = find.byType(RaisedButton);
    //   var formFields = find.byType(TextFormField);
    //
    //   await tester.enterText(formFields.at(0), "brand");
    //   await tester.enterText(formFields.at(1), "12");
    //   await tester.enterText(formFields.at(2), "10");
    //
    //   await tester.tap(registerBtn);
    //   await tester.pump(const Duration(milliseconds: 100));
    //   expect(find.text("Complete o campo"), findsOneWidget);
    // });
  });
}
