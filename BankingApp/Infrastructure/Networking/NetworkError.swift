//
//  NetworkError.swift
//  BankingApp
//
//  Created by Devayani Purandare on 29/06/26.
//
import Foundation

/// Represents all networking errors that can occur while
/// communicating with remote services.
enum NetworkError: LocalizedError, Sendable, Equatable {

    // MARK: Request

    case invalidURL
    case invalidRequest

    // MARK: Transport

    case noInternet
    case requestTimedOut
    case cancelled

    // MARK: Response

    case unauthorized
    case forbidden
    case notFound
    case serverError(statusCode: Int)
    case unexpectedStatusCode(Int)

    // MARK: Parsing

    case decodingFailed
    case encodingFailed

    // MARK: Unknown

    case unknown
}


extension NetworkError {

    var errorDescription: String? {

        switch self {

        case .invalidURL:
            return "The requested URL is invalid."

        case .invalidRequest:
            return "The request could not be created."

        case .noInternet:
            return "No internet connection."

        case .requestTimedOut:
            return "The request timed out."

        case .cancelled:
            return "The request was cancelled."

        case .unauthorized:
            return "Authentication required."

        case .forbidden:
            return "Access denied."

        case .notFound:
            return "Requested resource was not found."

        case .serverError(let code):
            return "Server error (\(code))."

        case .unexpectedStatusCode(let code):
            return "Unexpected response (\(code))."

        case .decodingFailed:
            return "Unable to decode response."

        case .encodingFailed:
            return "Unable to encode request."

        case .unknown:
            return "Something went wrong."
        }
    }
}

//Why LocalizedError?
//
//Later our UI can simply do:
//
//Text(error.localizedDescription)
//
//without additional mapping.
//
//Add Extension
//
//Same file.
//Why not store String inside enum?
//
//Because:
//
//case unauthorized(String)
//
//mixes UI with the networking layer.
//
//Networking should expose meaning, not presentation.
//
//Why Sendable?
//
//Again, networking runs in concurrent tasks.


