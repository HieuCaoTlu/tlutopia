import 'package:flutter/material.dart';
import 'package:tlutopia/object/Cart.dart';

class SearchFragment extends StatefulWidget {
  final Cart cart;
  const SearchFragment(this.cart, {Key? key}) : super(key: key);

  @override
  _SearchFragmentState createState() => _SearchFragmentState();
}

class _SearchFragmentState extends State<SearchFragment> {
  TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 120,
          decoration: const BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              alignment: Alignment.bottomLeft,
              image: AssetImage('assets/images/bg3.png'),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
          child: TextField(
            autocorrect: false,
            enableSuggestions: false,
            controller: search,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              hintText: "Tìm kiếm đầu sách",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              suffixIcon: Icon(Icons.search_rounded),
              suffixIconConstraints: BoxConstraints(minWidth: 70),
              contentPadding: EdgeInsets.all(16),
              fillColor: Color(0xffEFEFEF),
            ),
          ),
        )
      ]),
    );
  }
}
