# SteamDB Plugin for Millennium

> [!CAUTION]
> Upstream project status: [BossSloth/Steam-SteamDB-extension](https://github.com/BossSloth/Steam-SteamDB-extension) has been archived and is no longer maintained.

> [!IMPORTANT]
> This fork exists to keep SteamDB functionality usable on current Millennium versions. It modernizes the archived plugin for Millennium's current architecture (Lua backend, Python removed) and adapts protocol/API/runtime compatibility.

This repository is a community-maintained modernization of the original Steam-SteamDB Millennium plugin.  
Its goal is to preserve core SteamDB-in-Steam functionality after upstream archival and adapt it to modern Millennium releases.

This plugin ports the functionality of the popular [SteamDB Browser Extension](https://github.com/SteamDatabase/BrowserExtension) to the Steam client using Millennium.

## Why this fork exists

- The original Millennium plugin repository was archived and stopped receiving updates.
- Millennium has evolved (notably around backend/runtime expectations), so the archived plugin no longer fits current releases as-is.
- This fork applies ongoing compatibility updates (including protocol/API alignment and runtime fixes) so users can continue using SteamDB features on modern Millennium builds.

## Features
>Pretty much all of the SteamDB extension's features are included in this plugin.

See the [SteamDB Browser Extension](https://github.com/SteamDatabase/BrowserExtension) for more details about each feature or SteamDB's [extension page](https://steamdb.info/extension/).

> [!IMPORTANT]
> This plugin is not endorsed by SteamDB and is not created by them. SteamDB is not responsible for providing support or assistance for this plugin. Please direct any inquiries or issues to the plugin's maintainers or ask for help in the [Millennium discord](https://steambrew.app/discord)

|                           Store                            |                         Options Page                          |
|:----------------------------------------------------------:|:-------------------------------------------------------------:|
|       ![SteamDB store page](Images/steam_store.png)        |        ![SteamDB options](Images/steamdb_options.png)         |
|                **Store Achievement Groups**                |                **Personal Achievement Groups**                |
| ![Achievement groups](Images/store_achievement_groups.png) | ![Achievement groups](Images/personal_achievement_groups.png) |
|                       **Inventory**                        | |
| ![Inventory](Images/inventory.png)                         | |
Some pictures were taken from the SteamDB repository.

## Installation

1. Ensure you have Millennium installed on your Steam client
2. Download the [latest release](https://github.com/iFleey/Steam-SteamDB-extension/releases) of this plugin or from the [Steambrew](https://steambrew.app/plugin?id=c36d5f67c99f) website
3. Place the plugin files in your Millennium plugins directory (should be a plugins folder in your Steam client directory)
4. Restart your Steam client
5. Enable the SteamDB plugin in the Millennium plugin menu
6. Right click steam on your taskbar and Click "Exit Steam" to make sure the plugin is fully loaded (no it does NOT automatically restart, that is a reload)
7. Startup steam

## Usage

Once installed it should just work out of the box.
<br>
To see if the plugin is working you can go to any store app page and look for the newly added features
![SteamDB icons](Images/steam_store.png)

## Configuration

To configure the plugin:

1. Open Steam and navigate to the main store page
2. Click on "Your Store" in the top menu, then select "Preferences"
3. Look for the "SteamDB Options" button and click it

Alternatively, you can access the options page directly by entering this URL in your Steam client:
https://store.steampowered.com/account/?steamdb=true

Here you can customize various features and behaviors of the SteamDB plugin to suit your preferences. Just like in the SteamDB extension.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Credits

- Original SteamDB Browser Extension: [SteamDatabase](https://github.com/SteamDatabase)
- [Millennium](https://github.com/shdwmtr/millennium)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
