import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fmb_connect/app.dart';
import 'package:fmb_connect/auth.dart';
import 'package:fmb_connect/functions.dart';
import 'package:fmb_connect/main.dart';
import 'package:fmb_connect/menu_card.dart';

class FeedbackDialog extends ConsumerStatefulWidget {
  final Menu menu;
  final Function onSubmit;
  final bool withFeedback;
  const FeedbackDialog(this.menu, this.withFeedback, this.onSubmit, { super.key});
  @override
  ConsumerState<FeedbackDialog> createState() => _FeedbackDialogState();
}

class _FeedbackDialogState extends ConsumerState<FeedbackDialog> {
  late double rating;
  late TextEditingController reviewController;
  @override
  void initState() {
    super.initState();
  reviewController = TextEditingController(text:  widget.menu.review ?? '');
    rating = widget.menu.rating ?? 1;

  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      
        child:SingleChildScrollView(child: 
         Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                
                 Text('Menu for ${widget.menu.dateTime.toDateString}',style: Theme.of(context).textTheme.headlineSmall),
Wrap(children: 
(widget.menu.items??[])
.map((i) =>   Chip( label:  Text(i) )).toList().divide(const SizedBox(width: 10,) )
)
,
if (widget.withFeedback)
...[
const Divider(),
                       Text(
                        widget.menu.rating == null
                            ? 'Give feedback'
                            : 'Your feedback',
                        style: Theme.of(context).textTheme.headlineSmall),
                
                    StarRating(
                      size: 48,
                      rating: rating,
                      onRatingChanged: widget.menu.rating == null
                          ? (r) => setState(() => rating = r)
                          : null,
                    ),
                    TextFormField(
                      canRequestFocus: (widget.menu.rating == null),
                      minLines: 3,
                      maxLines: 3,
                      controller: reviewController,
                      decoration: const InputDecoration(
                          labelText: 'Review', border: OutlineInputBorder()),
                    ),
                    if (widget.menu.rating == null)
                      MaterialButton(
                          color: Colors.teal.shade900,
                          textColor: Colors.white,
                          child: const Text('Submit'),
                          onPressed: () {
                            postFeedback(ref.read(authProvider)?.its ?? '',
                                widget.menu, rating, reviewController.text);
                            showSnackBar('Thank you for your feedback');
                            navkey.currentState?.pop();
                            widget.onSubmit();
                          }),
              ]
                  ].divide(const SizedBox(
                    height: 10,
                  )),
                ),
              
             )         ));
  }
}
