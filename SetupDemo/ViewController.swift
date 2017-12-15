
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let client = MovieClient()
        client.getFeed(from: .nowPlaying) { result in
            switch result {
            case .success(let movieFeedResult):
                
                guard let movieResults = movieFeedResult?.results else { return }
                print(movieResults)
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }
}

