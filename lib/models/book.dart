import 'dart:convert';

Book bookFromJson(String str) => Book.fromJson(json.decode(str));

String bookToJson(Book data) => json.encode(data.toJson());

class Book {
    int id;
    String title;
    List<Author> authors;
    List<Author> translators;
    List<String> subjects;
    List<String> bookshelves;
    List<String> languages;
    bool copyright;
    String mediaType;
    Formats formats;
    int downloadCount;
    bool favourite;

    Book({
        required this.id,
        required this.title,
        required this.authors,
        required this.translators,
        required this.subjects,
        required this.bookshelves,
        required this.languages,
        required this.copyright,
        required this.mediaType,
        required this.formats,
        required this.downloadCount,
        required this.favourite,
    });

    factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["id"],
        title: json["title"],
        authors: List<Author>.from(json["authors"].map((x) => Author.fromJson(x))),
        translators: List<Author>.from(json["translators"].map((x) => Author.fromJson(x))),
        subjects: List<String>.from(json["subjects"].map((x) => x)),
        bookshelves: List<String>.from(json["bookshelves"].map((x) => x)),
        languages: List<String>.from(json["languages"].map((x) => x)),
        copyright: json["copyright"],
        mediaType: json["media_type"],
        formats: Formats.fromJson(json["formats"]),
        downloadCount: json["download_count"],
        favourite: json["favourite"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "authors": List<dynamic>.from(authors.map((x) => x.toJson())),
        "translators": List<dynamic>.from(translators.map((x) => x.toJson())),
        "subjects": List<dynamic>.from(subjects.map((x) => x)),
        "bookshelves": List<dynamic>.from(bookshelves.map((x) => x)),
        "languages": List<dynamic>.from(languages.map((x) => x)),
        "copyright": copyright,
        "media_type": mediaType,
        "formats": formats.toJson(),
        "download_count": downloadCount,
        "favourite": favourite,
    };
}

class Author {
    String name;
    int? birthYear;
    int? deathYear;

    Author({
        required this.name,
        this.birthYear,
        this.deathYear,
    });

    factory Author.fromJson(Map<String, dynamic> json) => Author(
        name: json["name"],
        birthYear: json["birth_year"],
        deathYear: json["death_year"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "birth_year": birthYear,
        "death_year": deathYear,
    };
}

class Formats {
    String? textHtml;
    String? textHtmlCharsetUtf8;
    String? applicationEpubZip;
    String? applicationXMobipocketEbook;
    String? textPlainCharsetUtf8;
    String? applicationRdfXml;
    String? imageJpeg;
    String? applicationOctetStream;
    String? textPlainCharsetUsAscii;

    Formats({
        this.textHtml,
        this.textHtmlCharsetUtf8,
        this.applicationEpubZip,
        this.applicationXMobipocketEbook,
        this.textPlainCharsetUtf8,
        this.applicationRdfXml,
        this.imageJpeg,
        this.applicationOctetStream,
        this.textPlainCharsetUsAscii,
    });

    factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        textHtml: json["text/html"],
        textHtmlCharsetUtf8: json["text/html; charset=utf-8"],
        applicationEpubZip: json["application/epub+zip"],
        applicationXMobipocketEbook: json["application/x-mobipocket-ebook"],
        textPlainCharsetUtf8: json["text/plain; charset=utf-8"],
        applicationRdfXml: json["application/rdf+xml"],
        imageJpeg: json["image/jpeg"],
        applicationOctetStream: json["application/octet-stream"],
        textPlainCharsetUsAscii: json["text/plain; charset=us-ascii"],
    );

    Map<String, dynamic> toJson() => {
        "text/html": textHtml,
        "text/html; charset=utf-8": textHtmlCharsetUtf8,
        "application/epub+zip": applicationEpubZip,
        "application/x-mobipocket-ebook": applicationXMobipocketEbook,
        "text/plain; charset=utf-8": textPlainCharsetUtf8,
        "application/rdf+xml": applicationRdfXml,
        "image/jpeg": imageJpeg,
        "application/octet-stream": applicationOctetStream,
        "text/plain; charset=us-ascii": textPlainCharsetUsAscii,
    };
}
