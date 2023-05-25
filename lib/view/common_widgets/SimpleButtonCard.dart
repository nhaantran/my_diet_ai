// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// import '../../common/values/colors.dart';

// class SimpleButtonCard extends StatefulWidget {
//   final AssetImage iconAssets;
//   final String buttonText;
//   Function onTap;

//   SimpleButtonCard({
//     Key? key,
//     required this.iconAssets,
//     required this.buttonText,
//     required this.onTap,
//   }) : super(key: key);

//   @override
//   State<SimpleButtonCard> createState() => _SimpleButtonWidetState();
// }

// class _SimpleButtonWidetState extends State<SimpleButtonCard>
//     with AutomaticKeepAliveClientMixin {
//   List<bool> isSelected = [true, false, false];
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.only(top: 15.0, bottom: 10.0),
//       child: Material(
//           elevation: 5.0,
//           borderRadius: BorderRadius.circular(20.0),
//           child: InkWell(
//             onTap: () {
//               widget.onTap();
//             },
//             child: Container(
//               padding: const EdgeInsets.only(left: 15, right: 5),
//               height: 90.0,
//               width: 300.0,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(20.0),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       widget.buttonText,
//                       textAlign: TextAlign.left,
//                       style: const TextStyle(
//                           fontSize: 15,
//                           color: AppColors.brand05,
//                           fontWeight: FontWeight.w900),
//                     ),
//                   ),
//                   Container(
//                     height: 48.0,
//                     width: 48.0,
//                     decoration: BoxDecoration(
//                         image: DecorationImage(
//                             image: widget.iconAssets, fit: BoxFit.fill)),
//                     child: const SizedBox(
//                       width: 54,
//                       height: 54,
//                       // child: ImageIcon(
//                       //   iconAssets,
//                       // ),
//                       // child: CachedNetworkImage(
//                       //   imageUrl: "${item.photourl}",
//                       // ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )),
//     );
//   }

//   @override
//   // TODO: implement wantKeepAlive
//   bool get wantKeepAlive => true;
// }
