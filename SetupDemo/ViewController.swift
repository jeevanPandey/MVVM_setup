
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
        return section == 0 ?  1 : self.movieResult?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell =  indexPath.section == 0 ? tableView.dequeueReusableCell(forIndexPath: indexPath) as MenuCell : tableView.dequeueReusableCell(forIndexPath: indexPath) as MovieCellTableViewCell
        if let movieCell = cell as? MovieCellTableViewCell,let movies = self.movieResult?.results,
            let eachmodel = movies[indexPath.row] as? Movie {
            let eachViewModel = MovieViewModel.init(model: eachmodel)
            movieCell.setUpWith(eachViewModel)
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return section == 0 ? 44 : 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 30))
        let sgement = UISegmentedControl(items: ["My info","My Design"])
        sgement.frame = CGRect(x: 20, y: 0, width: self.view.bounds.width-40, height: 30)
        sgement.backgroundColor = UIColor.white
        sgement.tintColor = UIColor.brown
        view.addSubview(sgement)
        return section == 0 ? nil : view

        
    }
    
    
}

