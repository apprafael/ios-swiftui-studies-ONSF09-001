//
//  TextField.swift
//  AppMusica
//
//  Created by Jessica Costa on 21/02/26.
//

import SwiftUI

struct TextGlassField: View {
    let title: String
    @Binding var text: String
    let isSecure: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.65))

            if isSecure {
                SecureField("", text: $text)
                    .glassStyle()
            } else {
                TextField("", text: $text)
                    .glassStyle()
            }
        }
    }
}

private extension View {
    func glassStyle() -> some View {
        self
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled(true)
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(.white.opacity(0.18))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(.white.opacity(0.25), lineWidth: 1)
            )
            .foregroundStyle(.white)
    }
}
