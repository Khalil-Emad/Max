import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import '../objects/currentUser.dart';
import '../objects/salesInvoice.dart';

class invoicePrint extends StatefulWidget {
  final String invoiceId;
  const invoicePrint({Key? key, required this.invoiceId}) : super(key: key);

  @override
  State<invoicePrint> createState() => invoicePrintState();
}

class invoicePrintState extends State<invoicePrint> {
  List<SalesInvoice> dataSales = [];
  List<SalesInvoice> dataSales1 = [];
  List<SalesInvoice> dataInvoice = [];
  List<SalesInvoice> dataInvoice1 = [];
  SalesInvoice itemTotal = SalesInvoice();
  getDataSales() async {
    dataSales1 = await SalesInvoice.getInvoicePrint(widget.invoiceId);
    setState(() {
      dataSales = dataSales1;
    });
  }

  getDataInvoice() async {
    dataInvoice1 = await SalesInvoice.getInvoicePrintTotal(widget.invoiceId);
    setState(() {
      dataInvoice = dataInvoice1;
    });
  }

  @override
  void initState() {
    super.initState();
    getDataSales();
    getDataInvoice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: PdfPreview(
          build: (format) => _generatePdf(format, "MAX"),
        ));
  }

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(
      version: PdfVersion.pdf_1_5,
      compress: true,
      author: "khalil",
    );
    var arabicFont =
        pw.Font.ttf(await rootBundle.load("assets/fonts/Arial.ttf"));
    // pw.Font.ttf(await rootBundle.load("assets/fonts/arabic.ttf"));

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            children: [
              pw.Container(
                width: 150,
                height: 50,
                child: pw.Text(title, style: pw.TextStyle(fontSize: 60)),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                "فاتورة رقم  ${widget.invoiceId}",
                style: pw.TextStyle(font: arabicFont),
                textDirection: pw.TextDirection.rtl,
              ),
              pw.SizedBox(
                height: 5,
              ),
              pw.Padding(
                  padding: pw.EdgeInsets.only(right: 15, left: 15),
                  child: pw.Column(children: [
                    pw.Row(
                      children: [
                        pw.Container(
                            padding: pw.EdgeInsets.all(1),
                            decoration: pw.BoxDecoration(
                              border: pw.Border.all(),
                              borderRadius:
                                  pw.BorderRadius.all(pw.Radius.circular(5.0)),
                            ),
                            child: pw.Row(children: [
                              pw.Text(
                                "${CurrentUser.firstName} ",
                              ),
                              pw.Text(
                                "وردية :",
                                style: pw.TextStyle(font: arabicFont),
                                textDirection: pw.TextDirection.rtl,
                              ),
                            ])),
                        pw.Spacer(),
                        pw.Text(
                          "الدفع : كاش",
                          style: pw.TextStyle(font: arabicFont),
                          textDirection: pw.TextDirection.rtl,
                        ),
                      ],
                    ),
                    pw.SizedBox(
                      height: 5,
                    ),
                    pw.Row(
                      children: [
                        pw.Text(
                          dataInvoice[0].time!,
                        ),
                        pw.Spacer(),
                        pw.Text(
                          dataInvoice.first.date!,
                        ),
                      ],
                    ),
                  ])),
              pw.Divider(
                thickness: 1,
              ),
              pw.Table(
                defaultVerticalAlignment: pw.TableCellVerticalAlignment.middle,
                columnWidths: {
                  0: pw.FlexColumnWidth(12),
                  1: pw.FlexColumnWidth(18),
                  2: pw.FlexColumnWidth(5),
                },
                children: [
                  pw.TableRow(children: [
                    pw.Column(children: [
                      pw.Text(
                        'الكود',
                        style: pw.TextStyle(font: arabicFont, fontSize: 12),
                        textDirection: pw.TextDirection.rtl,
                      )
                    ]),
                    pw.Column(children: [
                      pw.Text(
                        'الاسم',
                        style: pw.TextStyle(font: arabicFont, fontSize: 12),
                        textDirection: pw.TextDirection.rtl,
                      )
                    ]),
                    pw.Column(children: [
                      pw.Text(
                        'السعر',
                        style: pw.TextStyle(font: arabicFont, fontSize: 12),
                        textDirection: pw.TextDirection.rtl,
                      )
                    ]),
                  ])
                ],
              ),
              pw.ListView.builder(
                  itemCount: dataSales.length,
                  itemBuilder: (context, index) {
                    return pw.Table(
                        defaultVerticalAlignment:
                            pw.TableCellVerticalAlignment.middle,
                        columnWidths: {
                          0: pw.FlexColumnWidth(12),
                          1: pw.FlexColumnWidth(18),
                          2: pw.FlexColumnWidth(5),
                        },
                        children: [
                          pw.TableRow(children: [
                            pw.Column(children: [
                              pw.Text(dataSales[index].barcode!,
                                  style: pw.TextStyle(fontSize: 10))
                            ]),
                            pw.Column(children: [
                              pw.Text(
                                dataSales[index].categoryNameAr!,
                                style: pw.TextStyle(
                                    font: arabicFont, fontSize: 10),
                                textDirection: pw.TextDirection.rtl,
                              )
                            ]),
                            pw.Column(children: [
                              pw.Text(dataSales[index].salePrice!,
                                  style: pw.TextStyle(fontSize: 10))
                            ]),
                          ])
                        ]);
                  }),
              pw.SizedBox(height: 5),
              pw.Padding(
                padding: pw.EdgeInsets.only(right: 25, left: 25),
                child: pw.Column(children: [
                  pw.Container(
                    padding: pw.EdgeInsets.all(3.0),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(),
                      borderRadius:
                          pw.BorderRadius.all(pw.Radius.circular(5.0)),
                    ),
                    child: pw.Row(
                      children: [
                        pw.Text(
                          dataInvoice.first.total!,
                        ),
                        pw.Spacer(),
                        pw.Text(
                          "الاجمالى",
                          style: pw.TextStyle(font: arabicFont),
                          textDirection: pw.TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(
                    height: 5,
                  ),
                  pw.Container(
                    padding: pw.EdgeInsets.all(3.0),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(),
                      borderRadius:
                          pw.BorderRadius.all(pw.Radius.circular(5.0)),
                    ),
                    child: pw.Row(
                      children: [
                        pw.Text(
                          dataInvoice[0].discount!,
                        ),
                        pw.Spacer(),
                        pw.Text(
                          "الخصم",
                          style: pw.TextStyle(font: arabicFont),
                          textDirection: pw.TextDirection.rtl,
                        ),
                      ],
                    ),
                  ),
                  pw.SizedBox(
                    height: 5,
                  ),
                  pw.Container(
                    padding: pw.EdgeInsets.all(3.0),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(),
                      borderRadius:
                          pw.BorderRadius.all(pw.Radius.circular(5.0)),
                    ),
                    child: pw.Row(
                      children: [
                        pw.Text(
                          dataInvoice[0].cash!,
                        ),
                        pw.Spacer(),
                        pw.Text(
                          "المدفوع",
                          style: pw.TextStyle(font: arabicFont),
                          textDirection: pw.TextDirection.rtl,
                        ),
                      ],
                    ),
                  )
                ]),
              ),
              pw.Padding(
                  padding: pw.EdgeInsets.only(right: 10, left: 10),
                  child: pw.Center(
                      child: pw.Column(
                    children: [
                      pw.Text(
                        "1 شارع عبد العزيز على من كعابيش ",
                        style: pw.TextStyle(font: arabicFont, fontSize: 11),
                        textDirection: pw.TextDirection.rtl,
                      ),
                      pw.Text(
                        "بجوار بحر الطابق الثالث فيصل",
                        style: pw.TextStyle(font: arabicFont, fontSize: 11),
                        textDirection: pw.TextDirection.rtl,
                      ),
                      pw.Text(
                        "01033656531",
                        style: pw.TextStyle(font: arabicFont, fontSize: 10),
                        textDirection: pw.TextDirection.rtl,
                      ),
                      pw.SizedBox(height: 5),
                      pw.Text(
                        "الاستبدال او الاسترجاع خلال 14 يوم",
                        style: pw.TextStyle(font: arabicFont, fontSize: 8),
                        textDirection: pw.TextDirection.rtl,
                      ),
                      pw.Text(
                        "تمت البرمجة بواسطة كود رووت",
                        style: pw.TextStyle(font: arabicFont, fontSize: 8),
                        textDirection: pw.TextDirection.rtl,
                        // "Developed by Code Root",
                      ),
                      pw.Text(
                        "01122700297",
                        style: pw.TextStyle(font: arabicFont, fontSize: 8),
                        textDirection: pw.TextDirection.rtl,
                        // "Mobile : 01122700297",
                      ),
                    ],
                  )))
            ],
          );
        },
      ),
    );
    return pdf.save();
  }
}
