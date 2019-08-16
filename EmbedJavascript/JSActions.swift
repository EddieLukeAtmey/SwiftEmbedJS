//
//  JSActions.swift
//  EmbedJavascript
//
//  Created by mac on 8/16/19.
//  Copyright © 2019 Eddie. All rights reserved.
//

import Foundation
import JavaScriptCore

struct JSActionGMOPayment {
    var cardNumber: String
    var cardExp: String
    var cardCcv: String

    func sendPayment(callback: @escaping (String)->Void) {

        // Open resource
        guard let jsSourcePath = Bundle.main.path(forResource: "some", ofType: "js") else { callback("failed To load js"); return }

        do {
            let jsSourceContents = try String(contentsOfFile: jsSourcePath)
            jsContext?.exceptionHandler = { context, ex in
                if let s = ex?.toString() { callback(s) }
            }
            jsContext?.evaluateScript(jsSourceContents)

            guard let someFunction = jsContext?.objectForKeyedSubscript("someFunction") else { callback("Something went wrong"); return }
            someFunction.call(withArguments: ["a", { (something: String) in
                callback(something)
            }])

        }
        catch {
            callback(error.localizedDescription)
        }
    }

    private let jsContext = JSContext()
}
