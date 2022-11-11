#include <iostream>
#include <string>

std::string __attribute__((noinline)) b2s(bool b) {
    return b ? "true" : "false";
}

union {
    unsigned char c;
    bool b;
} volatile u;

int main() {
    u.c = 0x80;
    std::cout << b2s(u.b) << std::endl;
    return 0;
}

//clang++ -g -O0 -fno-omit-frame-pointer -fsanitize=address crash.cpp
//clang++ -g -O2 -fno-omit-frame-pointer -fsanitize=address crash.cpp
