import 'package:flutter/material.dart';
import 'package:school_app/widgets/profile_option.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0092FF),
        title: const Align(
          alignment: Alignment.centerRight,
          child: Text(
            "الملف الشخصي",
            style: TextStyle(
              fontFamily: 'Dubai',
              fontSize: 32,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        leadingWidth: 120,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              // swithc account
            },
            style: ElevatedButton.styleFrom(
              alignment: Alignment.center,
              backgroundColor: const Color(0xFFF0F6F6),
              surfaceTintColor: const Color(0xFFF0F6F6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(0),
            ),
            child: const Text(
              'تغير الحساب',
              style: TextStyle(
                fontFamily: 'Dubai',
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20),
              child: Text(
                'ملفك',
                style: TextStyle(
                  fontFamily: 'Dubai',
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              child: Card(
                color: Colors.white,
                surfaceTintColor: Colors.white,
                elevation: 3,
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(10),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'أسم المستخدم',
                          style: TextStyle(
                            fontFamily: 'Dubai',
                          ),
                        ),
                        SizedBox(width: 8),
                        // if (widget.authorImageUrl != null)
                        //   CircleAvatar(
                        //     radius: 20,
                        //     backgroundImage: NetworkImage(widget.authorImageUrl!),
                        //   )
                        // else
                        CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/icons/temps.png'),
                            radius: 20,
                            child: Icon(
                              Icons.person_outlined,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20, top: 8),
              child: Text(
                'ملف الطفل',
                style: TextStyle(
                  fontFamily: 'Dubai',
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              child: Card(
                color: Colors.white,
                surfaceTintColor: Colors.white,
                elevation: 3,
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(10),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'أسم الطفل',
                          style: TextStyle(
                            fontFamily: 'Dubai',
                          ),
                        ),
                        SizedBox(width: 8),
                        // if (widget.authorImageUrl != null)
                        //   CircleAvatar(
                        //     radius: 20,
                        //     backgroundImage: NetworkImage(widget.authorImageUrl!),
                        //   )
                        // else
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/icons/temps.png'),
                          radius: 20,
                          child: Icon(
                            Icons.sentiment_very_satisfied,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20, top: 8),
              child: Text(
                'مدرستك',
                style: TextStyle(
                  fontFamily: 'Dubai',
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              child: Card(
                color: Colors.white,
                surfaceTintColor: Colors.white,
                elevation: 3,
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(10),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'أسم المدرسة',
                          style: TextStyle(
                            fontFamily: 'Dubai',
                          ),
                        ),
                        SizedBox(width: 8),
                        // if (widget.authorImageUrl != null)
                        //   CircleAvatar(
                        //     radius: 20,
                        //     backgroundImage: NetworkImage(widget.authorImageUrl!),
                        //   )
                        // else
                        CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/icons/temps.png'),
                            radius: 20,
                            child: Icon(
                              Icons.school_outlined,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20, top: 8),
              child: Text(
                'لك',
                style: TextStyle(
                  fontFamily: 'Dubai',
                  fontSize: 20,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              child: Card(
                color: Colors.white,
                surfaceTintColor: Colors.white,
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Column(
                    children: [
                      ProfileOption(
                        title: 'الفواتير',
                        icon: Icon(
                          Icons.credit_card,
                          size: 40,
                        ),
                      ),
                      Divider(),
                      ProfileOption(
                        title: 'ملف تخزين',
                        icon: Icon(
                          Icons.cloud,
                          size: 40,
                        ),
                      ),
                      Divider(),
                      ProfileOption(
                        title: 'الصور',
                        icon: Icon(
                          Icons.photo_library,
                          size: 40,
                        ),
                      ),
                      Divider(),
                      ProfileOption(
                        title: 'الفواتير',
                        icon: Icon(
                          Icons.credit_card,
                          size: 40,
                        ),
                      ),
                      Divider(),
                      ProfileOption(
                        title: 'الأعلانات',
                        icon: Icon(
                          Icons.announcement,
                          size: 40,
                        ),
                      ),
                      Divider(),
                      ProfileOption(
                        title: 'الجدول الزمني',
                        icon: Icon(
                          Icons.table_chart,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 20, top: 8),
              child: Text(
                'أخرى',
                style: TextStyle(
                  fontFamily: 'Dubai',
                  fontSize: 20,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              child: Card(
                color: Colors.white,
                surfaceTintColor: Colors.white,
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: Column(
                    children: [
                      ProfileOption(
                        title: 'الفواتير',
                        icon: Icon(
                          Icons.credit_card,
                          size: 40,
                        ),
                      ),
                      Divider(),
                      ProfileOption(
                        title: 'ملف تخزين',
                        icon: Icon(
                          Icons.cloud,
                          size: 40,
                        ),
                      ),
                      Divider(),
                      ProfileOption(
                        title: 'الأحكام والشروط للبرنامج',
                        icon: Icon(
                          Icons.description,
                          size: 40,
                        ),
                      ),
                      Divider(),
                      ProfileOption(
                        title: 'FaceBook Page',
                        icon: Icon(
                          Icons.facebook,
                          size: 40,
                        ),
                      ),
                      Divider(),
                      ProfileOption(
                        title: 'الأعلانات',
                        icon: Icon(
                          Icons.announcement,
                          size: 40,
                        ),
                      ),
                      Divider(),
                      ProfileOption(
                        title: 'الجدول الزمني',
                        icon: Icon(
                          Icons.table_chart,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              child: Card(
                color: Colors.white,
                surfaceTintColor: Colors.white,
                elevation: 3,
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(10),
                  child: const Padding(
                    padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'تسجيل الخروج',
                          style: TextStyle(
                            fontFamily: 'Dubai',
                          ),
                        ),
                        SizedBox(width: 8),
                        // if (widget.authorImageUrl != null)
                        //   CircleAvatar(
                        //     radius: 20,
                        //     backgroundImage: NetworkImage(widget.authorImageUrl!),
                        //   )
                        // else
                        CircleAvatar(
                          radius: 20,
                          child: Icon(
                            Icons.logout,
                            size: 43,
                          ), // Placeholder image
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
