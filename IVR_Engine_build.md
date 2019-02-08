## IVR Engine build

Step-by-step:

1. Verzió növelése minden assemblyben
2. Megnyitjuk az ucmaivr.iss fájlt (ez az install script)
3. Átírjuk az elején a verziszámokat, meg ha kell még valami
4. Beírjuk az új verziószámot a Installer\setup\changelog.txt fájlba
5. Elindítjuk az Inno Setup alkalmazást
6. Megnyitjuk az ucmaivr.iss fájlt
7. Build -> Compile
8. Ha azt írja, hogy error, mert nincs aláírva az unistall…. fájl, akkor a következőt kell tenni:
    
    - Meg kell nézni nem generált-e le egy új fájlt aminek hasonló a neve mint uninst-5.5.9 (a)f317d3c28c.e32
    - Ha van ilyen, akkor meg kell nyitni a sign-uninstaller.cmd parancsfájlt és a végén átírni erre a névre, hogy majd ezt írja alá
    - Futtatni kell a sign-uninstaller.cmd parancsfájlt, jelszót kér: K1skop1
    - Vissza az Inno Setup Compiler-be, és újrapróbálkozni.
9. Most elvileg elkészült az ISO a setup mappa alatt az új verziószámmal

**Verzió növelése**: CMD- ból beállok az IVREngine mappába (mert innen indul ki rekurzívan lefelé), és kiadom a következő parancsot: *>D:\ \IVR\IVREngine\UpdateVersion\bin\Release\UpdateVersion.exe 2.1.1.0605*