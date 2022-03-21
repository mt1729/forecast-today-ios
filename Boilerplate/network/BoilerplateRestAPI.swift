//
// Created by Matthew Taylor on 3/20/22.
//

import Combine
import Foundation

// TODO: - Swinject singleton
struct BoilerplateRestAPI: RestAPI {
    let session: URLSession
    init(urlSession session: URLSession) {
        self.session = session
    }

    // Avoiding async/await at the moment for iOS 14 compatibility
    func fetchHourlyForecast(_ hourlyForecastBody: HourlyForecastBody) -> Future<NetworkResult<Forecast>, Error> {
        Future<NetworkResult<Forecast>, Error> { promise in
            let params = [
                "q": hourlyForecastBody.zipCode,
                "aqi": "no",
                "key": Environment.apiKey,
                "days": "1",
                "alerts": "no"
            ]

            var urlParts = URLComponents(string: Environment.apiRoot + "forecast.json")
            urlParts?.queryItems = params.map {
                URLQueryItem(name: $0, value: $1)
            }
            guard let url = urlParts?.url else {
                promise(.failure(NetworkError.invalidURL))
                return
            }

            session.dataTask(with: url) { data, response, error in
                if let error = error {
                    promise(.failure(error))
                    return
                }

                guard let data = data else {
                    promise(.failure(NetworkError.emptyResponse))
                    return
                }

                do {
                    let decoded = try JSONDecoder().decode(Forecast.self, from: data)
                    promise(.success(NetworkResult.success(decoded)))
                } catch {
                    promise(.failure(error))
                }
            }.resume()
        }
    }
}
