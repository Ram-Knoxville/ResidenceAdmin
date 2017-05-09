//
//  streammingVC.swift
//  Gate Guard
//
//  Created by Ram on 3/24/17.
//  Copyright © 2017 Ram. All rights reserved.
//

import UIKit
import LFLiveKit

class streammingVC: UIViewController, LFLiveSessionDelegate {

    @IBOutlet weak var menuBtn: UIBarButtonItem!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var beautyButton: UIButton!
    @IBOutlet weak var stateLabel: UILabel!
    
    @IBOutlet weak var startLiveButton: UIButton!
    
    //  La resolución predeterminada de 368 * 640 Audio: 44,1 iPhone6 ​​más del 48 dirección vertical de la pantalla de dos canales
    var session: LFLiveSession = {
        let audioConfiguration = LFLiveAudioConfiguration.defaultConfiguration(for: LFLiveAudioQuality.high)
        let videoConfiguration = LFLiveVideoConfiguration.defaultConfiguration(for: LFLiveVideoQuality.low3)
        let session = LFLiveSession(audioConfiguration: audioConfiguration, videoConfiguration: videoConfiguration)
        return session!
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        menuBtn.target = SWRevealViewController()
        
        menuBtn.action = #selector(SWRevealViewController.revealToggle(_:))
        
        session.delegate = self
        session.preView = self.view
        
        self.requestAccessForVideo()
        self.requestAccessForAudio()
        self.view.backgroundColor = UIColor.black
        self.startLiveButton.backgroundColor = UIColor(colorLiteralRed: 50, green: 32, blue: 245, alpha: 1)
        self.startLiveButton.layer.cornerRadius = 22
        self.startLiveButton.setTitle("Comenzar", for: UIControlState())
        
        cameraButton.addTarget(self, action: #selector(didTappedCameraButton(_:)), for:.touchUpInside)
        beautyButton.addTarget(self, action: #selector(didTappedBeautyButton(_:)), for: .touchUpInside)
        startLiveButton.addTarget(self, action: #selector(didTappedStartLiveButton(_:)), for: .touchUpInside)
    }
    
    //MARK: - Events
    
    //Comience Vivo
    func didTappedStartLiveButton(_ button: UIButton) -> Void {
        startLiveButton.isSelected = !startLiveButton.isSelected;
        if (startLiveButton.isSelected) {
            startLiveButton.setTitle("Fin", for: UIControlState())
            let stream = LFLiveStreamInfo()
            stream.url = "rtmp://live.hkstv.hk.lxdns.com:1935/live/stream153"
            session.startLive(stream)
        } else {
            startLiveButton.setTitle("Comenzar", for: UIControlState())
            session.stopLive()
        }
    }
    
    // Belleza
    func didTappedBeautyButton(_ button: UIButton) -> Void {
        session.beautyFace = !session.beautyFace;
        beautyButton.isSelected = !session.beautyFace
    }
    
    // Camara
    func didTappedCameraButton(_ button: UIButton) -> Void {
        let devicePositon = session.captureDevicePosition;
        session.captureDevicePosition = (devicePositon == AVCaptureDevicePosition.back) ? AVCaptureDevicePosition.front : AVCaptureDevicePosition.back;
    }
    
    // Cerrar
    func didTappedCloseButton(_ button: UIButton) -> Void  {
        
    }

    
    //MARK: AccessAuth
    
    func requestAccessForVideo() -> Void {
        let status = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo);
        switch status  {
        // 许可对话没有出现，发起授权许可
        case AVAuthorizationStatus.notDetermined:
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granted) in
                if(granted){
                    DispatchQueue.main.async {
                        self.session.running = true
                    }
                }
            })
            break;
        // Se ha abierto autorizado para continuar
        case AVAuthorizationStatus.authorized:
            session.running = true;
            break;
        // Usuario negó expresamente la autorización, o no puede acceder a la cámara del dispositivo
        case AVAuthorizationStatus.denied: break
        case AVAuthorizationStatus.restricted:break;
        default:
            break;
        }
    }
    
    func requestAccessForAudio() -> Void {
        let status = AVCaptureDevice.authorizationStatus(forMediaType:AVMediaTypeAudio)
        switch status  {
            
        //el diálogo de licencia no aparece, licencia de lanzamiento
        case AVAuthorizationStatus.notDetermined:
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeAudio, completionHandler: { (granted) in
                
            })
            break;
        // Se ha abierto autorizado para continuar
        case AVAuthorizationStatus.authorized:
            break;
        // Usuario negó expresamente la autorización, o no puede acceder a la cámara del dispositivo
        case AVAuthorizationStatus.denied: break
        case AVAuthorizationStatus.restricted:break;
        default:
            break;
        }
    }

    //MARK: - Callbacks
    
    //devolución de llamada
    func liveSession(_ session: LFLiveSession?, debugInfo: LFLiveDebug?) {
        print("debugInfo: \(debugInfo?.currentBandwidth)")
    }
    
    func liveSession(_ session: LFLiveSession?, errorCode: LFLiveSocketErrorCode) {
        print("errorCode: \(errorCode.rawValue)")
    }
    
    func liveSession(_ session: LFLiveSession?, liveStateDidChange state: LFLiveState) {
        print("liveStateDidChange: \(state.rawValue)")
        switch state {
        case LFLiveState.ready:
            stateLabel.text = "Desconectado"
            break;
        case LFLiveState.pending:
            stateLabel.text = "Conexión"
            break;
        case LFLiveState.start:
            stateLabel.text = "Conectado"
            break;
        case LFLiveState.error:
            stateLabel.text = "Error"
            break;
        case LFLiveState.stop:
            stateLabel.text = "Desconectado"
            break;
        default:
            break;
        }
    }

}
