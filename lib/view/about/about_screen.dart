import 'package:flutter/material.dart';
import 'package:prani_sheba/common/custom_app_bar.dart';
import 'package:prani_sheba/responsive/size_config.dart';

class AboutScreen extends StatelessWidget {
  static const routeName = 'about_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'এলপিইপি সম্পর্কে'),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
                // 'প্রাকৃতিক রূপবৈচিত্র্যে ভরা আমাদের এই বাংলাদেশ। এই দেশে পরিচিত অপরিচিত অনেক পর্যটক-আকর্ষক স্থান আছে।'
                // ' এর মধ্যে প্রত্নতাত্ত্বিক নিদর্শন, ঐতিহাসিক মসজিদ এবং মিনার, পৃথিবীর দীর্ঘতম প্রাকৃতিক সমুদ্র সৈকত, পাহাড়,'
                // ' অরণ্য ইত্যাদি অন্যতম। এদেশের প্রাকৃতিক সৌন্দর্য পর্যটকদের মুগ্ধ করে। বাংলাদেশের প্রত্যেকটি এলাকা বিভিন্ন '
                // 'স্বতন্ত্র্র বৈশিষ্ট্যে বিশেষায়িত । বাংলাদেশ দক্ষিণ এশিয়ার উত্তর পূর্ব অংশে অবস্থিত। বাংলাদেশের উত্তর সীমানা থেকে '
                // 'কিছু দূরে হিমালয় পর্বতমালা এবং দক্ষিণে বঙ্গোপসাগর। পশ্চিমে ভারতের পশ্চিমবঙ্গ, পূর্বে ভারতের ত্রিপুরা, মিজোরাম '
                // 'রাজ্য এবং মায়ানমারের পাহাড়ী এলাকা। অসংখ্য নদ-নদী পরিবেষ্টিত বাংলাদেশ প্রধানত সমতল ভূমি। দেশের উল্লেখযোগ্য '
                // 'নদ-নদী হলো- পদ্মা, ব্রহ্মপুত্র, সুরমা, কুশিয়ারা, মেঘনা ও কর্ণফুলী।একেকটি অঞ্চলের প্রাকৃতিক সৌন্দর্য ও '
                // 'খাদ্যাভ্যাস বিভিন্ন ধরনের। বাংলাদেশ রয়েল বেঙ্গল টাইগারের দেশ যার বাস সুন্দরবনে। এছাড়াও এখানে রয়েছে '
                // 'লাল মাটি দিয়ে নির্মিত মন্দির। এদেশে উল্লেখযোগ্য পর্যটন এলাকার মধ্যে রয়েছে: শ্র্রীমঙ্গল, যেখানে মাইলের পর '
                // 'মাইল জুড়ে রয়েছে চা বাগান। প্রত্নতাত্ত্বিক নিদর্শনের স্থানগুলোর মধ্যে রয়েছে–ময়নামতি, মহাস্থানগড় এবং পাহাড়পুর। '
                // 'রাঙ্গামাট, কাপ্তাই এবং কক্সবাজার প্রাকৃতিক দৃশ্যের জন্য খ্যাত। সুন্দরবনে আছে বন্য প্রাণী এবং পৃথিবীখ্যাত ম্যানগ্রোভ '
                // 'ফরেস্ট এ বনাঞ্চলে অবস্থিত ।',
                "LPEP has been working for renewable energy sector since 2009 in partnership with Idcol and established more than 700 Bio gas plant in Faridpur, Madaripur and Munshiganj area. In these plants there are 2,800 cattle and we are providing cattle health services to the beneficiary. The plants help saving about Tk. 2.00 million to refrain from cutting trees and by producing biogas for the rural farmer.  After Producing Bio gas the waste called as Bio slurry is mainly used organic fertilizer better than chemical fertilizer. LPEP has been engaged in Renewable energy and livestock sector to help all level farmers in rural areas to provide gas and electricity through bio gas and solar panel and also working to ensure health safety of livestock. LPEP is providing vaccination, artificial insemination, vitamins, calcium to farmers with low cost and advisory services and our veterinary doctor is having cattle for hands on training to the field supervisors and farmers phase by phase",
                style: TextStyle(fontSize: 16, color: Colors.black87),
                textAlign: TextAlign.justify)
          ],
        ),
      ),
    );
  }
}
