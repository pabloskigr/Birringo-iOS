//
//  OnboardingVC.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 24/1/22.
//

import UIKit

class OnboardingVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet var onboardingView: UIView!
    
    var slides: [OnboardingSlide] = []
    var currentPage = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextBtn.setTitle("Comenzar", for: .normal)
            } else {
                nextBtn.setTitle("Siguiente", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        self.navigationItem.hidesBackButton = true
        setupColors()
        
        slides = [
            OnboardingSlide(title: "Bienvenido", description: "A continuacion te mostramos que puedes hacer en la app", image: UIImage(named: "beer_image")!),
            OnboardingSlide(title: "Encuentra las mejores cervezas y lugares cercanos", description: "Birringo usara tu ubicación para que puedas localizar los mejores lugares donde tomar cerveza.",image: UIImage(named: "map")!),
            OnboardingSlide(title: "Haz retos mientras descubres nuevas cervezas", description: "Con la sección de gamificación podrás ganar puntos realizando quest para subir de posicion en el ranking de la app.", image: UIImage(named: "ganador")!)
        ]
        

    }
    private func setupColors(){
        onboardingView.backgroundColor = UIColor(named: "background")
        collectionView.backgroundColor = UIColor(named: "background")
    }
    

    @IBAction func nextBtnTapped(_ sender: UIButton) {
        if currentPage == slides.count - 1 {
            
            let mainTabBarController = storyboard!.instantiateViewController(identifier: "MainTabBarController")
            mainTabBarController.modalPresentationStyle = .fullScreen
                   self.present(mainTabBarController, animated: true, completion: nil)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.isPagingEnabled = false
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            collectionView.isPagingEnabled = true
        }
    }
}

extension OnboardingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    //Tamaño de cada vista del collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 10, height: collectionView.frame.height)
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {

            return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
    
    

   
    
}
