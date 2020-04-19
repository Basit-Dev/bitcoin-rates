import 'package:bitcoin_ticker/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  @override
  void initState() {
    super.initState();

    setState(() {});
  }

  String selectedAndroidButton = 'USD';

  DropdownButton<String> getAndroidButton() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (var i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];
      var item = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItems.add(item);
      print(currency);
    }
    return DropdownButton(
      value: selectedAndroidButton,
      items: dropDownItems,
// newValue is the state variable
      onChanged: (newValue) {
        setState(() {
          selectedAndroidButton = newValue;
        });
      },
    );
  }

  Text getDropDownItemsText;
  String selectedIOSPicker = 'USD';

  Widget getIosPicker() {
    List<Text> dropDownItems = [];
    for (var i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];
      var item = Text(currency);
      dropDownItems.add(item);
    }
    return CupertinoPicker(
      //scrollController: FixedExtentScrollController(initialItem: 5),
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        // Get the value for the dropdownItems based on the selectedIndex number and save it in getDropDownItemsText
        getDropDownItemsText = dropDownItems[selectedIndex];

        setState(() {
          // Convert getDropDownItemsText from Text type to String types.
          selectedIOSPicker = getDropDownItemsText.data;
        });
      },
      children: dropDownItems,
    );
  }

  CoinData coinData = CoinData();
  var priceBTC;

  Future<String> getAndroidRates() async {
    priceBTC = await coinData.getResult(selectedAndroidButton);
    return priceBTC;
  }

  Future<String> getIOSRates() async {
    priceBTC = await coinData.getResult(selectedIOSPicker);
    return priceBTC;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: Platform.isIOS ? getIOSRates() : getAndroidRates(),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text('🤑 Coin Ticker'),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 BTC =  $priceBTC ${Platform.isIOS ? selectedIOSPicker : selectedAndroidButton}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 ETH =  $priceBTC ${Platform.isIOS ? selectedIOSPicker : selectedAndroidButton}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 0),
                  child: Card(
                    color: Colors.lightBlueAccent,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 LTC =  $priceBTC ${Platform.isIOS ? selectedIOSPicker : selectedAndroidButton}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                    height: 190.0,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: 30.0),
                    color: Colors.lightBlue,
                    child: Platform.isIOS ? getIosPicker() : getAndroidButton()),
              ],
            ),
          );
        } else {
          return Container(
            color: Colors.blue,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CircularProgressIndicator(),
              ],
            ),
          );
        }
      },
    );
  }
}
