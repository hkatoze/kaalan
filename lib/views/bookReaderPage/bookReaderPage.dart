import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kaalan/constants.dart';
import 'package:kaalan/models/bookFromLibraryModel.dart';
import 'package:kaalan/models/bookModel.dart';
import 'package:kaalan/models/userModel.dart';
import 'package:kaalan/services/apiservices.dart';
import 'package:kaalan/services/localdbservices.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

/// Represents the BookReaderPage for Navigation

class BookReaderPage extends StatefulWidget {
  const BookReaderPage({
    super.key,
    required this.book,
    required this.user,
  });
  final BookModel book;
  final UserModel user;

  @override
  State<BookReaderPage> createState() => _BookReaderPageState();
}

class _BookReaderPageState extends State<BookReaderPage> {
  final PdfViewerController _pdfViewerController = PdfViewerController();
  final GlobalKey<SearchToolbarState> _textSearchKey = GlobalKey();

  late bool _showScrollHead;
  bool isInLibrary = false;
  int initialPage = 1;

  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  @override
  void initState() {
    _showScrollHead = true;
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    List<BookModel> libraryBooks = await fetchLibraryBooks(widget.user.id);

    var libraryBooksid = libraryBooks.map((e) => e.id);

    DatabaseManager.instance.getBookProgress(widget.book.id).then((book) {
      if (book != null) {
        _pdfViewerController.jumpToPage(book.progress);
      }
    });

    try {
      setState(() {
        isInLibrary = libraryBooksid.contains(widget.book.id);
      });
    } catch (e) {}
  }

  String? selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kbgColor,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: SizedBox(
            width: 50,
            height: 50,
            child: Center(
                child: Icon(
              defaultTargetPlatform == TargetPlatform.iOS
                  ? Icons.arrow_back_ios
                  : Icons.arrow_back,
              color: Colors.black,
            )),
          ),
        ),
        title: Text(
          widget.book.title,
          style: const TextStyle(
              fontFamily: "Nominee",
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            icon: SizedBox(
              width: 50,
              height: 50,
              child: Center(
                  child: Icon(
                Icons.more_horiz,
                color: Colors.black,
              )),
            ),
            onSelected: (result) {
              if (result == 0) {
                _pdfViewerKey.currentState?.openBookmarkView();
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                child: SubmenuItem(icon: Icons.bookmark, label: "Sommaire"),
              ),
            ],
          ),
        ],
      ),
      body: Stack(
        children: [
          SfPdfViewer.network(widget.book.bookLink,
              scrollDirection: PdfScrollDirection.horizontal,
              pageLayoutMode: PdfPageLayoutMode.single,
              interactionMode: PdfInteractionMode.selection,
              controller: _pdfViewerController,
              canShowScrollHead: _showScrollHead,
              key: _pdfViewerKey, onPageChanged: (pageDetails) {
            if (!isInLibrary) {
              if (pageDetails.newPageNumber == 3 ||
                  pageDetails.newPageNumber == 10 ||
                  pageDetails.newPageNumber == 20 ||
                  pageDetails.newPageNumber == 25) {
                AwesomeDialog(
                    context: context,
                    animType: AnimType.scale,
                    dialogType: DialogType.info,
                    btnCancelText: "NON MERCI",
                    btnCancelColor: ksecondaryColor,
                    btnOkText: "AJOUTER",
                    btnOkColor: kprimaryColor,
                    body: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Ajouter ce livre à votre bibliothèque afin de conserver votre progression à la prochaine ouverture.",
                        style: TextStyle(fontFamily: "Nominee"),
                      ),
                    ),
                    btnOkOnPress: () async {
                      String response = await addToLibrary(widget.user.id,
                          widget.book.id, pageDetails.newPageNumber);
                      if (response == "Livre ajouté à votre bibliothèque.") {
                        setState(() {
                          isInLibrary = true;
                        });
                      }
                      Fluttertoast.showToast(
                          msg: response,
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 7,
                          backgroundColor:
                              response == "Livre ajouté à votre bibliothèque."
                                  ? Colors.green
                                  : Colors.red,
                          textColor: Colors.white,
                          fontSize: 14.0);
                    },
                    btnCancelOnPress: () {
                      Navigator.canPop(context);
                    }).show();
              }
            } else {
              DatabaseManager.instance.addBookProgress(BookFromLibraryModel(
                  bookId: widget.book.id,
                  progress: pageDetails.newPageNumber,
                  isFinish: pageDetails.isLastPage));
            }
          }),
          Visibility(
            visible: _textSearchKey.currentState?._showToast ?? false,
            child: Align(
              alignment: Alignment.center,
              child: Flex(
                direction: Axis.horizontal,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(
                        left: 15, top: 7, right: 15, bottom: 7),
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: const BorderRadius.all(
                        Radius.circular(16.0),
                      ),
                    ),
                    child: const Text(
                      'Aucun résultat',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Nominee',
                          fontSize: 16,
                          color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Signature for the [SearchToolbar.onTap] callback.
typedef SearchTapCallback = void Function(Object item);

/// SearchToolbar widget
class SearchToolbar extends StatefulWidget {
  ///it describe the search toolbar constructor
  const SearchToolbar({
    this.controller,
    this.onTap,
    this.showTooltip = true,
    Key? key,
  }) : super(key: key);

  /// Indicates whether the tooltip for the search toolbar items need to be shown or not.
  final bool showTooltip;

  /// An object that is used to control the [SfPdfViewer].
  final PdfViewerController? controller;

  /// Called when the search toolbar item is selected.
  final SearchTapCallback? onTap;

  @override
  SearchToolbarState createState() => SearchToolbarState();
}

/// State for the SearchToolbar widget
class SearchToolbarState extends State<SearchToolbar> {
  /// Indicates whether search is initiated or not.
  bool _isSearchInitiated = false;

  /// Indicates whether search toast need to be shown or not.
  bool _showToast = false;

  ///An object that is used to retrieve the current value of the TextField.
  final TextEditingController _editingController = TextEditingController();

  /// An object that is used to retrieve the text search result.
  PdfTextSearchResult _pdfTextSearchResult = PdfTextSearchResult();

  ///An object that is used to obtain keyboard focus and to handle keyboard events.
  FocusNode? focusNode;

  @override
  void initState() {
    super.initState();
    focusNode = FocusNode();
    focusNode?.requestFocus();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    focusNode?.dispose();
    _pdfTextSearchResult.removeListener(() {});
    super.dispose();
  }

  ///Clear the text search result
  void clearSearch() {
    _isSearchInitiated = false;
    _pdfTextSearchResult.clear();
  }

  ///Display the Alert dialog to search from the beginning
  void _showSearchAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.all(0),
          title: const Text('Resultat de recherche'),
          content: const SizedBox(
              width: 328.0,
              child: Text(
                  'Aucune autre occurrence trouvée. Souhaitez-vous continuer la recherche depuis le début?')),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                setState(() {
                  _pdfTextSearchResult.nextInstance();
                });
                Navigator.of(context).pop();
              },
              child: Text(
                'OUI',
                style: TextStyle(
                    color: Color(0x00000000).withOpacity(0.87),
                    fontFamily: 'Nominee',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _pdfTextSearchResult.clear();
                  _editingController.clear();
                  _isSearchInitiated = false;
                  focusNode?.requestFocus();
                });
                Navigator.of(context).pop();
              },
              child: Text(
                'NON',
                style: TextStyle(
                    color: const Color(0x00000000).withOpacity(0.87),
                    fontFamily: 'Nominee',
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Material(
          color: Colors.transparent,
          child: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Color(0x00000000).withOpacity(0.54),
              size: 24,
            ),
            onPressed: () {
              widget.onTap?.call('Fermer la recherche');
              _isSearchInitiated = false;
              _editingController.clear();
              _pdfTextSearchResult.clear();
            },
          ),
        ),
        Flexible(
          child: TextFormField(
            style: TextStyle(
                color: const Color(0x00000000).withOpacity(0.87), fontSize: 16),
            enableInteractiveSelection: false,
            focusNode: focusNode,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.search,
            controller: _editingController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Trouvé...',
              hintStyle: TextStyle(color: Color(0x00000000).withOpacity(0.34)),
            ),
            onChanged: (text) {
              if (_editingController.text.isNotEmpty) {
                setState(() {});
              }
            },
            onFieldSubmitted: (String value) {
              if (kIsWeb) {
                _pdfTextSearchResult =
                    widget.controller!.searchText(_editingController.text);
                if (_pdfTextSearchResult.totalInstanceCount == 0) {
                  widget.onTap?.call('noResultFound');
                }
                setState(() {});
              } else {
                _isSearchInitiated = true;
                _pdfTextSearchResult =
                    widget.controller!.searchText(_editingController.text);
                _pdfTextSearchResult.addListener(() {
                  if (super.mounted) {
                    setState(() {});
                  }
                  if (!_pdfTextSearchResult.hasResult &&
                      _pdfTextSearchResult.isSearchCompleted) {
                    widget.onTap?.call('noResultFound');
                  }
                });
              }
            },
          ),
        ),
        Visibility(
          visible: _editingController.text.isNotEmpty,
          child: Material(
            color: Colors.transparent,
            child: IconButton(
              icon: const Icon(
                Icons.clear,
                color: Color.fromRGBO(0, 0, 0, 0.54),
                size: 24,
              ),
              onPressed: () {
                setState(() {
                  _editingController.clear();
                  _pdfTextSearchResult.clear();
                  widget.controller!.clearSelection();
                  _isSearchInitiated = false;
                  focusNode!.requestFocus();
                });
                widget.onTap!.call('Clear Text');
              },
              tooltip: widget.showTooltip ? 'Clear Text' : null,
            ),
          ),
        ),
        Visibility(
          visible:
              !_pdfTextSearchResult.isSearchCompleted && _isSearchInitiated,
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
        Visibility(
          visible: _pdfTextSearchResult.hasResult,
          child: Row(
            children: [
              Text(
                '${_pdfTextSearchResult.currentInstanceIndex}',
                style: TextStyle(
                    color:
                        const Color.fromRGBO(0, 0, 0, 0.54).withOpacity(0.87),
                    fontSize: 16),
              ),
              Text(
                ' de ',
                style: TextStyle(
                    color:
                        const Color.fromRGBO(0, 0, 0, 0.54).withOpacity(0.87),
                    fontSize: 16),
              ),
              Text(
                '${_pdfTextSearchResult.totalInstanceCount}',
                style: TextStyle(
                    color:
                        const Color.fromRGBO(0, 0, 0, 0.54).withOpacity(0.87),
                    fontSize: 16),
              ),
              Material(
                color: Colors.transparent,
                child: IconButton(
                  icon: const Icon(
                    Icons.navigate_before,
                    color: Color.fromRGBO(0, 0, 0, 0.54),
                    size: 24,
                  ),
                  onPressed: () {
                    setState(() {
                      _pdfTextSearchResult.previousInstance();
                    });
                    widget.onTap!.call('Previous Instance');
                  },
                  tooltip: widget.showTooltip ? 'Previous' : null,
                ),
              ),
              Material(
                color: Colors.transparent,
                child: IconButton(
                  icon: const Icon(
                    Icons.navigate_next,
                    color: Color.fromRGBO(0, 0, 0, 0.54),
                    size: 24,
                  ),
                  onPressed: () {
                    setState(() {
                      if (_pdfTextSearchResult.currentInstanceIndex ==
                              _pdfTextSearchResult.totalInstanceCount &&
                          _pdfTextSearchResult.currentInstanceIndex != 0 &&
                          _pdfTextSearchResult.totalInstanceCount != 0 &&
                          _pdfTextSearchResult.isSearchCompleted) {
                        _showSearchAlertDialog(context);
                      } else {
                        widget.controller!.clearSelection();
                        _pdfTextSearchResult.nextInstance();
                      }
                    });
                    widget.onTap!.call('Next Instance');
                  },
                  tooltip: widget.showTooltip ? 'Next' : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SubmenuItem extends StatelessWidget {
  const SubmenuItem({super.key, required this.icon, required this.label});
  final IconData icon;
  final String label;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Icon(icon),
        SizedBox(
          width: 10,
        ),
        Text(
          label,
          style: TextStyle(fontFamily: "Nominee"),
        )
      ]),
    );
  }
}
