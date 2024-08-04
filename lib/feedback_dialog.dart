import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:fmb_connect/functions.dart';
import 'package:fmb_connect/main.dart';
import 'package:fmb_connect/menu_card.dart';

class FeedbackDialog extends StatefulWidget {
  final Menu menu;
  final double? rating;
  final String? review;
  const FeedbackDialog(this.menu, this.rating, this.review, {super.key});

  @override
  State<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends State<FeedbackDialog> {
  late double rating;
  late String review;
  @override
  void initState() {
    super.initState();
    rating = widget.rating ?? 1;
    review = widget.review??'';
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController reviewController = TextEditingController();
    reviewController.text = review;
    return Dialog(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                        widget.rating == null
                            ? 'Give feedback'
                            : 'Your feedback',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall)),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    StarRating(
                      size: 48,
                      rating: rating,
                      onRatingChanged: widget.rating == null
                          ? (r) => setState(() => rating = r)
                          : null,
                    ),
                    TextFormField(
                      onEditingComplete: () {setState(() {
                        review=reviewController.text;
                      });},
                      
                      canRequestFocus: (widget.rating == null),
                      minLines: 3,
                      maxLines: 3,
                      controller: reviewController,
                      decoration: const InputDecoration(
                          labelText: 'Review', border: OutlineInputBorder()),
                    ),
                    if (widget.rating == null)
                      MaterialButton(
                          color: Colors.teal.shade900,
                          textColor: Colors.white,
                          child: const Text('Submit'),
                          onPressed: () {
                            postFeedback(
                                widget.menu, rating, reviewController.text);
                            Navigator.pop(context);
                            showSnackBar( 'Thank you for your feedback');
                          }),
                  ].divide(const SizedBox(
                    height: 10,
                  )),
                ),
              ],
            )));
  }
}
