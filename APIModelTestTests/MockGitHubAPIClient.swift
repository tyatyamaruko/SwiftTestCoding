//
//  MockGitHubAPIClient.swift
//  APIModelTestTests
//
//  Created by Ryota Karita on 2022/02/18.
//

import Foundation
@testable import APIModelTest

class MockGitHubAPIClient: GitHubAPIClientProtocol {
    var returnRepos: [GitHubRepository]
    var argsUser: String?
    
    init(repos: [GitHubRepository]) {
        self.returnRepos = repos
    }
    
    func fetchRepositories(user: String, handler: @escaping ([GitHubRepository]?) -> Void) {
        self.argsUser = user
        handler(self.returnRepos)
    }
}
