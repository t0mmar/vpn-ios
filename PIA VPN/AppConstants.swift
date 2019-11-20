//
//  AppConstants.swift
//  PIA VPN
//
//  Created by Davide De Rosa on 12/16/17.
//  Copyright © 2017 London Trust Media. All rights reserved.
//

import Foundation
import PIALibrary

struct AppConstants {
    static let teamId = "CNQ74B27V5"

    static let appGroup = "group.one.librem"
    
    static let appCenterAppId = "a2397c42-40ac-48e8-97e6-7498f0df0e1a"
    
    struct Flags {
        static var developmentPath = Bundle.main.path(forResource: "Flags-dev", ofType: "plist")
    }

    struct About {
        static var componentsPath = Bundle.main.path(forResource: "Components", ofType: "plist")
    }
    
    struct Regions {
        static var bundleURL = Bundle.main.url(forResource: "Regions", withExtension: "json")
    }

    struct InApp {
        static let yearlyProductIdentifier = "com.privateinternetaccess.subscription.1year"
        static let monthlyProductIdentifier = "com.privateinternetaccess.subscription.1month"
    }
    
    struct LegacyInApp {
        static let yearlyProductIdentifier = "com.privateinternetaccess.ios.iap.2019.1year"
        static let monthlyProductIdentifier = "com.privateinternetaccess.ios.iap.2019.1month"
        static let oldYearlyProductIdentifier = "com.privateinternetaccess.ios.iap.1year"
        static let oldMonthlyProductIdentifier = "com.privateinternetaccess.ios.iap.1month"
    }
    
    struct AppURL {
        static let hostRegion = "region"
    }
    
    struct Extensions {
        static let tunnelBundleIdentifier = "one.librem.tunnel.Tunnel"

        static let adBlockerBundleIdentifier = "one.librem.tunnel.AdBlocker"
    }
    
    struct SiriShortcuts {
        static let shortcutConnect = "com.privateinternetaccess.ios.PIA-VPN.connect"
        static let shortcutDisconnect = "com.privateinternetaccess.ios.PIA-VPN.disconnect"
    }
    
    struct Web {
        static let homeURL = URL(string: "https://librem.one/")!

        static let supportURL = URL(string: "https://librem.one/support/")!
        
        static let privacyURL = URL(string: "https://librem.one/policy/")!

        static let csEmail = "support@librem.one"
        
        static let friendReferralTerms = "https://librem.one/policy"

        static var stagingEndpointURL: URL? = {
            guard let path = Bundle.main.path(forResource: "staging", ofType: "endpoint") else {
                return nil
            }
            guard let content = try? String(contentsOfFile: path) else {
                return nil
            }
            return URL(string: content.trimmingCharacters(in: .whitespacesAndNewlines))
        }()
    }
    
    struct Servers {
        static var customServers: [Server]? = {
            guard let path = Bundle.main.path(forResource: "custom", ofType: "servers") else {
                return nil
            }
            guard let content = try? String(contentsOfFile: path) else {
                return nil
            }

            var servers: [Server] = []
            let lines = content.components(separatedBy: "\n")
            for line in lines {
                let tokens = line.components(separatedBy: ":")
                guard tokens.count == 6 else {
                    continue
                }
                
                let name = tokens[0]
                let country = tokens[1]
                let hostname = tokens[2]
                let address = tokens[3]
                
                guard let udpPort = UInt16(tokens[4]) else {
                    continue
                }
                guard let tcpPort = UInt16(tokens[5]) else {
                    continue
                }

                servers.append(Server(
                    name: name,
                    country: country,
                    hostname: hostname,
                    bestOpenVPNAddressForTCP: Server.Address(hostname: address, port: tcpPort),
                    bestOpenVPNAddressForUDP: Server.Address(hostname: address, port: udpPort),
                    pingAddress: nil
                ))
            }
            return servers
        }()
    }
    
    struct Fonts {
        static let typeface: Theme.Typeface = {
            let typeface = Theme.Typeface()
            typeface.regularName = "Roboto-Regular"
            typeface.mediumName = "Roboto-Medium"
            return typeface
        }()
    }
    
    struct VPNWidget {
        static let vpnStatus = "vpn.status"
        static let vpnButtonDescription = "vpn.button.description"
    }
    
    struct AppleUrls {
        static let subscriptions = "itms-apps://apps.apple.com/account/subscriptions"
    }
    
}
