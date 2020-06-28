import 'package:covidnearby/models/br_state.dart';
import 'package:covidnearby/screens/common.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  final List<BRState> states;

  SearchScreen({ Key key, this.states }) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController editingController = TextEditingController();
  List<BRState> items = List<BRState>();
  bool hasChanged = false;
  int itemsPosition = 0;
  int itemsCounter = 0;

  @override
  void initState() {
    items.addAll(widget.states);
    super.initState();
  }

  bool contains(String field, String query) =>
    field.toLowerCase().contains(query.toLowerCase().trim());

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() {
        hasChanged = true;
        items.clear();
        items.addAll(widget.states);
      });
    } else {
      List<BRState> filteredStatesCounties = List<BRState>();

      widget.states.forEach((state) {
        state.cities.forEach((county) {
          if (
            contains(county, query) ||
            contains(state.abbreviation, query) ||
            contains(state.name, query) ||
            contains(state.region.name, query)
          ) {
            filteredStatesCounties.add(
              BRState(
                abbreviation: state.abbreviation,
                name: state.name,
                region: BRRegion(
                  abbreviation: state.region.abbreviation,
                  name: state.region.name
                ),
                cities: [county]
              )
            );
          }
        });
      });

      filteredStatesCounties.sort((a, b) {
        if (contains(a.cities[0], query)) return -1;
        if (contains(b.cities[0], query)) return 1;
        return 0;
      });

      setState(() {
        hasChanged = true;
        items.clear();
        items.addAll(filteredStatesCounties);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                onChanged: (value) => filterSearchResults(value),
                controller: editingController,
                decoration: InputDecoration(
                  labelText: 'Buscar',
                  hintText: 'Buscar',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: items.fold(0, (total, state) => total + state.cities.length),
                itemBuilder: (context, index) {
                  if (hasChanged) {
                    hasChanged = false;
                    itemsPosition = 0;
                    itemsCounter = 0;
                  }

                  String stateAbbreviation = items[itemsPosition].abbreviation;
                  String stateCounty = items[itemsPosition].cities[itemsCounter];
                  itemsCounter++;

                  if (itemsCounter == items[itemsPosition].cities.length) {
                    itemsPosition++;
                    itemsCounter = 0;
                  }

                  if (itemsPosition == items.length) {
                    itemsPosition = 0;
                    itemsCounter = 0;
                  }

                  return ListTile(
                    title: Text('$stateCounty, $stateAbbreviation'),
                    // onTap: () => print('$county, $state has been tapped'),
                    onTap: () {
                      Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) => CommonScreen(
                            stateAbbr: stateAbbreviation,
                            city: stateCounty,
                          ),
                        ),
                      ).then((value) => setState(() {}));
                    },
                  );
                }
              ),
            ),
          ],
        )
      ),
    );
  }
}
