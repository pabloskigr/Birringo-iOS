//
//  QRVC.swift
//  Birringo
//
//  Created by Jonathan Miguel onrubia on 30/1/22.
//

import UIKit
import AVFoundation

class QRVC: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    var captureSession = AVCaptureSession()
    var videoPreviewLayer : AVCaptureVideoPreviewLayer?
    @IBOutlet weak var labelQR: UILabel!
    @IBOutlet weak var qrCodeFrameView: UIView!
    @IBOutlet weak var volverButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initQRScanner()
        labelQR.text = "Buscando QR.."
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.red.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView)
            view.bringSubviewToFront(labelQR)
            view.bringSubviewToFront(volverButton)
            view.bringSubviewToFront(qrCodeFrameView)
        }
    }
    
    private func initQRScanner(){
        let discoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualWideCamera], mediaType: .video, position: .back)
        
        guard let captureDevice = discoverySession.devices.first
        else {
            print("No se ha encontrado camaras")
            return
        }
        
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession.addInput(input)
            
            let videoMetaDataOutput = AVCaptureMetadataOutput()
            captureSession.addOutput(videoMetaDataOutput)
            
            videoMetaDataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            videoMetaDataOutput.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
            
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = .resizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            captureSession.startRunning()
        } catch {
            print("error")
            return
        }
    }
    
    func metadataOutput(_ output:AVCaptureMetadataOutput,didOutput metadataObjects:[AVMetadataObject], from connection : AVCaptureConnection){
        
        if metadataObjects.count == 0 {
            qrCodeFrameView.frame = CGRect.zero
            labelQR.text = "No se ha encontrado ningun QR"
            qrCodeFrameView.layer.borderColor = UIColor.red.cgColor
            return
        }
        
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        if metadataObj.type == AVMetadataObject.ObjectType.qr {
               // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
               let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
               qrCodeFrameView?.frame = barCodeObject!.bounds

               if metadataObj.stringValue != nil {
                   labelQR.text = metadataObj.stringValue!
                   if metadataObj.stringValue == "https://jonacedev.com/"{
                       qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                       DispatchQueue.main.asyncAfter(deadline: .now() + 3.5){
                           self.dismiss(animated: true, completion: nil)
                       }
                   } else {
                       qrCodeFrameView.layer.borderColor = UIColor.red.cgColor
                       labelQR.text = "El codigo no es correcto"
                   }
               }
        }
    }
    
    @IBAction func volverButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
