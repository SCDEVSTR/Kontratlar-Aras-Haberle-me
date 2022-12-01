// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

/**
  ERC20 fonksiyonlarına direkt erişim sağlayabilmek için ERC20 kütüphanemizi import etmeyi unutmuyoruz.

  tokenContract değişkenimizi address türünde değil de ERC20 türünde de kayıt edebilirdik. 
  Fakat böyle bir durumda ERC20 fonksiyonları haricinde hiçbir fonksiyonu kullanamayız.
  Eğer token kontratımızda diğer kontratlardan iletişime geçilecek özel bir fonksiyon yoksa kontrat
  adresimizi address yerine ERC20 türünden kaydetmemiz daha mantıklı olacaktır. Bu durumda kullanımı da 
  aşağıdaki gibi değişecektir.
 */

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";     // ERC20 import
import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155Supply.sol";

contract Items is ERC1155, ERC1155Supply {

  // ERC20 tokenContract = ERC20(0xd9145CCE52D386f254917e481eB44e9943F39138);
  address tokenContract = 0xd9145CCE52D386f254917e481eB44e9943F39138;

  constructor() ERC1155("") {}

  function mint(address account, uint256 id, uint256 amount, bytes memory data) public
  {
    // tokenContract.transferFrom(_msgSender(), address(this), 25 ether * amount);      --> Tek fark ERC20() diyerek sarmıyoruz çünkü zaten yukarıda ERC20 olarak belirledik
    ERC20(tokenContract).transferFrom(_msgSender(), address(this), 25 ether * amount);        
    _mint(account, id, amount, data);
  }

  function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data) public
  {
    _mintBatch(to, ids, amounts, data);
  }

  // The following functions are overrides required by Solidity.

  function _beforeTokenTransfer(address operator, address from, address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
    internal
    override(ERC1155, ERC1155Supply)
  {
    super._beforeTokenTransfer(operator, from, to, ids, amounts, data);
  }
}
