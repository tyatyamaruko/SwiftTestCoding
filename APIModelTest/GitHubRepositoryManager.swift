//
//  GitHubRepositoryManager.swift
//  APIModelTest
//
//  Created by Ryota Karita on 2022/02/18.
//

import Foundation

class GitHubRepositoryManager {
    private let client: GitHubAPIClientProtocol
    private var repos: [GitHubRepository]?
    
    var majorRepositories: [GitHubRepository] {
        guard let repos = self .repos else { return [] }
        return repos.filter { $0.star >= 5 }
    }
    
    init(client: GitHubAPIClientProtocol = GitHubClient()) {
        self.client = client
    }
    
    func load(user: String, completion: @escaping() -> Void) {
        self.client.fetchRepositories(user: user) { repositories in
            self.repos = repositories
            completion()
        }
    }
}
