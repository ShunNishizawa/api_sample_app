import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

import '../models/article.dart';
import '../widgets/article_container.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key, required this.title});

  final String title;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Article> articles = []; // 検索結果を格納する変数

  int perPage = 5;

  Future<List<Article>> searchQiita(String keyword) async {
    // 1. http通信に必要なデータを準備をする
    // 第１引数にbaseUrl,第２引数にURLパスをMap<String,dynamic>型でクエリパラメータを指定で指定する
    final uri = Uri.https('qiita.com', '/api/v2/items', {
      'query': 'title:$keyword',
      'per_page': perPage.toString(),
    });

    final token = dotenv.env['QIITA_ACCESS_TOKEN'] ?? '';

    // 2. リクエストの準備
    final http.Response res = await http.get(uri, headers: {
      'Authorization': 'Bearer $token',
    });

    // 3 ステータスに応じた処理
    // 4. 戻り値をArticleモデルに変換
    // 5. 変換したArticleクラスの配列を返す(returnする)
    if (res.statusCode == 200) {
      // レスポンスをモデルクラスへ変換
      final List<dynamic> body = jsonDecode(res.body);

      return body.map((dynamic json) => Article.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: TextField(
              style: TextStyle(
                // ← TextStyleを渡す
                fontSize: 18,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                // ← InputDecorationを渡す
                hintText: '検索ワードを入力してください',
              ),
              onSubmitted: (String value) async {
                final results = await searchQiita(value);
                setState(() {
                  articles = results;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
              if (index + 1 == articles.length + 1) {
                perPage = perPage + 5;

                return Text('読み込み');
              }
              // return null;
              return Column(
                  children: articles
                      .map((article) => ArticleContainer(article: article))
                      .toList());
            }),
          ),
        ],
      ),
    );
  }
}
