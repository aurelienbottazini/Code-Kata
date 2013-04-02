#include <iostream>
#include <cstdio>
using namespace std;
int main()
{

  int a, b;
  while(cin>>a>>b) {

    cout << a << " " << b << " ";

    int i, j;
    if(a < b ) {
      i = a;
      j = b;
    } else {
      i = b;
      j = a;
    }
    int max_cycle_length = 0;
    while(i < j + 1) {
      int n = i;
      int cycle_length = 1;

      while(n > 1) {
        if(n % 2 == 0){
          n = n / 2;
        } else {
          n = n * 3 + 1;
        }
        cycle_length++;
      } //end while
      if(cycle_length > max_cycle_length) {
        max_cycle_length = cycle_length;
      }
      i++;
    } //end while
    cout << max_cycle_length << endl;
  }

  return 0;
}
