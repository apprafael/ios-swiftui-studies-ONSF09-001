//
//  BottomSearchbar.swift
//  AppMusica
//
//  Created by Jessica Costa on 07/03/26.
//

import SwiftUI

struct BottomSearchBar: View {
    @Binding var searchText: String
    
    var body: some View {
        VStack(spacing: 0) {
            LinearGradient(
                colors: [
                    Color(.systemGroupedBackground).opacity(0),
                    Color(.systemGroupedBackground).opacity(0.9)
                ],
                startPoint: .top,
                endPoint: .bottom
            )
            .frame(height: 18)

            searchBar
                .padding(.top, 6)
                .padding(.bottom, 8)
                .background(Color(.systemGroupedBackground))
        }
    }
    
    private var searchBar: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)

            TextField("Buscar música", text: $searchText)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .fill(Color.white)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.black.opacity(0.06), lineWidth: 1)
        )
        .shadow(color: .black.opacity(0.05), radius: 8, y: 2)
        .padding(.horizontal, 16)
    }
}
