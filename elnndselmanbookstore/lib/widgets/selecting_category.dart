import 'package:avreenbooks/colors.dart';
import 'package:flutter/material.dart';
import 'package:searchable_dropdown/searchable_dropdown.dart';

// This class uses searchable dropdown package
// Link to it :  https://pub.dev/packages/searchable_dropdown

class SelectingCategory extends StatefulWidget {
  final Function selectCategoryFun;
  static const routeName = '/DropdownSearchable';

  const SelectingCategory({Key key, @required this.selectCategoryFun})
      : super(key: key);
  @override
  _DropdownSearchableState createState() => _DropdownSearchableState();
}

class _DropdownSearchableState extends State<SelectingCategory> {
  String selectedValue;
  List<int> selectedItemss;
  final List<DropdownMenuItem> items = [
    DropdownMenuItem(
      child: Text("مێژوو"),
      value: "مێژوو",
    ),
    DropdownMenuItem(
      child: Text("بایۆلۆجی"),
      value: "بایۆلۆجی",
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(left: 16, right: 16),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //===============================
            //      Choose Multi Items
            //===============================
            Container(
              constraints: BoxConstraints(maxWidth: 250),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'جۆر هەڵبژیرە',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                  ///////////////////////////
                  SearchableDropdown.multiple(
                    items: items,
                    selectedItems: selectedItemss,
                    // hint: Padding(
                    //   padding: const EdgeInsets.all(12.0),
                    //   child: Text("Select any"),
                    // ),
                    // searchHint: "Select any",
                    onChanged: (value) {
                      setState(() {
                        selectedItemss = value;
                      });
                    },
                    closeButton: null,
                    // displayItem: (value) {
                    //   print(value);
                    // },
                    doneButton: (selectedItemsDone, doneContext) {
                      return (TextButton(
                        onPressed: () {
                          print(selectedItemsDone);
                          widget.selectCategoryFun(selectedItemsDone);
                          Navigator.pop(doneContext);
                          setState(() {});
                        },
                        child: Text("باشە"),
                      ));
                    },

                    iconDisabledColor: Colors.brown,
                    iconEnabledColor: redList,
                    style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: redList,
                    ),
                    isExpanded: true,
                  )
                ],
              ),
            ),

            //==================================================================
          ],
        ),
      ),
    );
  }
}
