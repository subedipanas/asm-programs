find . -name "*.c" -exec gcc -c {} \;
find . -name "*.S" -exec gcc -c {} \;
gcc *.o -o app.out

rm *.o