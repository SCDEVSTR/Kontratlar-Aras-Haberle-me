// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract ContB{

  address contractA = 0xcD6a42782d230D7c13A74ddec5dD140e55499Df9;

  string public localName;
  uint256 public localCost;

  function getInfo_B() public returns (string memory, uint256) {
    bytes memory payload = abi.encodeWithSignature("getInfo_A()");    // İletişime geçeceğimiz fonksiyonu belirliyoruz 

    // contractA.call(payload) ile yukarıda belirlediğimiz payload ile birlikte hedef kontratımızla iletişime geçiyoruz
    // İletişime geçmemiz ayrı bir transaction olduğu için bu transaction'ın fail olma durumunu success adını verdiğimiz boolean değerine atıyoruz.
    // Böylecek success false olursa, transaction fail olmuştur, bizim de alttaki require ile tüm işlemleri iptal etmemiz gerekiy.r
    // Çünkü transaction fail olsa bile bizim fonksiyonumuz işleme devam eder. Kontrol etmemiz lazım!
    // returnData ile geri dönen veriyi alıyoruz. Gördüğünüz gibi sol taraftaki parantezde çıktıları alıyoruz.
    (bool success, bytes memory returnData) = contractA.call(payload);  
    require(success, "Failed!");
    
    // Burada da returnData ile gelen veriyi decode ederek içinden gelen string ve uint256 değerini alıyoruz.
    // Burada gelen verinin geliş sırasını ve türünü bilmemiz ve çıkartırken de aynı sıra ile çıkarmamız önemli.
    // ContratA'da nasıl yaparsanız, burada da öyle yapın. Ben önce string, sonra uint256 yaptım.
    // Bu verileri localName ve localCost diye yukarıda oluşturduğum değişkenlere atadım. Böylece başka kontrattan veri çekmiş olduk.
    (localName, localCost) = abi.decode(returnData, (string, uint256));
    return (localName, localCost);
  }

  function updateInfo_B(string memory _newName, uint256 _newCost) public {
    // Yine iletişime geçeceğim fonsiyonu yazıyorum, bu sefer parametreleri de var.
    // DİKKAT EDIN: Parametreler arasında boşluk yok !!!! BU ÇOK ÖNEMLİ. string,uint256 şeklinde aralarında sadece virgül var!
    // Normal parametreymiş gibi boşluk koyarsanız çalışmaz! 
    // Fonksyionu parametre türleri ile girdikten sonra sağına girdi olarak verdiğim verileri giriyorum.
    bytes memory payload = abi.encodeWithSignature("updateInfo_A(string,uint256)", _newName, _newCost);

    // Yine contrata bu çağrıyı yolluyorum ve transaction fail oldu mu olmadı mı boolean ile kontrol ediyorum. Bu kadar!
    (bool success,) = contractA.call(payload);
    require(success, "Failed!");
  }
}