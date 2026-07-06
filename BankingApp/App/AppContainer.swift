//
//  AppContainer.swift
//  BankingApp
//
//  Created by Devayani Purandare on 06/07/26.
//
import Foundation

final class AppContainer {

    let apiClient: any APIClient

    init() {

        let configuration = NetworkConfiguration.production

        let session = URLSession.shared

        let requestBuilder = RequestBuilder(
            configuration: configuration
        )

        let responseValidator = ResponseValidator()

        let decoder = JSONDecoderFactory.makeDefaultDecoder()

        self.apiClient = URLSessionAPIClient(
            session: session,
            requestBuilder: requestBuilder,
            responseValidator: responseValidator,
            decoder: decoder
        )
    }
}
