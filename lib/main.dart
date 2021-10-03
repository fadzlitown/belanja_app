import 'dart:io';

import 'package:belanja_app/widgets/chart.dart';
import 'package:belanja_app/widgets/new_transaction.dart';
import 'package:belanja_app/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'models/transaction.dart';

void main() {
  /// Controlling Orientation - Force always Portrait
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  /// Common Problem : Flutter needs to recalculate everything on the screen
  /// when build gets re-build ? --> by calling setState / orientation change, soft keyboard etc
  /// will trigger build when there's an update the configuration changes -> new UI screen

  /// Widget tree jobs to provide config for element & render tree
  /// Element tree jobs to connect widget & render tree, manage state, under render tree when widget tree changes
  /// Widget tree are immutable, it already has properties provided. (so every rebuild, it just changes a new value references)
  /// the state eg. _MyHomePageState is detach from the Widget. Thus, for every UI rebuild, the state will be stored
  /// When setState triggered, The other widget tree also will be kept on Element tree (created by flutter),
  /// Element tree can auto update its ref when a new configuration is available & re-render the UI.
  /// build() = runs very ofter & rebuilds the widget tree / parts of it
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          ///primarySwatch = diff shade of colors, primaryColor = single color
          /// will reflect to the appbar & other undefined floating button
          primarySwatch: Colors.green,
          accentColor: Colors.lightGreen,
          fontFamily: 'OpenSans',

          /// TITLE THEME WIDGET : headline6
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
              button:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          appBarTheme: AppBarTheme(

              /// TITLE APPBAR THEME
              /// AppBarTheme has own text theme which we could override, all title text in the app
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontFamily: 'OpenSans',
                      fontSize: 20,
                      fontWeight: FontWeight.bold)))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String titleInput;
  // String amountInput;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //     id: '1', title: 'New Shirt', amount: 29.99, dateTime: DateTime.now()),
    // Transaction(
    //     id: '2', title: 'Cap NY', amount: 40.89, dateTime: DateTime.now())
  ];

  bool _showChart = false;

  List<Transaction> get _getRecentTransactions {
    /// where : Returns a new lazy [Iterable] with all elements that satisfy to below condition
    return _userTransactions.where((element) {
      return element.dateTime
          .isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addTransaction(Transaction transaction) {
    setState(() {
      _userTransactions.add(transaction);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
              child: NewTransaction(_addTransaction),
              onTap: () {},

              ///avoid the sheet not close when top on it
              behavior: HitTestBehavior.opaque);
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) {
        return element.id == id;
      });
    });
  }

  ///Builder method = manage the logic & more readable code
  List<Widget> _buildLandscapeContent(
      MediaQueryData mediaQuery, AppBar appBar, Container txListWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Show Chart', style: Theme.of(context).textTheme.headline6),

          ///Switch = used Switch UI in Material Design
          ///Switch.adaptive = based on platform Android (Material) or iOS
          Switch.adaptive(
              value: _showChart,
              onChanged: (val) {
                setState(() {
                  _showChart = val;
                });
              })
        ],
      ),

      /// if isLandscapeMode & showChart only, then show Chart. Otherwise show List
      _showChart
          ? Container(

              /// Added Responsive layout size here.
              /// MediaQuery = allows to fetch info about the device orientation, measures & user settings
              /// & Calculate size of height dynamically using MediaQuery.of(context).size
              /// 0.0 = no height <----> 1.0 = full height,
              /// HENCE, chart view only needs 0.4 = 40% height allocated
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  .7,
              child: Container(
                  child: Chart(recentTransactions: _getRecentTransactions)))
          : txListWidget
    ];
  }

  List<Widget> _buildPotraitContent(
      MediaQueryData mediaQueryData, AppBar appBar, Container txListWidget) {
    return [
      Container(

          /// Added Responsive layout size here.
          /// MediaQuery = allows to fetch info about the device orientation, view measures, viewInset & user settings = any changes will cause rebuild
          /// & Calculate size of height dynamically using MediaQuery.of(context).size
          /// 0.0 = no height <----> 1.0 = full height,
          /// HENCE, chart view only needs 0.4 = 40% height allocated
          height: (mediaQueryData.size.height -
                  appBar.preferredSize.height -
                  mediaQueryData.padding.top) *
              .3,
          child: Container(
              child: Chart(recentTransactions: _getRecentTransactions))),
      txListWidget
    ];
  }

  Widget _buildAndroidPlatform() {
    return FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context));
  }

  @override
  Widget build(BuildContext context) {
    print('build _MyHomePageState');

    /// appBar = can be access everywhere & has an appBar size information
    final appBar = AppBar(
      title: Text(
        'Belanja App',
        style: TextStyle(fontFamily: 'Quicksand'),
      ),
      actions: <Widget>[
        IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.amber,
            ),
            onPressed: () => _startAddNewTransaction(context))
      ],
    );

    ///for optimization, only render once
    final mediaQuery = MediaQuery.of(context);

    ///Get current Orientation info
    final isLandscapeMode = mediaQuery.orientation == Orientation.landscape;

    ///Get Transaction List
    final txListWidget = Container(

        /// HENCE, list view only needs 0.6 = 60% height allocated
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.7,
        child: TransactionList(_userTransactions, _deleteTransaction));

    /// in iOS SingleChildScrollView will have some issue
    /// SafeArea = make sure everything positioned within the boundaries & respect the area of screen
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(

            /// Column widget important in layout!
            ///mainAxisAlignment starting from top->bottom,
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            mainAxisAlignment: MainAxisAlignment.start,

            ///crossAxisAlignment starting from left -> right. def is center
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Alternative Landscape solution, by using Switch to add the UI Screen logic
              /// if isLandscapeMode only, then show ROW Text & Switch otherwise empty
              if (isLandscapeMode)
                ..._buildLandscapeContent(mediaQuery, appBar, txListWidget),

              ///... flattening a list of widget into this children widgets (like merge multiple views)

              /// if Potreit only, then show Chart & List
              if (!isLandscapeMode)
                ..._buildPotraitContent(mediaQuery, appBar, txListWidget),

              /// NewTransaction(_addTransaction),   --> already handle in BottomSheet!
              /// pass the func pointer here
            ]),
      ),
    );

    return Scaffold(
      appBar: appBar,
      body: pageBody,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          Platform.isIOS ? Container() : _buildAndroidPlatform(),
    );
  }
}
