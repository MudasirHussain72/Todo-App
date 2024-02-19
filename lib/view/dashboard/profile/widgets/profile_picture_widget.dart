import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/res/colors.dart';
import 'package:todo_app/view/dashboard/profile/widgets/pick_image_dailog.dart';
import 'package:todo_app/view_model/controller/profile/profile_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// class ProfilePictureWidget extends StatelessWidget {
//   final dynamic snapshot;
//   const ProfilePictureWidget({
//     super.key,
//     required this.snapshot,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ProfileController>(
//         builder: (context, provider, child) => SizedBox(
//               width: 84,
//               height: 76,
//               child: Stack(
//                 children: [
//                   Align(
//                     alignment: Alignment.topLeft,
//                     child: Container(
//                       height: 80,
//                       width: 80,
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(18),
//                           // shape: BoxShape.circle,
//                           border: Border.all(
//                             color: snapshot.data!.docs[0]['profileImage']
//                                         .toString() ==
//                                     ""
//                                 ? AppColors.iconBlueColor
//                                 : Colors.transparent,
//                           )),
//                       child: provider.image == null
//                           ? snapshot.data!.docs[0]['profileImage'].toString() ==
//                                   ""
//                               ? Icon(
//                                   Icons.person,
//                                   size: 35,
//                                   color: Theme.of(context)
//                                       .colorScheme
//                                       .onBackground,
//                                 )
//                               : NetworkImageWidget(
//                                   borderRadius: 25,
//                                   imageUrl: snapshot
//                                       .data!.docs[0]['profileImage']
//                                       .toString())
//                           : Image.file(File(provider.image!.path).absolute),
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 5,
//                     right: 5,
//                     child: Container(
//                         decoration: BoxDecoration(
//                             color: Colors.red, shape: BoxShape.circle),
//                         child: GestureDetector(
//                             onTap: () {
//                               showDialog(
//                                   context: context,
//                                   builder: (BuildContext context) {
//                                     return const AlertDialog(
//                                         content: PickImageDailog());
//                                   });
//                             },
//                             child: Icon(Icons.add_circle_outline))),
//                   )
//                 ],
//               ),
//             ));
//   }
// }
class ProfilePictureWidget extends StatelessWidget {
  final AsyncSnapshot<QuerySnapshot<Object?>> snapshot;

  const ProfilePictureWidget({Key? key, required this.snapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!snapshot.hasData) {
      return CircularProgressIndicator();
    }

    final querySnapshot = snapshot.data!;
    final docs = querySnapshot.docs;

    if (docs.isEmpty) {
      return SizedBox(); // Handle empty data
    }

    final profileImage = docs[0]['profileImage'].toString();

    return Consumer<ProfileController>(
      builder: (context, provider, child) => SizedBox(
        width: 84,
        height: 76,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                height: 80,
                width: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: profileImage.isEmpty
                        ? AppColors.iconBlueColor
                        : Colors.transparent,
                  ),
                ),
                child: profileImage.isEmpty
                    ? Icon(
                        Icons.person,
                        size: 35,
                        color: Theme.of(context).colorScheme.onBackground,
                      )
                    : Image.network(
                        profileImage,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return CircularProgressIndicator();
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.error,
                            color: Colors.red,
                          );
                        },
                      ),
              ),
            ),
            Positioned(
              bottom: 5,
              right: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return const AlertDialog(
                          content: PickImageDailog(),
                        );
                      },
                    );
                  },
                  child: Icon(Icons.add_circle_outline),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
