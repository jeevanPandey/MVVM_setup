
import UIKit

class ViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    var movieResult:MovieFeedResult? {
        didSet{
            self.tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

      //  self.tableView.register(UINib(nibName: "MovieCell", bundle:nil), forCellReuseIdentifier: "MovieCell")
       // self.tableView.register(UINib(nibName: "MenuCell", bundle:nil), forCellReuseIdentifier: "MenuCell")
        self.tableView.register(MovieCellTableViewCell.self)
        self.tableView.register(MenuCell.self)
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        MovieClient.sharedClient.getFeed(from: .nowPlaying) { result in
            switch result {
            case .success(let movieFeedResult):
                self.movieResult = movieFeedResult
               // guard let movieResults = movieFeedResult?.results else { return }
              //  print(movieResults)
            case .failure(let error):
                print("the error \(error)")
            }
        }
    }
}

extension ViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let count = self.movieResult?.results?.count else {
            return 0
        }
       return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let movies = self.movieResult?.results else {
            
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as MovieCellTableViewCell
        let movie = movies[indexPath.row]
        let viewModel = MovieViewModel(model: movie)
       cell.setUpWith(viewModel)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}

