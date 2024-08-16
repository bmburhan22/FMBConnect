import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fmb_connect/auth.dart';
import 'package:fmb_connect/constdata.dart';
import 'package:fmb_connect/functions.dart';
import 'package:fmb_connect/main.dart';
import 'package:skeletonizer/skeletonizer.dart';

class Payment extends ConsumerStatefulWidget {
  const Payment({super.key});
  @override
  ConsumerState<Payment> createState() => _PaymentState();
}

class _PaymentState extends ConsumerState<Payment> {
  List<Map<String, dynamic>> paymentRecords = [];
  bool loading=true;
  Future<void> fetchPaymentInfo() async {
    setState(() {loading=true;});
    Map? res = await fetch('/payment_info', {
      'its': ref.read(authProvider)!.its,
    });
    /*
    POPULATE CONST DATA: PAYMENT
     setState(() {paymentRecords = constPaymentData;loading=false;});
     */
    if (res ==null)return;
    setState(() {
    paymentRecords= List<Map<String, dynamic>>.from(res['records']);
    loading=false;
    });
  }

  @override
  void initState() {

    super.initState();    
  fetchPaymentInfo();
  }

  @override
  Widget build(BuildContext context) {
    return 
                 RefreshIndicator(onRefresh:      fetchPaymentInfo,        child:
    
    Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal.shade900,
          foregroundColor: Colors.white,
          title: const Text('Payment Information'),
        ),
        body: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),

                child: 

                Column(
/*
 crossAxisAlignment: CrossAxisAlignment.center,
 */
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    Skeletonizer(
                      containersColor: Colors.teal.shade100,
                                enabled: loading
                                  ,child:  
                                  Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.teal.shade900,
                            borderRadius: BorderRadius.circular(15),
                            /* 
                            border: Border.all(width: 2, color: Colors.teal.shade900)
                            */
                            ),
                        child:

                            /*
                            Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                */
                                                              
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,

                                children: 
                                !loading&&paymentRecords.isEmpty?
                                [Text('No data found', style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white,  ) )]:
                                [
                              Text(
                                  'Year ${paymentRecords.firstOrNull?['year']}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge!
                                      .copyWith(  color: Colors.white)
)
                                          ,
                              Text(
                                  'Pending: INR ${paymentRecords.firstOrNull?['pending']}',
                                  style:
                                      Theme.of(context).textTheme.titleLarge!
                                      .copyWith(  color: Colors.white)
                                      ),
                              /*    ],
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                    */
                              Text(
                                  'Paid: INR ${paymentRecords.firstOrNull?['paid']}',
                                  style:
                                      Theme.of(context).textTheme.titleLarge!.copyWith(  color: Colors.white))
                                      ,
                              Text(
                                  'Total: INR ${paymentRecords.firstOrNull?['total']}',
                                  style:
                                      Theme.of(context).textTheme.titleLarge!.copyWith(  color: Colors.white)),
                            ])
                        // ])
                        )),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ExpansionTile(
                            collapsedBackgroundColor: Colors.teal.shade100,
                            title: const Text('Previous Years'),
                            children: paymentRecords.length<= 1
                                ? []
                                : paymentRecords
                                    .sublist(1)
                                    .map((data) => Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.teal.shade50,
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border: Border.all(
                                                width: 2,
                                                color: Colors.teal.shade900)),
                                        child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('Year: ${data['year']}',
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .titleMedium!
                                                          .copyWith(
                                                              color: Colors
                                                                  .blueGrey
                                                                  .shade900)),
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
                                                    Text(
                                                        'Paid: INR ${data['paid']}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium!),
                                                    Text(
                                                        'Total: INR ${data['total']}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .titleMedium!),
                                                  ])
                                            ])))
                                    .toList()
                                    .divide(const SizedBox(height: 10))
                                    .around(const SizedBox(height: 10))))
                  ]
                      .divide(const SizedBox(height: 20))
                      .around(const SizedBox(height: 20)),
                ))));
  }
}
