import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fmb_connect/auth.dart';
import 'package:fmb_connect/functions.dart';
import 'package:fmb_connect/main.dart';

class Payment extends ConsumerStatefulWidget {
  const Payment({super.key});
  @override
  ConsumerState<Payment> createState() => _PaymentState();
}

class _PaymentState extends ConsumerState<Payment> {
  Map<String, dynamic> paymentInfoCurrent = {
    'year': 2024,
    'total': 500,
    'paid': 400
  };
  List<Map<String, dynamic>> paymentInfoPrev = [
    {'year': 2023, 'total': 400, 'paid': 400},
    {'year': 2022, 'total': 300, 'paid': 300},
    {'year': 2021, 'total': 400, 'paid': 400},
    {'year': 2020, 'total': 200, 'paid': 200},
  ];
  Future<void> fetchPaymentInfo() async {
    Map? res = await fetch('/payment_info', {
      'its': ref.read(authProvider)!.its,
    });

    if (res == null) return;
    setState(() {
      paymentInfoCurrent = Map<String, dynamic>.from(res['current'] ?? []);
      paymentInfoPrev = List<Map<String, dynamic>>.from(res['prev'] ?? []);
    });
  }

  @override
  void initState() {
    super.initState();
    // fetchMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal.shade900,
          foregroundColor: Colors.white,
          title: const Text('Payment Information'),
        ),
        body: RefreshIndicator(
            onRefresh: fetchPaymentInfo,
            child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Column(
crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                      
                            "Current Year Payment Information",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.w700),
                          )),
                     Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.teal.shade50,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      width: 2, color: Colors.teal.shade900)),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Year ${paymentInfoCurrent['year']}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                    color: Colors
                                                        .blueGrey.shade900)),
                                        Text(
                                            'Pending: INR ${paymentInfoCurrent['total'] - paymentInfoCurrent['paid']}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!),
                                      ],
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Paid: INR ${paymentInfoCurrent['paid']}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!),
                                          Text('Total: INR ${paymentInfoCurrent['total']}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!),
                                        ])
                                  ]))
                                  ,
                  Padding(
                    padding:const EdgeInsets.symmetric(horizontal: 20),
                    child:ExpansionTile(
                      collapsedBackgroundColor: Colors.teal.shade100,
                      title: const Text('Previous Years'),
                      children: paymentInfoPrev
                          .map((data) =>
                           Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  color: Colors.teal.shade50,
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      width: 2, color: Colors.teal.shade900)),
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Year ${data['year']}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!
                                                .copyWith(
                                                    color: Colors
                                                        .blueGrey.shade900)),
                                        Text(
                                            'Pending: INR ${data['total'] - data['paid']}',
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleMedium!),
                                      ],
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('Paid: INR ${data['paid']}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!),
                                          Text('Total: INR ${data['total']}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleMedium!),
                                        ])
                                  ]
                                  )))
                          .toList()
                          .divide(const SizedBox(height: 10))
                          .around(const SizedBox(height: 10))
                    )
               )   ]
                          .divide(const SizedBox(height: 10))
                          .around(const SizedBox(height: 10)),
                  
                  
                ))));
  }
}
