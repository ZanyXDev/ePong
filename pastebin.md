/**
    Item {
        id: screen
        visible: false
        anchors.fill: parent
        
        
        
        RoundPanel {
            id: menuPanel
            visible: false
            opacity: 0
            width: parent.width * 0.9
            height: parent.height * 0.9
            inlineContent: MenuButtons {
                id: menuButtons
                anchors.fill: parent
                
                Rectangle {
                    id: borderRectMenu
                    anchors.fill: parent
                    border {
                        color: "darkgray"
                        width: 2 * DevicePixelRatio
                    }
                    color: "transparent"
                    radius: 10 * DevicePixelRatio
                }
                onMenuCmd: {
                    AppSingleton.toLog(`Command ${cmd} recived`)
                    screen.state = "hide_menu"
                    
                    switch (cmd) {
                    case Utils.MenuCmd.NewGame:
                        AppSingleton.toLog(`Command ${cmd} new game`)
                        break
                    case Utils.MenuCmd.NetworkGame:
                        break
                    case Utils.MenuCmd.Settings:
                        break
                    case Utils.MenuCmd.Records:
                        break
                    case Utils.MenuCmd.Rules:
                        break
                    default:
                        AppSingleton.toLog(`Command ${cmd} undefined`)
                    }
                }
            }
        }
        RoundPanel {
            id: rulesPanel
            visible: false
            width: parent.width * 0.9
            height: parent.height * 0.9
            inlineContent: Item {
                anchors.fill: parent
                
                Rectangle {
                    id: borderRectRules
                    anchors.fill: parent
                    border {
                        color: "darkgray"
                        width: 2 * DevicePixelRatio
                    }
                    color: "transparent"
                    radius: 10 * DevicePixelRatio
                }
            }
        }
        
        
        
        Connections {
            target: logoItem
            function onTimeToDie() {
                screen.state = "hide_logo"
                screen.state = "show_menu"
            }
        }
    }
*/
