//
//  ViewController.swift
//  EmbedJavascript
//
//  Created by mac on 8/15/19.
//  Copyright © 2019 Eddie. All rights reserved.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet private weak var tfCardNumber: UITextField?
    @IBOutlet private weak var tfCardExp: UITextField?
    @IBOutlet private weak var tfCardCcv: UITextField?
    @IBOutlet private weak var btnPay: UIButton?

    private var paymentAction: JSActionGMOPayment? { didSet {
        paymentAction?.sendPayment {
            self.btnPay?.isHidden = false
            print($0)
        }
    }}

    @IBAction private func payNow() {
        guard let cardNo = tfCardNumber?.text, let cardExp = tfCardExp?.text, let cardCcv = tfCardCcv?.text else { return }
        self.btnPay?.isHidden = true
        paymentAction = JSActionGMOPayment(cardNumber: cardNo, cardExp: cardExp, cardCcv: cardCcv)
    }
}
