//
//  PasswordField.swift
//  AppMusica
//
//  Created by Jessica Costa on 21/02/26.
//

import SwiftUI

struct PasswordField: View {
    let title: String
    @Binding var text: String
    @Binding var isVisible: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.white.opacity(0.65))

            HStack(spacing: 10) {
                Group {
                    if isVisible {
                        TextField("", text: $text)
                    } else {
                        SecureField("", text: $text)
                    }
                }
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled(true)
                .foregroundStyle(.white)

                Button {
                    isVisible.toggle()
                } label: {
                    Image(systemName: isVisible ? "eye.slash" : "eye")
                        .foregroundStyle(.white.opacity(0.75))
                }
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
            .background(.white.opacity(0.18))
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: 12, style: .continuous)
                    .stroke(.white.opacity(0.25), lineWidth: 1)
            )
        }
    }
}
