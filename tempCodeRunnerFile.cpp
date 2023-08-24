#include <iostream>
using namespace std;
int reverse(int n){
    int array[10];
    int i=0;
    while(n!=0){
        array[i]=n%10;
        n=n/10;
        i++;
    }
for(int j=(sizeof(array)/sizeof(int))-1;j>=0;j--){
        cout<<array[i];
    }

}
int main(){
    int n;
    cin>>n;
    reverse(n);
    
}