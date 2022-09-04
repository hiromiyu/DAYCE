//
//  Certification.swift
//  Secret Dairy
//
//  Created by ひろ on 2022/08/11.
//
import SwiftUI
import LocalAuthentication

struct Certification: View {
    
    var body: some View {
    
let context = LAContext()
var error: NSError?

if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
    
    switch context.biometryType {
    case .touchID
    case .faceID
    default:
        break
    }
} else {
    print("BiometryType Error: " + (error?.localizedDescription ?? "Unknown Error"))
}
}
}
