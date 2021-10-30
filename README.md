# Absolute minimal, non-sellable non-fungible token

This is an attempt the create a very minimal (=minimal gas cost) NFT contract which satisfies
the [ERC-721](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-721.md) interface with minimal gas cost.

For this reason the contract is written in [Ethereum VM byte code](https://ethervm.io/).

It contains 10 NFT token with URI metadata. Transfer / authorize methods are not implemented (let's say the owner is not
willing to sell any of them). But the image URLs can be published as NFT tokens.

Current status:

** [Deployed to Ropsten](https://ropsten.etherscan.io/address/0x9d0735daa8b54a23d0bf1fd12905a80e3e2339db) for 118822 gas. ** (Further improvement may be possible with removing jumps)