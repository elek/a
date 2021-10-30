PUSH1 0x00
CALLDATALOAD
PUSH1 0xE0
SHR

DUP1
PUSH4 0x01ffc9a7 ;supportsInterface
EQ
PUSH4 :supportsInterface
JUMPI

DUP1
PUSH4 e985e9c5 ;isApprovedForAll
EQ
PUSH4 :returnFalse
JUMPI

DUP1
PUSH4 06fdde03 ;name()
EQ
PUSH4 :name
JUMPI

DUP1
PUSH4 6352211e ;ownerOf()
EQ
PUSH4 :ownerOf
JUMPI

DUP1
PUSH4 70a08231 ;balanceOf()
EQ
PUSH4 :balanceOf
JUMPI

DUP1
PUSH4 95d89b41 ;symbol()
EQ
PUSH4 :symbol
JUMPI

DUP1
PUSH4 c87b56dd ;tokenURI()
EQ
PUSH4 :tokenURI
JUMPI

PUSH1 0x20
PUSH1 0x00
REVERT

;----ownerOf()---
:ownerOf
JUMPDEST
PUSH1 0x01
PUSH1 0x00
MSTORE
PUSH1 0x20
PUSH1 0x00
RETURN

;----tokenURI()---
:tokenURI
JUMPDEST
POP

PUSH1 0x20 ;string starts
PUSH1 0x00
MSTORE

PUSH1 0x1F ; size
PUSH1 0x20
MSTORE

PUSH32 0x68747470733a2f2f656c656b2e6769746875622e696f2f612f312e6a70670000 ; URL is here
PUSH1 0x40
MSTORE

;let's check the parameter
PUSH1 0x04
CALLDATALOAD
DUP1 ; for range check

;<10 ?
PUSH1 0x0A
GT
PUSH1 :ok
JUMPI
REVERT

:ok
JUMPDEST

;use last character
PUSH1 0x0A
SWAP1
MOD
;convert to ascii
PUSH1 0x30
ADD
;value is on the stack
;offset to write the value
PUSH1 0x03 ;this is the end of last byte in url, we need to go back to the end
PUSH1 0x5C ;write the digit to here
SUB
MSTORE8

PUSH1 0x60
PUSH1 0x00
RETURN

;----symbol()---
:symbol
JUMPDEST
PUSH1 0x20 ; string starts from 32
PUSH1 0x00
MSTORE

PUSH3 0x6d7372 ; the real content aligned to start at the 3rd 32 byte
PUSH1 0x23
MSTORE

PUSH1 0x03 ; the size of the string
PUSH1 0x20
MSTORE

PUSH1 0x60
PUSH1 0x00
RETURN

;----balanceOf()---
:balanceOf
JUMPDEST
PUSH1 0x64
PUSH1 0x00
MSTORE
PUSH1 0x20
PUSH1 0x00
RETURN

;----name()-----
:name
JUMPDEST

PUSH4 0x00000020
PUSH1 0x00
MSTORE ;location of dynamic value

PUSH8 0x6d757368726f6f6d
PUSH1 0x28
MSTORE ;string

PUSH1 0x08
PUSH1 0x20
MSTORE ;size of string

PUSH1 0x60
PUSH1 0x00
RETURN

;----supports interface-----
; is approved for all
:supportsInterface
JUMPDEST
PUSH1 0x04
CALLDATALOAD
PUSH1 0xE0
SHR
DUP1 ;duplicate for more checks

PUSH4 0x80ac58cd ; ERC721
EQ
PUSH4 :returnTrue
JUMPI

DUP1;
PUSH4 0x5b5e139f ; ERC721 metadata
EQ
PUSH4 :returnTrue
JUMPI

:returnFalse
JUMPDEST
PUSH1 0x20 ;return false
PUSH1 0x00
RETURN

;----generic return true-----
:returnTrue
JUMPDEST
PUSH1 0x01
PUSH1 0x00
MSTORE
PUSH1 0x20
PUSH1 0x00
RETURN

