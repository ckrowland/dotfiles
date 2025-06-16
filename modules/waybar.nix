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
          "eDP-1"
          "HDMI-A-1"
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
        margin: 6px 6px 6px 0px;
        padding: 2px 8px;
    }
    
    #taskbar {
        background-color: #303536;
        margin: 6px 0px 6px 6px;
        border: 2px solid #434a4c;
    }
    
    #taskbar button {
        all: initial;
        min-width: 0;
        box-shadow: inset 0 -3px transparent;
        padding: 2px 4px;
        color: #c7ab7a;
    }
    
    #taskbar button.focused {
        color: #ddc7a1;
    }
    
    #taskbar button.urgent {
        background-color: #e78a4e;
    }
    
    #clock {
        background-color: #303536;
        border: 2px solid #434a4c;
        color: #d4be98;
    }
    
    #tray {
        background-color: #d4be98;
        border: 2px solid #c7ab7a;
    }
    
    #battery,
    #cpu,
    #memory,
    #network,
    #temperature,
    #pulseaudio {
        background-color: #ddc7a1;
        border: 2px solid #c7ab7a;
        color: #1d2021;
    }
    
    #cpu.critical,
    #memory.critical {
        background-color: #ddc7a1;
        border: 2px solid #c7ab7a;
        color: #c14a4a;
    }
    
    #battery.warning,
    #battery.critical,
    #battery.urgent {
        background-color: #ddc7a1;
        border: 2px solid #c7ab7a;
        color: #c14a4a;
    }
    '';
  };
}
