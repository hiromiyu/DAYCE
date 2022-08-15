//
//  IDView.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/08/11.
//

import SwiftUI
import LocalAuthentication

struct IDView: View {
    
    var body: some View {
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "We need to unlock your data."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    if success {
                        
                    } else {
                        
                    }
                }            }
        }
    }
}

struct IDView_Previews: PreviewProvider {
    static var previews: some View {
        IDView()
    }
}
