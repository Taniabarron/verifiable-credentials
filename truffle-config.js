const HDWalletProvider = require("@truffle/hdwallet-provider");
const privateKey = "card kangaroo twice multiply discover art genius scale shoe whip mom siren";
const privateKeyProvider = new HDWalletProvider(privateKey, "https://rpc.testnet.fantom.network/"); // <-- fantom


module.exports = {
  /**
   * $ truffle test --network <network-name>
   */

  networks: {
    local: {
      provider: privateKeyProvider,
      host: "127.0.0.1",
      port: 8545,
      network_id: "*"
  },
  fantomtestnet: {
      provider: privateKeyProvider,
      host: "https://rpc.testnet.fantom.network/",
      network_id: "4002",
      gasPrice: 0
  }
  },

  // Set default mocha options here, use special reporters, etc.
  mocha: {
    // timeout: 100000
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "0.5.1",      // Fetch exact version from solc-bin (default: truffle's version)
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
      // settings: {          // See the solidity docs for advice about optimization and evmVersion
      //  optimizer: {
      //    enabled: false,
      //    runs: 200
      //  },
      //  evmVersion: "byzantium"
      // }
    }
  },

  // Truffle DB is currently disabled by default; to enable it, change enabled:
  // false to enabled: true. The default storage location can also be
  // overridden by specifying the adapter settings, as shown in the commented code below.
  //
  // NOTE: It is not possible to migrate your contracts to truffle DB and you should
  // make a backup of your artifacts to a safe location before enabling this feature.
  //
  // After you backed up your artifacts you can utilize db by running migrate as follows:
  // $ truffle migrate --reset --compile-all
  //
  // db: {
  //   enabled: false,
  //   host: "127.0.0.1",
  //   adapter: {
  //     name: "indexeddb",
  //     settings: {
  //       directory: ".db"
  //     }
  //   }
  // }
};
