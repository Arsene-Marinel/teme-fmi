#include <iostream>
using namespace std;

template <class T, class U>
T fun(T x, U y)
{
	return x + y;
}
int fun(int x, int y)
{
	return x - y;
}
int fun(int x)
{
	return x + 1;
}
int main()
{
	int* a = new int(10), b(5);
	cout << fun(a, b); // intra pe template cu T = int*, U = int; intoarce adresa cu b pozitii dupa adresa lui a => afiseaza: o adresa
	return 0;
}