// import 'package:flutter/material.dart';
// import 'package:mayapur_bace/core/theme/color_pallet.dart';
// import 'package:mayapur_bace/core/theme/fonts.dart';

import 'package:flutter/material.dart';
import 'package:mayapur_bace/core/theme/color_pallet.dart';
import 'package:mayapur_bace/core/theme/fonts.dart';

class MorningAarti extends StatelessWidget {
  const MorningAarti({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, List<String>> aartis = {
      "Sri Chaitanya Shikshashtakam": [
        "1. \nचेतो-दर्पण-मार्जनं भव-महा-दावाग्नि-निर्वापणं \nश्रेयः-कैरव-चन्द्रिकावितरणं विद्या-वधू-जीवनम् ।\nआनन्दाम्बुधि-वर्धनं प्रतिपदं पूर्णामृतास्वादनं \nसर्वात्म-स्नपनं परं विजयते श्री-कृष्ण-सङ्कीर्तनम् ॥",
        "2. \nनाम्नामकारि बहुधा निज-सर्व-शक्तिस्तत्रार्पिता नियमितः स्मरणे न कालः ।\nएतादृशी तव कृपा भगवन् ममापि दुर्दैवमीदृशमिहाजनि नानुरागः ॥",
        "3. \nत्रिणादपि सुनीचेन तरोरिव सहिष्णुना ।\nअमानिना मानदेन कीर्तनीयः सदा हरिः ॥",
        "4. \nन धनं न जनं न सुन्दरिं कवितां वा जगदीश कामये ।\nमम जन्मनि जन्मनीश्वरे भवताद् भक्तिरहैतुकी त्वयि ॥",
        "5. \nअयि नन्द-तनुज किंकरं पतितं मां विषमे भवाम्बुधौ ।\nकृपया तव पाद-पङ्कज-स्थित-धूली-सदृशं विचिन्तय ॥",
        "6. \nनयनं गलदश्रु-धारया वदनं गद्गद-रुद्धया गिरा ।\nपुलकैर्निचितं वपुः कदा तव नाम-ग्रहणे भविष्यति ॥",
        "7. \nयुगायितं निमेषेण चक्षुषा प्रावृषायितं ।\nशून्यायितं जगत्सर्वं गोविन्द-विरहेण मे ॥",
        "8. \nआश्लेष्य वा पादरतां पिनष्टु मामदर्शनान्मर्महतां करोतु वा ।\nयथा तथा वा विदधातु लम्पटो मत्प्राणनाथस्तु स एव नापरः ॥",
      ],
      "Guru Ashtakam": [
        "1. \nसंसार-दावानल-लीढ-लोक-त्राणाय कारुण्य-घनाघनत्वम् ।\nप्राप्तस्य कल्याण-गुणार्णवस्य वन्दे गु-रो-ः श्री-चरणारविन्दम् ॥",
        "2. \nमहाप्रभोः किर्तन-नृत्य-गीता-वदित्र-माद्यन्न मनो-रञ्जनाय ।\nप्राप्तस्य श्री रूप-नु-कू-ल-पत्या वन्दे गु-रो-ः श्री-चरणारविन्दम् ॥",
        "3. \nश्री विग्रहाराधन-नित्य-नाना-श्रृङ्गार-तान्मन्दिर-मार्जनादौ ।\nयुक्तस्य भक्तांश्च नियुञ्जतोपि वन्दे गु-रो-ः श्री-चरणारविन्दम् ॥",
        "4. \nचतुर्विधा-श्री-भगवत्प्रसादा-स्वाद्वन्न-तृप्तान हरि-भक्त-सङ्घान ।\nकृत्वैव त्रप्तिं भजतऽदः साधुत् वन्दे गु-रो-ः श्री-चरणारविन्दम् ॥",
        "5. \nश्री राधिका माधव-यो-रऽपार-माधुर्य-लीला गुण-रूप-नाम्नाम् ।\nप्रत्यश्रयो यस् च रसानु-चारिणे वन्दे गु-रो-ः श्री-चरणारविन्दम् ॥",
        "6. \nनिकुञ्ज-यूनोरति-केलि-सिद्ध्यै यायालिभिर् युक्तिरप्येकोपायः ।\nयत्किंकरि-स्मेर-धीरानु-कारिणे वन्दे गु-रो-ः श्री-चरणारविन्दम् ॥",
        "7. \nसाक्षाद् हरि-त्त्वेन समस्त-शास्त्रैर् उक्तस् तथाभ्यतःएव सद्भिः ।\nक्षेत्रे तनुं यच्च पावनं नाम वन्दे गु-रो-ः श्री-चरणारविन्दम् ॥",
        "8. \nयस्य प्रसादाद् भगवान प्रियः स्यात्यस्याप्रसादे नगति-हि-एति ।\nधयान्तु-सि-सिन्दुं सदा करुणावतारं वन्दे गु-रो-ः श्री-चरणारविन्दम् ॥\n",
      ],
      "Narsimmaha Aarti": [
        "1. \nनमस्ते नरसिंहाय प्रह्लाद-आह्लाद-दायिने ।\nहिरण्यकशिपोर वक्षः-शिला-टङ्क-नखालये ॥",
        "2. \nइतो नृसिंहः परतो नृसिंहो यतो यतो यामि ततो नृसिंहः ॥",
        "3. \nबहिर्नृसिंहो हृदये नृसिंहो नृसिंहमादिं शरणं प्रपद्ये ॥",
        "4. \nतव करकमलवरे नखमद्भुत-शृङ्गं \nदलितहिरण्यकशिपुतनुभृङ्गम् ॥\nकेशव धृतनरहरिरूप जय जगदीश हरे ॥",
        "5. \nइत्थं नृसिंहो भगवान गजेन्द्राद्येर्यथा स्मृतः ।\nभक्तानां च भयत्राता रक्षते तान् सदा हरिः ॥",
      ],
      "Tulsi Aarti": [
        "1. \nतुलसी कृष्णा प्रेयसी नमो नमों\nराधा कृष्णा सेवा पाबो एई अभिलाषी ॥",
        "2. \nये तोमार शरण लोय, तारा वांछा पूर्ण होय\nकृपा करी कोरो तारे वृंदावन वासीं ॥",
        "3. \nमोरा एई अभिलाष विलास कुंजे दिओ वास\nनयन हेरीबो सदा युगल रूप रासि ॥",
        "4. \nएई निवेदन धर सखीर अनुगत कोरो\nसेवा अधिकार दिए कोरो निज दासी ॥",
        "5. \nदिन कृष्णा दासे कोय एई येन मोरा होय\nश्री राधा गोविंद प्रेमे सदा येन भासिं ॥",
        "6. \nयानि कानि च पापानी ब्रह्म हत्यदिकानी च\nतानि तानि प्रणश्य प्रदक्षिणः पदे पदे ॥"
      ],
    };

    return Scaffold(
      backgroundColor: ColorPallete.whiteTextColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        children: aartis.keys.map((title) {
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: ExpansionTile(
              backgroundColor: ColorPallete.registerPageTitleColor,
              collapsedBackgroundColor: ColorPallete.orangeColor,
              textColor: ColorPallete.blackColor,
              collapsedTextColor: ColorPallete.buttonsColorPurple,
              iconColor: ColorPallete.pinkColor,
              collapsedIconColor: ColorPallete.blackColor,
              shape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              collapsedShape: BeveledRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              title: Text(
                title,
                style: Fonts.nunitoSans(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              children: aartis[title]!.map((shloka) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Card(
                    margin: EdgeInsets.all(0),
                    elevation: 3,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          colors: [
                            Colors.yellow,
                            Colors.orangeAccent,
                            Colors.yellow.shade300,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Text(
                        shloka,
                        textAlign: TextAlign.center,
                        style: Fonts.nunitoSans(
                          fontSize: 22,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }).toList(),
      ),
    );
  }
}
