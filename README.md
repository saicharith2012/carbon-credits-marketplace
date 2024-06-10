
```
carbon-credits-marketplace
├─ .env
├─ .vscode
│  └─ settings.json
├─ frontend
│  ├─ .env
│  ├─ README.md
│  ├─ eslint.config.mjs
│  ├─ package-lock.json
│  ├─ package.json
│  ├─ public
│  │  ├─ favicon.ico
│  │  ├─ index.html
│  │  ├─ logo192.png
│  │  ├─ logo512.png
│  │  ├─ manifest.json
│  │  └─ robots.txt
│  └─ src
│     ├─ App.css
│     ├─ App.js
│     ├─ App.module.scss
│     ├─ App.test.js
│     ├─ components
│     │  ├─ Header
│     │  │  ├─ header.module.scss
│     │  │  └─ index.js
│     │  ├─ Pages
│     │  │  ├─ ConnectMetamask
│     │  │  │  └─ connectMetamask.js
│     │  │  ├─ CreateGreenNFT
│     │  │  │  ├─ Audit.js
│     │  │  │  ├─ Claim.js
│     │  │  │  ├─ CreateGreenNFT.module.scss
│     │  │  │  └─ Register.js
│     │  │  ├─ GreenNFTMarketplace
│     │  │  │  └─ index.js
│     │  │  └─ MyGreenNFTs
│     │  │     └─ index.js
│     │  ├─ Web3Info
│     │  │  ├─ Web3Info.module.scss
│     │  │  └─ index.js
│     │  └─ ipfs
│     │     └─ ipfs.js
│     ├─ config
│     │  └─ webpack.js
│     ├─ index.js
│     ├─ layout
│     │  ├─ index.scss
│     │  └─ variables.scss
│     ├─ routes.js
│     ├─ smart-contract-artifacts
│     │  ├─ Address.json
│     │  ├─ CarbonCreditToken.json
│     │  ├─ Context.json
│     │  ├─ ERC165.json
│     │  ├─ ERC20.json
│     │  ├─ ERC721.json
│     │  ├─ EnumerableMap.json
│     │  ├─ EnumerableSet.json
│     │  ├─ GreenNFT.json
│     │  ├─ GreenNFTData.json
│     │  ├─ GreenNFTDataCommons.json
│     │  ├─ GreenNFTFactory.json
│     │  ├─ GreenNFTFactoryCommons.json
│     │  ├─ GreenNFTMarketPlace.json
│     │  ├─ GreenNFTMarketplaceCommons.json
│     │  ├─ GreenNFTTradable.json
│     │  ├─ IERC165.json
│     │  ├─ IERC20.json
│     │  ├─ IERC721.json
│     │  ├─ IERC721Enumerable.json
│     │  ├─ IERC721Metadata.json
│     │  ├─ IERC721Receiver.json
│     │  ├─ Migrations.json
│     │  ├─ Ownable.json
│     │  ├─ SafeMath.json
│     │  └─ Strings.json
│     └─ utils
│        └─ getWeb3.js
└─ smart-contract
   ├─ archives
   │  └─ migrations
   │     └─ 2_deploy_GreenNFTTradable.js
   ├─ build
   │  └─ contracts
   │     ├─ Address.json
   │     ├─ CarbonCreditToken.json
   │     ├─ Context.json
   │     ├─ ERC165.json
   │     ├─ ERC20.json
   │     ├─ ERC721.json
   │     ├─ EnumerableMap.json
   │     ├─ EnumerableSet.json
   │     ├─ GreenNFT.json
   │     ├─ GreenNFTData.json
   │     ├─ GreenNFTDataCommons.json
   │     ├─ GreenNFTFactory.json
   │     ├─ GreenNFTFactoryCommons.json
   │     ├─ GreenNFTMarketPlace.json
   │     ├─ GreenNFTMarketplaceCommons.json
   │     ├─ GreenNFTTradable.json
   │     ├─ IERC165.json
   │     ├─ IERC20.json
   │     ├─ IERC721.json
   │     ├─ IERC721Enumerable.json
   │     ├─ IERC721Metadata.json
   │     ├─ IERC721Receiver.json
   │     ├─ Migrations.json
   │     ├─ Ownable.json
   │     ├─ SafeMath.json
   │     └─ Strings.json
   ├─ contracts
   │  ├─ CarbonCreditToken.sol
   │  ├─ GreenNFT.sol
   │  ├─ GreenNFTData.sol
   │  ├─ GreenNFTFactory.sol
   │  ├─ GreenNFTMarketPlace.sol
   │  ├─ GreenNFTTradable.sol
   │  ├─ Migrations.sol
   │  ├─ commons
   │  │  ├─ GreenNFTDataCommons.sol
   │  │  ├─ GreenNFTFactoryCommons.sol
   │  │  └─ GreenNFTMarketPlaceCommons.sol
   │  └─ libraries
   │     └─ Strings.sol
   ├─ migrations
   │  ├─ 1_initial_migration.js
   │  ├─ 2_deploy_CarbonCreditToken.js
   │  ├─ 3_deploy_GreenNFTData.js
   │  ├─ 4_deploy_GreenNFTMarketPlace.js
   │  └─ 5_deploy_GreenNFTFactory.js
   ├─ package-lock.json
   ├─ package.json
   ├─ test
   └─ truffle-config.js

```