import 'package:flutter/material.dart';
import 'package:meals/widgets/main_drawer.dart';

class Settings extends StatefulWidget {
  static const route = '/settings';

  Function saveFilters;
  Map<String, bool> filters;
  Settings(this.filters,this.saveFilters);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var _isGlutenFree=false;

  var _isLactoseFree=false;

  var _isVegan=false;

  var _isVegetarian=false;

  Widget _buildSwitchTile(
      bool value, String title, String subTitle, Function onChange) {
    return SwitchListTile(
        value: value,
        title: Text(title),
        subtitle: Text(subTitle),
        onChanged: onChange);
  }

  @override
  void initState() {
    _isGlutenFree = widget.filters['gluten'];

    _isLactoseFree = widget.filters['lactose'];

    _isVegan = widget.filters['vegan'];

    _isVegetarian = widget.filters['vegetarian'];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () => widget.saveFilters({
              'gluten': _isGlutenFree,
              'lactose': _isLactoseFree,
              'vegan': _isVegan,
              'vegetarian': _isVegetarian
            }),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.topCenter,
            child: Text(
              'Meals you prefer!',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
              child: ListView(
            children: [
              _buildSwitchTile(_isLactoseFree, 'Lactose free',
                  'includes meal free from lactose', (newValue) {
                setState(() {
                  _isLactoseFree = newValue;
                });
              }),
              _buildSwitchTile(_isGlutenFree, 'Gluten free',
                  'includes meal free from gluten', (newValue) {
                setState(() {
                  _isGlutenFree = newValue;
                });
              }),
              _buildSwitchTile(_isVegan, 'Vegan', 'includes only vegan meals',
                  (newValue) {
                setState(() {
                  _isVegan = newValue;
                });
              }),
              _buildSwitchTile(
                  _isVegetarian, 'Vegetarian', 'includes only vegetarian meals',
                  (newValue) {
                setState(() {
                  _isVegetarian = newValue;
                });
              })
            ],
          ))
        ],
      ),
      drawer: MainDrawer(),
    );
  }
}
