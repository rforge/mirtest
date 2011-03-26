rm -r miRtest
rm -r miRtest.Rcheck
rm  miRtest_1.0.tar.gz
rm miRtest.tar.gz
cp miRtest.R miRtest.bckp

perl replace2.pl vignette/miRtest.Rnw mainExample.txt '<<.*>>=' '@'
sed s/#\'//g mainExample.txt > mainExample2.txt;
DATE=`date '+%Y-%m-%d'`
sed "s/\*\*AUTOMATICALLYINCLUDED\*\*/$DATE/g" package_description.txt  > del.txt
perl replace.pl del.txt pack.descr "##MAINEXAMPLE" mainExample2.txt 
rm mainExample2.txt
rm del.txt
perl replace.pl miRtest.bckp miRtest.R "##MAINEXAMPLE" mainExample.txt 

# Build sceleton
R --no-save --no-restore < buildPackage.R
cp pack.descr miRtest/man/miRtest.Rd
sed "s/\*\*AUTOMATICALLYINCLUDED\*\*/$DATE/g" DESCRIPTION >miRtest/DESCRIPTION

R --no-save --no-restore < buildPackage2.R;
rm miRtest/man/miRtest-package.Rd
mv pack.descr miRtest/man/miRtest.Rd
mv miRtest.bckp miRtest.R

# Create vignette
R --no-save --no-restore < buildPackage3.R;
cd vignette
./compile.sh miRtest
cd ..
cp vignette/miRtest* miRtest/inst/doc
perl replace.pl vignette/miRtest.Rnw miRtest/inst/doc/miRtest.Rnw "%%bibliography" vignette/miRtest.bbl --last-line

echo '\end{document}' | cat miRtest/inst/doc/miRtest.Rnw - > miRtest/inst/doc/miRtest.tmp
mv miRtest/inst/doc/miRtest.tmp miRtest/inst/doc/miRtest.Rnw
cp NAMESPACE miRtest/

# Build for linux
R CMD build miRtest
R CMD check miRtest_1.0.tar.gz
mv miRtest_1.0.tar.gz miRtest.tar.gz


# Build for windows
R CMD build --binary miRtest
rm -r miRtest
tar -xzf miRtest_1.0_R_x86_64-pc-linux-gnu.tar.gz 
zip -r miRtest.zip miRtest
mv miRtest_1.0_R_x86_64-pc-linux-gnu.tar.gz miRtest.binary.tar.gz
rm -r miRtest
rm -r miRtest.Rcheck
rm *.tar

