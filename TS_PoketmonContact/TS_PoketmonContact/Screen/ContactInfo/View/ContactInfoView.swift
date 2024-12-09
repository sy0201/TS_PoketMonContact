//
//  ContactInfoView.swift
//  TS_PoketmonContact
//
//  Created by siyeon park on 12/8/24.
//

import UIKit
import SnapKit

final class ContactInfoView: UIView {
    let baseView = UIView()
    
    let baseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 10
        return stackView
    }()
    
    lazy var profileImg: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = CGColor(red: 216/255, green: 216/255, blue: 216/255, alpha: 1.0)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    let randomButton: UIButton = {
        let button = UIButton()
        button.setTitle("프로필 이미지 랜덤 생성", for: .normal)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    let nameTextView: UITextField = {
        let nameTv = UITextField()
        nameTv.frame.size.height = 30
        nameTv.borderStyle = .roundedRect
        nameTv.placeholder = "이름을 입력해주세요."
        return nameTv
    }()
    
    let phoneTextView: UITextField = {
        let phoneTv = UITextField()
        phoneTv.frame.size.height = 30
        phoneTv.borderStyle = .roundedRect
        phoneTv.placeholder = "연락처를 입력해주세요.예시)010-1234-5678"
        return phoneTv
    }()
    var randomButtonTapped: (() -> Void)?
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImg.layer.cornerRadius = profileImg.bounds.width / 2
        profileImg.layer.masksToBounds = true
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private setup UI Methods

private extension ContactInfoView {
    func setupUI() {
        self.backgroundColor = .white
        addSubview(baseView)
        baseView.addSubview(baseStackView)
        baseStackView.addArrangedSubViews([profileImg,
                                           randomButton,
                                           nameTextView,
                                           phoneTextView])
    }
    
    func setupConstraint() {
        baseView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        baseStackView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
        }
        
        profileImg.snp.makeConstraints { make in
            make.top.equalTo(baseStackView.snp.top).offset(30)
            make.width.height.equalTo(150)
        }
        
        randomButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        nameTextView.snp.makeConstraints { make in
            make.leading.equalTo(baseStackView.snp.leading).offset(20)
            make.trailing.equalTo(baseStackView.snp.trailing).offset(-20)
        }
        
        phoneTextView.snp.makeConstraints { make in
            make.leading.equalTo(baseStackView.snp.leading).offset(20)
            make.trailing.equalTo(baseStackView.snp.trailing).offset(-20)
        }
    }
}
