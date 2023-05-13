//
//  NibLoadingView.swift
//  ExcitelCountries
//
//  Created by Yoana Mareva on 12.05.23.
//

import UIKit

private enum NibLoadingError: Error {
    case failedLoadingNib
}

extension NibLoadingError: LocalizedError {

    var errorDescription: String? {
        switch self {
        case .failedLoadingNib:
            return "Failed loading custom view"
        }
    }
}

open class NibLoadingView: UIView {

    open var bundle: Bundle {
        return Bundle.main
    }

    private var view: UIView!

    override public init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }

    private func xibSetup() {
        backgroundColor = .clear
        do {
            view = try loadViewFromNib()
            view.frame = bounds
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.translatesAutoresizingMaskIntoConstraints = true

            addSubview(view)
        } catch {
            print("error: \(error)")
        }
    }

    private func loadViewFromNib() throws -> UIView? {
        let viewType = type(of: self)

        let nibName = String(describing: viewType)
        let nib = UINib(nibName: nibName, bundle: bundle)

        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView else {
            throw NibLoadingError.failedLoadingNib
        }

        return view
    }
}
