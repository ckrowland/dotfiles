{ config, pkgs, ... }:

{
  programs.waybar = {
    enable = true;
    package = pkgs.waybar;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        margin-top = 4;
        margin-right = 4;
        margin-left = 4;
        margin-bottom = 4;
        output = [
          "HDMI-A-3"
        ];
        modules-left = [ "wlr/taskbar" ];
        modules-center = [ "clock" ];
        modules-right = [
          "tray"
          "cpu_text"
          "cpu"
          "memory"
          "battery"
          "network"
          "temperature"
          "pulseaudio"
        ];

	      "wlr/taskbar".icon-size = 20;
        
        tray = {
          spacing = 10;
          tooltip = false;
        };
        
        clock = {
          format = "{:%I:%M %p - %a, %d %b %Y}";
          tooltip = false;
        };
        
        cpu = {
          format = "cpu {usage}%";
          interval = 2;
          states.critical = 90;
        };
        
        memory = {
          format = "mem {percentage}%";
          interval = 2;
          states.critical = 80;
        };
        
        battery = {
          format = "bat {capacity}%";
          interval = 5;
          states = {
            warning = 20;
            critical = 10;
          };
          tooltip = false;
        };
        
        network = {
          format-wifi  = "wifi {bandwidthDownBits}";
          format-ethernet = "enth {bandwidthDownBits}";
          format-disconnected  = "no network";
          interval = 5;
          tooltip = false;
        };
        
        temperature = {
          thermal-zone = 2;
  	      hwmon-path = "/sys/class/hwmon/hwmon2/temp1_input";
  	      critical-threshold = 176;
  	      format-critical = "{icon} {temperatureF}°F";
  	      format = "{icon} {temperatureF}°F";
        };
        
        pulseaudio = {
          scroll-step = 5;
          max-volume = 150;
          format = "vol {volume}%";
          format-bluetooth = "vol {volume}%";
          nospacing = 1;
          on-click = "pavucontrol";
          tooltip = false;
        };
      };
    };
    style = ''
    * {
        border: none;
        border-radius: 0;
        min-height: 0;
        font-family: "iosevka nerd font";
        font-weight: 500;
        font-size: 14px;
        padding: 0;
    }
    
    window#waybar {
        background: #1d2021;
        border: 2px solid #3c3836;
    }
    
    tooltip {
        background-color: #1d2021;
        border: 2px solid #7c6f64;
    }
    
    #clock,
    #tray,
    #cpu,
    #memory,
    #battery,
    #network,
    #temperature,
    #pulseaudio {
        margin: 9px 6px 9px 0px;
        padding: 2px 8px;
    }
    
    #taskbar {
        margin: 6px 0px 6px 6px;
    }
    
    #taskbar button {
        all: initial;
        min-width: 0;
        box-shadow: inset 0 -3px transparent;
        padding: 2px 4px;
        color: #c7ab7a;
    }
    
    #clock {
        color: #cccccc;
    }
    
    #battery,
    #cpu,
    #memory,
    #network,
    #temperature,
    #pulseaudio {
        color: #cccccc;
    }

    '';
  };
}
