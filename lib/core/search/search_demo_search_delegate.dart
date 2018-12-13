import 'dart:async';

import 'package:barber_app/core/search/search_entity.dart';
import 'package:barber_app/helpers/request_helper.dart';
import 'package:flutter/material.dart';

class SearchDemoSearchDelegate extends SearchDelegate<SearchStoreItem> {
  final List<SearchStoreItem> netData = new List<SearchStoreItem>();
  final List<SearchStoreItem> history;

  SearchDemoSearchDelegate(this.history);

  @override
  Widget buildLeading(BuildContext context) {
    return new IconButton(
      tooltip: 'Back',
      icon: new AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  Future<List<SearchStoreItem>> searchStoreByName() async {
    final Completer<List<SearchStoreItem>> completer =
        new Completer<List<SearchStoreItem>>();
    RequestHelper.searchStoreByName(query).then((SearchEntity onValue) {
      netData.clear();
      netData.addAll(onValue.storeList);
      completer.complete(onValue.storeList);
    }).catchError((onError) {
      completer.complete(null);
    });

    return completer.future;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return new FutureBuilder<dynamic>(
        future: searchStoreByName(),
        initialData: query.isEmpty
            ? new AsyncSnapshot<List<SearchStoreItem>>.withData(
                //如果查询没输入找历史记录,如果输入了则请求网络
                ConnectionState.done,
                history)
            : new AsyncSnapshot<List<SearchStoreItem>>.withData(
                ConnectionState.waiting, null),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          print(snapshot.connectionState);
          print(snapshot.data);
          if (snapshot.connectionState == ConnectionState.waiting) {
            return new Center(
              child: new CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            var result = snapshot.data as List<SearchStoreItem>;
            if (result.length == 0) {
              return new Center(
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Icon(Icons.data_usage),
                    new Text('暂无记录'),
                  ],
                ),
              );
            }
            var suggestions = query.isEmpty
                ? result
                : result.where((SearchStoreItem i) =>
                    '${i.name}'.contains(query) || '${i.id}'.contains(query));
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: new _SuggestionList(
                query: query,
                suggestions: suggestions
                    .map((SearchStoreItem i) => '${i.name}')
                    .toList(),
                onSelected: (String suggestion) {
                  query = suggestion;
                  showResults(context);
                },
              ),
            );
          } else {
            return new Text('别着急');
          }
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    var selectData = netData.firstWhere((item) {
      return item.name.toString() == query;
    });
    if (selectData == null) {
      return new Center(
        child: new Text(
          '"$query"没有查询到,请咨询后再次查询',
          textAlign: TextAlign.center,
        ),
      );
    }

    return new ListView(
      children: <Widget>[
        new _ResultCard(
          result: selectData,
          searchDelegate: this,
        ),
      ],
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      query.isEmpty
          ? new IconButton(
              tooltip: 'Voice Search',
              icon: const Icon(Icons.mic),
              onPressed: () {
                query = 'TODO: implement voice input';
              },
            )
          : new IconButton(
              tooltip: 'Clear',
              icon: const Icon(Icons.clear),
              onPressed: () {
                query = '';
                showSuggestions(context);
              },
            )
    ];
  }
}

class _ResultCard extends StatelessWidget {
  const _ResultCard({this.searchDelegate, this.result});

  final SearchStoreItem result;
  final SearchDelegate<SearchStoreItem> searchDelegate;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return new GestureDetector(
      onTap: () {
        searchDelegate.close(context, result);
      },
      child: new Card(
        margin: const EdgeInsets.all(18.0),
        child: new Padding(
          padding: const EdgeInsets.all(18.0),
          child: new Column(
            children: <Widget>[
              new Text(
                result.name,
                style: theme.textTheme.headline,
              ),
              new Text(
                '店铺ID:${result.id}',
                style: theme.textTheme.subhead,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SuggestionList extends StatelessWidget {
  const _SuggestionList({this.suggestions, this.query, this.onSelected});

  final List<String> suggestions;
  final String query;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return new ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (BuildContext context, int i) {
        final String suggestion = suggestions[i];
        return new ListTile(
          leading: query.isEmpty ? const Icon(Icons.history) : const Icon(null),
          title: new RichText(
            text: new TextSpan(
              text: suggestion.substring(0, query.length),
              style:
                  theme.textTheme.subhead.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                new TextSpan(
                  text: suggestion.substring(query.length),
                  style: theme.textTheme.subhead,
                ),
              ],
            ),
          ),
          onTap: () {
            onSelected(suggestion);
          },
        );
      },
    );
  }
}
