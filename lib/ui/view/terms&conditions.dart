import 'package:fresh9_rider/ui/shared/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TermsAndConditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColor.primaryColor,
        title: Text(
          "Terms & Conditions",
        ),
      ),
      body: Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(children: [
            RichText(
                text: TextSpan(children: [
              //style: TextStyle(fontSize: 20),
              TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  text:
                      "This page (together with the documents referred to on it) tells you the terms and conditions on which we supply any of the products (Products) listed on our website www.Fresh9store.com (our site) to you. Please read these terms and conditions carefully before ordering any Products from our site. You should understand that by ordering any of our Products, you agree to be bound by these terms and conditions."
                      "\n\nYou should print a copy of these terms and conditions for future reference."
                      "\n\nPlease click on the button marked \"I Accept\" at the end of these terms and conditions if you accept them. Please understand that if you refuse to accept these terms and conditions, you will not be able to order any Products from our site."),
              TextSpan(
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  text: "\n\nInformation about us\n"),
              TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  text:
                      "www.Fresh9store.com is a site operated by Fresh9store Logistics (pvt) Ltd (we and/or the Company). We are registered in Pakistan under company number 7158005-8 and our registered office and main trading address is at 110 – B, Faiz Ahmed Faiz Road, Quaid e Azam Industrial Estate, Lahore Pakistan."),
              TextSpan(
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  text: "\n\nYour Status\n"),
              TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  text:
                      "By placing an order through our site, you warrant that:"
                      "You are legally capable of entering into binding contracts; and"
                      "You are at least 16 years old; we will not sell or deliver to anyone who is, or appears to be, under the age of 16; we reserve the right not to deliver if we are unsure of this."
                      "You do not intend to use our site or service for the sale or delivery of any form of alcohol, drugs and/or narcotics. We will refuse deliver any such products to anyone."),
              TextSpan(
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  text: "\n\nHow the contract is formed between you and us\n"),
              TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  text:
                      "After placing an order, you will receive an e-mail from us acknowledging that we have received your order. Please note that this does not mean that your order has been accepted. Your order constitutes an offer to us to buy a Product. All orders are subject to acceptance by us, and we will confirm such acceptance to you by sending you an e-mail that confirms that the Product has been dispatched (the Dispatch Confirmation). The contract between us (Contract) will only be formed when we send you the Dispatch Confirmation. We reserve the right to refuse any order or cancel a delivery at any time without giving a reason."
                      "The Contract will relate only to those Products whose dispatch we have confirmed in the Dispatch Confirmation. We will not be obliged to supply any other Products which may have been part of your order until the dispatch of such Products has been confirmed in a separate Dispatch Confirmation."
                      "Please note that once you have made your order and your payment has been authorized you will not be able to cancel your order and that refunds may be given at the discretion of the management."),
              TextSpan(
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  text: "\n\nOur Status\n"),
              TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  text:
                      "We are entering into the Contract ourselves and not as nominee or agent for any other person and we alone shall be responsible to you under it; no other person, as agent or otherwise, is entitled or authorised to bind or commit the Company to any obligation to you."
                      "We may provide links on our site to the websites of other companies (other websites), whether affiliated with us or not. We cannot give any undertaking, that products you purchase from companies to whose website we have provided a link on our site, will be of satisfactory quality, and any such warranties are DISCLAIMED by us absolutely. This DISCLAIMER does not affect your statutory rights against the third party."
                      "All questions regarding goods shown on our site should be directed to the affiliate restaurant."),
              TextSpan(
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  text: "\n\nAvailability and Delivery\n"),
              TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  text:
                      "Your order will be fulfilled by the delivery date/time set out in the Dispatch Confirmation."
                      "Delivery shall only be made to verified residential addresses and for intended consumption at home."
                      "Delivery periods quoted at the time of ordering are approximate only and may vary. Products will be delivered to the address designated by you at the time of ordering. You agree to take particular care when providing us with your details and warrant that these details are accurate and complete at the time of ordering."
                      "In case of a late delivery, the delivery charge will neither be voided nor refunded."
                      "If you fail to accept delivery of a Product at the time they are ready for delivery, or we are unable to deliver at the nominated time due to your failure to provide appropriate instructions, or authorizations, then such Products shall be deemed to have been delivered to you and all risk and responsibility in relation to such Products shall pass to you. Any storage, insurance and other costs which we incur as a result of the inability to deliver shall be your responsibility and you shall indemnify us in full for such cost."
                      " In the unlikely event that a wrong item is delivered or a partial delivery is made, you have the right to reject the delivery of the wrong item and you shall be not be liable to make any payment."),
              TextSpan(
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  text: "\n\nRisk and Title\n"),
              TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  text:
                      " The Products will be at your risk from the time of delivery."
                      "Ownership of the Products will only pass to you when we receive full payment of all sums due in respect of the Products, including delivery charges. It is the responsibility of the customer to thoroughly check the Products before agreeing to pay for an order."),
              TextSpan(
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  text: "\n\nPrice and Payment\n"),
              TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  text:
                      "The price of any Products will be as quoted on our site or other websites from time to time, except in cases of obvious error."
                      "If the prices on our websites or any other websites are exclusive of any applicable taxes it shall be indicated so. However the prices of Products shall exclude delivery costs, which shall be confirmed prior to your placing an order and added to the total amount due."
                      " Prices are liable to change at any time, but changes will not affect orders in respect of which we have already sent you a Dispatch Confirmation."
                      " Our site contains a large number of Products and it is always possible that, despite our best efforts, some of the Products listed on our site may be incorrectly priced. We will normally verify prices as part of our dispatch procedures so that, where a Product’s correct price is less than our stated price, we will charge the lower amount when dispatching the Product to you. If a Product’s correct price is higher than the price stated on our site, we will normally, at our discretion, either contact you for instructions before dispatching the Product, or reject your order and notify you of such rejection."
                      " We are under no obligation to provide the Product to you at the incorrect (lower) price, even after we have sent you a Dispatch Confirmation, if the pricing error is obvious and unmistakeable and could have reasonably been recognised by you as a mis-pricing."
                      " Payment for all Products must be made by cash on delivery."
                      "  We do not accept payment with credit or debit card, VISA, Mastercard, Debit, switch, solo, AMEX, Paypal, Diner Club and or Cheques."),
              TextSpan(
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  text: "\n\nFresh9store Cash\n"),
              TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  text:
                      "Fresh9store Cash is a closed loop wallet that can only be used to purchase specific items and/or services from and/or within Fresh9store. It is not redeemable or transferable into Cash. The items and/or services which can be purchased using Fresh9store Cash shall be the sole discretion of Fresh9store."
                      "Fresh9store Cash can be topped up using a number of different banking methods that can vary based on the customer location, or the discretion of Fresh9store. All applicable duties, taxes, charges for using any of these methods would be charged to the customer. The number of top-ups or the total amount of Fresh9store Cash you can maintain may be limited at the sole discretion of Fresh9store. Once the request for top-up is completed, it cannot be cancelled or refunded by you."
                      "Fresh9store Cash can be transferred to another User. Fresh9store identifies Users through their mobile numbers and provides a confirmation screen which shows the user and their name in our system to you. The amount you specify will be transferred to the user who possesses the account belonging to the number you specify. Fresh9store does not hold any responsibility beyond that (i.e. that the person is the same person that you want to send it to) The amount transferred will be deducted from your wallet and added to the specified user’s wallet. This transfer, once made, cannot be reversed or cancelled."
                      "You can request Fresh9store Cash from another User. The User will receive your request and can then transfer Fresh9store Cash to you upon their discretion. Fresh9store is only responsible for routing your request to the User that you have specified."
                      "You agree that in providing you with the aforementioned features, Fresh9store is merely enabling the transfer of Fresh9store Cash balance and is no way responsible for the actions of the individual Users, including the reason for which Fresh9store Cash is transferred by or to you."
                      "You may be entitled to purchase bundles of Fresh9store Cash (“Fresh9store Bundles”) that you can apply toward payment of certain services provided by Fresh9store or fees charged by Fresh9store in relation to services and/or products offered by Fresh9store."
                      "Fresh9store Bundles are only valid for use on the Fresh9store platform, and are not transferable or redeemable for cash and may only be used for certain Services."
                      "Additional restrictions on Fresh9store Bundles may apply as communicated to you in a relevant promotion or specific terms. Fresh9store may cancel, or vary the terms, relating to any Fresh9store Bundles at any time in its sole discretion."
                      "There may be additional charges (if any) that Fresh9store may apply on any and all transactions made using Fresh9store Cash."
                      "From time to time, Fresh9store may provide incentives for referring new customers (Referral Program). The nature and amount of these incentives will be determined by Fresh9store and the terms, restrictions, conditions, and qualification requirements thereof can vary based on the discretion of Fresh9store."
                      "User consents to receive all disclosures, notices, change in terms, and other documents related to these Terms & Conditions and use of the Mobile Wallet electronically. User agrees that Fresh9store may provide notices to the User concerning these Terms by posting the material on our website, through electronic notice given to any electronic mailbox it maintains for the User or to any other email address or telephone number you provide to us."
                      "Fresh9store is not responsible for any errors, delays, or the inability to use the Fresh9store Fresh9store Wallet for any transaction."
                      "The User is responsible for maintaining the confidentiality of his/her Fresh9store Wallet information and any underlying financial information. You should keep all credentials secure and confidential. Do not share your credentials with any other person. Information you provide to any mobile wallet provider is subject to that provider’s agreements and is not governed by these Terms."
                      "Fresh9store reserves the right to terminate the User’s usage of his/her Fresh9store Wallet at any time with or without notice. Fresh9store may terminate or amend these Terms at any time without notice unless required by law. The User’s use of Fresh9store Wallet after Fresh9store has made such changes will be deemed your consent to the changes."
                      "This Agreement is governed by the laws of Pakista. This Agreement is the sole understanding of the parties with respect to the stated subject matter. If any provision of this Agreement is held by a court of competent jurisdiction to be invalid or unenforceable, such provision will be enforced to the fullest extent that it is valid and enforceable under applicable law. All provision of this Agreement relating to ownership, indemnification, and limitations of liability shall remain in full force and effect after termination of this Agreement. Fresh9store may assign these Terms. You may not assign these Terms."
                      "Fresh9store IS NOT AND SHALL NOT BE LIABLE FOR ANY LOSS, DAMAGE OR INJURY OR FOR ANY DIRECT, INDIRECT, SPECIAL, INCIDENTAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES, INCLUDING LOST PROFITS, ARISING FROM OR RELATED TO YOUR ACCESS OR USE OF THE Fresh9store WALLET."
                      "Fresh9store shall incur no liability if it is unable to complete a transaction in a timely manner because: (i) your account does not contain sufficient funds to complete the transaction or the transaction exceeds the limit of your overdraft protection options; (ii) the Fresh9store Wallet is not working properly and you knew or were advised about the problem before completing the transaction; (iii) circumstances beyond Fresh9stores control (such as, but not limited to, telecommunication failure, fire, flood, or interference from an outside force) that prevent or delay the transaction; (v) Fresh9store has reason to believe the transaction is unauthorized by you; and/or (vi) there may be other exceptions stated in our agreement(s) with you."),
              TextSpan(
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  text: "\n\nOur Liability\n"),
              TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  text:
                      "We warrant to you that any Product purchased from us through our site is of satisfactory quality and reasonably fit for all the purposes for which products of the kind are commonly supplied."
                      "Our liability for losses you suffer as a result of us breaking this agreement is strictly limited to the purchase price of the Product you purchased and any losses which are a foreseeable consequence of us breaking the agreement. Losses are foreseeable where they could be contemplated by you and us at the time your order is accepted by us."
                      "This does not include or limit in any way our liability:"
                      "For death or personal injury caused by our negligence;"
                      "For fraud or fraudulent misrepresentation; or"
                      "For any matter for which it would be illegal for us to exclude, or attempt to exclude, our liability."
                      "We are not responsible for indirect losses which happen as a side effect of the main loss or damage, including but not limited to:"
                      "loss of income or revenue"
                      "loss of business"
                      "loss of profits or contracts"
                      "loss of anticipated savings"
                      "loss of data, or"
                      "waste of management or office time however arising and whether caused by tort (including negligence), breach of contract or otherwise;"
                      "provided that this clause 8.4 shall not prevent claims for loss of or damage to your tangible property that fall within the terms of clause 8.1 or clause 8.2 or any other claims for direct financial loss that are not excluded by any of the provisions of this clause 8.4."
                      "Great care has been taken to ensure that the information available on this Website is correct and error free. We apologize for any errors or omissions that may have occurred. We cannot warrant that use of the Website will be error free or fit for purpose, timely, that defects will be corrected, or that the site or the server that makes it available are free of viruses or bugs or represents the full functionality, accuracy, reliability of the Website and we do not make any warranty whatsoever, whether express or implied, relating to fitness for purpose, or accuracy."
                      "By accepting these terms of use you agree to relieve us from any liability whatsoever arising from your use of information from any third party, or your use of any third party website."
                      "We do not accept any liability for any delays, failures, errors or omissions or loss of transmitted information, viruses or other contamination or destructive properties transmitted to you or your computer system via our website."),
              TextSpan(
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  text: "\n\nWritten communications\n"),
              TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  text:
                      "Applicable laws require that some of the information or communications we send to you should be in writing. When using our site, you accept that communication with us will be mainly electronic. We will contact you by e-mail or provide you with information by posting notices on our website. For contractual purposes, you agree to this electronic means of communication and you acknowledge that all contracts, notices, information and other communications that we provide to you electronically comply with any legal requirement that such communications be in writing. This condition does not affect your statutory rights."),
              TextSpan(
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  text: "\n\nNotices\n"),
              TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  text:
                      "All notices given by you to us must be given to __________________ at ____________ . We may give notice to you at either the e-mail or postal address you provide to us when placing an order, or in any of the ways specified in clause 9 above. Notice will be deemed received and properly served immediately when posted on our website, 24 hours after an e-mail is sent, or three days after the date of posting of any letter. In proving the service of any notice, it will be sufficient to prove, in the case of a letter, that such letter was properly addressed, stamped and placed in the post and, in the case of an e-mail, that such e-mail was sent to the specified e-mail address of the addressee."),
              TextSpan(
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  text: "\n\nTransfer of rights and obligations\n"
                      "The contract between you and us is binding on you and us and on our respective successors and assigns."
                      "You may not transfer, assign, charge or otherwise dispose of a Contract, or any of your rights or obligations arising under it, without our prior written consent."
                      "We may transfer, assign, charge, sub-contract or otherwise dispose of a Contract, or any of our rights or obligations arising under it, at any time during the term of the Contract."),
              TextSpan(
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  text: "\n\nEvents outside our control\n"),
              TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  text:
                      "We will not be liable or responsible for any failure to perform, or delay in performance of, any of our obligations under a Contract that is caused by events outside our reasonable control (Force Majeure Event)."
                      "A Force Majeure Event includes any act, event, non-happening, omission or accident beyond our reasonable control and includes in particular (without limitation) the following:"
                      "Strikes, lock-outs or other industrial action."
                      "Civil commotion, riot, invasion, terrorist attack or threat of terrorist attack, war (whether declared or not) or threat or preparation for war."
                      "Fire, explosion, storm, flood, earthquake, subsidence, epidemic or other natural disaster."
                      "Impossibility of the use of railways, shipping, aircraft, motor transport or other means of public or private transport."
                      "Impossibility of the use of public or private telecommunications networks."
                      "The acts, decrees, legislation, regulations or restrictions of any government."
                      "Our performance under any Contract is deemed to be suspended for the period that the Force Majeure Event continues, and we will have an extension of time for performance for the duration of that period. We will use our reasonable endeavours to bring the Force Majeure Event to a close or to find a solution by which our obligations under the Contract may be performed despite the Force Majeure Event."),
              TextSpan(
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  text: "\n\nWaiver\n"),
              TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  text:
                      "If we fail, at any time during the term of a Contract, to insist upon strict performance of any of your obligations under the Contract or any of these terms and conditions, or if we fail to exercise any of the rights or remedies to which we are entitled under the Contract, this shall not constitute a waiver of such rights or remedies and shall not relieve you from compliance with such obligations."
                      "A waiver by us of any default shall not constitute a waiver of any subsequent default."
                      "No waiver by us of any of these terms and conditions shall be effective unless it is expressly stated to be a waiver and is communicated to you in writing in accordance with clause 10 above."),
              TextSpan(
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                text: "\n\nSeverability\n",
              ),
              TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  text:
                      "If any of these terms and Conditions or any provisions of a Contract are determined by any competent authority to be invalid, unlawful or unenforceable to any extent, such term, condition or provision will to that extent be severed from the remaining terms, conditions and provisions which will continue to be valid to the fullest extent permitted by law."),
              TextSpan(
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  text: "\n\nEntire agreement\n"),
              TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  text:
                      "These terms and conditions and any document expressly referred to in them constitute the whole agreement between us and supersede any previous arrangement, understanding or agreement between us, relating to the subject matter of any Contract."
                      "We each acknowledge that, in entering into a Contract, (and the documents referred to in it), neither of us relies on any statement, representation, assurance or warranty (Representation) of any person (whether a party to that Contract or not) other than as expressly set out in these terms and conditions."
                      "Each of us agrees that the only rights and remedies available to us arising out of or in connection with a Representation shall be for breach of contract as provided in these terms and conditions."
                      "Nothing in this clause shall limit or exclude any liability for fraud."),
              TextSpan(
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  text: "\n\nOur right to vary these terms and conditions\n"),
              TextSpan(
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  text:
                      "We have the right to revise and amend these terms and conditions from time to time."
                      "You will be subject to the policies and terms and conditions in force at the time that you order products from us, unless any change to those policies or these terms and conditions is required to be made by law or governmental authority (in which case it will apply to orders previously placed by you), or if we notify you of the change to those policies or these terms and conditions before we send you the Dispatch Confirmation (in which case we have the right to assume that you have accepted the change to the terms and conditions, unless you notify us to the contrary within seven working days of receipt by you of the Products)."),
              TextSpan(
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  text: "\n\nLaw and jurisdiction\n"),
              TextSpan(
                style: TextStyle(fontSize: 16, color: Colors.black),
                text:
                    "Contracts for the purchase of Products through our site and any dispute or claim arising out of or in connection with them or their subject matter or formation (including non-contractual disputes or claims) will be governed by Pakistani law. Any dispute or claim arising out of or in connection with such Contracts or their formation (including non-contractual disputes or claims) shall be subject to the non-exclusive jurisdiction of the courts of Pakistan.",
              )
            ])),
          ])),
    );
  }
}
