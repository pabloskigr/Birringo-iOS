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
    var params : [String : Any]?
    var quest : Quest?
    
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
    
        if let metadataObj = metadataObjects.first {
            guard let readableObj = metadataObj as? AVMetadataMachineReadableCodeObject else {return}
    
            if readableObj.stringValue != nil{
                checkCode(codeToCheck: readableObj.stringValue ?? "defaultCode")
            }
        }
    }
    
    func checkCode(codeToCheck: String){
        self.captureSession.stopRunning()
        params = [
         "id" : quest?.id ?? 0 ,
         "codigo" : codeToCheck ,
         "puntos" : quest?.puntos ?? 0,
        ]
        
        NetworkManager.shared.checkQrCode(apiToken: Session.shared.api_token ?? "", params: params){
            response, errors in DispatchQueue.main.async {
                
                if response?.status == 1 {
                    self.qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                    self.labelQR.text = response?.msg ?? "El codigo es correcto"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                        self.dismiss(animated: true, completion: nil)
                    }
                   
                    
                } else if response?.status == 0 {
                    self.labelQR.text = response?.msg ?? "El codigo no es correcto"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                        self.labelQR.text = "Buscando QR.."
                        self.captureSession.startRunning()
                    }
                   
                    
                } else if errors == .badData || errors == .errorConnection {
                    self.labelQR.text = "Ha ocurrido un error"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                        self.labelQR.text = "Buscando QR.."
                        self.captureSession.startRunning()
                    }
                  

                } else {
                    self.labelQR.text = "Ha ocurrido un error"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                        self.labelQR.text = "Buscando QR.."
                        self.captureSession.startRunning()
                    }
                }
            }
        }
    }
    
    @IBAction func volverButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
