//
//  GitHubAPIClient.swift
//  APIModelTest
//
//  Created by Ryota Karita on 2022/02/18.
//

import Foundation


protocol GitHubAPIClientProtocol {
    func fetchRepositories(user: String, handler: @escaping([GitHubRepository]?) -> Void)
}

class GitHubClient: GitHubAPIClientProtocol {
    func fetchRepositories(user: String, handler: @escaping ([GitHubRepository]?) -> Void) {
        let url = URL(string: "http://api.github.com/users/\(user)/repos")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                handler(nil)
                return
            }
            
            let repos = try! JSONDecoder().decode([GitHubRepository].self, from: data)
            
            DispatchQueue.main.async {
                handler(repos)
            }
        }
        task.resume()
    }
}
