//
//  EpisodesDetailViewController.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 17/10/21.
//
import UIKit

final class EpisodesDetailViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var blurBgView: UIView!
    @IBOutlet weak var serieImage: UIImageView!
    @IBOutlet weak var episodeTitle: UILabel!
    @IBOutlet weak var episodeInfo: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    lazy var blurEffect = UIBlurEffect(style: .systemMaterial)
    lazy var blurView = UIVisualEffectView(effect: blurEffect)
    var presenter: EpisodesDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPresenterViewLoad()
        updateTopConstraint()
        setupUIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateBlurFrame()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        updateBlurFrame()
        updateTopConstraint()
    }
    
    func loadPresenterViewLoad() {
        presenter?.viewDidLoad()
    }
    
    private func setupUIView() {
        summary.setFont(.bodyM)
        episodeTitle.setFont(.titleS)
        episodeInfo.setFont(.bodyM)
    }
    
    func updateBlurFrame() {
        DispatchQueue.main.async {
            self.blurView.frame = self.blurBgView.bounds
        }
    }
    
    private func updateTopConstraint() {
        DispatchQueue.main.async {
            self.topConstraint.constant = self.view.frame.height - self.blurBgView.frame.height - 30
        }
    }
}

extension EpisodesDetailViewController: EpisodesDetailViewProtocol {
    func updateView(with info: EpisodeInfo) {
        blurBgView.insertSubview(blurView, at: 0)
        bgImage.contentMode = .scaleAspectFill
        serieImage.load(url: info.showPoster ?? "")
        bgImage.load(url: info.originalPoster ?? "")
        summary.text = info.summary.htmlToString
        episodeTitle.text = info.name
        episodeInfo.text = "episode.detail.episode".localized + " \(info.number), " + "episode.detail.season".localized +  " \(info.season)"
    }
}
