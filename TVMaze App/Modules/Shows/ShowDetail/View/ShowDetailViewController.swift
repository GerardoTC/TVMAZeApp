//
//  ShowDetailViewController.swift
//  TVMaze App
//
//  Created by Gerardo Tarazona Caceres on 16/10/21.
//
import UIKit

final class ShowDetailViewController: UIViewController, Storyboarded {
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var showName: UILabel!
    @IBOutlet weak var showInfo: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var episodesTitle: UILabel!
    @IBOutlet weak var seasonsInput: UITextField!
    @IBOutlet weak var episodesList: UICollectionView!
    @IBOutlet weak var pickerImage: UIImageView!
    @IBOutlet weak var loadingView: UILoadingView!
    @IBOutlet weak var seasonPickerView: UIView!
    var seasonPicker: UIPickerView = UIPickerView()
    
    var presenter: ShowDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPresenterViewLoad()
        setupUIView()
    }
    
    private func loadPresenterViewLoad() {
        presenter?.viewDidLoad()
    }

    private func setupUIView() {
        setupTextStyles()
        setupCollection()
        setupPicker()
        view.bringSubviewToFront(loadingView)
    }

    private func setupTextStyles() {
        showName.setFont(.titleL)
        showInfo.setFont(.bodyM, color: .textColorSecondary)
        summary.setFont(.bodyM, color: .textColorSecondary)
        episodesTitle.setFont(.titleS)
    }
    
    private func setupCollection() {
        episodesList.delegate = self
        episodesList.dataSource = self
        episodesList.register(UINib(nibName: EpisodeCollectionViewCell.viewID, bundle: .main),
                              forCellWithReuseIdentifier: EpisodeCollectionViewCell.viewID)
    
    }
    
    private func setupPicker() {
        seasonsInput.inputView = seasonPicker
        seasonsInput.inputAccessoryView = createToolbarForPicker()
        seasonsInput.tintColor = BaseColorPalette.clearColor.color
        seasonPicker.delegate = self
        seasonPicker.dataSource = self
    }

    @objc func hidePicker() {
        seasonsInput.resignFirstResponder()
    }
    
    private func createToolbarForPicker() -> UIToolbar {
        let toolBar = UIToolbar(frame: CGRect(x:0, y:0, width:100, height:100))
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = BaseColorPalette.tintColor.color
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "shows.detail.done".localized, style: .done, target: self, action: #selector(hidePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        return toolBar
    }
    
    func startLoading() {
        DispatchQueue.main.async {
            self.loadingView.isHidden = false
        }
        
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.loadingView.alpha = 1
            UIView.animate(withDuration: 0.5,animations: {
                self.loadingView.alpha = 0
            }) { _ in
                self.loadingView.isHidden = true
            }
        }
    }
}

//MARK: - ShowDetailViewProtocol
extension ShowDetailViewController: ShowDetailViewProtocol {
    func updateEpisodesList() {
        DispatchQueue.main.async { [unowned self] in
            episodesList.reloadData()
        }
    }
    
    func updateView(_ info: ShowInfoDetail) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.poster.load(url: info.poster ?? "", errorClosure: { [weak self] _ in
                self?.poster.isHidden = true
            })
            self.showName.text = info.title
            self.showInfo.text = info.genres + (info.schedule == " • " ? "" :  "\n" + info.schedule)
            self.summary.text = info.summary.htmlToString
        }
    }
    
    func hideEpisodes() {
        DispatchQueue.main.async { [weak self] in
            self?.episodesList.isHidden = true
            self?.episodesTitle.isHidden = true
            self?.seasonPickerView.isHidden = true
        }
    }
}

//MARK: - CollectionView Data Source
extension ShowDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.episodesCount() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EpisodeCollectionViewCell.viewID, for: indexPath)
        presenter?.setup(cell: cell as? BaseEpisodeCollectionCell, at: indexPath.row)
        return cell
    }
    
    
}

//MARK: - CollectionView Delegate
extension ShowDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.didSelect(episode: indexPath.row)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

//MARK: - PickerView Data Source
extension ShowDetailViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        presenter?.seasonsCount() ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        presenter?.seasonTitle(for: row)
    }
}

//MARK: - PickerView Delegate
extension ShowDetailViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        presenter?.seasonSelected(row)
        seasonsInput.text = presenter?.seasonTitle(for: row)
    }
}
