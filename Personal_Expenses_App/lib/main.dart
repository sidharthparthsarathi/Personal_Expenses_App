import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import './widgets/New_Transactions.dart';
import './widgets/TransactionsList.dart';
import './Models/Transactions.dart';
import './widgets/chart.dart';
void main()
{
  //WidgetsFlutterBinding.ensureInitialized();//we have to again run build method to do this.
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,
  //DeviceOrientation.portraitDown]);
  runApp(MyAppState());
}
class MyAppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.purple,
      accentColor: Colors.blue[700],
      appBarTheme: AppBarTheme/*only works for appbar*/(textTheme: ThemeData.light()/*set of Defaults*/.textTheme/*access TextTheme*/.copyWith(
        headline6: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 20,
        ), 
      )/*Copy with our own setting*/,//to set the title of every appbar to this global font.
      color: Colors.green),
      fontFamily: 'QuickSand',//you can write 'quicksand' also which is valis but 'quick sand' is not valid because space is not valid
      textTheme: /*global fontfamily*/ThemeData.light().textTheme.copyWith(
        headline6: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.red,
        ),
        button: TextStyle(color: Colors.white,),
      )
    ),
      home: MyApp(),
    );
  }
}



class MyApp extends StatefulWidget {//converted stateless to stateful widget
  //String titleInput;
  //String amount;
  @override
  _MyAppState createState() => _MyAppState();
}




class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  static String encode=Transaction.encodeTransactions([]);//Converted The Lists into String format in Transactions.dart
  static String data=encode;
  List<Transaction> transaction=Transaction.decodeTransactions(data);//Transaction List Declaration
  Future<String> get localPath async {//Local Path For Storing Data
    var directory = await getApplicationDocumentsDirectory();//Changed This From Final To Var 
    print('The Path Of This'+directory.path);
    return directory.path;
  }




  Future<File> get localFile async {//Local File
    var path = await localPath;
    print('Control In localfile Line 74');
    return File('$path/Data.txt');
  }




  Future<String> readContent() async {//ReadContent
    try {
      var file = await localFile;
      // Read the file
      String contents = await file.readAsString();
      print('The Control Is In ReadContent'+contents+'Line 85');//For Debugging
      // Returning the contents of the file
      return contents;
    } catch (e) {
      // If encountering an error, return
      return 'Error!';
    }
  }




  Future<File> writeContent() async {//Write Content
    var file = await localFile;
    // Write the file
    return file.writeAsString(data);
  }






    
    /*Transaction(id: 't1',title: 'Dollar',amount: 69.9,date: DateTime.now(),),
    Transaction(id: 't2',title: 'INR',amount: 10,date: DateTime.now()),
     Transaction(id: 't2',title: 'INR',amount: 10,date: DateTime.now()),
      Transaction(id: 't2',title: 'INR',amount: 10,date: DateTime.now()),
       Transaction(id: 't2',title: 'INR',amount: 10,date: DateTime.now()),
        Transaction(id: 't2',title: 'INR',amount: 10,date: DateTime.now()),
         Transaction(id: 't2',title: 'INR',amount: 10,date: DateTime.now()),
          Transaction(id: 't2',title: 'INR',amount: 10,date: DateTime.now()),
           Transaction(id: 't2',title: 'INR',amount: 10,date: DateTime.now()),
            Transaction(id: 't2',title: 'INR',amount: 10,date: DateTime.now()),*///For Testing View Port//For Adding Images
  //];



  bool showChart=false;


  /*@override
  void didChangeAppLifecycleState(AppLifecycleState state){
    print(state);
  }
  void dispose(){
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }*///Commented For Important Code Readability.

  List<Transaction> get recentTransactions{
    return transaction.where((tx){
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7),),);
    }).toList();
  }



  void _addNewTransaction(String txTitle,double txAmount,DateTime chosenDate)
  {
    final newTx=Transaction(title: txTitle,amount: txAmount,date: chosenDate/*DateTime.now()*/,id: DateTime.now().toString(),);
    writeContent();
    setState(() {
      transaction.add(newTx);
      data=encode;
      data=Transaction.encodeTransactions(transaction);
      writeContent();
    });
    writeContent();
  }



  void startNewTransaction(BuildContext hellctc)
  {
    showModalBottomSheet(context: hellctc, builder: (_){
      return GestureDetector(
        onTap: () {},
        child: NewTransactions(_addNewTransaction),
        behavior: HitTestBehavior.opaque,);
    },
    );
  }


  void deleteTransaction(String id)//Delete Transac
  {
    setState(() {
          transaction.removeWhere((tx) => tx.id==id);
    });
  }


  List<Widget> buildPortrait(MediaQueryData mediaQuery,AppBar appBar,Widget txListWidget){//Portrait Mode
    return [Container(height: (mediaQuery.size.height-appBar.preferredSize.height-mediaQuery.padding.top)*0.3,
        child: Chart(recentTransactions)),
        txListWidget];
  }


  List<Widget> buildLandscape(MediaQueryData mediaQuery,AppBar appBar,Widget txListWidget)//Landscpe Mode
  {
    return [Container(height: (mediaQuery.size.height-appBar.preferredSize.height-mediaQuery.padding.top)*0.13,
          child: Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Show Chart', style: Theme.of(context).textTheme.headline6,),
              Switch.adaptive(
                activeColor: Theme.of(context).accentColor,
                value: showChart,
                onChanged: (val)
              {
                setState(() {
                   showChart=val;
                });
              }),
            ],),
        ),
        showChart ? Container(height: (mediaQuery.size.height-appBar.preferredSize.height-mediaQuery.padding.top)*0.6,
        child: Chart(recentTransactions))
        : txListWidget];
  }



  Widget buildAppBar(String appBarTitle)//In Case of Error Use PreferredSizeWidget Instead of Widget//Another Solution
  {
    return Platform.isIOS ? CupertinoNavigationBar(//Ignore For Android
      middle: FittedBox(child: Text(appBarTitle)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
        GestureDetector(
          child: const Icon(CupertinoIcons.add),//using const to avoid performance drop
          onTap: () => startNewTransaction(context),),
      ],),
    )
    : AppBar(centerTitle: true,
    title: FittedBox(child: Text(appBarTitle)),
    actions: [
        IconButton(
          icon: const Icon(Icons.add),//using const to avoid performance drop
          onPressed: () => startNewTransaction(context),
          color: Colors.indigo,
          ),
          ],
    );
  }


  @override
  void initState() {
        WidgetsBinding.instance.addObserver(this);
    super.initState();
    writeContent();
    readContent().then((String value) {
      setState(() {
        data = value;
        print('This Is My String'+data+'In Set State Line-242');
      });
    });
  }




  @override
  Widget build(BuildContext context) {
    //print('build() MyHomePageState');
    print(data);
    final appBarTitle='PERSONAL EXPENSES APP';
    final mediaQuery=MediaQuery.of(context);
    final isLandscape=mediaQuery.orientation == Orientation.landscape;
    final PreferredSizeWidget appbar=buildAppBar(appBarTitle);
    //print(mediaQuery.size.height);
    final txListWidget=Container(height: (mediaQuery.size.height-appbar.preferredSize.height-mediaQuery.padding.top)*(isLandscape ? 0.87 : 0.7),
        child: TransactionList(transaction,deleteTransaction,isLandscape),);
        final pageBody= SafeArea(child: SingleChildScrollView(//For adding Scrolling Functionality To Column
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [ 
        if(isLandscape)//we can use ternary expression here or if statement
        ...buildLandscape(mediaQuery, appbar, txListWidget),
        if(!isLandscape)//we can use ternary expression here or if statement
        ...buildPortrait(mediaQuery,appbar,txListWidget),
      ],
      ),
    ),);
    return Platform.isIOS ? CupertinoPageScaffold(
      child: pageBody,
      navigationBar: appbar,
      )
     : Scaffold(appBar: appbar,//AppBar(centerTitle: true,//to place the title in center
    //title: Text(
      //'PERSONAL EXPENSES APP',
      //style: TextStyle(fontFamily: 'OpenSans',),//you can also use 'opensans' (lowerCase) but cant used with space('open sans')
          body: pageBody,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,//centerDocked, 
          floatingActionButton: Platform.isIOS ? Container() : FloatingActionButton(child: const Icon(Icons.add),onPressed: () => startNewTransaction(context),backgroundColor: Colors.indigo,),//Platform.isAndroid ? FloatingActionButton(child: Icon(Icons.add),onPressed: () => startNewTransaction(context),backgroundColor: Colors.indigo,) : Container(),
      );
  }
}