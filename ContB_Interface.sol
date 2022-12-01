// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

// Interface'imizi oluşturuyoruz
interface IContA {
    // ContA'daki fonksiyonların tanımlama kısmını olduğu gibi alıyoruz.
    // Public olanlar external olarak değişiyor
    // ContA'da bir sürü fonksiyon olabilir, siz sadece kullanacağınız fonksiyonları bu interface'e geçirin. 
    // Böylece 20 tane fonksiyon olsa da siz 2 tane ihtiyacını olanı yazarak ContA'nın iç yapısında erişim sağlamış olacaksınız.
    function getInfo_A() external view returns (string memory, uint256);
    function updateInfo_A(string memory _newName, uint256 _newCost) external;
}

contract ContB {

    // Hedef kontratın adresini giriyoruz ve türünü IContA olarak belirliyoruz. Çünkü kullanacağımız tüm parametreler mevcut.
    IContA contractA = IContA(0x1c91347f2A44538ce62453BEBd9Aa907C662b4bD); 

    string public localName;
    uint256 public localCost;

    function getInfo_B() public returns (string memory, uint256) {
        // Gördüğünüz gibi direkt fonksiyonu çağırarak veriyi çekiyoruz.
        (localName, localCost) = contractA.getInfo_A();

        // Daha sonra return ederek bu fonksiyonu çağıran kişiye geri döndürüyoruz.
        // Bunu yapmasak bile veriyi tek satırda çektik, ve ContB'ye yazdık
        return (localName, localCost);
    }

    function updateInfo_B(string memory _newName, uint256 _newCost) public {
        // Aynı şekilde tek satırda hoop veriyi yazıyoruz karşıya. Temiz.
        contractA.updateInfo_A(_newName, _newCost);
    }
}