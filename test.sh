echo "Testing hi"
ftp -n 127.0.0.1 1021 << EOF
    quote USER hi
    quote PASS hi
    mkdir testing
    quit
EOF

echo "Testing bye"
ftp -n 127.0.0.1 1021 << EOF
    quote USER bye
    quote PASS bye
    mkdir testing
    quit
EOF
