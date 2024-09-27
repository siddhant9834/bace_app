import 'package:flutter/material.dart';
import 'package:mayapur_bace/core/theme/color_pallet.dart';
import 'package:mayapur_bace/core/theme/fonts.dart';

class MorningAarti extends StatelessWidget {
  const MorningAarti({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.whiteTextColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                'Sri Chaitanya Shikshashtakam',
                style: Fonts.alata(
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: ColorPallete.blackColor),
              ),
            ),
            Divider(
              color: ColorPallete.faintBlackTextColor,
              indent: 10,
              endIndent: 10,
              thickness: 1.5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                textAlign: TextAlign.center,
                // textDirection: TextDirection.rtl,
      '''
      (1)
                    
      चेतोदर्पणमार्जनं भवमहादावाग्नि-निर्वापणं
      श्रेयः कैरवचन्द्रिकावितरणं विद्यावधूजीवनम्।
      आनन्दाम्बुधिवर्धनं प्रतिपदं पूर्णामृतास्वादनं
      सर्वात्मस्नपनं परं विजयते श्रीकृष्ण संकीर्तनम्।।
                    
      (2)

      नाम्नामकारि बहुधा निजसर्वशक्ति-
      स्तत्रार्पिता नियमितः स्मरणे न कालः।
      एतादृशी तव कृपा भगवन्ममापि
      दुर्दैवमीदृशमिहाजनि नाऽनुरागः॥
                                 
                    
      (3)

      तृणादपि सुनीचेन, तरोरपि सहिष्णुना।              
      अमानिना मानदेन , कीर्तनीयः सदा हरिः॥
                    
      (4)
                    
      न धनं न जनं न सुन्दरीं , कवितां वा जगदीश कामये।
      मम जन्मनि जन्मनीश्वरे , भवताद्‌भक्तिरहैतुकी त्वयि॥     
                    
      (5)
                    
      अयि नन्दतनुज किङ्करं , पतितं मां विषमे भवाम्बुधौ।
      कृपया तव पादपंकज- स्थितधूलीसदृशं विचिन्तय॥
                    
      (6)
                    
      नयनं गलदश्रुधारया वदनं गद्‌गद्‌-रुद्धया गिरा।
      पुलकैर्निचितं वपुः कदा तव नाम-ग्रहणे भविष्यति॥
                    
      (7)
                    
      युगायितं निमेषेण चक्षुषा प्रावृषायितम्।
      शून्यायितं जगत्‌ सर्व गोविन्द-विरहेण मे॥
                    
      (8)
                    
      आश्लिष्य वा पादरतां पिनष्टु मा-
      मदर्शनार्न्महतां करोतु वा।
      यथा तथा वा विदधातु लम्पटो
      मत्प्राणनाथस्तु स एव नापरः॥
                    ''',
                      style: Fonts.firasans(fontSize: 20, fontWeight: FontWeight.w500, color: ColorPallete.blackColor),
                      ),
            )
          ],
        ),
      ),
    );
  }
}
