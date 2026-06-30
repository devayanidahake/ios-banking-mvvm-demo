//
//  JSONDecoderFactory.swift
//  BankingApp
//
//  Created by Devayani Purandare on 29/06/26.
//

import Foundation

/// Factory responsible for creating configured JSONDecoder instances.
///
/// Keeping decoder configuration in one place ensures consistency
/// across the entire application.
enum JSONDecoderFactory {

    static func makeDefaultDecoder() -> JSONDecoder {

        let decoder = JSONDecoder()

        decoder.keyDecodingStrategy = .convertFromSnakeCase

        decoder.dateDecodingStrategy = .iso8601

        return decoder
    }
}

/**Interview Guide
 Q1. Why create a JSONDecoderFactory?
 Answer

 Creating a configured JSONDecoder in one place ensures consistency across the application.

 Instead of repeating configuration in multiple classes, all decoding behavior is centralized.

 Benefits:

 Single source of truth
 Easier maintenance
 Consistent decoding rules
 Q2. Why not use JSONDecoder() directly?
 Answer

 If every API creates its own decoder:

 Configuration gets duplicated.
 Different decoding strategies may accidentally be used.
 Future changes require updating multiple files.

 A factory solves this problem.

 Q3. Why not use a Singleton?
 Answer

 JSONDecoder is not documented as thread-safe.

 Creating a new decoder for each request avoids shared mutable state and is inexpensive.

 This aligns well with Swift Concurrency.

 Q4. Why use an enum?
 Answer

 The factory has no state and no dependencies.

 An enum is a clean namespace for static factory methods.

 There's no reason to instantiate it.

 Q5. Which SOLID principle does this follow?
 Single Responsibility

 Only responsible for creating configured decoders.

 Q6. Which Design Pattern is this?

 Factory Pattern

 It encapsulates object creation and hides configuration details from consumers.

 Staff Engineer Review
 👍 Approved

 One suggestion I'd mention in a real review:

 If different APIs require different date formats in the future, consider adding additional factory methods (for example, makeISO8601Decoder() and makeCustomDateDecoder()) rather than making callers modify the decoder after creation.

 That keeps configuration centralized while remaining flexible.*/
