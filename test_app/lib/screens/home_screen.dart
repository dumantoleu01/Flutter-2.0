import 'package:flutter/material.dart';
import 'package:test_app/db/notes_database.dart';
import 'package:test_app/model/note.dart';
import 'package:test_app/screens/sortable_page.dart';
import 'package:test_app/services/networking.dart';
import 'package:test_app/widget/tabbar_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String currSymbol;
  late String currName;
  late double currPrice;

  late List<Note> notes;
  bool isLoading = false;
  bool isRefreshed = false;

  Future<void> refreshNotes() async {
    setState(() => isLoading = true);

    this.notes = await NotesDatabase.instance.readAllNotes();

    setState(() {
      isLoading = false;
      isRefreshed = true;
    });
  }

  Future updateNote(List<Note> notes, int index) async {
    final note = notes[index].copy(
      symbol: currSymbol,
      name: currName,
      price: currPrice,
    );

    await NotesDatabase.instance.update(note);
  }

  Future addNote() async {
    final note = Note(
      symbol: currSymbol,
      name: currName,
      price: currPrice,
    );
    await NotesDatabase.instance.create(note);
  }

  void addOrUpdateNote(List<Note> notes, int index) async {
    // ignore: unnecessary_null_comparison
    final isUpdating = notes.length > index ? true : false;

    if (isUpdating) {
      await updateNote(notes, index);
    } else {
      await addNote();
    }
  }

  Future getDataFromUrl() async {
    Networking networking = Networking();
    dynamic curr = await networking.getData();
    if (curr == "Internet connection lost") {
      print("Internet connection lost");
    } else {
      dynamic date = curr["data"];
      for (var i = 0; i < date.length; i++) {
        // print(date[i]["symbol"]);
        // print(date[i]["name"]);
        // print(date[i]["metrics"]["market_data"]["price_usd"]);
        currSymbol = date[i]["symbol"];
        currName = date[i]["name"];
        currPrice = double.parse((date[i]["metrics"]["market_data"]
                ["price_usd"])
            .toStringAsFixed(5));
        print(currPrice.runtimeType);
        addOrUpdateNote(notes, i);
        // print(notes[i].name);
      }
    }
  }

  @override
  // ignore: unused_element
  void initState() {
    refreshNotes();
    getDataFromUrl();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TabBarWidget(
      title: "Test App",
      tabs: [
        Tab(icon: Icon(Icons.sort_by_alpha), text: 'Sortable'),
      ],
      children: [
        isRefreshed
            ? SortablePage(
                currencies: notes,
              )
            : Center(
                child: Text("Data is Loading..."),
              ),
      ],
    );
  }
}
