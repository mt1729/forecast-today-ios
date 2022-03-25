//
// Created by Matthew Taylor on 3/20/22.
//

import Combine
import Foundation

// NOTE: - Using `Never` can be misleading, since errors are captured in `Result.success` for `NetworkResult.error`
class ForecastTodayRestAPI: RestAPI, ObservableObject {
    let session: URLSession
    init(urlSession session: URLSession) {
        self.session = session
    }

    // Avoiding async/await at the moment for iOS 14 compatibility
    func fetchHourlyForecast(_ forecastReq: ForecastRequest) -> Future<NetworkResult<ForecastResponse>, Never> {
        Future<NetworkResult<ForecastResponse>, Never> { [self] promise in
            let params = [
                "q": forecastReq.zipCode,
                "key": Environment.apiKey
            ]

            var urlParts = URLComponents(string: Environment.apiRoot + "forecast.json")
            urlParts?.queryItems = params.map {
                URLQueryItem(name: $0, value: $1)
            }
            guard let url = urlParts?.url else {
                promise(.success(.error(NetworkError.invalidURL)))
                return
            }

            session.dataTask(with: url) { resData, res, resError in
                if let err = resError {
                    promise(.success(.error(err)))
                    return
                }

                guard let data = resData, let statusCode = (res as? HTTPURLResponse)?.statusCode else {
                    promise(.success(.error(NetworkError.emptyResponse)))
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode(ForecastResponse.self, from: data)
                    if statusCode.isHTTPSuccess {
                        // A little unintuitive to read out `.success(.success())`
                        // May need typealias for readability
                        promise(.success(.success(statusCode, decoded)))
                    } else {
                        promise(.success(.failure(statusCode)))
                    }
                } catch let jsonErr {
                    promise(.success(.error(jsonErr)))
                }
            }.resume()
        }
    }
}
