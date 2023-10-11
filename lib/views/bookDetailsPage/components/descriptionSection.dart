import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'package:kaalan/constants.dart';

class DescriptionSection extends StatelessWidget {
  const DescriptionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: kwidth(context, 0.87),
          child: const Text(
            "Synopsis",
            style: TextStyle(
                fontFamily: "Nominee",
                fontWeight: FontWeight.bold,
                fontSize: 17),
            textAlign: TextAlign.start,
          ),
        ),
        SizedBox(
          height: kheight(context, 0.03),
        ),
        SizedBox(
          width: kwidth(context, 0.87),
          child: ExpandText(
            "Vrey, pencuri andal anggota komplotan Kucing Liar,terbiasa menghalalkan segala cara untuk mendapatkan keinginannya.Valadin, Elvar terhormat yang menjalani hidupnya sebagai seorang Eldynn,kesatria suci yang bersumpah melindungi sesamanya.Kisah mereka terjalin di Ther Melian,sebuah benua tropis kecil yang diselimuti kabut dan misteri.Vrey memburu harta legendaris yang diimpikan setiap pencuri. Sedang Valadin menjalankan misi rahasia untuk mengembalikan kejayaan bangsanya.Pencarian masing-masing membawa mereka dalam petualangan yang luar biasa, dan pada akhirnya mempertemukan mereka....Apakah yang akan terjadi selanjutnya?Akankah mereka berakhir sebagai teman atau musuh?\nInilah PEMBUKAAN dari kisah mereka....Editor's Note:Merupakan kisah fantasi lokal, yang ceritanya berpusat pada sebuah benua bernama Ther Melian yang karakteristiknya mirip dengan Indonesia; seperti terletak di khatulistiwa, dengan hutan, tanaman, dan satwa khas Indonesia (komodo).Dunia Ther Melian didiami berbagai ras, dengan berbagai satwa mistis, dan bentang alam yang memukau (dilengkapi peta). Ceritanya tentang seorang gadis pencuri dan seorang kesatria Elvar yang rela mengobankan apa pun untuk mencapai apa yang mereka impikan. Ini adalah buku pertama dari tetralogi Ther Melian.",
            textAlign: TextAlign.justify,
            style: const TextStyle(fontFamily: "Nominee"),
            maxLines: 8,
            indicatorCollapsedHint: "Show More",
            indicatorIconColor: kprimaryColor,
            indicatorExpandedHint: "Show More",
            capitalizeIndicatorHintText: false,
            indicatorHintTextStyle: TextStyle(color: kprimaryColor),
          ),
        )
      ],
    );
  }
}
